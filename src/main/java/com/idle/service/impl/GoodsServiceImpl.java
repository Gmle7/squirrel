package com.idle.service.impl;

import com.github.pagehelper.PageHelper;
import com.idle.dao.GoodsMapper;
import com.idle.pojo.Goods;
import com.idle.service.GoodsService;
import com.idle.util.DateUtil;
import com.idle.util.UserGrid;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
 * 对商品的操作类（增删改查）
 * @ClassName 	GoodServiceImpl
 * @date		2017-5-9下午9:22:24
 */

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

    @Resource
    private GoodsMapper goodsMapper;

    @Override
    public void downGood(Integer goodsId) {
        goodsMapper.downGood(goodsId);
    }

    public int addGood(Goods goods) {
        String startTime = DateUtil.getNowTime();
        //添加上架时间，第一次擦亮时间和发布时间相同
        goods.setGoodsStatus("正常");
        goods.setStartTime(startTime);
        goods.setPolishTime(startTime);
        goods.setEndTime("未下架");
        goods.setCommentNum(0);
        return goodsMapper.insert(goods);
    }

    public Goods getGoodsByPrimaryKey(Integer goodsId) {
        return goodsMapper.selectByPrimaryKey(goodsId);
    }

    public void deleteGoodsByPrimaryKey(Integer goodsId) {
        goodsMapper.deleteByPrimaryKey(goodsId);
    }

    public List<Goods> getAllGoods() {
        return goodsMapper.selectAllGoods();
    }

    public UserGrid<Goods> searchGoods(String goodsName,String description,int pageNum,int pageSize) {
        //PageHelper.startPage(pageNum,pageSize);
        List<Goods> goodsList = goodsMapper.searchGoods(goodsName,description);
        UserGrid<Goods> userGrid=new UserGrid<>();
        userGrid.setCurrent(pageNum);
        userGrid.setRowCount(4);
        userGrid.setRows(goodsList);
        userGrid.setTotal(0);
        return  userGrid;
    }

    public UserGrid<Goods> getGoodsByCategoryId(Integer categoryId,int pageNum, int pageSize) {
        //PageHelper.startPage(pageNum,pageSize);
        List<Goods> goodsList=goodsMapper.selectByCategoryId(categoryId);
        UserGrid<Goods> userGrid=new UserGrid<>();
        userGrid.setCurrent(pageNum);
        userGrid.setRowCount(4);
        userGrid.setRows(goodsList);
        userGrid.setTotal(0);
        return userGrid;
    }

    public void updateGoodsByPrimaryKeyWithBLOBs(int goodsId,Goods goods) {
        goods.setGoodsId(goodsId);
        this.goodsMapper.updateByPrimaryKeyWithBLOBs(goods);
    }

    public List<Goods> getGoodsByCategoryOrderByDate(Integer categoryId,Integer limit) {
        return goodsMapper.selectByCategoryOrderByDate(categoryId , limit);
    }

    public List<Goods> getGoodsByUserId(Integer user_id) {
        return goodsMapper.getGoodsByUserId(user_id);
    }

    public List<Goods> getGoodsListByCategoryId(Integer categoryId) {
        return goodsMapper.getGoodsListByCategoryId(categoryId);
    }

    @Override
    public int getGoodsNum() {
        return goodsMapper.getGoodsCount();
    }

    @Override
    public List<Goods> getGoodsPage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum,pageSize);//分页核心代码
        return goodsMapper.selectAllGoodsAndCategoryNameAndUserName();
    }

    @Override
    public List<Goods> getNewGoods() {
        return goodsMapper.getNewGoods();
    }

}