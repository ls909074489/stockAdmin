package ${packageName};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.yy.frame.dao.IBaseDAO;
import com.yy.frame.service.TreeServiceImpl;
import ${packageName}.${commonEntityName}DAO;


/**
 * ${entityChinese}service
 * @ClassName: UserDAO
 * @author  
 * @date ${createDate}
 */
@Service
@Transactional
public class ${commonEntityName}Service extends TreeServiceImpl<${entityName}, String> {

	@Autowired
	private ${commonEntityName}DAO dao;

	@Override
	protected IBaseDAO<${entityName}, String> getDAO() {
		return dao;
	}

}
