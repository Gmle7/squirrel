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
    <%--<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/materialize/0.100.0/js/materialize.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>--%>
    <%--<script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>--%>
    <%--<script type="text/javascript" src="<%=basePath%>js/index.bundle.js"></script>--%>
    <script type="text/javascript" src="<%=basePath%>/js/user.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css"/>
    <%--<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">--%>
    <link rel="stylesheet" href="<%=basePath%>css/detail.css"/>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>/css/common.css"/>
</head>
<body ng-view="ng-view">
<!--描述：顶部-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="nav1">
        <div class=" ">
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
            <ul class="nav navbar-nav navbar-left">
                <c:if test="${!empty cur_user}">
                    <a href="<%=basePath%>goods/homeGoods" class="logo">
                        <em class="em1">Gmle7</em>
                        <em class="em2">闲置空间</em>
                    </a>
                </c:if>
            </ul>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li>
                        <button ng-click="showLogin()" data-position="bottom" data-delay="0" trigger="click|hover|focus"
                                data-tooltip="需要先登录哦！" title="需要先登录哦" class="red lighten-1 waves-effect waves-light btn"
                                data-tooltip-id="510d3084-e666-f82f-3655-5eae4304a83a">
                            <a>发布闲置</a>
                        </button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li>
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
                                <li><a onclick="ChangeName()">修改昵称</a></li>
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
                <form:form action="/user/addUser" method="post" id="user2" role="form"
                           onsubmit="return submitSignUp(this)">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="phone2" required="required" pattern="^1[0-9]{10}$"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="confirmPassword" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>确认密码</label>
                    </div>
                    <div>
                        <a id="badUser" style="color: red"></a>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="button" class="waves-effect waves-light btn verify-btn red lighten-1"
                                onclick="return checkSameUser(this.form)">
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
<!--修改昵称-->
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
    <div id="myCarouse2" class="carousel slide" style="width: 480px;margin-left: 240px">
        <!-- 轮播（Carousel）指标 -->
        <ol class="carousel-indicators">
            <c:forEach var="item" items="${goodsExtend.images}" varStatus="status">
                <li data-target="#myCarouse2"
                    data-slide-to=${status.index} <c:if test="${status.index==0}">class='active'</c:if>></li>
            </c:forEach>
        </ol>
        <!-- 轮播（Carousel）项目 -->
        <div class="carousel-inner">
            <c:forEach var="item" items="${goodsExtend.images}" varStatus="status">
                <div class="item <c:if test="${status.index==0}">active</c:if>"
                     style="height: 300px;border: 2px;border-color: #00b8d4">
                    <img src="<%=basePath%>upload/${item.imgUrl}" alt="First slide${item.imgId}"
                         style="width: 100%;height: 100%">
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="col s6" style="margin-left: 240px">
        <h1 class="item-name">${goodsExtend.goods.goodsName}</h1>
        <%--<a onclick="addCollection()"><i class="black material-icons">stars</i>关注一下</a>--%>

        <a onclick="addCollection()" id="noCollection"><img src="<%=basePath%>img/heart1.png"
                                                            style="height: 24px;width: 24px"/>关注一下</a>

        <a onclick="cancelCollection()" style="display: none" id="yesCollection"><img
                src="<%=basePath%>img/heart2.png" style="height: 24px;width: 24px"/>已经关注</a>

        <h2 class="item-price" style="padding-left: 90px">¥:${goodsExtend.goods.price}
            <span class="itemRealPrice" style="padding-left: 90px;color: black">¥:<s><c:out
                    value="${goodsExtend.goods.realPrice}"></c:out></s>
            </span>
        </h2>
        <div class="item-public-info">
            <c:choose>
                <c:when test="${goodsExtend.goods.isBargain eq '0'}">
                    <p class="bargain" style="padding-left: 80px">可接受讲价</p>
                </c:when>
                <c:otherwise>
                    <p class="bargain">不接受讲价</p>
                </c:otherwise>
            </c:choose>
            <p style="padding-left: 80px">
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
                    <em>后可查看卖家信息和发表评论哦</em>
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
                    <div class="value">${seller.weixin}</div>
                </div>
            </div>
        </c:if>
        <h2 class="item-pub-time">发布于 ${goodsExtend.goods.startTime}
            <%--<span><c:set var="nowDate" value="<%=System.currentTimeMillis()%>"></c:set>
                <c:choose>
                    <c:when test="${nowDate-seller.lastLogin > 0}">
                        <span class="STYLE1">当前用户在线</span>
                    </c:when>
                    <c:otherwise>
                        <span class="STYLE2">当前用户不在线</span>
                    </c:otherwise>
                </c:choose>
            </span>--%>
        </h2>
    </div>
</div>
<div class="detail-box stark-components z-depth-1 row">
    <h1 class="title">商品详情</h1>
    <hr class="hr1"/>
    <hr class="hr2"/>
    <p class="section">${goodsExtend.goods.description}</p>
    <p class="section"></p>
    <p class="section">
        如果联系卖家没有回应，建议加卖家微信，联系卖家的时候，请说明是在湘信院Gmle7校园闲置空间上看见的哦~
    </p>
