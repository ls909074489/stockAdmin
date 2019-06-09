<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="验证码输入框名称"%>
<%@ attribute name="inputClass" type="java.lang.String" required="false" description="验证框Css类"%>
<%@ attribute name="inputStyle" type="java.lang.String" required="false" description="验证框样式"%>
<%@ attribute name="placeholder" type="java.lang.String" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<input type="text" id="${name}" name="${name}" maxlength="6" class="${inputClass}" style="${inputStyle}" placeholder="${placeholder}"/>
<img id="img-${name}" src="${ctx}/pub/validateCodeServlet" onclick="$('.${name}Refresh').click();" class="rap-validateCode mid"/>
<a href="javascript:" onclick="$('#img-${name}').attr('src','${ctx}/pub/validateCodeServlet?'+new Date().getTime());" class="mid ${name}Refresh">看不清</a>