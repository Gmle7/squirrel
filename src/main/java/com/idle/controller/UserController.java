package com.idle.controller;

import com.idle.pojo.Collection;
import com.idle.pojo.Goods;
import com.idle.pojo.GoodsExtend;
import com.idle.pojo.User;
import com.idle.service.CollectionService;
import com.idle.service.GoodsService;
import com.idle.service.UserService;
import com.idle.util.DateUtil;
import com.idle.util.GoodsExtendAndImage;
import com.idle.util.MD5;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Resource
    private UserService userService;
    @Resource
    private GoodsService goodsService;
    @Resource
    private CollectionService collectionService;
    @Resource
    private GoodsExtendAndImage goodsExtendAndImage;

    /**
     * 用户注册
     *
     * @param user1
     * @return
     */
    @RequestMapping(value = "/addUser")
    @ResponseBody
    public boolean addUser(@RequestBody User user1) {
        String t = DateUtil.getNowTime();
        //对密码进行MD5加密
        String str = MD5.md5(user1.getPassword());
        user1.setCreateAt(t);//创建开始时间
        user1.setPassword(str);
        user1.setGoodsNum(0);
        userService.addUser(user1);
        return true;
    }

    /**
     * 注册判断用户手机是否重复注册
     *
     * @param user1
     * @return
     */
    @RequestMapping(value = "/checkSameUser")
    @ResponseBody
    public boolean checkSameUser(@RequestBody User user1) {
        User user = userService.getUserByPhone(user1.getPhone());
        if (user == null) {//检测该用户是否已经注册,null为未注册
            return true;
        }
        return false;
    }

    /**
     * 登录跳转
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/login")
    public ModelAndView loginValidate(HttpServletRequest request, User user) {
        User cur_user = userService.getUserByPhone(user.getPhone());
        String time = DateUtil.getNowTime();
        userService.updateLastLogin(time, cur_user.getUserId());//设置登录时间
        String url = request.getHeader("Referer");
        request.getSession().setAttribute("cur_user", cur_user);
        return new ModelAndView("redirect:" + url);

    }

    @RequestMapping(value = "/checkPwd", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkPwd(@RequestBody User user) {
        User cur_user = userService.getUserByPhone(user.getPhone());
        if (cur_user != null) {
            String pwd = MD5.md5(user.getPassword());
            if (pwd.equals(cur_user.getPassword())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 修改昵称
     *
     * @param request
     * @param user
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/changeName")
    public ModelAndView changeName(HttpServletRequest request, @RequestBody User user, ModelMap modelMap) {
        String url = request.getHeader("Referer");
        //从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        cur_user.setUsername(user.getUsername());//更改当前用户的用户名
        userService.updateUserName(cur_user);//执行修改操作
        request.getSession().setAttribute("cur_user", cur_user);//修改session值
        return new ModelAndView("redirect:" + url);
    }

    /**
     * 完善或修改信息
     *
     * @param request
     * @param user
     * @return
     */
    @RequestMapping(value = "/updateInfo")
    @ResponseBody
    public boolean updateInfo(HttpServletRequest request, @RequestBody User user) {
        //从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        cur_user.setUsername(user.getUsername());
        cur_user.setEmail(user.getEmail());
        //cur_user.setPassword(user.getPassword());
        cur_user.setWeixin(user.getWeixin());
        userService.updateUserName(cur_user);//执行修改操作
        return true;
    }

    /**
     * 用户退出
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().setAttribute("cur_user", null);
        return "redirect:/goods/homeGoods";
    }


    /**
     * 个人中心
     *
     * @return
     */
    @RequestMapping(value = "/home")
    public String home() {
        return "/user/home";
    }

    /**
     * 个人信息设置
     *
     * @return
     */
    @RequestMapping(value = "/basic")
    public String basic() {
        return "/user/basic";
    }

    /**
     * 我的闲置
     * 查询出所有的用户商品以及商品对应的图片
     *
     * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
     */
    @RequestMapping(value = "/allGoods")
    public ModelAndView goods(HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getUserId();
        List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("goodsList", goodsList);
        mv.setViewName("/user/goods");
        return mv;
    }

    /**
     * 我的关注
     * 查询出用户所有的收藏商品带图片
     * @return 返回的model为 goodsAndImage对象,该对象中包含goods 和 images，参考相应的类
     */
    @RequestMapping(value = "/allCollection")
    public ModelAndView collection(HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getUserId();
        List<Collection> collectionList = collectionService.getCollectionsByUserId(userId);
        ModelAndView mv = new ModelAndView();
        mv.addObject("collectionList", collectionList);
        mv.setViewName("/user/collection");
        return mv;
    }

}