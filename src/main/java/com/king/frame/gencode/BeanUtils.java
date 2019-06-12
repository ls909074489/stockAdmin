package com.king.frame.gencode;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.util.StringUtils;
import com.king.modules.sys.mappingtable.MappingTableEntity;
import com.king.modules.sys.mappingtable.MappingTableSubEntity;


/**
 * @author hongten(hongtenzone@foxmail.com)
 * @date 2013-2-24
 */
public class BeanUtils {
	
	//公共部分
	public static final String RT_1 = "\r\n";
	public static final String RT_2 = RT_1+RT_1;
	public static final String TAB_1 = "\t";
	public static final String TAB_2 = "\t\t";
	public static final String BLANK_1 =" ";
	public static final String BLANK_4 ="    ";
	public static final String BLANK_8 =BLANK_4 + BLANK_4;
	
	private static String action_View_Edit_Del="render : YYDataTableUtils.renderActionCol,";
	private static String action_Del="render : YYDataTableUtils.renderRemoveActionCol,";
	
	private static String templatefiles="templatefiles";
	//文件 地址
	private static final String savePath="D:\\codes\\";
	
	
	public static void main(String[] args) throws Exception{
		MappingTableEntity info=new MappingTableEntity();
		info.setEntityName("AdddEntity");
		info.setExtendsEntity("BaseEntity");
		info.setPackageName("com.yy.modules.ver.auditCols");
		info.setEntityChinese("测试111");
		info.setAuthor("ls2008");
		info.setControllerPath("/ver/test1");
		info.setJspPath("modules/ver/test1");//jsp路径
		info.setTemplateType(EntityInfo.GENTYPE_MAINSON_SERVERPAGE);
		
		
		
		//生成实体==================================================================================
		List<MappingTableSubEntity> list=new ArrayList<MappingTableSubEntity>();
		MappingTableSubEntity col=new MappingTableSubEntity();
		col.setColName("name");
		col.setColType("String");
		col.setColLength(50);
		col.setColDesc("名称");
		col.setRequired(true);
		col.setEleType(MappingTableSubEntity.EleType.TEXT);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("code");
		col.setColType("String");
		col.setColLength(50);
		col.setColDesc("编码");
		col.setRequired(true);
		col.setEleType(MappingTableSubEntity.EleType.TEXT);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("datecols");
		col.setColType("String");
		col.setColLength(50);
		col.setColDesc("日期");
		col.setEleType(MappingTableSubEntity.EleType.DATE);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("timecols");
		col.setColType("String");
		col.setColLength(50);
		col.setColDesc("日期时间");
		col.setEleType(MappingTableSubEntity.EleType.DATETIME);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("isDisplay");
		col.setColType("String");
		col.setColLength(1);
		col.setColDesc("是否显示");
		col.setEleType(MappingTableSubEntity.EleType.REF);
		col.setColCount(2);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("type");
		col.setColType("String");
		col.setColLength(36);
		col.setColDesc("类别");
		col.setEleType(MappingTableSubEntity.EleType.SELECT);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("type111");
		col.setColType("String");
		col.setColLength(36);
		col.setColDesc("备注");
		col.setEleType(MappingTableSubEntity.EleType.TEXTAREA);
		col.setColCount(3);
		list.add(col);
		
		//子表=======================
		col=new MappingTableSubEntity();
		col.setColName("subcode");
		col.setColType("String");
		col.setColLength(36);
		col.setColDesc("编码");
		col.setEleType(MappingTableSubEntity.EleType.TEXT);
		col.setMain(false);
		col.setColCount(1);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("subname");
		col.setColType("String");
		col.setColLength(36);
		col.setColDesc("名称");
		col.setEleType(MappingTableSubEntity.EleType.TEXT);
		col.setMain(false);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("sex");
		col.setColType("String");
		col.setColLength(36);
		col.setColDesc("性别");
		col.setEleType(MappingTableSubEntity.EleType.SELECT);
		col.setMain(false);
		list.add(col);
		col=new MappingTableSubEntity();
		col.setColName("birthdate");
		col.setColType("Date");
		col.setColLength(36);
		col.setColDesc("日期");
		col.setEleType(MappingTableSubEntity.EleType.DATE);
		col.setMain(false);
		col.setColCount(1);
		list.add(col);
		
		//生成实体==================================================================================
		
		createCode(info, list);
	}
	
