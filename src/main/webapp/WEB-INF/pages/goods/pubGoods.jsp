<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布商品</title>
    <link rel="stylesheet" href="<%=basePath%>/css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>/css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>/css/user.css" />
    <%--<script type="text/javascript" src="<%=basePath%>/js/jquery-3.1.1.min.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <!-- bootstrap -->
    <%--<link rel="stylesheet" href="<%=basePath%>/css/bootstrap.min.css">--%>
    <%--<script type="text/javascript" src="<%=basePath%>/js/bootstrap.min.js"></script>--%>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- 图片上传即使预览插件 -->
    <link rel="stylesheet" href="<%=basePath%>/css/fileinput.min.css">
    <script type="text/javascript" src="<%=basePath%>/js/fileinput.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/zh.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/css/common.css" />

    <style>
        .container{padding-top:10px}
    </style>
</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="<%=basePath%>goods/homeGoods">
                <h1 class="logo"></h1>
            </a>
            <a href="/user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--
            描述：左侧个人中心栏
        -->
        <div id="user_nav">
            <div class="user_info">
                <div class="head_img">
                    <img src="<%=basePath%>img/photo.jpg">
                </div>
                <div class="big_headimg">
                    <img src="">
                </div>
                <span class="name">${cur_user.username}</span>
                <span class="school">湖南信息学院</span>
                <span class="name">发布闲置数量：${cur_user.goodsNum}</span>
            </div>
            <div class="home_nav">
                <ul>
                    <a href="">
                        <li class="notice">
                            <div></div>
                            <span>我的消息</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="">
                        <li class="fri">
                            <div></div>
                            <span>我的关注</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="/user/basic">
                        <li class="set">
                            <div></div>
                            <span>个人设置</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="/goods/publishGoods">
                        <li class="store">
                            <div></div>
                            <span>发布物品</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="/user/allGoods">
                        <li class="second">
                            <div></div>
                            <span>我的闲置</span>
                            <strong></strong>
                        </li>
                    </a>
                </ul>
            </div>
        </div>
        <!--
	            描述：发布物品
        -->
        <div id="user_content">
            <div class="basic">
                <form:form action="/goods/publishGoodsSubmit" method="post" role="form" id="pubForm" enctype="multipart/form-data">
                    <h1 style="margin-left: 210px;margin-top: -30px;">发布物品</h1><hr />
                    <div class="changeinfo">
                        <span>商品名称：</span>
                        <input class="in_info" type="text" name="goodsName" placeholder="请输入物品名"/>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <span>出售价格：</span>
                        <input class="in_info" type="text" name="price" placeholder="请输入出售价格"/>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo">
                        <span>商品原价：</span>
                        <input class="in_info" type="text" name="realPrice" placeholder="请输入商品原价"/>
                        <span id="checkphone">(*选填,请如实填写)</span>
                    </div>
                    <div class="changeinfo">
                        <span>物品类别：</span>
                        <select class="in_info" name="categoryId">
                            <option value="1">数码电子</option>
                            <option value="2">校园代步</option>
                            <option value="3">生活电器</option>
                            <option value="4">图书期刊</option>
                            <option value="5">服装衣帽</option>
                            <option value="6">娱乐运动</option>
                            <option value="7">精致迷你</option>
                            <option value="8">宠物相关</option>
                            <option value="9">房屋出租</option>
                        </select>
                        <span>(*必填)</span>
                    </div>
                    <div class="changeinfo" id="description">
                        <span>商品描述：</span>
                        <div class="sha">
                            <div class="publ">
                                <div class="pub_con">
                                    <div class="text_pu">
                                        <input type="text" name="description" class="emoji-wysiwyg -editor" style="width: 390px;height: 100px;border-radius: 4px"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <hr />
                    <div class="changeinfo">
                        <span>可否讲价：</span>
                        <label class="in_info"><input type="radio" name="isBargain" value="1">拒绝</label>
                        <label class="in_info"><input type="radio" name="isBargain" value="0">接受</label>
                    </div>
                    <div class="changeinfo">
                        <span>商品图片：</span>
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-1">
                                    <div class="form-group">
                                        <div class="col-sm-10" style="padding-left: 50px;">
                                            <input type="file" name="myFile" data-ref="imgUrl" multiple class="col-sm-10 myFile" value=""/>
                                            <input type="hidden" name="imgUrl" value="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="height: 20px"><a id="pubBadMsg" style="color: red;margin-left: 300px;"></a></div>
                    <input type="button" class="setting-save" value="发布物品" style="margin-top: 30px;background-color: blue;margin-left: 260px;
                    width: 200px;" onclick="return checkPublish(this.form)"/>
                </form:form>
            </div>
            <!--
                描述：最右侧，可能认识的人
            -->
            <div class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class="change">换一组</span>
                    <span class="underline"></span>
                </div>
                <ul>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>格物楼楼主</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>XDF厨师长</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>石岚舟</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>赤沙岘</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>Kevin</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    $(".myFile").fileinput({
        uploadUrl:"<%=basePath%>goods/uploadFile",//上传的地址
        uploadAsync:true, //默认异步上传
        showUpload: false, //是否显示上传按钮,跟随文本框的那个
        showRemove : false, //显示移除按钮,跟随文本框的那个
        showCaption: true,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        dropZoneEnabled: true,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        //minImageWidth: 50, //图片的最小宽度
        //minImageHeight: 50,//图片的最小高度
        //maxImageWidth: 1000,//图片的最大宽度
        //maxImageHeight: 1000,//图片的最大高度
        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
        //minFileCount: 0,
        maxFileCount: 4, //表示允许同时上传的最大文件个数
        enctype: 'multipart/form-data',
        validateInitialCount:true,
        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        allowedFileTypes: ['image'],//配置允许文件上传的类型
        allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
        allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
        language : 'zh'
    })
    //异步上传返回结果处理
    $('.myFile').on('fileerror', function(event, data, msg) {
        console.log("fileerror");
        console.log(data);
    });
    //异步上传返回结果处理
    $(".myFile").on("fileuploaded", function (event, data, previewId, index) {
        var ref=$(this).attr("data-ref");
        var imgUrl=$("input[name='"+ref+"']").val();
        imgUrl+=data.response.imgUrl+',';
        //imgUrl=imgUrl.substring(0,imgUrl.length-1);
        $("input[name='"+ref+"']").val(imgUrl);
        console.log($("input[name='"+ref+"']").val());
    });

    //同步上传错误处理
    $('.myFile').on('filebatchuploaderror', function(event, data, msg) {
        console.log("filebatchuploaderror");
        console.log(data);
    });

    //同步上传返回结果处理
    $(".myFile").on("filebatchuploadsuccess", function (event, data, previewId, index) {
        console.log("filebatchuploadsuccess");
        console.log(data);
    });

    //上传前
    $('.myFile').on('filepreupload', function(event, data, previewId, index) {
        console.log("filepreupload");
    });
    //验证注册时手机号是否已经被用过
    function checkPublish(form) {
        var pubMsg={
            goodsName:form.goodsName.value,
            price:form.price.value,
            categoryId:form.categoryId.value,
            isBargain:form.isBargain.value,
            description:form.description.value,
            imgUrl:form.imgUrl.value
        }
        if (pubMsg.goodsName == ""||pubMsg.goodsName.replace(/(^s*)|(s*$)/g, "").length ==0) {
            $("#pubBadMsg").html("商品名称不能为空！");
            return false;
        }
        if (pubMsg.price == "") {
            $("#pubBadMsg").html("商品价格不能为空！");
            return false;
        }
        if (pubMsg.categoryId == "") {
            $("#pubBadMsg").html("请选择物品类别！");
            return false;
        }
        if (pubMsg.isBargain == "") {
            $("#pubBadMsg").html("可否讲价为必选项！");
            return false;
        }if (pubMsg.description.length>255) {
            $("#pubBadMsg").html("商品描述不能超过255字！");
            return false;
        }
        if (pubMsg.imgUrl == "") {
            $("#pubBadMsg").html("请上传至少一张商品图片");
            return false;
        }
        $("#pubForm").submit();
    }
    //验证消息显示在页面上
    $(function () {
        $("input[name='goodsName']").focus(function () {
            $("#pubBadMsg").html("");
        })
        $("input[name='price']").focus(function () {
            $("#pubBadMsg").html("");
        })
        $("select[name='categoryId']").focus(function () {
            $("#pubBadMsg").html("");
        })
        $("textarea[name='description']").focus(function () {
            $("#pubBadMsg").html("");
        })
        $("label[name='isBargain']").focus(function () {
            $("#pubBadMsg").html("");
        })
        $("input[name='imgUrl']").focus(function () {
            $("#pubBadMsg").html("");
        })
    })
</script>
<div class="copyright-bottom">
    Copyright &copy; @2018 110XB工作室 <strong><a href="//www.cschenchao.com/" target="_blank">闲置平台</a></strong>&nbsp;
    <strong><a href="//www.cschenchao.com/" target="_blank">cschenchao.com</a></strong> All Rights Reserved.
    备案号：123456789-1
</div>
</body>
</html>