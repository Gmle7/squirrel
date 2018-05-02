package com.idle.service;

import com.idle.pojo.Comments;

import java.util.List;

/**
 * Created by T005 on 2018/4/20.
 */
public interface CommentsService {

    int addComment(Comments comments);

    List<Comments> selectCommentsByGoodsId(int goodsId);
}
