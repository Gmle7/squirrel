<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Gmle7后台管理系统</title>
	<script src="../js/jquery-3.1.1.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" href="../css/jquery.bootgrid.min.css">
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery.bootgrid.min.js"></script>
	<script src="../js/bootstrap-datetimepicker.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css" type="text/css">
	<link rel="stylesheet" href="../css/common.css" />
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-inverse">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar">*****</span>
						</button>
						<a class="navbar-brand" href="#">Gmle7后台管理系统</a>
					</div>
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav">
							<li><a href="/user/logout">logout</a></li>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<h2>Gmle7商品信息</h2>
			<a class="btn btn-primary" href="/admin/exportGood">导出数据为excel</a>
			<a class="btn btn-primary" href="#" id="add">添加用户</a>
			<div class="btn-group">
				<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					查看接口数据 <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="/admin/goodList?current=1&rowCount=10&sort[sender]=asc&searchPhrase=&id=b0df282a-0d67-40e5-8558-c9e93b7befed" target="_blank">JSON</a></li>
				</ul>
			</div>
			<table id="grid-data" class="table table-condensed table-hover table-striped">
				<thead>
				<tr>
					<th data-column-id="goodsId"  data-identifier="true" data-type="numeric">闲置编号</th>
					<th data-column-id="goodsName">闲置名称</th>
					<th data-column-id="categoryName">所属分类</th>
					<th data-column-id="price">出售价格</th>
					<th data-column-id="startTime">发布时间</th>
					<th data-column-id="polishTime">擦亮数量</th>
					<th data-column-id="endTime">下架时间</th>
					<th data-column-id="username">所属用户</th>
					<th data-column-id="goodsStatus">状态</th>
					<th data-column-id="commands" data-formatter="commands" data-sortable="false">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	</div>
</div>
<script>
    $(document).ready(function(){
        var rowId;
        var grid = $("#grid-data").bootgrid({
            ajax:true,
            post: function ()
            {
                return {
                    id: "b0df282a-0d67-40e5-8558-c9e93b7befed"
                };
            },
            url:"/admin/goodList",
            formatters: {
                "commands": function(column, row)
                {
                    return "<button type=\"button\" class=\"btn btn-xs btn-default command-edit\" data-row-id=\"" + row.goodsId + "\">下架<span class=\"fa fa-pencil\"></span></button>" +
                        "<button type=\"button\" class=\"btn btn-xs btn-default command-delete\" data-row-id=\"" + row.goodsId + "\">删除<span class=\"fa fa-trash-o\"></span></button>";
                },
            }
        }).on("loaded.rs.jquery.bootgrid", function()
		{
            grid.find(".command-edit").on("click", function(e)
            {
                $("#downModal").modal({
                    keyboard: true
				});
                rowId = $(this).data("row-id");
//                $.post("/admin/downGood",{goodsId:$(this).data("row-id")},function(){
//                    alert("下架成功");
//                    $("#grid-data").bootgrid("reload");
//                });
            }).end().find(".command-delete").on("click", function(e)
            {
                $("#delModal").modal({
                    keyboard: true
                });
                rowId = $(this).data("row-id");
            });
        });

        $("#submit1").click(function(){
            $.post("/admin/downGood",{goodsId:rowId},function(){
                    alert("下架成功");
                    $("#grid-data").bootgrid("reload");
                });
            $("#downModal").modal('hide');
        });
        $("#submit2").click(function(){
            $.post("/admin/delGood",{goodsId:rowId},function(){
                alert("删除成功");
                $("#grid-data").bootgrid("reload");
            });
            $("#delModal").modal('hide');
        });
    });

</script>
<div class="modal fade" id="downModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="downModalLabel">
					下架商品
				</h4>
			</div>
			<div class="modal-body">
				请确认是否下架改闲置物品！
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default"
						data-dismiss="modal">取消
				</button>
				<button type="button" class="btn btn-primary" id="submit1">
					确认
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="delModalLabel">
					请确认是否删除改闲置物品！
				</h4>
			</div>
			<div class="modal-body">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default"
						data-dismiss="modal">取消
				</button>
				<button type="button" class="btn btn-primary" id="submit2">
					确认
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade stumodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">信息修改</h4>
			</div>
			<form action="" method="post">
				<div class="modal-body">
					<div class="form-group">
						<label for="userId2">userId</label>
						<input type="text" name="userId" class="form-control" id="userId2" readonly="true">
					</div>
					<div class="form-group">
						<label for="userName2">userName</label>
						<input type="text" name="userName" class="form-control" id="userName2" readonly="true">
					</div>
					<div class="form-group">
						<label for="userPower2">userPower</label>
						<input type="text" name="userPower" class="form-control" id="userPower2">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade addmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">添加用户</h4>
			</div>
			<form action="" method="post">
				<div class="modal-body">
					<div class="form-group">
						<label for="userName1">userName</label>
						<input type="text" name="userName" class="form-control" id="userName1">
					</div>
					<div class="form-group">
						<label for="userAge1">userAge</label>
						<input type="text" name="userAge" class="form-control" id="userAge1">
					</div>
					<div class="form-group">
						<label for="userMajor1">userMajor</label>
						<input type="text" name="userMajor" class="form-control" id="userMajor1">
					</div>
					<div class="form-group">
						<input type="hidden" name="Id" class="form-control" id="Id">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Add User</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="copyright-bottom">
	Copyright &copy; @2018 110XB工作室   <strong><a href="//www.cschenchao.com/" target="_blank">闲置平台</a></strong>&nbsp;
	<strong><a href="//www.cschenchao.com/" target="_blank">cschenchao.com</a></strong> All Rights Reserved. 备案号：123456789-1
</div>
</body>
</html>