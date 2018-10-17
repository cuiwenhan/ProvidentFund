<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- 使用模态窗口引入bootstrap ${pageContext.request.contextPath}-->
<link rel="stylesheet" type="text/css"
	href="resources/js/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/js/bootstrap/css/bootstrap-theme.min.css">
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/bootstrap/js/bootstrap.min.js"></script>
<!--最基础jQuery.js都是基于这个  -->
<script type="text/javascript" src="resources/jquery-1.11.3.min.js"></script>
<!-- 异步转换参数js -->
<script type="text/javascript" src="resources/jqueryExt.js"></script>
<!-- 上传文件js -->
<script type="text/javascript" src="resources/jquery.form.js"></script>
</head>

<body>
	<table class="table table-hover">
		<thead>
			<tr class="success">
				<th>商品编号</th>
				<th>商品名称</th>
				<th>商品类型</th>
				<th>商品Desc</th>
				<th>商品价格</th>
				<th>商品图片</th>
				<th>商品数量</th>
				<th>日期</th>
				<th colspan="6">名称查询 <input type="text" class="goodsName"
					id="goodsNames" placeholder="请输入名称" name="goodsName"> <input
					type="text" class="goodsName" id="typeNames" placeholder="请输入类型"
					name="typeName">
				</th>
				<th><input type="button" data-toggle="modal"
					data-target="#myModal" class="emptys btn btn-default" value="添加"></th>
			</tr>
		</thead>
		<tbody id="tbody">

		</tbody>
	</table>

	<!-- 模态框弹出录入内容 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="modalTitle1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">
						&times;
						<!-- 关闭按钮 -->
					</button>
					<h4 class="modal-title" id="modalTitle1">录入学生</h4>
				</div>
				<div class="modal-body">
					<!--form提交表单  -->
					<form class="form-horizontal" id="form1"
						enctype="multipart/form-data">
						<div class="form-group">
							<label for="roleName" class="col-sm-2 control-label">商品名</label>
							<div class="col-sm-4">

								<input type="hidden" id="goodsId" name="goodsId"
									class="form-control" placeholder="请输入"> <input
									type="text" id="goodsName" name="goodsName"
									class="form-control" placeholder="请输入商品名">
							</div>
						</div>

						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">商品类型</label>
							<div class="col-sm-4">

								<select class="sele form-control" name="typeId">

								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">商品Desc</label>
							<div class="col-sm-4">
								<input type="text" id="goodsDesc" class="form-control"
									name="goodsDesc" placeholder="请输入">

							</div>
						</div>

						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">商品价格</label>
							<div class="col-sm-4">
								<input type="text" id="goodsUnitPrice" class="form-control"
									name="goodsUnitPrice" placeholder="请输入">

							</div>
						</div>

						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">商品图片</label>
							<div class="col-sm-4">
								<!-- <input type="text" id="goodsUnitPrice" class="form-control" name="goodsUnitPrice"
										placeholder="请输入">  -->
								<input type="file" name="goodsImage" />
								<!-- <input type="file"  name="goodsImage"/>
                                        <input type="button" onclick="uploadss()" value="上传"/>
                                        <input type="text" id="a" class="form-control" name="goodsImageName"
										placeholder="请输入">  -->
							</div>
						</div>

						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">数量</label>
							<div class="col-sm-4">
								<input type="text" id="sellCount" class="form-control"
									name="sellCount" placeholder="请输入">

							</div>
						</div>

						<div class="form-group">
							<label for="description" class="col-sm-2 control-label">日期</label>
							<div class="col-sm-4">
								<input type="date" id="goodsDate" class="form-control"
									name="goodsDate" placeholder="请输入">

							</div>
						</div>

						<input type="button" id="saveUploadOrUpdate" data-toggle='modal'
							data-target='#myModal' class="btn btn-primary" value="保存">
					</form>

				</div>
				<div class="modal-footer">

					<button type="button" class="up btn btn-default"
						data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

