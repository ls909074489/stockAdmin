<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:forEach var="cur" items="${functreeList}" varStatus="vs">
  <c:if test="${cur.nodeData.func_type=='space'}">
		<li class="nav-item">
		<a href="javascript:;" class="nav-link nav-toggle">
			<c:if test="${ empty cur.nodeData.iconcls }">
				<i class="fa fa-th-large"></i>
			</c:if>
			<c:if test="${ not empty cur.nodeData.iconcls }">
				<i class="${cur.nodeData.iconcls}"></i>
			</c:if>
			<span class="title">${cur.nodeData.func_name}</span>
			<span class="arrow"></span>
		</a>
  </c:if>
  
  <c:if test="${cur.nodeData.func_type=='func'}">
  	<c:set var="url" value="${fn:replace(cur.nodeData.func_url,'@ctx@',ctx)}" />
	  	<li class="nav-item">
			<a class="J_menuItem" data-index="${cur.nodeData.uuid}" href="${url}">
				<c:if test="${ empty cur.nodeData.iconcls }">
					<i class="fa fa-angle-right"></i>
				</c:if>
				<c:if test="${ not empty cur.nodeData.iconcls }">
					<i class="${cur.nodeData.iconcls}"></i>
				</c:if>
				${cur.nodeData.func_name}
			</a>
		</li>
  </c:if>
  
  <!-- 如果有childen -->
  <c:if test="${not empty cur.children }">
  	<!-- 注意此处，子列表覆盖treeList，在request作用域 --> 
    <c:set var="functreeList" value="${cur.children}" scope="request" />
    <ul class="sub-menu">
    	<!-- 递归 调用 -->
    	<c:import url="subfunc.jsp" />
    </ul>
  </c:if>
  
</c:forEach>