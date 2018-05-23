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
    <title>个人设置</title>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" href="../css/userhome.css" />
    <link rel="stylesheet" href="../css/user.css" />
    <link rel="stylesheet" href="../css/common.css" />

</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="/goods/homeGoods">
                <h1 class="logo"></h1>
            </a>
            <a href="/user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--
            作者：hlk_1135@outlook.com
            时间：2017-05-10
            描述：左侧个人中心栏
        -->
        <div id="user_nav">
            <div class="user_info">
                <div class="head_img">
                    <img src="<%=basePath%>img/photo.jpg">
                </div>
                <div class="big_headimg">
                    <img src="<%=basePath%>img/findfun.png">
                </div>
                <span class="name">${cur_user.username}</span>
                <span class="school">湖南信息学院</span>
                <span class="name">闲置数量：${cur_user.goodsNum}</span>
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
                            <span>关注列表</span>
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
            作者：hlk_1135@outlook.com
            时间：2017-05-10
            描述：右侧内容区域
        -->
        <div id="user_content">
            <div class="basic">
                <form:form action="/user/updateInfo" method="post" id="user4" role="form">
                    <h1>完善与修改个人信息</h1><hr />
                    <div class="changeinfo">
                        <span>昵称：</span>
                        <input class="in_info" type="text" name="username" placeholder="请输入昵称" value="${cur_user.username}"/>
                    </div><hr />
                    <div class="changeinfo">
                        <span>开通时间：</span>
                        <input class="in_info" type="text" name="createAt" value="${cur_user.createAt}" readonly="true"/>
                    </div><hr />
                    <div class="changeinfo">
                        <span>手机号码：</span>
                        <input class="in_info" type="text" name="phone" value="${cur_user.phone}" readonly="true"/>
                        <span id="checkphone">已验证</span>
                    </div><hr />
                    <div class="changeinfo">
                        <span>weixin：</span>
                        <input class="in_info" type="text" name="weixin" placeholder="请输入微信号" value="${cur_user.weixin}"/>
                    </div><hr />
                    <div class="changeinfo">
                        <span>E-mail：</span>
                        <input class="in_info" type="text" name="email" placeholder="请输入邮箱号" value="${cur_user.email}"/>
                    </div>
                    <div class="alert alert-success" id="commentSuccess">
                        <a href="#" class="alert-link">修改成功！</a>
                    </div>
                    <div class="alert alert-warning alert-dismissable" id="commentWarning">
                        <button type="button" class="close" data-dismiss="alert"
                                aria-hidden="true">
                            &times;
                        </button>
                        不能为空！
                    </div>
                    <div class="alert alert-danger alert-dismissable" id="commentError">
                        <button type="button" class="close" data-dismiss="alert"
                                aria-hidden="true">
                            &times;
                        </button>
                        系统错误，修改失败！
                    </div>
                    <button type="button" class="setting-save" onclick="return submitMessage(this.form)">
                        <em>保存修改信息</em>
                    </button>
                </form:form>
            </div>
            <!-- 描述：最右侧，可能认识的人 -->
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
    $(function () {
        //进页面先不让评论警告框显示
        $("#commentWarning").css("display", "none");
        $("#commentSuccess").css("display", "none");
        $("#commentError").css("display", "none");
    })

    function submitMessage(form) {
        var userInfo = {
            username:form.username.value,
            weixin:form.weixin.value,
            email:form.email.value
        }
        //创建异步对象
        $.ajax({
            // 请求发送方式
            type: 'post',
            // 验证文件
            url: '/user/updateInfo',
            // 用户输入的帐号密码
            data: JSON.stringify(userInfo),
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            // 异步，不写默认为True
            async: true,
            //请求成功后的回调
            success: function (data) {
                console.log(data)
                if (data) {
                    $("#commentSuccess").css("display", "block");
                    $(function () {
                        setTimeout(function () {
                            location.reload();
                        }, 1000)
                    });
                } else {
                    $("#commentError").css("display", "block");
                }
            },
            error: function () {
                alert('服务端异常');
            }
        })
    }
</script>
</body>
</html>