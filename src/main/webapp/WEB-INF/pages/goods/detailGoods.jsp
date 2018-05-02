<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>湘信院闲置空间</title>
    <link rel="stylesheet" href="<%=basePath%>css/index.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/user.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/detail.css"/>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <%--<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>--%>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/css/common.css"/>

</head>
<body ng-view="ng-view">
<!--描述：顶部-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="nav1">
        <div class=" ">
            <c:if test="${!empty cur_user}">
                <a href="<%=basePath%>goods/homeGoods" class="logo">
                    <em class="em1">Gmle7</em>
                    <em class="em2">闲置空间</em>
                        <%--<em class="em3">idle.market</em>--%>
                </a>
            </c:if>
            <div class="nav-wrapper search-bar">
                <form ng-submit="search()" class="ng-pristine ng-invalid ng-invalid-required" action="/goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="搜索宝贝..." style="height: 40px;width: 400px"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label for="search" class="active">
                            <i ng-click="search()" class="iconfont"></i>
                        </label>
                    </div>
                </form>
            </div>
            <ul class="nav navbar-nav navbar-left">
                <c:if test="${empty cur_user}">
                    <li><a class="nav-left" onclick="showLogin()"><span
                            class="glyphicon glyphicon-user"></span> 同学，要先<span style="color: red">登录</span>哦</a></li>
                    <li><a class="nav-left" onclick="showSignup()"><span
                            class="glyphicon glyphicon-log-in"></span> 免费注册</a></li>
                </c:if>
            </ul>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                        <button ng-click="showLogin()" data-position="bottom" data-delay="0" trigger="click|hover|focus"
                                data-tooltip="需要先登录哦！" title="需要先登录哦" class="red lighten-1 waves-effect waves-light btn"
                                data-tooltip-id="510d3084-e666-f82f-3655-5eae4304a83a">
                            <a>发布闲置</a>
                        </button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="publish-btn">
                        <button data-position="bottom" class="red lighten-1 waves-effect waves-light btn">
                            <a href="/goods/publishGoods">发布闲置</a>
                        </button>
                    </li>
                    <li>
                        <a href="/user/allGoods">我的闲置</a>
                    </li>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
                    <li class="notification">
                        <i ng-click="showNotificationBox()" class="iconfont"></i>
                        <div ng-show="notification.tagIsShow"
                             class="notification-amount red lighten-1 ng-binding ng-hide">0
                        </div>
                    </li>
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="/user/home">个人中心</a></li>
                                <li><a>我的消息</a></li>
                                <li><a onclick="ChangeName()">更改用户名</a></li>
                                <li><a href="/user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</div>
<!--描述：登录-->
<div ng-controller="loginController" class="ng-scope">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showLogin()">
                    <div class="col s12 title"></div>
                </a>
                <form:form action="/user/login" method="post" id="user" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" required="required" pattern="^1[0-9]{10}$"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码</label>
                        <a ng-click="showForget()" class="forget-btn">忘记密码？</a>
                    </div>
                    <button type="submit" class="waves-effect waves-light btn login-btn red lighten-1">
                        <i class="iconfont left"></i>
                        <em>登录</em>
                    </button>
                    <div class="col s12 signup-area">
                        <em>没有账号？赶快</em>
                        <a onclick="showSignup()" class="signup-btn">注册</a>
                        <em>吧！</em>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<!--描述：注册-->
<div ng-controller="signupController" class="ng-scope">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showSignup()">
                    <div class="col s12 title"></div>
                </a>
                <form:form action="/user/addUser" method="post" id="user2" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" required="required" pattern="^1[0-9]{10}$"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码</label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="submit" class="waves-effect waves-light btn verify-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<!--更改用户名-->
<div ng-controller="changeNameController" class="ng-scope">
    <div id="changeName" class="change-name stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <div class="col s12 title">
                    <h1>修改用户名</h1>
                </div>
                <form:form action="/user/changeName" method="post" id="user3" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>修改用户名</label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button class="waves-effect waves-light btn publish-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>确认</em>
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<!--显示商品详情-->
<div ng-controller="detailBoxController" class="detail-box stark-components z-depth-1 row ng-scope">
    <div class="col s12 path">
        <a href="<%=basePath%>goods/category/${goodsExtend.goods.categoryId}">${goodsExtend.goods.categoryName}</a>
        <em>></em>
        <a>${goodsExtend.goods.goodsName}</a>
    </div>
    <!-- 轮播图 -->
    <div id="myCarouse2" class="carousel slide" style="width: 485px">
        <!-- 轮播（Carousel）指标 -->
        <ol class="carousel-indicators">
            <c:forEach var="item" items="${goodsExtend.images}" varStatus="status">
            <li data-target="#myCarouse2" data-slide-to=${status.index} <c:if test="${status.index==0}">class='active'</c:if>></li>
            </c:forEach>
        </ol>
        <!-- 轮播（Carousel）项目 -->
        <div class="carousel-inner">
            <c:forEach var="item" items="${goodsExtend.images}" varStatus="status">
                <div class="item <c:if test="${status.index==0}">active</c:if>" style="height: 300px">
                    <img src="<%=basePath%>upload/${item.imgUrl}" alt="First slide${item.imgId}" style="width: 100%;height: 100%">
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="col s6">
        <h1 class="item-name">${goodsExtend.goods.goodsName}</h1>
        <h2 class="item-price">${goodsExtend.goods.price}</h2>
        <div class="item-public-info">
            <p class="bargain">可讲价</p>
            <p>
                <i class="iconfont"></i>
                <em class="item-location">湖南信息学院</em>
            </p>
        </div>
        <div class="publisher-info-title">
            <em>卖家信息</em>
            <hr>
        </div>
        <c:if test="${empty cur_user}">
            <div class="item-contact">
                <p class="not-login">
                    <a onclick="showLogin()">登录</a>
                    <em>或</em>
                    <a onclick="showSignup()">注册</a>
                    <em>后可查看联系信息和发表评论哦</em>
                </p>
            </div>
        </c:if>
        <c:if test="${!empty cur_user}">
            <div class="item-contact">
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.username}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.phone}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.email}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value"></div>
                </div>
            </div>
        </c:if>
        <h1 class="item-pub-time">发布于 ${goodsExtend.goods.startTime}</h1>
    </div>
