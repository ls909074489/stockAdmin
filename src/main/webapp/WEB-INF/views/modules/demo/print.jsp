<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<title></title>
<%-- <script language="javascript" src="${ctx}/assets/lodop/query-1.4.4.min.js"></script> --%>



<div class="page-content" id="yy-page-list" style="" align="center">
	<br><br>
	<input type="button" onclick="printDiv('form2');" value="打印"/>
	<br><br>
	<div id="form2">
		 
		  <table border="1" width="100%" height="106" cellspacing="0" bgcolor="" style="border:solid 1px black;border-collapse:collapse">
		  <tr><td colspan="3"> <span><h2><font color="#009999">演示如何打印当前页面的内容：</font></h2></span></td></tr>
		  <tr>
		    <td width="66" height="16" style="border:solid 1px black"><font color="#0000FF">X</font><font color="#0000FF">等</font></td>
			<td width="51" height="16" style="border:solid 1px black"><font color="#0000FF">Y等</font></td>
			<td width="51" height="16" style="border:solid 1px black"><font color="#0000FF">Z等</font></td>
		  </tr> 
		  <tr>
		    <td width="66" height="12" style="border:solid 1px black"><span style="font-family:Wingdings;font-size:25px;" >&#254;</span>X001</td>
			<td width="51" height="12" style="border:solid 1px black"><strike>Y001</strike>
				<img alt="" class="img-circle" src="${ctx}/assets/metronic/v4.5/global/img/portfolio/1200x900/91.jpg" style="height: 100px;width:100px;">
				<input type="checkbox" name="aa" checked="checked"/>====<input type="radio" checked="checked">
			</td>
			<td width="51" height="44" rowspan="3"  style="border:solid 1px black">
		      <ol style="list-style-type:upper-alpha;list-style-position:inside;">
		        <li>Z001</li>
		        <li>Z002</li>
		        <li>Z003</li>
		        <li>Z004</li>
		        <li>Z005</li>
		       </ol>
		    </td>
		   </tr> 
		 <tr>
		 	<td width="30%" height="16" style="border:solid 1px black"><strong>X002</strong></td>
			<td width="51" height="16"  style="border:solid 1px black"><u>Y002</u><span style="visibility: hidden">hidesome</span></td></tr> 
		  <tr>
		  	<td width="30%" height="16" style="border:solid 1px black"><span style="text-decoration: overline">X003</span>
			</td><td width="40%" height="16" style="border:solid 1px black"><em>Y003</em><input type="radio" name="R1"><input type="radio" name="R1" checked></td>
		 </tr>
		</table>
			<div id="div_print">
		<h1 style="Color:Red">The Div content which you want to print</h1>
	</div>
	
	</div>
	

	
</div>
	
<script type="text/javascript">
 function printDiv(eId){
	  $("#"+eId).jqprint({printContainer: false});
	  console.info(222);
	 //("#"+eId).jqprint({ operaSupport: true });
 }
$(document).ready(function() {
	/* $("#printContainer").jqprint({
	     debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
	     importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
	     printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
	     operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
	}); */
});



</script>