</div>
<div class="row detail-area" id="comment">
    <div class="clo s12">
        <div ng-controller="commentController" class="comment stark-components z-depth-1 ng-scope">
            <h1 class="title">评论</h1>
            <hr class="hr1"/>
            <hr class="hr2"/>
            <div class="comment-collection">
                <c:forEach var="item" items="${commentsList}" varStatus="status">
                    <em></em>
                    <div class="comment-item ng-scope">
                        <div class="comment-main-content">
                            <em class="name ng-binding">${item.username}</em>
                            <em class="ng-hide">回复</em>
                            <em class="name ng-binding ng-hide">@:</em>
                            <em class="ng-binding">${item.content}</em>
                        </div>
                        <div class="comment-function">
                            <em class="time ng-binding">${item.createAt}</em>
                            <a class="reply-or-delete" onclick="willReport(${status.index})">举报</a>
                            <a class="reply-or-delete" onclick="willDelete(${status.index})">删除</a>
                            <a class="reply-or-delete" onclick="willReply(${status.index})">回复</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="comment-add row">
                <c:if test="${!empty cur_user}">
                    <div class="input-field col s12">
                        <i class="iconfont prefix"></i>
                        <input id="commentBox" type="text" name="commentBox"
                               class="validate ng-pristine ng-untouched ng-valid ng-empty"/>
                        <label for="commentBox" name="forCommentBox">这里写下评论</label>
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
                        <button type="button" class="waves-effect wave-light btn comment-submit"
                                onclick="return submitComments()">确认
                        </button>
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
    window.onload=function () {
        if (${empty cur_user}) {
            return false
        }
        getCollection();
    }

    $(function () {
        $("input[name='commentBox']").blur(function () {
            $("label[name='forCommentBox']").html("这里写下评论");
        })
    })

    function getCollection() {
        var goods = {
            goodsId:${goodsExtend.goods.goodsId}
        }
        $.ajax({
            type: 'post',
            url: '/collection/getCollection',
            data: JSON.stringify(goods),
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            async: true,
            success: function (data) {
                if (data) {
                    $("#yesCollection").css("display", "block");
                    $("#noCollection").css("display", "none");
                } else {
                    $("#noCollection").css("display", "block");
                    $("#yesCollection").css("display", "none");
                }
            },
            error: function () {
                alert('服务端异常');
            }
        })
    }

    function addCollection() {
        if (${empty cur_user}) {
            alert("请先登录哦！！！")
            return false
        }
        var goods = {
            goodsId:${goodsExtend.goods.goodsId}
        }
        $.ajax({
            type: 'post',
            url: '/collection/addCollection',
            data: JSON.stringify(goods),
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            async: true,
            success: function (data) {
                if (data) {
                    $("#yesCollection").css("display", "block");
                    $("#noCollection").css("display", "none");
                } else {
                    $("#noCollection").css("display", "block");
                    $("#yesCollection").css("display", "none");
                }
            },
            error: function () {
                alert('服务端异常');
            }
        })
    }

    function cancelCollection() {
        if (${empty cur_user}) {
            alert("请先登录哦！！！")
            return false
        }
        var goods = {
            goodsId:${goodsExtend.goods.goodsId}
        }
        $.ajax({
            type: 'post',
            url: '/collection/cancelCollection',
            data: JSON.stringify(goods),
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            async: true,
            success: function (data) {
                if (data) {
                    $("#yesCollection").css("display", "none");
                    $("#noCollection").css("display", "block");
                } else {
                    $("#noCollection").css("display", "none");
                    $("#yesCollection").css("display", "block");
                }
            },
            error: function () {
                alert('服务端异常');
            }
        })
    }

    $(function () {
        //进页面先不让评论警告框显示
        $("#commentWarning").css("display", "none");
        $("#commentSuccess").css("display", "none");
        $("#commentError").css("display", "none");
        $("#commentBox").focus(function () {
            $("#commentWarning").css("display", "none");
            $("#commentSuccess").css("display", "none");
            $("#commentError").css("display", "none");
        })
    })

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
            type: 'post',
            url: '/comments/addComments',
            data: JSON.stringify(comments),
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            async: true,
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
    function willReply(commentId) {
        if (${empty cur_user}) {
            alert("请先登录哦！！！")
            return false
        }
        $("label[name='forCommentBox']").html("回复@${commentsList.get(commentId).username}");
        $("input[name='commentBox']").focus();
    }
    function willReport(commentId) {
        if (${empty cur_user}) {
            alert("请先登录哦！！！")
            return false
        }
        alert("系统已接受到您的举报信息，谢谢！")
    }
    function willDelete(commentId) {
        if (${empty cur_user}) {
            alert("请先登录哦！！！")
            return false
        }
        alert("对不起，您没有权限！")
    }
</script>
</body>
</html>