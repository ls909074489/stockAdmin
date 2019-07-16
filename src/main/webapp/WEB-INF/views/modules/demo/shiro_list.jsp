<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="page-content" id="yy-page-list" align="center">
	<h3>add by ls2008</h3>
	<hr>
	
	<p>(shiro:hasPermission)验证当前用户是否拥有制定权限</p>
	<shiro:hasPermission name="user:create">  
	    <a href="createUser.jsp">Create a new User</a>  
	</shiro:hasPermission>  
	<hr>
	
	<p>(shiro:hasAnyRoles)验证当前用户是否属于以下任意一个角色。</p>
	<shiro:hasAnyRoles name="admin, project manager, aaa">
		   我有当前标签的一个角色啦  
	</shiro:hasAnyRoles>
	<hr>
	
	
	<p>(shiro:hasRole)验证当前用户是否属于该角色</p>
	<shiro:hasRole name="administrator">  
	    <a href="admin.jsp">Administer the system</a>  
	</shiro:hasRole>  
	<hr>
	
	<shiro:hasPermission name="role_add">  
	  <input type="button" value="添加角色"/>
	</shiro:hasPermission>  
	<hr>
</div>

	
