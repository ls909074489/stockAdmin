package com.king.frame.specifications;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;

import com.google.common.collect.Lists;
import com.king.common.utils.CollectionsUtil;
import com.king.common.utils.DateUtil;
import com.king.modules.sys.org.OrgEntity;

public class DynamicSpecifications {

	//定义传输过来的字段，如果inOrgIds查询不为空，那么就是查询下级
	private static final String ORGIDS = "org.nodepath2";

	/**
	 * 创建动态查询条件组合.
	 */
	public static <T> Specification<T> buildSpecification(Map<String, Object> searchParams, final Class<T> clazz) {
		if (searchParams == null || searchParams.isEmpty())
			return null;
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		Specification<T> spec = bySearchFilter(filters.values(), clazz);
		return spec;
	}

	public static <T> Specification<T> bySearchFilter(final Collection<SearchFilter> filters, final Class<T> clazz) {
		return new Specification<T>() {
			@Override
			public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
				boolean isorg = false;
				String orgNodepath = "";
				if (CollectionsUtil.isNotEmpty(filters)) {

					List<Predicate> predicates = Lists.newArrayList();
					for (SearchFilter filter : filters) {
						// nested path translate, 如Task的名为"user.name"的filedName, 转换为Task.user.name属性
						String[] names = StringUtils.split(filter.fieldName, ".");
						if (ORGIDS.equals(names[0])) {
							isorg = true;
							orgNodepath = filter.value.toString();
							continue;
						}
						Path expression = root.get(names[0]);
						for (int i = 1; i < names.length; i++) {
							expression = expression.get(names[i]);
						}
						Object value = replaceSpace(filter.value);
						
						// date convert
						if ("java.util.Date".equals(expression.getJavaType().getName())) {
							value = DateUtil.strToDateOrDateTime(value.toString());
						}
						// logic operator
						switch (filter.operator) {
						case EQ:
							predicates.add(builder.equal(expression, value));
							break;
						case LIKE:
							builder.like((Expression<String>) expression, "%" + value + "%");
							predicates.add(builder.like(expression, "%" + value + "%"));
							break;
						case BW:
							predicates.add(builder.like(expression, value + "%"));
							break;
						case EW:
							predicates.add(builder.like(expression, "%" + value));
							break;
						case GT:
							predicates.add(builder.greaterThan(expression, (Comparable) value));
							break;
						case LT:
							predicates.add(builder.lessThan(expression, (Comparable) value));
							break;
						case GTE:
							predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable) value));
							break;
						case LTE:
							predicates.add(builder.lessThanOrEqualTo(expression, (Comparable) value));
							break;
						case NOTNULL:
							predicates.add(builder.isNotNull(expression));
							break;
						case NULL:
							predicates.add(builder.isNull(expression));
							break;
						case NE:
							predicates.add(builder.notEqual(expression, value));
							break;
						case IN:
							In in = builder.in(expression);
							String[] values = ((String) value).split(",");
							for (String val : values) {
								in.value(replaceSpace(val));
							}
							predicates.add(in);
							break;
						case NOTIN:							
							In in2 = builder.in(expression);
							String[] values2 = ((String) value).split(",");
							for (String val : values2) {
								in2.value(replaceSpace(val));
							}
							predicates.add(builder.not(in2));
							break;
						case CONTAIN:					
							String[] values4 = ((String) value).split(",");
							for (String val : values4) {
								builder.like((Expression<String>) expression, "%" + val + "%");
								predicates.add(builder.like(expression, "%" + val + "%"));
								
							}
							break;
						case OR:
							//by linjq
							//or的话前端用 search_OR_随意字段=LIKE_字段1#value1,EQ_字段2#value2
							//随意字段必须为本实体的某个字段，实际上是不查这个随意字段的。只用“=号”后面的值进行or拼接
							//例子：search_OR_acStatus=EQ_acStatus#yfj,EQ_mobilePhone#15586948173
							String[] values3 = ((String) value).split(",");
							Map<String, Object> searchParams = new HashMap<String, Object>();
							for (String val : values3) {
								String[] valArr = val.split("#");
								if(valArr.length!=2){
									continue;
								}
								searchParams.put(valArr[0], valArr[1]);
							}
							Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
							Predicate[] preArr = null;
							if (!filters.isEmpty()) {
								preArr = new Predicate[filters.size()];
								int cnt = 0;
								Iterator<String> it = filters.keySet().iterator();
								while (it.hasNext()) {
									String key = it.next();
									preArr[cnt] = getPath(root, filters.get(key), builder);
									cnt++;
								}
								predicates.add(builder.or(preArr));
							}
							break;
						}
					}
					if (predicates.size() > 0) {
						// 加入只能查看下级组织
						if (isorg) {
							builder.and(predicates.toArray(new Predicate[predicates.size()]));

							CriteriaQuery<Object> criteriaQuery = builder.createQuery();

							Subquery<OrgEntity> subquery = criteriaQuery.subquery(OrgEntity.class);

							Root subfromquery = subquery.from(OrgEntity.class);
							Root fromquery = subquery.from(clazz);

							subquery.select(subfromquery.get("uuid")); // field to map with main-query
							// Expression<String> expression2 = (Expression<String>) "123";
							// subquery.where(builder.equal(root.get("orgid"), subfromquery.get("uuid")));
							Path expressionOrg = root.get("nodepath");
							subquery.where(builder.like((Expression<String>) expressionOrg, orgNodepath+"%"));

							return builder.and(builder.exists(subquery));
						} else {
							// 将所有条件用 and 联合起来
							return builder.and(predicates.toArray(new Predicate[predicates.size()]));
						}
					}

				}
				// return query.getRestriction();
				return builder.conjunction();
			}
		};

	}
	
	private static String replaceSpace(Object value) {
		if(value==null) {
			return null;
		}
		return StringUtils.trim(value.toString()); 
	}
	
	@SuppressWarnings({ "rawtypes", "incomplete-switch", "unchecked" })
	private static <T> Predicate getPath(Root<T> root, SearchFilter filter, CriteriaBuilder builder){
		Predicate p = null;
		// nested path translate, 如Task的名为"user.name"的filedName, 转换为Task.user.name属性
		String[] names = StringUtils.split(filter.fieldName, ".");
		Path expression = root.get(names[0]);
		for (int i = 1; i < names.length; i++) {
			expression = expression.get(names[i]);
		}
		
		Object value = filter.value;
		switch (filter.operator) {
		case EQ:
			p = builder.equal(expression, value);
			break;
		case LIKE:
			p = builder.like((Expression<String>) expression, "%" + value + "%");
			break;
		case BW:
			p = builder.like(expression, value + "%");
			break;
		case EW:
			p = builder.like(expression, "%" + value);
			break;
		case GT:
			p = builder.greaterThan(expression, (Comparable) value);
			break;
		case LT:
			p = builder.lessThan(expression, (Comparable) value);
			break;
		case GTE:
			p = builder.greaterThanOrEqualTo(expression, (Comparable) value);
			break;
		case LTE:
			p = builder.lessThanOrEqualTo(expression, (Comparable) value);
			break;
		case NOTNULL:
			p = builder.isNotNull(expression);
			break;
		case NULL:
			p = builder.isNull(expression);
			break;
		case NE:
			p = builder.notEqual(expression, value);
			break;
		case IN:
			In in = builder.in(expression);
			String[] values = ((String) value).split(",");
			for (String val : values) {
				in.value(val);
			}
			p = in;
			break;
		case NOTIN:							
			In in2 = builder.in(expression);
			String[] values2 = ((String) value).split(",");
			for (String val : values2) {
				in2.value(val);
			}
			p = builder.not(in2);
			break;
		}
		return p;
	}

}
