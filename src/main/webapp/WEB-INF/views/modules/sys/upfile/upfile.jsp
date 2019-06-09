<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>文件上传</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<tags:uploadFiles id="uploadFiles" />
		</div>
	</div>
	<script type="text/javascript">
		var _fileUploadTool;//上传变量
		var entityUuid = '${entityUuid}';
		var entityType = '${entityType}';
		var editAble = '${editAble}';
		$(document).ready(function() {
			_fileUploadTool = new FileUploadTool("uploadFiles", entityType);
			if(editAble=="true"){
				_fileUploadTool.loadFilsTableList(entityUuid, "edit");
				_fileUploadTool.init("edit");
			} else {
				_fileUploadTool.loadFilsTableList(entityUuid, "view");
				_fileUploadTool.init("view");
			}
		});
		
	</script>
</body>
</html>