	public static void createCode(MappingTableEntity info,List<MappingTableSubEntity> list) throws Exception{
		List<MappingTableSubEntity> mainList=new ArrayList<MappingTableSubEntity>();
		List<MappingTableSubEntity> subList=new ArrayList<MappingTableSubEntity>();
		for(MappingTableSubEntity c:list){
			if(c.isMain()){
				mainList.add(c);
			}else{
				subList.add(c);
			}
		}
		
		if(Integer.parseInt(info.getTemplateType())<10){
			//创建主表实体
			if(mainList!=null&&mainList.size()>0){
				createEntity(info, mainList);
				createDao(info);
				createService(info);
				createController(info);
			}
			//创建字表实体
			if(subList!=null&&subList.size()>0){
				MappingTableEntity subInfo=new MappingTableEntity ();
				org.apache.commons.beanutils.BeanUtils.copyProperties(subInfo, info);
				subInfo.setEntityChinese(info.getEntityChinese()+"子表");
				subInfo.setEntityName((info.getEntityName().replace("Entity", "")+"SubEntity"));
				subInfo.setControllerPath(info.getControllerPath()+"Sub");
				subInfo.setMain(false);
				createEntity(subInfo, subList);
				createDao(subInfo);
				createService(subInfo);
				createController(subInfo);
			}
		}
		
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			createJspList(info,list);
			createJspEdit(info,list);
			createJspDetail(info,list);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			createJspTreeMain(info, list);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREELISTPAGE)){
			createJspTreeList(info, list);
			createJspEdit(info,list);
			createJspDetail(info,list);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_REFLISTSELECT)){
			createJspRefList(info,list);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_REFTREESELECT)){
			createJspRefTree(info,list);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)){//主子表（服务器分页）
			createJspList(info,mainList);
			createJspMainSonAdd(info,list);
			createJspMainSonEdit(info,list);
			createJspMainSonDetail(info,list);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_WEBPAGE)){//主子表（前端分页）
			createJspList(info,mainList);
			createJspMainSonAdd(info,list);
			createJspMainSonWebEdit(info,list);
			createJspMainSonWebDetail(info,list);
		}
	}


	public static void createEntity(MappingTableEntity info,List<MappingTableSubEntity> list) throws IOException{
		String entityName=getUppercaseChar(info.getEntityName());
		String preName=entityName.toLowerCase().replace("entity", "");
		if(!entityName.contains("Entity")){
			entityName+="Entity";
		}
		String fileName = savePath+ entityName+ ".java";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		StringBuilder sb=new StringBuilder();
		sb.append("package "+info.getPackageName()+";"+RT_2);
		
		//判断需要import的类 start
		boolean hasDate=false;
		for(MappingTableSubEntity col : list){
			if(col.getColType().equals("Date")){
				hasDate=true;
			}
		}
		if(hasDate){
			sb.append("import java.util.Date;").append(RT_1);
			sb.append("import com.fasterxml.jackson.annotation.JsonFormat;").append(RT_1);
		}
		sb.append("import javax.persistence.Column;").append(RT_1);
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			sb.append("import com.yy.frame.entity.BaseEntity;").append(RT_1);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			sb.append("import com.yy.frame.entity.TreeEntity;").append(RT_1);
			sb.append("import com.fasterxml.jackson.annotation.JsonIgnoreProperties;").append(RT_1);
			sb.append("import javax.persistence.FetchType;").append(RT_1);
			sb.append("import javax.persistence.JoinColumn;").append(RT_1);
			sb.append("import javax.persistence.ManyToOne;").append(RT_1);
			sb.append("import javax.persistence.CascadeType;").append(RT_1);
		}else{
			sb.append("import com.yy.frame.entity.BaseEntity;").append(RT_1);
		}
		if(!info.isMain()){
			sb.append("import javax.persistence.CascadeType;").append(RT_1);
			sb.append("import javax.persistence.FetchType;").append(RT_1);
			sb.append("import javax.persistence.JoinColumn;").append(RT_1);
			sb.append("import javax.persistence.ManyToOne;").append(RT_1);
			sb.append("import com.fasterxml.jackson.annotation.JsonIgnoreProperties;").append(RT_1);
			sb.append("import ").append(info.getPackageName()).append(".").append(entityName.replace("Sub", "")).append(";").append(RT_1);
		}
		
		sb.append("import com.yy.common.annotation.MetaData;").append(RT_1);
		sb.append("import javax.persistence.Entity;").append(RT_1);
		sb.append("import javax.persistence.Table;").append(RT_1);
		sb.append("import org.hibernate.annotations.Cache;").append(RT_1);
		sb.append("import org.hibernate.annotations.CacheConcurrencyStrategy;").append(RT_1);
		sb.append("import org.hibernate.annotations.DynamicInsert;").append(RT_1);
		sb.append("import org.hibernate.annotations.DynamicUpdate;").append(RT_1);
		//判断需要import的类 end
		
		appendFileAnno(info, sb);//类备注
		
		sb.append("@Entity").append(RT_1);
		if(!StringUtils.isEmpty(info.getTableName())){
			sb.append("@Table(name = \""+info.getTableName()+"\")").append(RT_1);
		}else{
			if(preName.lastIndexOf("sub")==(preName.length()-3)){
				sb.append("@Table(name = \"yy_"+preName.replace("sub", "_sub")+"\")").append(RT_1);
			}else{
				sb.append("@Table(name = \"yy_"+preName+"\")").append(RT_1);
			}
		}
		sb.append("@DynamicInsert").append(RT_1);
		sb.append("@DynamicUpdate").append(RT_1);
		sb.append("@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)").append(RT_1);
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			sb.append("public class " + entityName + " extends "+info.getExtendsEntity()+" {"+RT_2);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			sb.append("public class " + entityName + " extends TreeEntity {"+RT_2);
		}else{
			sb.append("public class " + entityName + " extends "+info.getExtendsEntity()+" {"+RT_2);
		}
		
		sb.append("	private static final long serialVersionUID = 1L;"+RT_2);
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){//树状
			sb.append("	@ManyToOne(cascade = { CascadeType.REFRESH }, fetch = FetchType.LAZY)").append(RT_1);
			sb.append("	@JoinColumn(name = \"parentid\")").append(RT_1);
			sb.append("	@JsonIgnoreProperties({\"hibernateLazyInitializer\", \"handler\"})").append(RT_1);
			sb.append("	private ").append(entityName).append(" parent;").append(RT_2);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!info.isMain()){//主子表
			sb.append("	@ManyToOne(cascade = { CascadeType.REFRESH }, fetch = FetchType.LAZY)").append(RT_1);
			sb.append("	@JoinColumn(name = \"mainid\")").append(RT_1);
			sb.append("	@JsonIgnoreProperties({\"hibernateLazyInitializer\", \"handler\"})").append(RT_1);
			sb.append("	private ").append(entityName.replace("Sub", "")).append(" main;").append(RT_2);
		}
		
		//生成变量
		for(MappingTableSubEntity col : list){
			if(col.getColType().equals("Date")){
				sb.append("	@JsonFormat(pattern = \"yyyy-MM-dd HH:mm:ss\", timezone = \"GMT+08:00\")").append(RT_1);
			}
			sb.append("	@MetaData(value = \"").append(col.getColDesc()).append("\")").append(RT_1);
			if(col.getColType().equals("String")){
				if(!StringUtils.isEmpty(col.getColLength())){
					sb.append("	@Column(length = ").append(col.getColLength()).append(")").append(RT_1);
				}else{
					sb.append("	@Column(length = ").append(250).append(")").append(RT_1);
				}
			}else{
				sb.append("	@Column()").append(RT_1);
			}
			sb.append("	private ").append(col.getColType()).append(BLANK_1).append(col.getColName()).append(";").append(RT_2);
		}
		
		
		//生成getter和setter方法
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){//树状
			sb.append("	public ").append(entityName).append(" getParent() {").append(RT_1);
			sb.append("		return parent;").append(RT_1);
			sb.append("	}").append(RT_1);
			sb.append("	public void setParent(").append(entityName).append(" parent) {").append(RT_1);
			sb.append("		this.parent = parent;").append(RT_1);
			sb.append("	}").append(RT_1);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!info.isMain()){//主子表
			sb.append("	public ").append(entityName.replace("Sub", "")).append(" getMain() {").append(RT_1);
			sb.append("		return main;").append(RT_1);
			sb.append("	}").append(RT_1);
			sb.append("	public void setMain(").append(entityName.replace("Sub", "")).append(" main) {").append(RT_1);
			sb.append("		this.main = main;").append(RT_1);
			sb.append("	}").append(RT_1);
		}
		for(MappingTableSubEntity col : list){
			sb.append("	public ").append(col.getColType()).append(" get").append(getUppercaseChar(col.getColName())).append("() {").append(RT_1);
			sb.append(TAB_2).append("return ").append(col.getColName()).append(";").append(RT_1).append("	}").append(RT_2);
			sb.append("	public void set").append(getUppercaseChar(col.getColName())).append("(").append(col.getColType()).append(BLANK_1).append(col.getColName()).append(") {").append(RT_1);
			sb.append(TAB_2).append("this.").append(col.getColName()).append(" = ").append(col.getColName()).append(";").append(RT_1).append("	}").append(RT_2);
		}
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){//树状
			sb.append("	@Override").append(RT_1);
			sb.append("	public String getParentId() {").append(RT_1);
			sb.append("		if(parent!=null&&parent.getUuid()!=null){").append(RT_1);
			sb.append("			return this.parent.getUuid();").append(RT_1);
			sb.append("		}else{").append(RT_1);
			sb.append("			return \"\";").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("	}").append(RT_1);
		}
		sb.append("}");
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	
	/**
	 * 创建bean的Dao<br>
	 * 
	 * @param c
	 * @throws Exception
	 */
	public static void createDao(MappingTableEntity info) throws Exception {
		String entityName=getUppercaseChar(info.getEntityName());
		if(!entityName.contains("Entity")){
			entityName+="Entity";
		}
		String daoName=getUppercaseChar(info.getEntityName());
		daoName=daoName.replace("Entity", "");
		if(!daoName.contains("Dao")){
			daoName+="Dao";
		}
		
		String fileName = savePath+ daoName + ".java";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		StringBuilder sb=new StringBuilder();
		sb.append("package "+info.getPackageName()+";"+RT_2);
		
		sb.append("import com.yy.frame.dao.IBaseDAO;").append(RT_1);
		sb.append("import org.springframework.stereotype.Repository;").append(RT_1);
		
		appendFileAnno(info, sb);//类备注
		sb.append("@Repository").append(RT_1);
		sb.append("public interface " + daoName + " extends IBaseDAO<"+entityName+",String> {"+RT_2+"}");
		
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
	}

    
    
    /**
     * 创建bean的service
     * @param c
     * @throws Exception
     */
    public static void createService(MappingTableEntity info) throws Exception{
    	String entityName=getUppercaseChar(info.getEntityName());
		if(!entityName.contains("Entity")){
			entityName+="Entity";
		}
		String daoName=getUppercaseChar(info.getEntityName());
		daoName=daoName.replace("Entity", "");
		if(!daoName.contains("Dao")){
			daoName+="Dao";
		}
		String serviceName=getUppercaseChar(info.getEntityName());
		serviceName=serviceName.replace("Entity", "");
		if(!serviceName.contains("Service")){
			serviceName+="Service";
		}
		
		String fileName = savePath+ serviceName + ".java";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		StringBuilder sb=new StringBuilder();
		sb.append("package "+info.getPackageName()+";"+RT_2);
		
		sb.append("import com.yy.frame.dao.IBaseDAO;").append(RT_1);
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			sb.append("import com.yy.frame.service.BaseServiceImpl;").append(RT_1);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			sb.append("import com.yy.frame.service.TreeServiceImpl;").append(RT_1);
		}else{
			sb.append("import com.yy.frame.service.BaseServiceImpl;").append(RT_1);
		}
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!entityName.contains("Sub")){//主表才生成方法
			sb.append("import java.util.List;").append(RT_1);
			sb.append("import com.yy.frame.controller.ActionResultModel;").append(RT_1);
		}
		sb.append("import org.springframework.stereotype.Service;").append(RT_1);
		sb.append("import org.springframework.transaction.annotation.Transactional;").append(RT_1);
		sb.append("import org.springframework.beans.factory.annotation.Autowired;").append(RT_1);
		
		appendFileAnno(info, sb);//类备注
		sb.append("@Service").append(RT_1).append("@Transactional(readOnly=true)").append(RT_1);
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			sb.append("public class " + serviceName + " extends BaseServiceImpl<"+entityName+",String> {"+RT_2);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			sb.append("public class " + serviceName + " extends TreeServiceImpl<"+entityName+",String> {"+RT_2);
		}else{
			sb.append("public class " + serviceName + " extends BaseServiceImpl<"+entityName+",String> {"+RT_2);
		}
		
		sb.append("	@Autowired").append(RT_1);
		sb.append("	private ").append(daoName).append(" dao;").append(RT_1);
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!entityName.contains("Sub")){//主表才生成方法
			sb.append("	@Autowired").append(RT_1);
			sb.append("	private ").append(serviceName.replace("Service", "SubService")).append(" subService;").append(RT_1);
		}
		sb.append("	//@Autowired").append(RT_1);
		sb.append("	//private DbUtilsDAO dbDao;").append(RT_2);
		
		sb.append("	protected IBaseDAO<").append(entityName).append(", String> getDAO() {").append(RT_1);
		sb.append("		return dao;").append(RT_1);
		sb.append("	}").append(RT_2);
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!entityName.contains("Sub")){//主表才生成方法
			sb.append("	/**").append(RT_1);
			sb.append("	 * @Title: saveSelfAndSubList").append(RT_1); 
			sb.append("	 * @author ").append(info.getAuthor()).append(RT_1);
			sb.append("	 * @date ").append(getDate()).append(RT_1);
			sb.append("	 * @param @param model").append(RT_1);
			sb.append("	 * @param @return 设定文件 ").append(RT_1);
			sb.append("	 * @return String 返回类型 ").append(RT_1);
			sb.append("	 * @throws").append(RT_1);
			sb.append("	 */").append(RT_1);
			sb.append("	 @Transactional").append(RT_1);
			sb.append("	public ActionResultModel<AdddEntity> saveSelfAndSubList(AdddEntity entity, List<AdddSubEntity> subList,String[] deletePKs) {").append(RT_1);
			sb.append("		ActionResultModel<AdddEntity> arm = new ActionResultModel<AdddEntity>();").append(RT_1);
			sb.append("		// 删除子表").append(RT_1);
			sb.append("		if (deletePKs != null && deletePKs.length > 0) {").append(RT_1);
			sb.append("			subService.delete(deletePKs);").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("		AdddEntity savedEntity = save(entity);").append(RT_1);
			sb.append("		// 保存").append(RT_1);
			sb.append("		if(subList!=null&&subList.size()>0){").append(RT_1);
			sb.append("			for (AdddSubEntity sub : subList) {").append(RT_1);
			sb.append("				sub.setMain(savedEntity);").append(RT_1);
			sb.append("			}").append(RT_1);
			sb.append("			subService.save(subList);").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("		arm.setRecords(savedEntity);").append(RT_1);
			sb.append("		arm.setSuccess(true);").append(RT_1);
			sb.append("		return arm;").append(RT_1);
			sb.append("	}").append(RT_1);
		}
		
		sb.append("}");
		
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
    }
    
    
	
	public static void createController(MappingTableEntity info) throws IOException {
		String entityName=getUppercaseChar(info.getEntityName());
		String jspPreName=entityName.toLowerCase().replace("entity", "");
		if(!entityName.contains("Entity")){
			entityName+="Entity";
		}
		String subEntityName=entityName;
		subEntityName=subEntityName.replace("Entity", "SubEntity");
		String controllerName=getUppercaseChar(info.getEntityName());
		controllerName=controllerName.replace("Entity", "");
		if(!controllerName.contains("Controller")){
			controllerName+="Controller";
		}
		String serviceName=getUppercaseChar(info.getEntityName());
		serviceName=serviceName.replace("Entity", "");
		if(!serviceName.contains("Service")){
			serviceName+="Service";
		}
		
		String fileName = savePath+ controllerName + ".java";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		StringBuilder sb=new StringBuilder();
		sb.append("package "+info.getPackageName()+";"+RT_2);
		
		Map<String,String> importMap=new HashMap<String,String>();
		List<String> importList=new ArrayList<String>();
		importList.add("import javax.servlet.ServletRequest;");

		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			importList.add("import com.yy.frame.controller.BaseController;");
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			importList.add("import com.yy.frame.controller.TreeController;");
			importList.add("import java.util.List;");
			importList.add("import java.util.ArrayList;");
			importList.add("import com.yy.common.bean.TreeBaseBean;");
			importList.add("import org.springframework.web.bind.annotation.ResponseBody;");
		}else{
			importList.add("import com.yy.frame.controller.BaseController;");
		}
		importList.add("import org.springframework.stereotype.Controller;");
		importList.add("import org.springframework.web.bind.annotation.RequestMapping;");
		importList.add("import org.springframework.beans.factory.annotation.Autowired;");
		if(!info.isMain()){//子表
			importList.add("import com.yy.frame.controller.ActionResultModel;");
			importList.add("import org.springframework.util.StringUtils;");
		}else{
			importList.add("import org.springframework.ui.Model;");
			importList.add("import net.sf.json.JSONObject;");
			importList.add("import org.springframework.stereotype.Controller;");
			importList.add("import org.springframework.web.bind.annotation.ModelAttribute;");
			importList.add("import org.springframework.web.bind.annotation.RequestMapping;");
			importList.add("import org.springframework.web.bind.annotation.RequestParam;");
			importList.add("import org.springframework.web.bind.annotation.ResponseBody;");
			importList.add("import org.springframework.beans.factory.annotation.Autowired;");
			importList.add("import org.springframework.dao.DataIntegrityViolationException;");
			importList.add("import java.io.UnsupportedEncodingException;");
			importList.add("import java.net.URLDecoder;");
			importList.add("import java.util.ArrayList;");
			importList.add("import java.util.List;");
			importList.add("import javax.servlet.ServletRequest;");
			importList.add("import javax.validation.Valid;");
			importList.add("import com.yy.common.utils.Constants;");
			importList.add("import com.yy.frame.controller.ActionResultModel;");
		}
		for(String s:importList){
			importMap.put(s, s);
		}
		for(String key:importMap.keySet()){
			sb.append(key).append(RT_1);
		}
		
		appendFileAnno(info, sb);//类备注
		if(info.isMain()){
			sb.append("@Controller").append(RT_1).append("@RequestMapping(value = \"").append(info.getControllerPath()).append("\")").append(RT_1);
		}else{
			sb.append("@Controller").append(RT_1).append("@RequestMapping(value = \"").append(info.getControllerPath()).append("\")").append(RT_1);
		}
		
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_SERVERPAGE)){
			sb.append("public class " + controllerName + " extends BaseController<"+entityName+"> {"+RT_2);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			sb.append("public class " + controllerName + " extends TreeController<"+entityName+"> {"+RT_2);
		}else{
			sb.append("public class " + controllerName + " extends BaseController<"+entityName+"> {"+RT_2);
		}
		
		sb.append("	@Autowired").append(RT_1);
		sb.append("	private ").append(serviceName).append(" service;").append(RT_2);
		
		if(!info.isMain()){//子表
			sb.append("	//重写要根据主表id查询否则返回空").append(RT_1);
			sb.append("	@Override").append(RT_1);
			sb.append("	protected ActionResultModel<").append(entityName).append("> doQuery(ServletRequest request) {").append(RT_1);
			sb.append("		String mainId=request.getParameter(\"search_EQ_main.uuid\");").append(RT_1);
			sb.append("		if(StringUtils.isEmpty(mainId)){").append(RT_1);
			sb.append("			ActionResultModel<").append(entityName).append("> arm=new ActionResultModel<").append(entityName).append(">();").append(RT_1);
			sb.append("			//arm.setRecords(new ArrayList<").append(entityName).append(">());").append(RT_1);
			sb.append("			arm.setTotal(0);").append(RT_1);
			sb.append("			arm.setTotalPages(0);").append(RT_1);
			sb.append("			arm.setMsg(\"请根据主表id查询\");").append(RT_1);
			sb.append("			return arm;").append(RT_1);
			sb.append("		}else{").append(RT_1);
			sb.append("			return super.doQuery(request);").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("	}").append(RT_1);
		}
		
		
		//生成对应controller方法
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_TREEMAINPAGE)){
			sb.append("	/**").append(RT_1);
			sb.append("	 * ").append(RT_1);
			sb.append("	 * @Title: listView").append(RT_1); 
			sb.append("	 * @author ").append(info.getAuthor()).append(RT_1);
			sb.append("	 * @date ").append(getDate()).append(RT_1);
			sb.append("	 * @param @param model").append(RT_1);
			sb.append("	 * @param @return 设定文件 ").append(RT_1);
			sb.append("	 * @return String 返回类型 ").append(RT_1);
			sb.append("	 * @throws").append(RT_1);
			sb.append("	 */").append(RT_1);
			sb.append("	@RequestMapping(\"/list\")").append(RT_1);
			sb.append("	public String listView(Model model) {").append(RT_1);
			sb.append("		return \""+info.getJspPath()+"/"+jspPreName+"_main\";").append(RT_1);
			sb.append("	}").append(RT_2);
			
			
			sb.append("	@ResponseBody").append(RT_1);
			sb.append("	@RequestMapping(value = \"/dataTreeList\")").append(RT_1);
			sb.append("	private List<TreeBaseBean> dataTreeList() {").append(RT_1);
			sb.append("		List<TreeBaseBean> treeList = new ArrayList<TreeBaseBean>();").append(RT_1);
			sb.append("		TreeBaseBean bean = null;").append(RT_1);
			sb.append("		List<").append(entityName).append("> objList = (List<").append(entityName).append(">) service.findAll();").append(RT_1);
			sb.append("		if (objList != null && objList.size() > 0) {").append(RT_1);
			sb.append("			for (").append(entityName).append(" d : objList) {").append(RT_1);
			sb.append("				bean = new TreeBaseBean(d.getUuid(), d.getName(), d.getParentId(), false, false, d);").append(RT_1);
			sb.append("				treeList.add(bean);").append(RT_1);
			sb.append("			}").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("		return treeList;").append(RT_1);
			sb.append("	}").append(RT_1);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_REFLISTSELECT)){// 列表单选
			sb.append("	@RequestMapping(\"/ref").append(getUppercaseChar(jspPreName)).append("Sel\")").append(RT_1);
			sb.append("	public String ref").append(getUppercaseChar(jspPreName)).append("Sel(Model model, ServletRequest request) {").append(RT_1);
			sb.append("		model.addAttribute(\"callBackMethod\",request.getParameter(\"callBackMethod\"));").append(RT_1);
			sb.append("		return \"modules/ref/").append(jspPreName).append("_ref_select\";").append(RT_1);
			sb.append("	}").append(RT_2);
		}else if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!info.isMain()){// 主子表
			//子表不需要生成方法
		}else{
			sb.append("	/**").append(RT_1);
			sb.append("	 * ").append(RT_1);
			sb.append("	 * @Title: listView").append(RT_1); 
			sb.append("	 * @author ").append(info.getAuthor()).append(RT_1);
			sb.append("	 * @date ").append(getDate()).append(RT_1);
			sb.append("	 * @param @param model").append(RT_1);
			sb.append("	 * @param @return 设定文件 ").append(RT_1);
			sb.append("	 * @return String 返回类型 ").append(RT_1);
			sb.append("	 * @throws").append(RT_1);
			sb.append("	 */").append(RT_1);
			sb.append("	@RequestMapping(\"/list\")").append(RT_1);
			sb.append("	public String listView(Model model) {").append(RT_1);
			sb.append("		return \""+info.getJspPath()+"/"+jspPreName+"_list\";").append(RT_1);
			sb.append("	}").append(RT_2);

			sb.append("	@Override").append(RT_1);
			sb.append("	public String addView(Model model, ServletRequest request) {").append(RT_1);
			if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!info.isMain()){// 主子表
				sb.append("		return \""+info.getJspPath()+"/"+jspPreName+"_add\";").append(RT_1);
			}else{
				sb.append("		return \""+info.getJspPath()+"/"+jspPreName+"_edit\";").append(RT_1);
			}
			sb.append("	}").append(RT_2);

			sb.append("	@Override").append(RT_1);
			sb.append("	public String editView(Model model, ServletRequest request, "+entityName+" entity) {").append(RT_1);
			sb.append("		return \""+info.getJspPath()+"/"+jspPreName+"_edit\";").append(RT_1);
			sb.append("	}").append(RT_2);

			sb.append("	@Override").append(RT_1);
			sb.append("	public String detailView(Model model, ServletRequest request, "+entityName+" entity) {").append(RT_1);
			sb.append("		return \""+info.getJspPath()+"/"+jspPreName+"_detail\";").append(RT_1);
			sb.append("	}").append(RT_2);
		}
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_MAINSON_SERVERPAGE)&&!entityName.contains("Sub")){//主表才生成方法
			sb.append("	/**").append(RT_1);
			sb.append("	 * 新增主子表").append(RT_1);
			sb.append("	 * @Title: addwithsub").append(RT_1); 
			sb.append("	 * @author ").append(info.getAuthor()).append(RT_1);
			sb.append("	 * @date ").append(getDate()).append(RT_1);
			sb.append("	 * @param @param model").append(RT_1);
			sb.append("	 * @param @return 设定文件 ").append(RT_1);
			sb.append("	 * @return String 返回类型 ").append(RT_1);
			sb.append("	 * @throws").append(RT_1);
			sb.append("	 */").append(RT_1);
			sb.append("	@ResponseBody").append(RT_1);
			sb.append("	@RequestMapping(value = \"/addwithsub\")").append(RT_1);
			sb.append("	public ActionResultModel<").append(entityName).append("> addwithsub(ServletRequest request, Model model, @Valid ").append(entityName).append(" entity,").append(RT_1);
			sb.append("		@RequestParam(value = \"subList[]\", required = false) String[] subArrs,").append(RT_1);
			sb.append("		@RequestParam(value = \"deletePKs[]\", required = false) String[] deletePKs,Boolean isCommunityApply) {").append(RT_1);
			sb.append("		ActionResultModel<").append(entityName).append("> arm = new ActionResultModel<").append(entityName).append(">();").append(RT_1);
			sb.append("		arm.setSuccess(true);").append(RT_1);
			sb.append("		List<").append(subEntityName).append("> subList = this.convertToEntities(subArrs);").append(RT_1);
			sb.append("		try {").append(RT_1);
			sb.append("			arm = service.saveSelfAndSubList(entity, subList, deletePKs);").append(RT_1);
			sb.append("		} catch (DataIntegrityViolationException e) {").append(RT_1);
			sb.append("			arm.setSuccess(false);").append(RT_1);
			sb.append("			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));").append(RT_1);
			sb.append("			e.printStackTrace();").append(RT_1);
			sb.append("		} catch (Exception e) {").append(RT_1);
			sb.append("			arm.setSuccess(false);").append(RT_1);
			sb.append("			arm.setMsg(\"保存失败\");").append(RT_1);
			sb.append("			e.printStackTrace();").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("		return arm;").append(RT_1);
			sb.append("	}").append(RT_1);
			
			sb.append("	/**").append(RT_1);
			sb.append("	 * 更新主子表").append(RT_1);
			sb.append("	 * @Title: addwithsub").append(RT_1); 
			sb.append("	 * @author ").append(info.getAuthor()).append(RT_1);
			sb.append("	 * @date ").append(getDate()).append(RT_1);
			sb.append("	 * @param @param model").append(RT_1);
			sb.append("	 * @param @return 设定文件 ").append(RT_1);
			sb.append("	 * @return String 返回类型 ").append(RT_1);
			sb.append("	 * @throws").append(RT_1);
			sb.append("	 */").append(RT_1);
			sb.append("	@ResponseBody").append(RT_1);
			sb.append("	@RequestMapping(value = \"/updatewithsub\")").append(RT_1);
			sb.append("	public ActionResultModel<").append(entityName).append("> update(ServletRequest request,@Valid @ModelAttribute(\"preloadEntity\") ").append(entityName).append(" entity,").append(RT_1);
			sb.append("		@RequestParam(value = \"subList[]\", required = false) String[] subArrs,@RequestParam(value = \"deletePKs[]\", required = false) String[] deletePKs) {").append(RT_1);
			sb.append("		ActionResultModel<").append(entityName).append("> arm = new ActionResultModel<").append(">();").append(RT_1);
			sb.append("		arm.setSuccess(true);").append(RT_1);
			sb.append("		List<").append(subEntityName).append("> subList = this.convertToEntities(subArrs);").append(RT_1);
			sb.append("		try {").append(RT_1);
			sb.append("			arm = service.saveSelfAndSubList(entity, subList, deletePKs);").append(RT_1);
			sb.append("		} catch (DataIntegrityViolationException e) {").append(RT_1);
			sb.append("			arm.setSuccess(false);").append(RT_1);
			sb.append("			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));").append(RT_1);
			sb.append("			e.printStackTrace();").append(RT_1);
			sb.append("		} catch (Exception e) {").append(RT_1);
			sb.append("			arm.setSuccess(false);").append(RT_1);
			sb.append("			arm.setMsg(\"保存失败\");").append(RT_1);
			sb.append("			e.printStackTrace();").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("		return arm;").append(RT_1);
			sb.append("	}").append(RT_1);
			
			sb.append("	/**").append(RT_1);
			sb.append("	 * 转换子表").append(RT_1);
			sb.append("	 * @Title: addwithsub").append(RT_1); 
			sb.append("	 * @author ").append(info.getAuthor()).append(RT_1);
			sb.append("	 * @date ").append(getDate()).append(RT_1);
			sb.append("	 * @param @param model").append(RT_1);
			sb.append("	 * @param @return 设定文件 ").append(RT_1);
			sb.append("	 * @return String 返回类型 ").append(RT_1);
			sb.append("	 * @throws").append(RT_1);
			sb.append("	 */").append(RT_1);
			sb.append("	private List<").append(subEntityName).append("> convertToEntities(String[] paramArr) {").append(RT_1);
			sb.append("		List<").append(subEntityName).append("> returnList = new ArrayList<").append(">();").append(RT_1);
			sb.append("		if (paramArr == null || paramArr.length == 0){").append(RT_1);
			sb.append("		return returnList;").append(RT_1);
			sb.append("		}else{").append(RT_1);
			sb.append("		for (String data : paramArr) {").append(RT_1);
			sb.append("			JSONObject jsonObject = new JSONObject();").append(RT_1);
			sb.append("			String[] properties = data.split(\"&\");").append(RT_1);
			sb.append("			for (String property : properties) {").append(RT_1);
			sb.append("				String[] nameAndValue = property.split(\"=\");").append(RT_1);
			sb.append("				if (nameAndValue.length == 2) {").append(RT_1);
			sb.append("					try {").append(RT_1);
			sb.append("						nameAndValue[0] = URLDecoder.decode(nameAndValue[0], \"UTF-8\");").append(RT_1);
			sb.append("					nameAndValue[1] = URLDecoder.decode(nameAndValue[1], \"UTF-8\");").append(RT_1);
			sb.append("					} catch (UnsupportedEncodingException e) {").append(RT_1);
			sb.append("						e.printStackTrace();").append(RT_1);
			sb.append("					}").append(RT_1);
			sb.append("					jsonObject.put(nameAndValue[0], nameAndValue[1]);").append(RT_1);
			sb.append("				}").append(RT_1);
			sb.append("			}").append(RT_1);
			sb.append("			").append(subEntityName).append(" obj = (").append(subEntityName).append(") JSONObject.toBean(jsonObject,").append(subEntityName).append(".class);").append(RT_1);
			sb.append("			returnList.add(obj);").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("		return returnList;").append(RT_1);
			sb.append("		}").append(RT_1);
			sb.append("	}").append(RT_1);
		}
		
		sb.append("}");
		
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
	}

    
    
	public static void createJspList(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+ jspPreName + "_list.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		StringBuilder sb=new StringBuilder();
		sb.append("<%@ page contentType=\"text/html;charset=UTF-8\"%>"+RT_1);
		sb.append("<%@ taglib prefix=\"c\" uri=\"http://java.sun.com/jsp/jstl/core\"%>").append(RT_1);
		sb.append("<%@ taglib prefix=\"shiro\" uri=\"http://shiro.apache.org/tags\"%>").append(RT_1);
		sb.append("<c:set var=\"ctx\" value=\"${pageContext.request.contextPath}\"/>").append(RT_1);
		sb.append("<c:set var=\"serviceurl\" value=\"${ctx}"+info.getControllerPath()+"\"/>").append(RT_1);
		sb.append("<html>").append(RT_1);
		sb.append("<head>").append(RT_1);
		sb.append("<title>"+info.getEntityChinese()+"</title>").append(RT_1);
		sb.append("</head>").append(RT_1);
		sb.append("<body>").append(RT_1);
		
		//创建list表格start
		sb.append(createListContent(info,list));
		//创建list表格end
		
		sb.append("	<!-- 公用脚本 -->").append(RT_1);
		sb.append("	<%@include file=\"/WEB-INF/views/common/listscript.jsp\"%>").append(RT_2);
		sb.append("	<script type=\"text/javascript\">").append(RT_1);
		sb.append("		_isNumber = true;").append(RT_1);
		
		//创建列表的列变量start
		sb.append(createTableCols(info,list,true,false,action_View_Edit_Del));
		//创建列表的列变量end
		
		sb.append(RT_2);	
		sb.append("		//var _setOrder = [[5,'desc']];").append(RT_1);
		sb.append("		$(document).ready(function() {").append(RT_1);
		sb.append("			_queryData = $(\"#yy-form-query\").serializeArray();").append(RT_1);
		sb.append("			bindListActions();").append(RT_1);
		sb.append("			serverPage(null);").append(RT_1);
		sb.append("		});").append(RT_1);
		sb.append("	</script>").append(RT_1);
		sb.append("</body>").append(RT_1);
		sb.append("</html>	").append(RT_1);
		sb.append("").append(RT_1);
				
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
		
	}
    
	
	public static void createJspEdit(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+ jspPreName + "_edit.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		StringBuilder sb=new StringBuilder();
		sb.append("<%@ page contentType=\"text/html;charset=UTF-8\"%>"+RT_1);
		sb.append("<%@ taglib prefix=\"c\" uri=\"http://java.sun.com/jsp/jstl/core\"%>"+RT_1);		
		sb.append("<c:set var=\"ctx\" value=\"${pageContext.request.contextPath}\" />"+RT_1);
		sb.append("<c:set var=\"serviceurl\" value=\"${ctx}"+info.getControllerPath()+"\"/>"+RT_1);
		sb.append("<html>"+RT_1);
		sb.append("<head>"+RT_1);
		sb.append("<title>"+info.getEntityChinese()+"</title>"+RT_1);
		sb.append("</head>"+RT_1);
		sb.append("<body>"+RT_1);
		sb.append("	<div id=\"yy-page-edit\" class=\"container-fluid page-container page-content\" >"+RT_1);
		sb.append("		<div class=\"row yy-toolbar\">"+RT_1);
		sb.append("			<button id=\"yy-btn-save\" class=\"btn blue btn-sm\">"+RT_1);
		sb.append("				<i class=\"fa fa-save\"></i> 保存"+RT_1);
		sb.append("			</button>"+RT_1);
		sb.append("			<button id=\"yy-btn-cancel\" class=\"btn blue btn-sm\">"+RT_1);
		sb.append("				<i class=\"fa fa-rotate-left\"></i> 取消"+RT_1);
		sb.append("			</button>"+RT_1);
		sb.append("		</div>"+RT_1);
//		sb.append("	<div>"+RT_1);
		sb.append("		<form id=\"yy-form-edit\" class=\"form-horizontal yy-form-edit\">"+RT_1);
		sb.append("			<input name=\"uuid\" type=\"text\" class=\"hide\" value=\"${entity.uuid}\">"+RT_1);
		
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:list){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		sb.append(createFormElement(list,true));
		//创建form元素end
		
		sb.append("		</form>"+RT_1);
		
		sb.append("	</div>"+RT_1);
		sb.append("	<!-- 公用脚本 -->"+RT_1);
		sb.append("	<%@include file=\"/WEB-INF/views/common/editscript.jsp\"%>"+RT_2);
		sb.append("	<script type=\"text/javascript\">"+RT_2);
		sb.append("		$(document).ready(function() {"+RT_1);
		sb.append("			//按钮绑定事件"+RT_1);
		sb.append("			bindEditActions();"+RT_1);					
		sb.append("			//bindButtonAction();"+RT_1);
		sb.append("			validateForms();"+RT_1);	
		sb.append("			setValue();"+RT_1);
		sb.append("		});"+RT_2);	
		sb.append("		//设置默认值"+RT_1);
		sb.append("		function setValue() {"+RT_1);	
		sb.append("			if ('${openstate}' == 'add') {"+RT_1);
		sb.append("				//$(\"select[name='is_use']\").val('1');"+RT_1);	
		sb.append("			} else if ('${openstate}' == 'edit') {"+RT_1);
		for(int i=0;i<detailList.size();i++){
			if(detailList.get(i).getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
				sb.append("				$(\"select[name='"+detailList.get(i).getColName()+"']\").val('${entity."+detailList.get(i).getColName()+"}');"+RT_1);	
			}
		}
		sb.append("			}"+RT_1);	
		sb.append("		}"+RT_2);	
		sb.append("		//表单校验"+RT_1);	
		sb.append("		function validateForms(){"+RT_1);	
		sb.append("			validator = $('#yy-form-edit').validate({"+RT_1);	
		sb.append("				onsubmit : true,"+RT_1);	
		sb.append("				rules : {"+RT_1);	
		
		boolean hasRule=false;
		for(int i=0;i<detailList.size();i++){
			String requiredStr="";
			if(detailList.get(i).isRequired()){
				requiredStr="required : true,";
			}
			if(!hasRule){
				sb.append("					'"+detailList.get(i).getColName()+"' : {"+requiredStr+"maxlength : 100}");	
			}else{
				sb.append(",").append(RT_1).append("					'"+detailList.get(i).getColName()+"' : {"+requiredStr+"maxlength : 100}");	
			}
			hasRule=true;
		}
		sb.append(RT_1).append("				}"+RT_1);	
		sb.append("			});"+RT_1);					
		sb.append("		}"+RT_1);	
		sb.append("	</script>"+RT_1);	
		sb.append("</body>"+RT_1);	
		sb.append("</html>"+RT_1);					
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
		
	}
	
	public static void createJspDetail(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+ jspPreName + "_detail.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		StringBuilder sb=new StringBuilder();
		sb.append("<%@ page contentType=\"text/html;charset=UTF-8\"%>"+RT_1);
		sb.append("<%@ taglib prefix=\"c\" uri=\"http://java.sun.com/jsp/jstl/core\"%>"+RT_1);		
		sb.append("<c:set var=\"ctx\" value=\"${pageContext.request.contextPath}\" />"+RT_1);
		sb.append("<c:set var=\"serviceurl\" value=\"${ctx}"+info.getControllerPath()+"\"/>"+RT_1);
		sb.append("<html>"+RT_1);
		sb.append("<head>"+RT_1);
		sb.append("<title>"+info.getEntityChinese()+"</title>"+RT_1);
		sb.append("</head>"+RT_1);
		sb.append("<body>"+RT_1);
		sb.append("	<div id=\"yy-page-detail\" class=\"container-fluid page-container page-content\" >"+RT_1);
		sb.append("		<div class=\"row yy-toolbar\">"+RT_1);
		sb.append("			<button id=\"yy-btn-backtolist\" class=\"btn blue btn-sm\">"+RT_1);
		sb.append("				<i class=\"fa fa-rotate-left\"></i> 返回"+RT_1);
		sb.append("			</button>"+RT_1);
		sb.append("		</div>"+RT_1);
//		sb.append("	<div>"+RT_1);
		sb.append("		<form id=\"yy-form-detail\" class=\"form-horizontal yy-form-detail\">"+RT_1);
		sb.append("			<input name=\"uuid\" type=\"text\" class=\"hide\" value=\"${entity.uuid}\">"+RT_1);
		
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:list){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		sb.append(createFormElement(list,false));
		//创建form元素end
		
		sb.append("		</form>"+RT_1);
		sb.append("	</div>"+RT_1);
		sb.append("	<!-- 公用脚本 -->"+RT_1);
		sb.append("	<%@include file=\"/WEB-INF/views/common/detailscript.jsp\"%>"+RT_2);
		sb.append("	<script type=\"text/javascript\">"+RT_2);
		sb.append("		$(document).ready(function() {"+RT_1);
		sb.append("			//按钮绑定事件"+RT_1);
		sb.append("			bindDetailActions();"+RT_1);					
		sb.append("			//bindButtonAction();"+RT_1);
		sb.append("			setValue();"+RT_2);
		sb.append("			YYFormUtils.lockForm(\"yy-form-detail\");"+RT_1);
		sb.append("		});"+RT_2);	
		sb.append("		//设置默认值"+RT_1);
		sb.append("		function setValue() {"+RT_1);	
		sb.append("			if ('${openstate}' == 'add') {"+RT_1);
		sb.append("				//$(\"select[name='is_use']\").val('1');"+RT_1);	
		sb.append("			} else if ('${openstate}' == 'detail') {"+RT_1);
		for(int i=0;i<detailList.size();i++){
			if(detailList.get(i).getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
				sb.append("				$(\"select[name='"+detailList.get(i).getColName()+"']\").val('${entity."+detailList.get(i).getColName()+"}');"+RT_1);	
			}
		}
		sb.append("			}"+RT_1);	
		sb.append("		}"+RT_2);	
		sb.append("	</script>"+RT_1);	
		sb.append("</body>"+RT_1);	
		sb.append("</html>"+RT_1);					
		fw.write(sb.toString());
		fw.flush();
		fw.close();
		showInfo(fileName);
		
	}

	
	/**
	 * 树
	 * @param info
	 * @param list
	 * @throws IOException
	 */
	public static void createJspTreeMain(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+ jspPreName + "_main.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:list){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		String formEleStr=createFormElement(list,true);
		String validateFormStr=createValidateFormFunc(detailList);
		
		StringBuilder showDataStr= new StringBuilder();
		for(int i=0;i<detailList.size();i++){
			if(detailList.get(i).getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
				showDataStr.append("			$(\"select[name='"+detailList.get(i).getColName()+"']\").val(treeNode.nodeData."+detailList.get(i).getColName()+");"+RT_1);	
			}else if(detailList.get(i).getEleType().equals(MappingTableSubEntity.EleType.TEXTAREA)){
				showDataStr.append("			$(\"textarea[name='"+detailList.get(i).getColName()+"']\").val(treeNode.nodeData."+detailList.get(i).getColName()+");"+RT_1);	
			}else{
				showDataStr.append("			$(\"input[name='"+detailList.get(i).getColName()+"']\").val(treeNode.nodeData."+detailList.get(i).getColName()+");"+RT_1);	
			}
		}
		
		//创建form元素end
		String fileStr=readFileByLines("treeMainJsp.txt",formEleStr,validateFormStr,showDataStr.toString());
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	/**
	 * 左树右列表
	 * @param info
	 * @param list
	 * @throws IOException
	 */
	public static void createJspTreeList(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+ jspPreName + "_list.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:list){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		String formEleStr=createFormElement(list,true);
		String validateFormStr=createValidateFormFunc(detailList);
		
		StringBuilder showDataStr= new StringBuilder();
		for(int i=0;i<detailList.size();i++){
			if(detailList.get(i).getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
				showDataStr.append("			$(\"select[name='"+detailList.get(i).getColName()+"']\").val(treeNode.nodeData."+detailList.get(i).getColName()+");"+RT_1);	
			}else if(detailList.get(i).getEleType().equals(MappingTableSubEntity.EleType.TEXTAREA)){
				showDataStr.append("			$(\"textarea[name='"+detailList.get(i).getColName()+"']\").val(treeNode.nodeData."+detailList.get(i).getColName()+");"+RT_1);	
			}else{
				showDataStr.append("			$(\"input[name='"+detailList.get(i).getColName()+"']\").val(treeNode.nodeData."+detailList.get(i).getColName()+");"+RT_1);	
			}
		}
		//创建form元素end
		String fileStr=readFileByLines("treeListMainJsp.txt",formEleStr,validateFormStr,showDataStr.toString());
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(info,list,true,false,action_View_Edit_Del));
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	
	/**
	 * 列表参照选择
	 * @param info
	 * @param list
	 * @throws IOException
	 */
	public static void createJspRefList(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+"ref_"+jspPreName + "_list.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:list){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		String formEleStr=createFormElement(list,true);
		String validateFormStr=createValidateFormFunc(detailList);
		
		//创建form元素end
		String fileStr=readFileByLines("refList.txt",formEleStr,validateFormStr,"");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(info,list,true,false,action_View_Edit_Del));
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	/**
	 * 树选择
	 * @param info
	 * @param list
	 * @throws IOException
	 */
	public static void createJspRefTree(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		
		String fileName = savePath+"ref_"+jspPreName + "_tree.jsp";
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:list){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		
		//创建form元素end
		String fileStr=readFileByLines("refTree.txt","","","");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	/**
	 * 生成主子表编辑页面
	 * @param info
	 * @param list
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public static void createJspMainSonAdd(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException, IllegalAccessException, InvocationTargetException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		String fileName = savePath+ jspPreName + "_add.jsp";
		
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		List<MappingTableSubEntity> mainList=new ArrayList<MappingTableSubEntity>();
		List<MappingTableSubEntity> subList=new ArrayList<MappingTableSubEntity>();
		StringBuilder subThs=new StringBuilder();
		StringBuilder subNewData=new StringBuilder();
		for(MappingTableSubEntity c:list){
			if(c.isMain()){
				mainList.add(c);
			}else{
				subList.add(c);
				if(c.isListVisiable()){
					subThs.append("								<th>"+c.getColDesc()+"</th>").append(RT_1);
					subNewData.append(",").append(RT_1);
					subNewData.append("					'").append(c.getColName()).append("': ''");
				}
			}
		}
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:mainList){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		
		
		String formEleStr=createFormElement(mainList,true);
		String validateFormStr=createValidateFormFunc(detailList);
		
		MappingTableEntity subInfo=new MappingTableEntity ();
		org.apache.commons.beanutils.BeanUtils.copyProperties(subInfo, info);
		subInfo.setEntityChinese(info.getEntityChinese()+"子表");
		subInfo.setEntityName((info.getEntityName().replace("Entity", "")+"SubEntity"));
		subInfo.setControllerPath(info.getControllerPath()+"Sub");
		subInfo.setMain(false);
		
		//创建form元素end
		String fileStr=readFileByLines("mainSonAdd.txt",formEleStr,validateFormStr,"");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(subInfo,subList,false,true,action_Del));
		fileStr=fileStr.replaceAll("#subTableTHeadThs#", subThs.toString());
		fileStr=fileStr.replaceAll("#subNewData#", subNewData.toString());
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	/**
	 * 创建主子编辑页面
	 * @param info
	 * @param list
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static void createJspMainSonEdit(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException, IllegalAccessException, InvocationTargetException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		String fileName = savePath+ jspPreName + "_edit.jsp";
		
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		List<MappingTableSubEntity> mainList=new ArrayList<MappingTableSubEntity>();
		List<MappingTableSubEntity> subList=new ArrayList<MappingTableSubEntity>();
		StringBuilder subThs=new StringBuilder();
		StringBuilder subNewData=new StringBuilder();
		for(MappingTableSubEntity c:list){
			if(c.isMain()){
				mainList.add(c);
			}else{
				subList.add(c);
				if(c.isListVisiable()){
					subThs.append("								<th>"+c.getColDesc()+"</th>").append(RT_1);
					subNewData.append(",").append(RT_1);
					subNewData.append("					'").append(c.getColName()).append("': ''");
				}
			}
		}
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:mainList){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		
		
		String formEleStr=createFormElement(mainList,true);
		String validateFormStr=createValidateFormFunc(detailList);
		
		MappingTableEntity subInfo=new MappingTableEntity ();
		org.apache.commons.beanutils.BeanUtils.copyProperties(subInfo, info);
		subInfo.setEntityChinese(info.getEntityChinese()+"子表");
		subInfo.setEntityName((info.getEntityName().replace("Entity", "")+"SubEntity"));
		subInfo.setControllerPath(info.getControllerPath()+"Sub");
		subInfo.setMain(false);
		
		//创建form元素end
		String fileStr=readFileByLines("mainSonEdit.txt",formEleStr,validateFormStr,"");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(subInfo,subList,false,true,action_Del));
		fileStr=fileStr.replaceAll("#subTableTHeadThs#", subThs.toString());
		fileStr=fileStr.replaceAll("#subNewData#", subNewData.toString());
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	
	public static void createJspMainSonWebEdit(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException, IllegalAccessException, InvocationTargetException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		String fileName = savePath+ jspPreName + "_edit.jsp";
		
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		List<MappingTableSubEntity> mainList=new ArrayList<MappingTableSubEntity>();
		List<MappingTableSubEntity> subList=new ArrayList<MappingTableSubEntity>();
		StringBuilder subThs=new StringBuilder();
		StringBuilder subNewData=new StringBuilder();
		for(MappingTableSubEntity c:list){
			if(c.isMain()){
				mainList.add(c);
			}else{
				subList.add(c);
				if(c.isListVisiable()){
					subThs.append("								<th>"+c.getColDesc()+"</th>").append(RT_1);
					subNewData.append(",").append(RT_1);
					subNewData.append("					'").append(c.getColName()).append("': ''");
				}
			}
		}
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:mainList){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		
		
		String formEleStr=createFormElement(mainList,true);
		String validateFormStr=createValidateFormFunc(detailList);
		
		MappingTableEntity subInfo=new MappingTableEntity ();
		org.apache.commons.beanutils.BeanUtils.copyProperties(subInfo, info);
		subInfo.setEntityChinese(info.getEntityChinese()+"子表");
		subInfo.setEntityName((info.getEntityName().replace("Entity", "")+"SubEntity"));
		subInfo.setControllerPath(info.getControllerPath()+"Sub");
		subInfo.setMain(false);
		
		//创建form元素end
		String fileStr=readFileByLines("mainSonWebEdit.txt",formEleStr,validateFormStr,"");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(subInfo,subList,false,true,action_Del));
		fileStr=fileStr.replaceAll("#subTableTHeadThs#", subThs.toString());
		fileStr=fileStr.replaceAll("#subNewData#", subNewData.toString());
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	/**
	 * 创建主子查看页面
	 * @param info
	 * @param list
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static void createJspMainSonDetail(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException, IllegalAccessException, InvocationTargetException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		String fileName = savePath+ jspPreName + "_detail.jsp";
		
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		List<MappingTableSubEntity> mainList=new ArrayList<MappingTableSubEntity>();
		List<MappingTableSubEntity> subList=new ArrayList<MappingTableSubEntity>();
		StringBuilder subThs=new StringBuilder();
		StringBuilder subNewData=new StringBuilder();
		for(MappingTableSubEntity c:list){
			if(c.isMain()){
				mainList.add(c);
			}else{
				subList.add(c);
				if(c.isListVisiable()){
					subThs.append("								<th>"+c.getColDesc()+"</th>").append(RT_1);
					subNewData.append(",").append(RT_1);
					subNewData.append("					'").append(c.getColName()).append("': ''");
				}
			}
		}
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:mainList){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		
		String formEleStr=createFormElement(mainList,true);
		String validateFormStr="";//createValidateFormFunc(detailList);
		
		MappingTableEntity subInfo=new MappingTableEntity ();
		org.apache.commons.beanutils.BeanUtils.copyProperties(subInfo, info);
		subInfo.setEntityChinese(info.getEntityChinese()+"子表");
		subInfo.setEntityName((info.getEntityName().replace("Entity", "")+"SubEntity"));
		subInfo.setControllerPath(info.getControllerPath()+"Sub");
		subInfo.setMain(false);
		
		//创建form元素end
		String fileStr=readFileByLines("mainSonDetail.txt",formEleStr,validateFormStr,"");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(subInfo,subList,false,false,null));
		fileStr=fileStr.replaceAll("#subTableTHeadThs#", subThs.toString());
		fileStr=fileStr.replaceAll("#subNewData#", subNewData.toString());
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	
	public static void createJspMainSonWebDetail(MappingTableEntity info, List<MappingTableSubEntity> list) throws IOException, IllegalAccessException, InvocationTargetException {
		String jspPreName=info.getEntityName().toLowerCase().replace("entity", "");
		String fileName = savePath+ jspPreName + "_detail.jsp";
		
		File file =  createFile(fileName);
		FileWriter fw = new FileWriter(file);
		
		List<MappingTableSubEntity> mainList=new ArrayList<MappingTableSubEntity>();
		List<MappingTableSubEntity> subList=new ArrayList<MappingTableSubEntity>();
		StringBuilder subThs=new StringBuilder();
		StringBuilder subNewData=new StringBuilder();
		for(MappingTableSubEntity c:list){
			if(c.isMain()){
				mainList.add(c);
			}else{
				subList.add(c);
				if(c.isListVisiable()){
					subThs.append("								<th>"+c.getColDesc()+"</th>").append(RT_1);
					subNewData.append(",").append(RT_1);
					subNewData.append("					'").append(c.getColName()).append("': ''");
				}
			}
		}
		//创建form元素start
		List<MappingTableSubEntity> detailList=new ArrayList<MappingTableSubEntity>();//明细页面显示的字段列
		for(MappingTableSubEntity col:mainList){
			if(col.isDetailVisiable()){
				detailList.add(col);
			}
		}
		
		String formEleStr=createFormElement(mainList,true);
		String validateFormStr="";//createValidateFormFunc(detailList);
		
		MappingTableEntity subInfo=new MappingTableEntity();
		org.apache.commons.beanutils.BeanUtils.copyProperties(subInfo, info);
		subInfo.setEntityChinese(info.getEntityChinese()+"子表");
		subInfo.setEntityName((info.getEntityName().replace("Entity", "")+"SubEntity"));
		subInfo.setControllerPath(info.getControllerPath()+"Sub");
		subInfo.setMain(false);
		
		//创建form元素end
		String fileStr=readFileByLines("mainSonWebDetail.txt",formEleStr,validateFormStr,"");
		fileStr=fileStr.replaceAll("#title#", info.getEntityChinese());
		fileStr=fileStr.replaceAll("#serviceurl#", info.getControllerPath());
		fileStr=fileStr.replaceAll("#jspPreName#", jspPreName);
		fileStr=fileStr.replaceAll("#tableCols#", createTableCols(subInfo,subList,false,false,null));
		fileStr=fileStr.replaceAll("#subTableTHeadThs#", subThs.toString());
		fileStr=fileStr.replaceAll("#subNewData#", subNewData.toString());
		//创建list表格start
		fileStr=fileStr.replaceAll("#listContent#", createListContent(info,list));
		//创建list表格end
		
		fw.write(fileStr);
		fw.flush();
		fw.close();
		showInfo(fileName);
	}
	
	
	private static String createFormElement(List<MappingTableSubEntity> detailList,boolean isEdit){
		StringBuilder sb=new StringBuilder();
		StringBuilder sbCol=new StringBuilder();
		int colIndex=0;//用于计算一个字段占多列的情况
		
		for(int i=0;i<detailList.size();i++){
			//设置列==========================
			int colMd=0;
			int colMdSub1=0;
			int colMdSub2=0;
			String colSubStyle1="";
			String colSubStyle2="";
			if(detailList.get(i).getColCount()==1){
				colMd=4;
				colMdSub1=4;
				colMdSub2=8;
			}else if(detailList.get(i).getColCount()==2){
				colMd=8;
				colMdSub1=2;
				colMdSub2=10;
			}else if(detailList.get(i).getColCount()==3){
				colMd=12;
				colMdSub1=1;
				colMdSub2=11;
				colSubStyle1="style=\"width: 11.11%;\"";
				colSubStyle2="style=\"width: 88.89%;\"";
			}
			sbCol=new StringBuilder();
			sbCol.append("					<div class=\"col-md-"+colMd+"\">"+RT_1);
			sbCol.append("						<div class=\"form-group\">"+RT_1);
			String requiredCls="";
			if(isEdit&&detailList.get(i).isRequired()){
				requiredCls=" required";
			}
			sbCol.append("							<label class=\"control-label col-md-"+colMdSub1+requiredCls+"\" "+colSubStyle1+">"+detailList.get(i).getColDesc()+"</label>"+RT_1);		
			sbCol.append("							<div class=\"col-md-"+colMdSub2+"\" "+colSubStyle2+">"+RT_1);
			sbCol.append("								").append(createHtmlEle(detailList.get(i))).append(RT_1);
			sbCol.append("							</div>"+RT_1);
			sbCol.append("						</div>"+RT_1);
			sbCol.append("					</div>"+RT_1);
			//设置列==========================
			
			colIndex+=detailList.get(i).getColCount();
			
			if(detailList.get(i).isRow()){//是否单独一行
				sb.append("				<div class=\"row\">"+RT_1);
				sb.append(sbCol.toString());
				sb.append("				</div>"+RT_1);
				colIndex=0;
			}else{
				if(colIndex==1){
					sb.append("				<div class=\"row\">"+RT_1);
				}
				sb.append(sbCol.toString());
				if(colIndex%3==0||i==(detailList.size()-1)){
					colIndex=0;
					sb.append("				</div>"+RT_1);
				}
			}
		}
		return sb.toString();
	}
	
	
	private static String createListContent(MappingTableEntity info,List<MappingTableSubEntity> list){
		StringBuilder sb=new StringBuilder();
		sb.append("	<div id=\"yy-page\" class=\"container-fluid page-container\">").append(RT_1);
		
		if(!info.getTemplateType().equals(EntityInfo.GENTYPE_REFLISTSELECT)){//列表参照选择
			sb.append("		<div class=\"page-content\" id=\"yy-page-list\">").append(RT_1);
			sb.append("			<div class=\"row yy-toolbar\">").append(RT_1);
			sb.append("				<button id=\"yy-btn-add\" class=\"btn blue btn-sm\">").append(RT_1);
			sb.append("					<i class=\"fa fa-plus\"></i> 新增").append(RT_1);
			sb.append("				</button>").append(RT_1);
			sb.append("				<button id=\"yy-btn-remove\" class=\"btn red btn-sm\">").append(RT_1);
			sb.append("					<i class=\"fa fa-trash-o\"></i> 删除").append(RT_1);
			sb.append("				</button>").append(RT_1);
			sb.append("				<button id=\"yy-btn-refresh\" class=\"btn blue btn-sm\">").append(RT_1);
			sb.append("					<i class=\"fa fa-refresh\"></i> 刷新").append(RT_1);
			sb.append("				</button>").append(RT_1);
			sb.append("			</div>").append(RT_1);
		}

		sb.append("			<div class=\"row yy-searchbar form-inline\">").append(RT_1);
		sb.append("				<form id=\"yy-form-query\">").append(RT_1);
		
		boolean hasSearch=false;
		for(MappingTableSubEntity col:list){
			if(col.isSearch()){
				hasSearch=true;
				if(col.getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
					sb.append("					<label for=\"search_EQ_"+col.getColDesc()+"\" class=\"control-label\">"+col.getColDesc()+"</label>").append(RT_1);
					sb.append("					<select class=\"yy-input-enumdata form-control\" id=\"search_EQ_"+col.getColName()+"\" ").append(RT_1);
					sb.append("						name=\"search_EQ_"+col.getColDesc()+"\" data-enum-group=\""+col.getEnumGroup()+"\"></select>").append(RT_2);
				}else{
					sb.append("					<label for=\"search_LIKE_"+col.getColDesc()+"\" class=\"control-label\">"+col.getColDesc()+"</label>").append(RT_1);
					sb.append("					<input type=\"text\" autocomplete=\"on\" name=\"search_LIKE_"+col.getColDesc()+"\"").append(RT_1);
					sb.append("						id=\"search_LIKE_"+col.getColDesc()+"\" class=\"form-control input-sm\">").append(RT_2);
				}
			}
		}
		if(!hasSearch){//没有就默认一个给查询
			sb.append("					<label for=\"search_EQ_billstatus\" class=\"control-label\">xxx</label>").append(RT_1);
			sb.append("					<select class=\"yy-input-enumdata form-control\" id=\"search_EQ_billstatus\" ").append(RT_1);
			sb.append("						name=\"search_EQ_billstatus\" data-enum-group=\"BillApplyStatus\"></select>").append(RT_2);
			sb.append("					<label for=\"search_LIKE_name\" class=\"control-label\">xxxxx</label>").append(RT_1);
			sb.append("					<input type=\"text\" autocomplete=\"on\" name=\"search_LIKE_name\"").append(RT_1);
			sb.append("						id=\"search_LIKE_name\" class=\"form-control input-sm\">").append(RT_2);
		}
		
		sb.append("					<button id=\"yy-btn-search\" type=\"button\" class=\"btn btn-sm btn-info\">").append(RT_1);
		sb.append("						<i class=\"fa fa-search\"></i>查询").append(RT_1);
		sb.append("					</button>").append(RT_1);
		sb.append("					<button id=\"rap-searchbar-reset\" type=\"reset\" class=\"red\">").append(RT_1);
		sb.append("						<i class=\"fa fa-undo\"></i> 清空").append(RT_1);
		sb.append("					</button>").append(RT_1);
		sb.append("				</form>").append(RT_1);
		sb.append("			</div>").append(RT_1);
		sb.append("			<div class=\"row\">").append(RT_1);
		sb.append("				<table id=\"yy-table-list\" class=\"yy-table\">").append(RT_1);
		sb.append("					<thead>").append(RT_1);
		sb.append("						<tr>").append(RT_1);
		sb.append("							<th style=\"width: 30px;\">序号</th>").append(RT_1);
		
		if(!info.getTemplateType().equals(EntityInfo.GENTYPE_REFLISTSELECT)){//列表参照选择
			sb.append("							<th class=\"table-checkbox\">").append(RT_1);
			sb.append("								<input type=\"checkbox\" class=\"group-checkable\" data-set=\"#yy-table-list .checkboxes\"/>").append(RT_1);
			sb.append("							</th>").append(RT_1);
		}

		sb.append("							<th>操作</th>").append(RT_1);
		for(MappingTableSubEntity col:list){
			if(col.isListVisiable()){
				sb.append("							<th>"+col.getColDesc()+"</th>").append(RT_1);
			}
		}
		sb.append("						</tr>").append(RT_1);
		sb.append("					</thead>").append(RT_1);
		sb.append("					<tbody></tbody>").append(RT_1);
		sb.append("				</table>").append(RT_1);
		sb.append("			</div>").append(RT_1);
		sb.append("		</div>").append(RT_1);
		sb.append("	</div>").append(RT_2);
		
		return sb.toString();
	}
	/**
	 * 创建列表列
	 * @param list
	 * @return
	 */
	private static String createTableCols(MappingTableEntity info,List<MappingTableSubEntity> list,boolean isShowCheckBox,boolean isRenderEdit,String actionCol){
		StringBuilder sb=new StringBuilder();
		if(info.isMain()){
			sb.append("		var _tableCols = [ {").append(RT_1);
		}else{
			sb.append("		var _subTableCols = [ {").append(RT_1);
		}
		sb.append("				data : null,").append(RT_1);
		sb.append("				orderable : false,").append(RT_1);
		sb.append("				className : \"center\",").append(RT_1);
		sb.append("				width : \"50\"").append(RT_1);
		
		if(info.getTemplateType().equals(EntityInfo.GENTYPE_REFLISTSELECT)){//列表参照选择
			sb.append("			},{").append(RT_1);
			sb.append("				data : \"uuid\",").append(RT_1);
			sb.append("				className : \"center\",").append(RT_1);
			sb.append("				orderable : false,").append(RT_1);
			sb.append("				render : YYDataTableUtils.renderSelectActionSubCol,").append(RT_1);								
			sb.append("				width : \"50\"").append(RT_1);
		}else{
			if(isShowCheckBox){
				sb.append("			},{").append(RT_1);
				sb.append("				data : \"uuid\",").append(RT_1);
				sb.append("				orderable : false,").append(RT_1);								
				sb.append("				className : \"center\",").append(RT_1);
				sb.append("				/* visible : false, */").append(RT_1);
				sb.append("				width : \"40\",").append(RT_1);
				sb.append("				render : YYDataTableUtils.renderCheckCol").append(RT_1);	
			}
			if(!StringUtils.isEmpty(actionCol)){
				sb.append("				},{").append(RT_1);
				sb.append("				data : \"uuid\",").append(RT_1);
				sb.append("				className : \"center\",").append(RT_1);
				sb.append("				orderable : false,").append(RT_1);
				sb.append("				").append(actionCol).append(RT_1);								
				sb.append("				width : \"50\"").append(RT_1);
			}
		}
		boolean hasAppendUuid=false;
		for(int i=0;i<list.size();i++){
			if(list.get(i).isListVisiable()){
				sb.append("			},{").append(RT_1);
				sb.append("				data : \""+list.get(i).getColName()+"\",").append(RT_1);
				sb.append("				width : \"").append(list.get(i).getColWidth()).append("\",").append(RT_1);
				sb.append("				className : \"center\",").append(RT_1);
				if(isRenderEdit){
					sb.append("				render : function(data, type, full) {").append(RT_1);
					if(list.get(i).getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
						if(!hasAppendUuid){
							sb.append("					return '<input class=\"form-control\" type=\"hidden\" value=\"'+ full.uuid + '\" name=\"uuid\">'+").append(RT_1);
							sb.append("							creRnum('sys_sex', '").append(list.get(i).getColName()).append("', data,false);").append(RT_1);
						}else{
							sb.append("							return creRnum('sys_sex', '").append(list.get(i).getColName()).append("', data,false);").append(RT_1);
						}
					}else{
						if(!hasAppendUuid){
							sb.append("					return '<input class=\"form-control\"  type=\"hidden\" value=\"'+ full.uuid + '\" name=\"uuid\">'+").append(RT_1);
							sb.append("							'<input class=\"form-control\" value=\"'+ data + '\" name=\"").append(list.get(i).getColName()).append("\">';").append(RT_1);
						}else{
							sb.append("					return '<input class=\"form-control\" value=\"'+ data + '\" name=\"").append(list.get(i).getColName()).append("\">';").append(RT_1);	
						}	
					}
					sb.append("				},").append(RT_1);
				}else{
					if(list.get(i).getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
						sb.append("				render : function(data, type, full) {").append(RT_1);
						sb.append("					return YYDataUtils.getEnumName(\"sys_sex\", data);").append(RT_1);
						sb.append("				},").append(RT_1);
					}
				}
				sb.append("				orderable : true").append(RT_1);
				hasAppendUuid=true;
			}
		}
		sb.append("			}];").append(RT_1);
		return sb.toString();
	}
	/**
	 * 创建验证方法
	 * @param detailList
	 * @return
	 */
	private static String createValidateFormFunc(List<MappingTableSubEntity> detailList){
		StringBuilder sb=new StringBuilder();
		sb.append("		//表单校验"+RT_1);	
		sb.append("		function validateForms(){"+RT_1);	
		sb.append("			validata = $('#yy-form-edit').validate({"+RT_1);	
		sb.append("				onsubmit : true,"+RT_1);	
		sb.append("				rules : {"+RT_1);	
		
		boolean hasRule=false;
		for(int i=0;i<detailList.size();i++){
			String requiredStr="";
			if(detailList.get(i).isRequired()){
				requiredStr="required : true,";
			}
			if(!hasRule){
				sb.append("					'"+detailList.get(i).getColName()+"' : {"+requiredStr+"maxlength : 100}");	
			}else{
				sb.append(",").append(RT_1).append("					'"+detailList.get(i).getColName()+"' : {"+requiredStr+"maxlength : 100}");	
			}
			hasRule=true;
		}
		sb.append(RT_1).append("				}"+RT_1);	
		sb.append("			});"+RT_1);					
		sb.append("		}"+RT_1);
		return sb.toString();
	}
	
	  /**
     * 以行为单位读取文件，常用于读面向行的格式化文件
     */
    public static String readFileByLines(String fileName,String formEleStr,String validateFormStr,String showDataStr) {
    	StringBuilder sb=new StringBuilder();
    	fileName=BeanUtils.class.getResource("")+File.separator+templatefiles+File.separator+fileName;
		fileName=fileName.replace("file:/", "");
		
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
//            reader = new BufferedReader(new FileReader(file));
        	reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),"UTF-8"));
            String tempString = null;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
            	if(tempString.contains("#formElements#")){
            		sb.append(formEleStr).append(RT_1);
            	}else if(tempString.contains("#validateForms#")){
            		sb.append(validateFormStr).append(RT_1);
            	}else if(tempString.contains("#showDataSetVal#")){
            		sb.append(showDataStr).append(RT_1);
            	}else{
            		sb.append(tempString).append(RT_1);
            	}
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
        return sb.toString();
    }
    /**
     * 创建文件
     * @Title: createFile 
     * @author liusheng
     * @date 2017年6月28日 下午2:39:19 
     * @param @param fileName
     * @param @return
     * @param @throws IOException 设定文件 
     * @return File 返回类型 
     * @throws
     */
    public static File createFile(String fileName) throws IOException{
    	File file=new File(fileName);
		 //判断目标文件所在的目录是否存在  
       if(!file.getParentFile().exists()) {  
           //如果目标文件所在的目录不存在，则创建父目录  
           System.out.println("目标文件所在目录不存在，准备创建它！");  
           if(!file.getParentFile().mkdirs()) {  
               System.out.println("创建目标文件所在目录失败！");  
           }  
       }
		 if(!file.exists()){
	         file.createNewFile();
		 }  
		 return file;
    }
    
	/**
	 * 获取路径的最后面字符串<br>
	 * 如：<br>
	 *     <code>str = "com.b510.base.bean.User"</code><br>
	 *     <code> return "User";<code>
	 * @param str
	 * @return
	 */
	public static String getLastChar(String str) {
		if ((str != null) && (str.length() > 0)) {
			int dot = str.lastIndexOf('.');
			if ((dot > -1) && (dot < (str.length() - 1))) {
				return str.substring(dot + 1);
			}
		}
		return str;
	}
	
	/**
	 * 把第一个字母变为小写<br>
	 * 如：<br>
	 *     <code>str = "UserDao";</code><br>
	 *     <code>return "userDao";</code>
	 * @param str
	 * @return
	 */
	public static String getLowercaseChar(String str){
		return str.substring(0,1).toLowerCase()+str.substring(1);
	}
	
	/**
	 * 将第一个字母变为大写
	 * @Title: getUppercaseChar 
	 * @author liusheng
	 * @date 2017年6月28日 下午1:48:37 
	 * @param @param str
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	public static String getUppercaseChar(String str){
		return str.substring(0,1).toUpperCase()+str.substring(1);
	}

	/**
	 * 显示信息
	 * @param info
	 */
	public static void showInfo(String info){
		System.out.println("创建文件："+ info+ "成功！");
	}
	
	/**
	 * 获取系统时间
	 * @return
	 */
	public static String getDate(){
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return simpleDateFormat.format(new Date());
	}
	
	
	/**
	 * 追加类备注
	 * @Title: appendFileAnno 
	 * @author liusheng
	 * @date 2017年6月28日 下午3:02:51 
	 * @param @param enInfo
	 * @param @param sb 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public static void appendFileAnno(MappingTableEntity enInfo,StringBuilder sb){
		sb.append(RT_1).append("/**"+RT_1+BLANK_1+"*"+BLANK_1+enInfo.getEntityChinese() +RT_1);//类注释
		sb.append(BLANK_1+"*"+BLANK_1+"@author "+enInfo.getAuthor() +RT_1);
		sb.append(BLANK_1+"*"+BLANK_1+"@date " +getDate()+RT_1);
		sb.append(BLANK_1+"*/"+RT_1);
	}
	
	private static String createHtmlEle(MappingTableSubEntity col){
		String htmlStr="";
		if(col.getEleType().equals(MappingTableSubEntity.EleType.DATE)){
			htmlStr="<input name=\""+col.getColName()+"\" id=\""+col.getColName()+"\" type=\"text\" value=\"${entity."+col.getColName()+"}\" class=\"Wdate form-control\" onclick=\"WdatePicker();\">";
		}else if(col.getEleType().equals(MappingTableSubEntity.EleType.DATETIME)){
			htmlStr="<input name=\""+col.getColName()+"\" id=\""+col.getColName()+"\" type=\"text\" value=\"${entity."+col.getColName()+"}\" class=\"Wdate form-control\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});\">";
		}else if(col.getEleType().equals(MappingTableSubEntity.EleType.SELECT)){
			htmlStr="<select name=\""+col.getColName()+"\" id=\""+col.getColName()+"\" data-enum-group=\""+col.getEnumGroup()+"\" class=\"yy-input-enumdata form-control\"></select>";
		}else if(col.getEleType().equals(MappingTableSubEntity.EleType.TEXTAREA)){
			htmlStr="<textarea name=\""+col.getColName()+"\" id=\""+col.getColName()+"\" class=\"form-control\">${entity."+col.getColName()+"}</textarea>";
		}else if(col.getEleType().equals(MappingTableSubEntity.EleType.REF)){
			StringBuilder refStr=new StringBuilder();
			refStr.append("<div class=\"input-group input-icon right\">").append(RT_1);
			refStr.append("								<input id=\""+col.getColName()+"Uuid\" name=\""+col.getColName()+".uuid\" type=\"hidden\" value=\"${entity."+col.getColName()+"}\">").append(RT_1);
			refStr.append("								<i class=\"fa fa-remove\" onclick=\"cleanDef('"+col.getColName()+"Uuid','"+col.getColName()+"Name');\" title=\"清空\"></i>").append(RT_1);
			refStr.append("								<input id=\""+col.getColName()+"Name\" name=\""+col.getColName()+"Name\" type=\"text\" class=\"form-control\" readonly=\"readonly\" value=\"${entity."+col.getColName()+"}\">").append(RT_1);
			refStr.append("								<span class=\"input-group-btn\">").append(RT_1);
			refStr.append("									<button id=\""+col.getColName()+"-select-btn\" class=\"btn btn-default btn-ref\" type=\"button\">").append(RT_1);
			refStr.append("										<span class=\"glyphicon glyphicon-search\"></span>").append(RT_1);
			refStr.append("									</button>").append(RT_1);
			refStr.append("								</span>").append(RT_1);
			refStr.append("							</div>");
			htmlStr=refStr.toString();
		}else{
			htmlStr="<input name=\""+col.getColName()+"\" id=\""+col.getColName()+"\" type=\"text\" value=\"${entity."+col.getColName()+"}\" class=\"form-control\">";
		}
		return htmlStr;
	}
}
