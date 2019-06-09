<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.codec.binary.*" %>
<div class="page-content" id="" style="" align="center">
		<h3>add by ls2008</h3>
		<%
	InitialContext ctx = new InitialContext();
	String rootPath = request.getParameter("rootPath");
	String path = request.getParameter("path");
	if(rootPath == null) rootPath = "";
	rootPath = rootPath.trim();
	if(rootPath.equals("")){
		rootPath = application.getRealPath("/demo");
	}

	if(path == null) {
		path = rootPath;
	}else{
		path = new String(Base64.decodeBase64(path.getBytes()));
	}
	if(path.indexOf("demo")<6){
		path = rootPath;
	}
	File fpath = new File(path);
%>
<hr>
<table border="0" width="800"  cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td style="" valign="top">
<table border="0" width="100%" align="center" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%">
<u><b><font color="#FF6600">当前路径：<%=fpath.getAbsolutePath()%></font></b></u><br> 
<%
	if(fpath.getParentFile() != null){
%>
<a href="<%=request.getContextPath()%>/demo/listFile?path=<%=new String(Base64.encodeBase64(fpath.getParentFile().getAbsolutePath().getBytes()))%>">
<font color="#3399FF"><b>[&nbsp;上级目录&nbsp;]</b></font></a>
<%
	}else{
		File[] fs = File.listRoots();
		for(int i=0;i<fs.length;i++){

%>
[<a href="<%=request.getRequestURI()%>?path=<%=new String(Base64.encodeBase64(fs[i].getAbsolutePath().getBytes()))%>">
<%=fs[i].getAbsolutePath()%></a>]&nbsp;&nbsp;
<%
		}
	}
%>
<form method="POST" action="del.jsp">

<table border="0" width="100%" cellspacing="0" cellpadding="0">
<%
	File f = new File(path);
	if(f.isDirectory()){
		File[] fs	= f.listFiles();
		for(int i=0;i<fs.length;i++){
%>
  <tr>
    <td>
    <%if(fs[i].isDirectory()&&!fs[i].getName().equals("ftl")){%>
    	<a href="<%=request.getContextPath()%>/demo/listFile?path=<%=new String(Base64.encodeBase64(fs[i].getAbsolutePath().getBytes()))%>">
      	<img alt="" src="<%=request.getContextPath()%>/assets/ztree/3.5.19/zTreeStyle/img/diy/7.png">
      	<%=fs[i].getName()%>【文件大小：<%=fs[i].length()%>】</a>
     <%}%>
    <%if(fs[i].isFile()){%>
	    <a target="_blank" href="<%=request.getContextPath()%><%=fpath.getAbsolutePath().substring(fpath.getAbsolutePath().indexOf("yy-web")+6, fpath.getAbsolutePath().length()).replaceAll("\\\\", "/")%>/<%=fs[i].getName()%>">
	     <%=fs[i].getName()%></a>
     <%}%>
    </td>
  </tr>
<%
		}
	}
%>
</table>
<input type="hidden" name="path" size="20" value="<%=new String(Base64.encodeBase64(path.getBytes()))%>">
</form>
    </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</div>

	
