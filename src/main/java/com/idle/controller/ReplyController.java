package com.idle.controller;

import com.idle.pojo.Reply;
import com.idle.service.ReplyService;
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
@RequestMapping(value = "/reply")
public class ReplyController {
    @Resource
    private ReplyService replyService;

    /**
     * 回复评价
     *
     * @param reply
     * @return
     */
    @RequestMapping(value = "/addReply")
    @ResponseBody
    public boolean addReply(@RequestBody Reply reply) {
        String time = DateUtil.getNowTime();
        reply.setCreateAt(time);
        replyService.insertReply(reply);
        return true;
    }
}
