package com.idle.service.impl;

import com.idle.dao.CommentsMapper;
import com.idle.pojo.Comments;
import com.idle.service.CommentsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by T005 on 2018/4/20.
 */
@Service("CommentsService")
public class CommentsServiceImpl implements CommentsService{
    @Resource
    private CommentsMapper commentsMapper;

    @Override
    public void insertComment(Comments comments) {
        commentsMapper.insert(comments);
    }

    @Override
    public List<Comments> selectCommentsByGoodsId(int goodsId) {
        return commentsMapper.selectCommentsByGoodsId(goodsId);
    }
}
