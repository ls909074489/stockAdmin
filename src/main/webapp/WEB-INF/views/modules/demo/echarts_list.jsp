<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%-- <script src="${ctx}/assets/echarts/echarts.min.js" type="text/javascript"></script> --%>

<style type="text/css" id="yangshi"></style>

<div class="page-content" id="yy-page-list" style="" align="center">
		<hr>
		<h1>
			<a href="http://echarts.baidu.com/echarts2/doc/example.html" target="_blank">参考http://echarts.baidu.com/echarts2/doc/example.html</a><br>
			<a href="http://echarts.baidu.com/examples.html" target="_blank">参考http://echarts.baidu.com/examples.html</a>
		</h1>
		<hr>
		<div class="row">
		   <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
		    <div id="main" style="width: 600px;height:400px;"></div>
		    <script type="text/javascript">
		        // 基于准备好的dom，初始化echarts实例
		        var myChart = echarts.init(document.getElementById('main'));
		
		        // 指定图表的配置项和数据
		        var option = {
		            title: {
		                text: 'ECharts 入门示例'
		            },
		            tooltip: {},
		            legend: {
		                data:['销量']
		            },
		            xAxis: {
		                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
		            },
		            yAxis: {},
		            series: [{
		                name: '销量',
		                type: 'bar',
		                data: [5, 20, 36, 10, 10, 20]
		            }]
		        };
		
		        // 使用刚指定的配置项和数据显示图表。
		        myChart.setOption(option);
		    </script>
		 </div>
		 
		 
		 
		 <div class="row">
		   <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
		    <div id="main1" style="width: 600px;height:400px;"></div>
		    <script type="text/javascript">
		        // 基于准备好的dom，初始化echarts实例
		        var myChart1 = echarts.init(document.getElementById('main1'));
		
		        // 指定图表的配置项和数据
		        var option1 = {
		        	    title : {
		        	        text: '某站点用户访问来源',
		        	        subtext: '纯属虚构',
		        	        x:'center'
		        	    },
		        	    tooltip : {
		        	        trigger: 'item',
		        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
		        	    },
		        	    legend: {
		        	        orient : 'vertical',
		        	        x : 'left',
		        	        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
		        	    },
		        	    toolbox: {
		        	        show : true,
		        	        feature : {
		        	            mark : {show: true},
		        	            dataView : {show: true, readOnly: false},
		        	            magicType : {
		        	                show: true, 
		        	                type: ['pie', 'funnel'],
		        	                option: {
		        	                    funnel: {
		        	                        x: '25%',
		        	                        width: '50%',
		        	                        funnelAlign: 'left',
		        	                        max: 1548
		        	                    }
		        	                }
		        	            },
		        	            restore : {show: true},
		        	            saveAsImage : {show: true}
		        	        }
		        	    },
		        	    calculable : true,
		        	    series : [
		        	        {
		        	            name:'访问来源',
		        	            type:'pie',
		        	            radius : '55%',
		        	            center: ['50%', '60%'],
		        	            data:[
		        	                {value:335, name:'直接访问'},
		        	                {value:310, name:'邮件营销'},
		        	                {value:234, name:'联盟广告'},
		        	                {value:135, name:'视频广告'},
		        	                {value:1548, name:'搜索引擎'}
		        	            ]
		        	        }
		        	    ]
		        	};
		
		        // 使用刚指定的配置项和数据显示图表。
		        myChart1.setOption(option1);
		    </script>
		 </div>
</div>
		