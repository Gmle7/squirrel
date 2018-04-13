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
    <link rel="stylesheet" href="../css/index.css" />
    <script type="text/javascript" src="../js/jquery.js" ></script>
    <script type="text/javascript" src="../js/materialize.min.js" ></script>
    <script type="text/javascript" src="../js/index.bundle.js" ></script>
    <link rel="stylesheet" href="../css/materialize-icon.css" />
    <link rel="stylesheet" href="../css/user.css" />
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function showLogin() {
            if($("#signup-show").css("display")=='block'){
                $("#signup-show").css("display","none");
            }
            if($("#login-show").css("display")=='none'){
                $("#login-show").css("display","block");
            }else{
                $("#login-show").css("display","none");
            }
        }
        function showSignup() {
            if($("#login-show").css("display")=='block'){
                $("#login-show").css("display","none");
            }
            if($("#signup-show").css("display")=='none'){
                $("#signup-show").css("display","block");
            }else{
                $("#signup-show").css("display","none");
            }
        }
        function ChangeName() {
            if($("#changeName").css("display")=='none'){
                $("#changeName").css("display","block");
            }else{
                $("#changeName").css("display","none");
            }
        }
        function check(form) {
            var user={
                phone:form.phone.value,
                password:form.password.value
            }
            //创建异步对象
            $.ajax({
                // 请求发送方式
                type: 'post',
                // 验证文件
                url: '/user/checkPwd',
                // 用户输入的帐号密码
                data : JSON.stringify(user),
                dataType : 'json',
                contentType : 'application/json;charset=UTF-8',
                /*data: user,{'username': $("#phone").val(), 'password': $("#password").val()},*/
                // 异步，不写默认为True
                async: true,
                //请求成功后的回调
                success: function(data){
                    if (data){
                        /*alert('登录成功')*/
                        $("#user1").submit();
                    }else{
                        /*alert('帐号或密码错误');*/
                        $("#badPwd").html("账号或密码错误！");
                    }
                },
                error: function(){
                    alert('服务端异常');
                }

            })
        }
        function checkSameUser(form){
            var user={
                phone:form.phone.value,
                password:form.password.value,
                username:form.username.value
            }
            console.log(user);
            //创建异步对象
            $.ajax({
                // 请求发送方式
                type: 'post',
                // 验证文件
                url: '/user/checkSameUser',
                // 用户输入的帐号密码
                data : JSON.stringify(user),
                dataType : 'json',
                contentType : 'application/json;charset=UTF-8',
                // 异步，不写默认为True
                async: true,
                //请求成功后的回调
                success: function(data){
                    console.log(data);
                    if (data){
                        submitSignUp(form);
                    }else{
                        $("#badUser").html("该手机号无效或已被注册！");
                    }
                },
                error: function(){
                    alert('服务端异常');
                }

            })
        };
        function submitSignUp(form) {
            var user={
                phone:form.phone.value,
                password:form.password.value,
                username:form.username.value
            }
            //创建异步对象
            $.ajax({
                // 请求发送方式
                type: 'post',
                // 验证文件
                url: '/user/addUser',
                // 用户输入的帐号密码
                data : JSON.stringify(user),
                dataType : 'json',
                contentType : 'application/json;charset=UTF-8',
                // 异步，不写默认为True
                async: true,
                //请求成功后的回调
                success: function(data){
                    if (data){
                        $("#badUser").html("注册成功，请前往登录页登录！");
                    }else{
                        $("#badUser").html("系统错误，请联系管理员！");
                    }
                },
                error: function(){
                    alert('服务端异常');
                }
            })
        }
        $(function () {
            $("#password").focus(function () {
                /*$("#badPwd").hide();*/
                /*$("#badPwd").css("display","none");*/
                $("#badPwd").html("");
            })
            $("#phone2").focus(function () {
                /*$("#badPwd").hide();*/
                /*$("#badPwd").css("display","none");*/
                $("#badUser").html("");
            })
            /*$("input[type=password]").blur(function () {
                if ($(this).val()=="") {
                    $(this).hide();
                    $("input[type=text]").show();
                }
            })*/
        });
        $(function (){
            setTimeout(function () {
                $("#welcome").css("display","none");
                $("#myCarousel").css("display","block");
                $('#myCarousel').carousel();
            },13500)
        });
    </script>
