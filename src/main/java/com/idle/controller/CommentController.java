package com.idle.controller;

import com.idle.pojo.Comments;
import com.idle.pojo.User;
import com.idle.service.CommentsService;
import com.idle.util.DateUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by T005 on 2018/4/20.
 */
@Controller
@RequestMapping(value = "/comments")
public class CommentController {
    @Resource
    private CommentsService commentsService;

    /**
     * 发表商品评价
     *
     * @param comments
     * @return
     */
    @RequestMapping(value = "/addComments")
    @ResponseBody
    public boolean addComments(@RequestBody Comments comments) {
        String time = DateUtil.getNowTime();
        comments.setCreateAt(time);
        commentsService.insertComment(comments);
        return true;
    }
}
