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
    <meta charset="utf-8" />
    <title>湘信院闲置空间</title>
    <script type="text/javascript" src="<%=basePath%>/js/user.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <link rel="stylesheet" href="../css/materialize-icon.css" />
</head>
<body ng-view="ng-view">
<!--描述：顶部-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="nav1">
        <div class=" ">
            <%--<a href="#" class="logo">
                <em class="em1">湘信院</em>
                <em class="em2">闲置空间</em>
                <em class="em3">hnisc.market</em>
            </a>--%>
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
                    <li><a onclick="showLogin()"><span
                            class="glyphicon glyphicon-user"></span> 同学，要先<span style="color: red">登录</span>哦</a></li>
                    <li><a onclick="showSignup()"><span
                            class="glyphicon glyphicon-log-in"></span> 免费注册</a></li>
                </c:if>
            </ul>

            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                        <button ng-click="showLogin()" data-position="bottom" data-delay="0" trigger="click|hover|focus"
                                data-tooltip="需要先登录哦！" title="需要先登录哦" class="red lighten-1 waves-effect waves-light btn"
                                data-tooltip-id="510d3084-e666-f82f-3655-5eae4304a83a">
                            发布闲置
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
<!-- 描述：登录-->
<div ng-controller="loginController" class="ng-scope">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showLogin()">
                    <div class="col s12 title"></div>
                </a>
                <form:form action="/user/login" method="post" id="user1" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
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
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
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
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
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
<!--描述：左侧显示部分-->
<div class="main-content">
    <!-- 描述：最新发布-->
    <div class="index-title">
        <a href="">${catelog.name}</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${goodsExtendList}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>湖南信息学院</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!--描述：右侧导航条-->
<div ng-controller="sidebarController" class="sidebar stark-components ng-scope">
    <li ng-class="{true: 'active'}[isAll]">
        <a href="/goods/catelog/1" class="index">
            <img src="<%=basePath%>img/index.png">
            <em>最新发布</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isDigital]">
        <a href="/goods/catelog/1" class="digital">
            <img src="<%=basePath%>img/digital.png"/>
            <em>闲置数码</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isRide]">
        <a href="/goods/catelog/2" class="ride">
            <img src="<%=basePath%>img/ride.png"/>
            <em>校园代步</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isCommodity]">
        <a href="/goods/catelog/3" class="commodity">
            <img src="<%=basePath%>img/commodity.png"/>
            <em>电器日用</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isBook]">
        <a href="/goods/catelog/4" class="book">
            <img src="<%=basePath%>img/book.png"/>
            <em>图书教材</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isMakeup]">
        <a href="/goods/catelog/5" class="makeup">
            <img src="<%=basePath%>img/makeup.png"/>
            <em>美妆衣物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSport]">
        <a href="/goods/catelog/6" class="sport">
            <img src="<%=basePath%>img/sport.png"/>
            <em>运动棋牌</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/catelog/7" class="smallthing">
            <img src="<%=basePath%>img/smallthing.png"/>
            <em>票券小物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/catelog/8" class="smallthing">
            <img src="<%=basePath%>img/pet.png"/>
            <em>宠物相关</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/catelog/9" class="smallthing">
            <img src="<%=basePath%>img/house.png"/>
            <em>房屋出租</em>
        </a>
    </li>
    <div class="info">
        <a href="" target="_blank">关于我们</a><em>-</em>
        <a href="">联系我们</a>
        <p>©2018 110XB工作室</p>
    </div>
</div>
</body>
</html>