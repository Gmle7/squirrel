package com.idle.controller;

import com.idle.pojo.Goods;
import com.idle.pojo.User;
import com.idle.service.GoodsService;
import com.idle.util.GoodsGrid;
import com.idle.util.UserGrid;
import com.idle.service.UserService;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.List;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Resource
    private UserService userService;
    @Resource
    private GoodsService goodsService;

    @RequestMapping(value = "/userListPage",method = RequestMethod.GET)
    public String userList() {
        return "/admin/userList";
    }

    @RequestMapping(value = "/goodListPage",method = RequestMethod.GET)
    public String goodsList() {
        return "/admin/goodsList";
    }

    @RequestMapping(value="/getUserInfo",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public User getUserById(@RequestParam("userId") int userId){
        return userService.selectByPrimaryKey(userId);
    }

    @RequestMapping(value="/getGoodInfo",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Goods getGoodInfoById(@RequestParam("goodId") int goodId){
        return goodsService.getGoodsByPrimaryKey(goodId);
    }

    @RequestMapping(value="/downGood",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public void downGoodById(@RequestParam("goodId") int goodId){
        goodsService.downGood(goodId);
    }

    @RequestMapping(value="/delGood",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public void delGoodById(@RequestParam("goodsId") int goodsId){
        goodsService.deleteGoodsByPrimaryKey(goodsId);
    }

    @RequestMapping(value="/getUserByPhone",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public User getUserByPhone(@RequestParam("phone") String phone){
        return userService.getUserByPhone(phone);
    }

    @RequestMapping(value = "/userList",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public UserGrid getUserList(@RequestParam("current") int current,@RequestParam("rowCount") int rowCount) {
        int total = userService.getUserNum();
        List<User>  list = userService.getPageUser(current,rowCount);
        UserGrid userGrid = new UserGrid();
        userGrid.setCurrent(current);
        userGrid.setRowCount(rowCount);
        userGrid.setRows(list);
        userGrid.setTotal(total);
        return userGrid;
    }

    @RequestMapping(value = "/goodList",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public GoodsGrid getGoodList(@RequestParam("current") int current,@RequestParam("rowCount") int rowCount) {
        int total = goodsService.getGoodsNum();
        List<Goods>  list = goodsService.getGoodsPage(current,rowCount);
        GoodsGrid goodsGrid = new GoodsGrid();
        goodsGrid.setCurrent(current);
        goodsGrid.setRowCount(rowCount);
        goodsGrid.setRows(list);
        goodsGrid.setTotal(total);
        return goodsGrid;
    }
    //将用户信息导出到Excel
    @RequestMapping("/exportUser")
    public void export(HttpServletResponse response) throws Exception{
        InputStream is=userService.getInputStream();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("contentDisposition", "attachment;filename=AllUsers.xls");
        ServletOutputStream output = response.getOutputStream();
        IOUtils.copy(is,output);
    }
}