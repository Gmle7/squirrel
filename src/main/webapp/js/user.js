/**
 * Created by T005 on 2018/4/16.
 */
//登录页面的显示逻辑
function showLogin() {
    if ($("#signup-show").css("display") == 'block') {
        $("#signup-show").css("display", "none");
    }
    if ($("#login-show").css("display") == 'none') {
        $("#login-show").css("display", "block");
    } else {
        $("#login-show").css("display", "none");
    }
}

//注册页面的显示逻辑
function showSignup() {
    if ($("#login-show").css("display") == 'block') {
        $("#login-show").css("display", "none");
    }
    if ($("#signup-show").css("display") == 'none') {
        $("#signup-show").css("display", "block");
    } else {
        $("#signup-show").css("display", "none");
    }
}

//更改信息页面的显示逻辑
function ChangeName() {
    if ($("#changeName").css("display") == 'none') {
        $("#changeName").css("display", "block");
    } else {
        $("#changeName").css("display", "none");
    }
}

//验证密码
function check(form) {
    var user = {
        phone: form.phone.value,
        password: form.password.value
    }
    if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(user.phone))) {
        $("#badPwd").html("请输入正确的手机号码！");
        return false;
    }
    if (user.phone == "") {
        $("#badPwd").html("手机号不能为空！");
        form.username.focus();
        return false;
    }
    if (user.password == "") {
        $("#badPwd").html("密码不能为空！");
        form.password.focus();
        return false;
        //创建异步对象
        $.ajax({
            // 请求发送方式
            type: 'post',
            // 验证文件
            url: '/user/checkPwd',
            // 用户输入的帐号密码
            data: JSON.stringify(user),
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',
            /*data: user,{'username': $("#phone").val(), 'password': $("#password").val()},*/
            // 异步，不写默认为True
            async: true,
            //请求成功后的回调
            success: function (data) {
                if (data) {
                    /*alert('登录成功')*/
                    $("#user1").submit();
                } else {
                    /*alert('帐号或密码错误');*/
                    $("#badPwd").html("账号或密码错误！");
                }
            },
            error: function () {
                alert('服务端异常');
            }

        })
    }
}

//验证注册时手机号是否已经被用过
function checkSameUser(form) {
    var user = {
        phone: form.phone.value,
        password: form.password.value,
        username: form.username.value
    }
    if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(user.phone))) {
        $("#badUser").html("请输入正确的手机号码！");
        return false;
    }
    //创建异步对象
    $.ajax({
        // 请求发送方式
        type: 'post',
        // 验证文件
        url: '/user/checkSameUser',
        // 用户输入的帐号密码
        data: JSON.stringify(user),
        dataType: 'json',
        contentType: 'application/json;charset=UTF-8',
        // 异步，不写默认为True
        async: true,
        //请求成功后的回调
        success: function (data) {
            if (data) {
                submitSignUp(form);
            } else {
                $("#badUser").html("该手机号无效或已被注册！");
            }
        },
        error: function () {
            alert('服务端异常');
        }
    })
}

//提交登录信息，跳转页面
function submitSignUp(form) {
    var user = {
        phone: form.phone.value,
        password: form.password.value,
        username: form.username.value
    }
    //创建异步对象
    $.ajax({
        // 请求发送方式
        type: 'post',
        // 验证文件
        url: '/user/addUser',
        // 用户输入的帐号密码
        data: JSON.stringify(user),
        dataType: 'json',
        contentType: 'application/json;charset=UTF-8',
        // 异步，不写默认为True
        async: true,
        //请求成功后的回调
        success: function (data) {
            if (data) {
                $("#badUser").html("注册成功，请前往登录页登录！");
            } else {
                $("#badUser").html("系统错误，请联系管理员！");
            }
        },
        error: function () {
            alert('服务端异常');
        }
    })
}

//验证消息显示在页面上
$(function () {
    $("input[name='password']").focus(function () {
        $("#badPwd").html("");
        $("#badUser").html("");
    })
    $("input[name='phone']").focus(function () {
        $("#badPwd").html("");
        $("#badUser").html("");
    })
})