</div>
<div class="detail-box stark-components z-depth-1 row">
    <h1 class="title">商品详情</h1>
    <hr class="hr1"/>
    <hr class="hr2"/>
    <p class="section">${goodsExtend.goods.description}</p>
    <p class="section"></p>
    <p class="section">
        联系我的时候，请说明是在湘信院Squirrel校园闲置空间上看见的哦~
    </p>
</div>
<div class="row detail-area" id="comment">
    <div class="clo s12">
        <div ng-controller="commentController" class="comment stark-components z-depth-1 ng-scope">
            <h1 class="title">评论</h1>
            <hr class="hr1"/>
            <hr class="hr2"/>
            <div class="comment-collection">
                <c:forEach var="item" items="${commentsList}">
                    <em></em>
                    <div class="comment-item ng-scope">
                        <div class="comment-main-content">
                            <em class="name ng-binding">${item.username}</em>
                            <em class="ng-hide">回复</em>
                            <em class="name ng-binding ng-hide">@:</em>
                            <em class="ng-binding">${item.content}</em>
                        </div>
                        <div class="comment-function">
                            <em class="time ng-biinding">${item.createAt}</em>
                            <a class="reply-or-delete">删除</a>
                            <a class="reply-or-delete">回复</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="comment-add row">
                <c:if test="${!empty cur_user}">
                <div class="input-field col s12">
                    <%--<form:form action="/comments/addComments" method="post" id="comments" role="form">--%>
                        <i class="iconfont prefix"></i>
                        <input id="commentBox" type="text" name="commentBox" class="validate ng-pristine ng-untouched ng-valid ng-empty"/>
                        <label for="commentBox">这里写下评论</label>
                        <div class="alert alert-success" id="commentSuccess">
                            <a href="#" class="alert-link">评论成功！</a>
                        </div>
                        <div class="alert alert-warning alert-dismissable" id="commentWarning">
                            <button type="button" class="close" data-dismiss="alert"
                                    aria-hidden="true">
                                &times;
                            </button>
                            评论不能为空！
                        </div>
                        <div class="alert alert-danger alert-dismissable" id="commentError">
                            <button type="button" class="close" data-dismiss="alert"
                                    aria-hidden="true">
                                &times;
                            </button>
                            系统错误，评论失败！
                        </div>
                        <button type="button" class="waves-effect wave-light btn comment-submit" onclick="return submitComments()">确认</button>
                        <button type="button" class="waves-effect wave-light btn comment-submit" onclick="return freshComments()">确认2</button>
                    <%--</form:form>--%>
                </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<div class="copyright-bottom">
    Copyright &copy; @2018 110XB工作室 <strong><a href="//www.cschenchao.com/" target="_blank">闲置平台</a></strong>&nbsp;
    <strong><a href="//www.cschenchao.com/" target="_blank">cschenchao.com</a></strong> All Rights Reserved.
    备案号：123456789-1
</div>
<script>
    //验证消息显示在页面上
    $(function () {
        //进页面先不让评论就警告框显示
        $("#commentWarning").css("display", "none");
        $("#commentSuccess").css("display", "none");
        $("#commentError").css("display", "none");
        $("#commentBox").focus(function () {
            $("#commentWarning").css("display", "none");
            $("#commentSuccess").css("display", "none");
            $("#commentError").css("display", "none");
        })
    })

    function freshComments() {
        var commentsMsg={
            goodsId:${goodsExtend.goods.goodsId},
        }
        $.ajax({
            type: 'post',
            url: '/comments/getComments',
            //params:{goodsId:${goodsExtend.goods.goodsId},
            data:commentsMsg,
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            async: true,
            success: function (data) {
                console.log(data);
                if (data) {

                } else {

                }
            },
            error: function () {
                alert('服务端异常');
            }
        })
    }

    function submitComments() {
        console.log($('#commentBox').val());
        if ($('#commentBox').val() == "") {
            $("#commentWarning").css("display", "block");
            return false;
        }
        var comments = {
            userId:${goodsExtend.goods.userId},
            goodsId:${goodsExtend.goods.goodsId},
            content: $('#commentBox').val()
        }
        //创建异步对象
        $.ajax({
            // 请求发送方式
            type: 'post',
            // 验证文件
            url: '/comments/addComments',
            // 用户输入的帐号密码
            data: JSON.stringify(comments),
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
                        }, 1500)
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