<body ng-view="ng-view">
<!--描述：顶部-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="white nav1">
        <div class="nav-wrapper">
            <a href="<%=basePath%>goods/homeGoods" class="logo">
                <em class="em1">湘信院</em>
                <em class="em2">闲置空间</em>
                <em class="em3">hnisc.market</em>
            </a>
            <div class="nav-wrapper search-bar">
                <form ng-submit="search()" class="ng-pristine ng-invalid ng-invalid-required" action="/goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="搜点什么吧233..." style="height: 40px;"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label for="search" class="active">
                            <i ng-click="search()" class="iconfont"></i>
                        </label>
                    </div>
                </form>
            </div>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                        <button ng-click="showLogin()" data-position="bottom" data-delay="0"
                                data-tooltip="需要先登录哦！" title="需要先登录哦" class="red lighten-1 waves-effect waves-light btn" data-tooltip-id="510d3084-e666-f82f-3655-5eae4304a83a"	>
                            我要发布</button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="publish-btn">
                        <button data-position="bottom" class="red lighten-1 waves-effect waves-light btn">
                            <a href="/goods/publishGoods">我要发布</a>
                        </button>
                    </li>
                    <li>
                        <a href="/user/allGoods">我发布的商品</a>
                    </li>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
                    <li class="notification">
                        <i ng-click="showNotificationBox()" class="iconfont"></i>
                        <div ng-show="notification.tagIsShow" class="notification-amount red lighten-1 ng-binding ng-hide">0 </div>
                    </li>
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="/user/home">个人中心</a></li>
                                <li><a>消息</a></li>
                                <li><a onclick="ChangeName()">更改用户名</a></li>
                                <li><a href="/user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
                <c:if test="${empty cur_user}">
                    <li>
                        <a onclick="showLogin()">登录</a>
                    </li>
                    <li>
                        <a onclick="showSignup()">注册</a>
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
                        <input type="text" id="phone" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" id="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label>
                        <a id="badPwd" style="color: red"></a>
                        <a ng-click="showForget()" class="forget-btn">忘记密码？</a>
                    </div>
                    <button type="button" class="waves-effect waves-light btn login-btn red lighten-1" onclick="return check(this.form)">
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
                <form:form action="/user/addUser" method="post" id="user2" role="form"  onsubmit="return submitSignUp(this)">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="phone2"required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label>
                    </div>
                    <div>
                        <a id="badUser" style="color: red"></a>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="button" class="waves-effect waves-light btn verify-btn red lighten-1" onclick="return checkSameUser(this.form)">
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
<!--描述：左侧导航条-->
<div ng-controller="sidebarController" class="sidebar stark-components ng-scope">
    <li ng-class="{true: 'active'}[isAll]">
        <a href="/goods/catelog/1" class="index">
            <img src="../img/index.png">
            <em>最新发布</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isDigital]">
        <a href="/goods/catelog/1" class="digital">
            <img src="../img/digital.png"  />
            <em>闲置数码</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isRide]">
        <a href="/goods/catelog/2" class="ride">
            <img src="../img/ride.png"/>
            <em>校园代步</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isCommodity]">
        <a href="/goods/catelog/3" class="commodity">
            <img src="../img/commodity.png"/>
            <em>电器日用</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isBook]">
        <a href="/goods/catelog/4" class="book">
            <img src="../img/book.png"/>
            <em>图书教材</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isMakeup]">
        <a href="/goods/catelog/5" class="makeup">
            <img src="../img/makeup.png"/>
            <em>美妆衣物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSport]">
        <a href="/goods/catelog/6" class="sport">
            <img src="../img/sport.png"/>
            <em>运动棋牌</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/catelog/7" class="smallthing">
            <img src="../img/smallthing.png"/>
            <em>票券小物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/catelog/8" class="smallthing">
            <img src="../img/pet.png"/>
            <em>宠物相关</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="/goods/catelog/9" class="smallthing">
            <img src="../img/house.png"/>
            <em>房屋出租</em>
        </a>
    </li>
    <div class="info">
        <a href="" target="_blank">关于我们</a><em>-</em>
        <a href="">联系我们</a>
        <p>©2018 110XB工作室</p>
    </div>
</div>
<!--描述：右侧显示部分-->
<div class="main-content">
    <!-- 描述：右侧banner（图片）部分-->
    <div class="slider-wapper">
        <!-- 轮播图 -->
        <div id="myCarousel" class="carousel slide" style="display: none">
            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="../img/findfun.png" alt="First slide1">
                </div>
                <div class="item">
                    <img src="../img/findfun.png" alt="Second slide2">
                </div>
                <div class="item">
                    <img src="../img/findfun.png" alt="Third slide3">
                </div>
            </div>
            <!-- 轮播（Carousel）导航 -->
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- 进入主页校园广告 -->
        <div id="welcome" class="slider" style="touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
            <ul class="slides" style="height: 400px;">
                <li class="active" style="opacity: 1;">
                    <a href="/goods/catelog/2">
                        <div class="bannerimg">
                            <ul class="bannerul">
                                <p class="text1">亲爱的同学：</p>
                                <p class="text2">欢迎来到湖南信息学院Squirrel校园闲置空间。临近毕业季</p>
                                <p class="text3">的你，是否有太多的闲置与校友分享，为了追求更好的校园服</p>
                                <p class="text4">务，我们打造了一个全新的校园平台——<span>Squirrel闲置空间</span></p>
                                <p class="text5">更丰富的闲置分享，更自由的校园话题讨论，你想要的，都在这里！</p>
                                <p class="text6">加入Squirrel，你的大学，应更精彩!!!</p>
                            </ul>
                            <div class="logoimg">
                                <img src="../img/p_logo.jpg" />
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="index-title">
        <a href="">最新发布</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">闲置数码</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">校园代步</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods2}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">电器日用</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods3}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">图书教材</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods4}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">美妆衣物</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods5}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">运动棋牌</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods6}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">票券小物</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods7}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">宠物相关</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods8}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
    <div class="index-title">
        <a href="">房屋出租</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods9}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.id}">
                        <div class="card-image">
                            <img src="../upload/${item.imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.name}"></c:out></p>
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
</body>
</html>