</body>
</html>
<script>
  /* 页面加载函数 */
   $(function(){
     queryTbGoods();
     queryType();
  });
  /* 查询商品表 */
  function queryTbGoods(){
    $.ajax({
       url:"goods/queryTbGoods",
       type:"post",
       dataType:"json",
       success:function(data){
          $("#tbody").empty();
          for(var i=0;i<data.length;i++){
            var obj=data[i];
            var tr="<tr>";
                 tr+="<td>"+obj.goodsId+"</td>";
                 tr+="<td>"+obj.goodsName+"</td>";
                 tr+="<td>"+obj.tbgoodstype.typeName+"</td>";
                 tr+="<td>"+obj.goodsDesc+"</td>";
                 tr+="<td>"+obj.goodsUnitPrice+"</td>";
                 tr+="<td><img style=' width:80px; height:80px;' src='"+obj.goodsImageName+"'/></td>";
                 tr+="<td>"+obj.sellCount+"</td>";
                 tr+="<td>"+obj.goodsDate+"</td>";
                 tr+="<td><input type='button'  id="+obj.goodsId+" data-toggle='modal' data-target='#myModal' title="+obj.goodsId+"  class='findById btn btn-default' value='修改'></td>";
                 tr+="<td><input type='button' id="+obj.goodsId+"  class='delete btn btn-default' value='删除'></td>";
                 tr+="</tr>";
                 $("#tbody").append(tr);
          }
       }
    });
  }
  /*查询商品类型  */
  function queryType(){
     $.ajax({
       url:"goods/queryType",
       type:"post",
       dataType:"json",
       success:function(data){
         for(var i=0;i<data.length;i++){
            var obj=data[i];
            $(".sele").append("<option value='"+obj.typeId+"'>"+obj.typeName+"</option>");
         }
       }
     });
   };
   /* 添加修改之前清空form表单 */
   $(document).on("click",".emptys",function(){
          $("#goodsId").val("");
           $("#goodsName").val("");
           $("#goodsDesc").val("");
           $("#goodsUnitPrice").val("");
           $("#sellCount").val("");
           $("#goodsDate").val("");
  });
   /* 上传文本图片和修改 */
   $(document).on("click","#saveUploadOrUpdate",function(){
      $("#form1").ajaxSubmit({
        url:"goods/saveUploadOrUpdate",
        type:"post",
        contentType:"application/x-www-form-urlencoded; charset=utf-8",
        dataType:"text",
        success:function(data){
           alert(data);
           queryTbGoods();
        }
      });
   });
   /* 删除 */
   $(document).on("click",".delete",function(){
      var id=this.id;
     
      $.ajax({
         url:"goods/deleteTbGoods",
         type:"post",
         data:{"goodsId":id},
         dataType:"text",
         success:function(data){
           alert(data);
           queryTbGoods();
         }
      });
   });
   /*修改前查询  */
   $(document).on("click",".findById",function(){
      var id=this.id;
      $.ajax({
         url:"goods/queryById",
         type:"post",
         data:{"goodsId":id},
         dataType:"json",
         success:function(data){
           $("#goodsId").val(data.goodsId);
           $("#goodsName").val(data.goodsName);
           $("#goodsDesc").val(data.goodsDesc);
           $("#goodsUnitPrice").val(data.goodsUnitPrice);
           $("#sellCount").val(data.sellCount);
           $("#goodsDate").val(data.goodsDate);
         }
         
      });
   });
   /* 条件查询 */
   $(document).on("blur",".goodsName",function(){
      var name=$("#goodsNames").val();
      var tyName=$("#typeNames").val();
      $.ajax({
        url:"goods/queryByName",
        type:"post",
        data:{"goodsName":name,"typeName":tyName},
        dataType:"json",
        success:function(data){
              $("#tbody").empty();
          for(var i=0;i<data.length;i++){
            var obj=data[i];
            var tr="<tr>";
                 tr+="<td>"+obj.goodsId+"</td>";
                 tr+="<td>"+obj.goodsName+"</td>";
                 tr+="<td>"+obj.tbgoodstype.typeName+"</td>";
                 tr+="<td>"+obj.goodsDesc+"</td>";
                 tr+="<td>"+obj.goodsUnitPrice+"</td>";
                 tr+="<td><img style=' width:80px; height:80px;' src='"+obj.goodsImageName+"'/></td>";
                 tr+="<td>"+obj.sellCount+"</td>";
                 tr+="<td>"+obj.goodsDate+"</td>";
                 tr+="<td><input type='button'  id="+obj.goodsId+" data-toggle='modal' data-target='#myModal' title="+obj.goodsId+"  class='findById btn btn-default' value='修改'></td>";
                 tr+="<td><input type='button' id="+obj.goodsId+"  class='delete btn btn-default' value='删除'></td>";
                 tr+="</tr>";
                 $("#tbody").append(tr);
          }
        }
      });
   });
   /* 提交 1111*/
</script>