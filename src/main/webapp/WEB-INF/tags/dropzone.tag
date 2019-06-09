<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="name"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="id"%>
<%@ attribute name="uploadurl" type="java.lang.String" required="false" description="提交地址"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- BEGIN PAGE CONTENT-->
<form action="#"  id="${id}" name="${name}" enctype="multipart/form-data">
	  <input type="hidden" name = "uploadurl" value="${uploadurl}">
	  <input type="hidden" name = "entityType">
	  <input type="hidden" name = "entityUuid">
	  <div class="fallback"> <!-- This div will be removed if the fallback is not necessary -->
	    <input type="file" name="attachment[]" />
	    etc...
	  </div>
	  <div class="dz-message rap-dz-message"> 
	  	<span>拖拽文件到此处进行上传<br/>（或点击此处选择文件）</span>
	  </div>
	  
</form>
<!-- END PAGE CONTENT-->
