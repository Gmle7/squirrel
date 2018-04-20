package com.idle.service.impl;

import com.idle.dao.ReplyMapper;
import com.idle.pojo.Reply;
import com.idle.service.ReplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by T005 on 2018/4/20.
 */
@Service("ReplyService")
public class ReplyServiceImpl implements ReplyService{
    @Resource
    private ReplyMapper replyMapper;

    @Override
    public void insertReply(Reply reply){
        replyMapper.insert(reply);
    }

}
