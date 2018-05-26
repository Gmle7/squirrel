package com.idle.controller;

import com.idle.pojo.Collection;
import com.idle.pojo.Goods;
import com.idle.pojo.User;
import com.idle.service.CollectionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/collection")
public class CollectionController {

    @Resource
    private CollectionService collectionService;

    @RequestMapping(value = "/getCollection")
    @ResponseBody
    public Boolean getCollectionByUserIdAndGoodsId(HttpServletRequest request, @RequestBody Goods goods) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        List<Collection> collectionList= collectionService.getCollectionByUserIdAndGoodsId(cur_user.getUserId(),goods.getGoodsId());
        if(collectionList.size()>=1){
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/addCollection")
    @ResponseBody
    public Boolean addCollectionByUserIdAndGoodsId(HttpServletRequest request,@RequestBody Goods goods) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        int i= collectionService.addCollectionByUserIdAndGoodsId(cur_user.getUserId(),goods.getGoodsId());
        if(i>=1){
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/cancelCollection")
    @ResponseBody
    public Boolean deleteCollectionByUserIdAndGoodsId(HttpServletRequest request,@RequestBody Goods goods) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        int i= collectionService.deleteCollectionByUserIdAndGoodsId(cur_user.getUserId(),goods.getGoodsId());
        if(i>=1){
            return true;
        }
        return false;
    }
}
