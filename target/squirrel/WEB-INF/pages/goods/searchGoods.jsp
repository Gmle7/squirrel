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
    <link rel="stylesheet" href="<%=basePath%>/css/materialize-icon.css"/>
    <script type="text/javascript" src="<%=basePath%>/js/user.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>/css/common.css"/>
<body ng-view="ng-view">
<!--描述：顶部-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="nav1">
        <div class=" ">
            <%--<a href="#" class="logo">
                <em class="em1">湘信院</em>
                <em class="em2">闲置空间</em>
                <em class="em3">idle.market</em>
            </a>--%>
            <div class="nav-wrapper search-bar">
                <form ng-submit="search()" class="ng-pristine ng-invalid ng-invalid-required" action="/goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="搜索宝贝..." style="height: 40px;width: 400px"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"
                               value="<c:out value="${search}"></c:out>"/>
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
                <form:form action="/user/login" method="post" id="user1" role="form">
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
<!--描述：右侧显示部分-->
<div class="main-content">
    <!--描述：分类-->
    <div class="index-title">
        <a href="">${userGrid.rows.get(1).categoryName}</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:if test="${empty userGrid}">
                <div class="no_share">
                    <span>没有任何内容，试着搜索其他的东西吧！</span>
                </div>
            </c:if>
            <c:forEach var="item" items="${userGrid.rows}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goodsId}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><a style="position: relative;color: red;">¥:<c:out
                                value="${item.price}"></c:out><span class="itemRealPrice">¥:<s><c:out
                                value="${item.realPrice}"></c:out></s></span></a></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goodsName}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>湖南信息学院</p>
                            <p><c:out value="${item.startTime}"></c:out></p>
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
        <a href="<%=basePath%>goods/category/1" class="index">
            <img src="<%=basePath%>img/index.gif">
            <em>最新发布</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isDigital]">
        <a href="/goods/category/1" class="digital">
            <img src="<%=basePath%>img/digital.png"/>
            <em>闲置数码</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isRide]">
        <a href="/goods/category/2" class="ride">
            <img src="<%=basePath%>img/ride.png"/>
            <em>校园代步</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isCommodity]">
        <a href="/goods/category/3" class="commodity">
            <img src="<%=basePath%>img/commodity.png"/>
            <em>电器日用</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isBook]">
        <a href="/goods/category/4" class="book">
            <img src="<%=basePath%>img/book.png"/>
            <em>图书教材</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isMakeup]">
        <a href="/goods/category/5" class="makeup">
            <img src="<%=basePath%>img/makeup.png"/>
            <em>美妆衣物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSport]">
        <a href="/goods/category/6" class="sport">
            <img src="<%=basePath%>img/sport.png"/>
            <em>运动棋牌</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/category/7" class="smallthing">
            <img src="<%=basePath%>img/smallthing.png"/>
            <em>票券小物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/category/8" class="smallthing">
            <img src="<%=basePath%>img/pet.png"/>
            <em>宠物相关</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/category/9" class="smallthing">
            <img src="<%=basePath%>img/house.png"/>
            <em>房屋出租</em>
        </a>
    </li>
</div>
<!-- 底部分页栏-->
<div class="copyright-bottom">
    <ul class="pagination pager">
        <c:if test="${userGrid.current!=1}">
            <li><a href="#">&laquo;</a></li>
        </c:if>
        <li class="active"><a href="#">1</a></li>
        <li class="disabled"><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">5</a></li>
        <li><a href="#">&raquo;</a></li>
    </ul>
    <!-- 在这个上面添加上一页的功能(添加这个功能之前还需要判断当前页面是否为第一页,如果为第一页则不显示上一页) -->
    <%--<c:if test="${userGrid.current!=1}">
        <a href="<c:url value='/goods/search?str=${search}&&current${userGrid.currentPage-1}' />">
            上一页
        </a>
        &nbsp;
    </c:if>--%>

    <%--<!-- 分页的分页进行修改的地方就是这里---将已经拿到的页面进行分页操作! -->
    <c:forEach begin="${startN }" end="${endN }" var="idx">
        <!-- 用超链接进行包一下即可 -->
        <c:if test="${result.currentPage!=idx }">
            <!-- 这里记得将当前页的参数传参过去 -->
            <a href="<c:url value='/goods/search/${idx }' />">
                    ${idx }
            </a>
        </c:if>
        <c:if test="${userGrid.current==idx }">
            ${idx }
        </c:if>
        &nbsp;
    </c:forEach>--%>

    <!-- 在这个下面添加下一页的功能(添加这个功能之前还需要判断当前页面是否为最后一页,如果为最后一页则不显示下一页) -->
    <%--<c:if test="${userGrid.current!=userGrid.pageCount }">
        <a href="<c:url value='/goods/search?str=${search}&&current${userGrid.currentPage+1}' />">
            下一页
        </a>
    </c:if>--%>
</div>
<!--网页底部信息-->
<div class="copyright-bottom">
    Copyright &copy; @2018 110XB工作室 <strong><a href="//www.cschenchao.com/" target="_blank">闲置平台</a></strong>&nbsp;
    <strong><a href="//www.cschenchao.com/" target="_blank">cschenchao.com</a></strong> All Rights Reserved.
    备案号：123456789-1
</div>
</body>
</html>