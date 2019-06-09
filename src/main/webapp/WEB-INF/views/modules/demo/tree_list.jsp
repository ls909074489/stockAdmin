<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/bd/administrative" />
<html>
<head>
<title>行政区域</title>
</head>
<body>
<div class="page-content" id="yy-page-list" style="" align="center">
		<h3>add by ls2008</h3>
		<hr>
		<div id="sqlDiv" style="text-align: left;"></div>
		<hr><hr>
		<div style="background-color: red;width: 100%; height: 10px;"></div>
		<div id="samesqlDiv" style="text-align: left;"></div>
		<div style="height: 20px;"></div>
		1:AdministrativeEntity> 2:DepartmentEntity  3:FailureCauseClassEntity  4 :FuncEntity  5:MaterialClassEntity  6:MaterialTypeEntity 7:OrgEntity	<br>
		8:OutletAreaEntity	9:OutletsEntity 10:ProcessGroupEntity 11:RoleGroupEntity 12:SupplierClassEntity 13:TableRelationshipsEntity 14:ComplaintClassEntity<br>
		<div class="row-fluid">
			<!-- <div style="text-align: center;">
				<a id="expandAllBtn" href="#" onclick="return false;">【展开】</a> 
				<a id="collapseAllBtn" href="#" onclick="return false;">【折叠】</a>
			</div> -->
			<div class="row-fluid" align="center">
				<div class="btn-group btn-group-solid">
					<button id="yy-expandAll" type="button" class="btn btn-sm blue">
						全展开
					</button>
					<button  id="yy-collapseAll" type="button" class="btn btn-sm green ">
						全折叠
					</button>
					<button id="yy-expandSon" type="button" class="btn btn-sm blue">
						展开
					</button>
					<button id="yy-collapseSon" type="button" class="btn btn-sm green ">
						折叠
					</button>
					
					<button id="yy-btn-createStock" class="btn blue btn-sm" onclick="getNodePath();">
						<i class="fa"></i> 检查nodepath==${type}
					</button> 
				</div>
			</div>
			<span class="span12">
				<input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
				type="text" autocomplete="off" placeholder="查找...">
			</span>
		</div>
		<div id="ztree" class="ztree"></div>
</div>
	<!-- 公共脚本 -->
	
	<!-- 树功能脚本 -->
	<jsp:include page="/WEB-INF/views/common/ztreescript.jsp" flush="true">   
	 	 <jsp:param name="serviceurl" value="${serviceurl}"/>
	     <jsp:param name="dataTreeUrl" value="${ctx}/bd/ref/dataTree?type=${type}"/>
	     <jsp:param name="onDblClickMethod" value="selfOnClick"/> 
	     <jsp:param name="onClickMethod" value="selfOnClick"/>
	</jsp:include> 
	
	
	<script type="text/javascript">
			function selfOnClick(event, treeId, treeNode){
				alert(treeNode);
			}
	
			function getNodePath(){
				var treeObj = $.fn.zTree.getZTreeObj("ztree");
				var nodes = treeObj.transformToArray(treeObj.getNodes());
				var sameCount=0;
				var diffentCount=0;
				var sql="";
				var samesql="";
				var ttt='${type}';
				
				 var tableName='yy_org';
				if(ttt=='1'){
					tableName='bd_administrative';
				}else if(ttt=='2'){
					tableName='yy_department';
				}else if(ttt=='3'){
					tableName='bd_failure_cause_class';
				}else if(ttt=='4'){
					tableName='yy_func';
				}else if(ttt=='5'){
					tableName='bd_material_class';
				}else if(ttt=='6'){
					tableName='bd_material_type';
				}else if(ttt=='7'){
					tableName='yy_org';
				}else if(ttt=='8'){
					tableName='bd_outlet_area';
				}else if(ttt=='9'){
					tableName='yy_org_outlets';
				}else if(ttt=='10'){
					tableName='yy_process_group';
				}else if(ttt=='11'){
					tableName='yy_rolegroup';
				}else if(ttt=='12'){
					tableName='bd_supplier_class';
				}else if(ttt=='13'){
					tableName='yy_table_relationships';
				}     
				    
				for(var i=0;i<nodes.length;i++){    
				     var dbPath=nodes[i].nodeData.nodepath;
				    // var pagePath=getPathByParent(nodes[i].nodeData.code,nodes[i].getParentNode());
				    var pagePath=getPathByParent(nodes[i].id,nodes[i].getParentNode()) 
				    //console.info(dbPath+"=111=="+pagePath);
				    
				    
				    //sql+="<div>update "+tableName+" set nodepath='"+pagePath+"' where uuid='"+nodes[i].id+"';</div>";
				    
					if(dbPath==pagePath){
						sql+="<div>update "+tableName+" set nodepath='"+pagePath+"' where uuid='"+nodes[i].id+"';</div>";
						sameCount++;
					}else{
						samesql+="<div>update "+tableName+" set nodepath='"+pagePath+"' where uuid='"+nodes[i].id+"';</div>";
						diffentCount++;
					}
				}
				console.info("共："+nodes.length+" 相同："+sameCount+" 不同："+diffentCount);
				//YYUI.promAlert("共："+nodes.length+" 相同："+sameCount+" 不同："+diffentCount);
				$("#sqlDiv").html(sql);
				$("#samesqlDiv").html(samesql);
			}
			
			function getPathByParent(path,pNode){
				if(pNode!=null){
					//path=pNode.nodeData.code+","+path;
					path=pNode.id+","+path;
					if(pNode.getParentNode()!=null){
						path=getPathByParent(path,pNode.getParentNode());
					}
				}
				return path;
			}
	</script>
</body>
</html>