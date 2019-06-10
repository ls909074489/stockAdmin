package ${packageName};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.yy.frame.dao.IBaseDAO;
import com.yy.frame.service.BaseServiceImpl;
import ${packageName}.${commonEntityName}Dao;

/**
 * ${entityChinese}service
 * @ClassName: ${commonEntityName}Service
 * @author  
 * @date ${createDate}
 */
@Service
@Transactional
public class ${commonEntityName}Service extends BaseServiceImpl<${entityName}, String> {

	@Autowired
	private ${commonEntityName}Dao dao;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

}
