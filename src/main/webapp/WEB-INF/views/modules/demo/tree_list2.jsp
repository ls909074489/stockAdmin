<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<div class="page-content" id="yy-page-list" style="" align="center">
		<h3>add by ls2008</h3>
		<hr>
		<div id="sqlDiv" style="text-align: left;"></div>
		<div style="height: 20px;"></div>
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
						<i class="fa"></i> 检查nodepath
					</button> 
				</div>
			</div>
			<span class="span12">
				<input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
				type="text" autocomplete="off" placeholder="查找...">
			</span>
		</div>
		<div id="treeFunc" class="ztree"></div>
		
		
</div>

<script type="text/javascript">
	var _zTree;//树
	var _changeParent;//是否变更了父节点
	//页面形态
	var _isSelected = true;

	var _treeSetting = {
			check : {
				enable : false
			},
			async: {
				enable: true,
				url:"../sys/role/getRoleGroup?roleId=${roleId}",
				//url:"../sys/data/dataAdmin",		
				autoParam:["id", "name=n", "level=lv"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			view: {
				dblClickExpand: false,
				//ddDiyDom: addDiyDom,
				fontCss: getFontCss   //搜索结果高亮
			},
			data: {
				key: {
					title:"title"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				onDblClick: treeClickMethod,
				onClick : treeClickMethod
			}
		};
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	//查询树节点后高亮显示
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}



	// _zTree 返回数据进行预处理
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}


	// _zTree 点击触发的事件
	function treeClickMethod(event, treeId, treeNode) {
		console.info(event);
		console.info(treeId);
		console.info(treeNode);
		alert("点击了"+treeNode.id+":"+treeNode.name);
		_zTree.selectNode(treeNode);
	}
	
	function onSearchTree(){
		var searchValue = $('#searchTreeNode').val();
		YyZTreeUtils.searchNode(_zTree,searchValue);
	}
	//绑定按钮事件
 	function bindDefaultActions() {
		//zTree的搜索事件绑定
		$('#searchTreeNode').bind("propertychange", onSearchTree)
			.bind("input", onSearchTree); 
		$('#searchTreeNode').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onSearchTree();
	        }
	    });
	}

	

	$(document).ready(function() {
		//加载ztree
		_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
		/* $("#expandAllBtn").bind("click", {type:"expandAll"}, function(){
			_zTree.expandAll(true);
		});//展开
		$("#collapseAllBtn").bind("click", {type:"collapseAll"}, function(){
			_zTree.expandAll(false);
		});//折叠 */
		
		//折叠/展开
		$('#yy-expandAll').bind('click', function() {
			_zTree.expandAll(true);
		});
		$('#yy-collapseAll').bind('click', function() {
			_zTree.expandAll(false);
		});
		$('#yy-expandSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				YYUI.promMsg("请选择节点");
				return;
			}
			_zTree.expandNode(nodes, true, true, true);
		});
		
		$('#yy-collapseSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				YYUI.promMsg("请选择节点");
				return;
			}
			_zTree.expandNode(nodes, false, true, true);
		});
		//绑定按钮
		bindDefaultActions();

		YYFormUtils.lockForm('yy-form-func');
	});
	
	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	}
	
	

	function getNodePath(){
		var treeObj = $.fn.zTree.getZTreeObj("treeFunc");
		var nodes = treeObj.transformToArray(treeObj.getNodes());
		var sameCount=0;
		var diffentCount=0;
		var sql="";
		for(var i=0;i<nodes.length;i++){    
		     var dbPath=nodes[i].nodeData.nodepath;
		    // var pagePath=getPathByParent(nodes[i].nodeData.code,nodes[i].getParentNode());
		    var pagePath=getPathByParent(nodes[i].id,nodes[i].getParentNode()) 
		    //console.info(dbPath+"=111=="+pagePath);
		    
		    sql+="<div>update yy_rolegroup set nodepath='"+pagePath+"' where uuid='"+nodes[i].id+"';</div>";
		    
			if(dbPath==pagePath){
				sameCount++;
			}else{
				diffentCount++;
			}
		}
		console.info("共："+nodes.length+" 相同："+sameCount+" 不同："+diffentCount);
		//YYUI.promAlert("共："+nodes.length+" 相同："+sameCount+" 不同："+diffentCount);
		$("#sqlDiv").html(sql);
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
	
