<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/instructions" />
<html>
<head>
<title>帮助手册</title>
</head>
<body>
	<div id="maindiv" class="ui-layout-center">
		<div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<div class="col-md-12">
								<div style="text-align: center;">
									<h3>${func.func_name}帮助说明</h3>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<div class="col-md-12">
								<div>
									${instructions.content}
								</div>
							</div>
						</div>
					</div>	
				</div>
		</div>
	</div>

</body>
</html>