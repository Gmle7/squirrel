package com.ldu.service.impl;

import com.github.pagehelper.PageHelper;
import com.ldu.dao.GoodsMapper;
import com.ldu.pojo.Goods;
import com.ldu.service.GoodsService;
import com.ldu.util.DateUtil;
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
    public void downGood(Integer goodId) {
        goodsMapper.downGood(goodId);
    }

    public int addGood(Goods goods , Integer duration) {
        String startTime = DateUtil.getNowTime();
        //添加上架时间，第一次擦亮时间和发布时间相同
        goods.setStartTime(startTime);
        goods.setPolishTime(startTime);
        return goodsMapper.insert(goods);
    }

    public Goods getGoodsByPrimaryKey(Integer goodsId) {
        return goodsMapper.selectByPrimaryKey(goodsId);
    }

    public void deleteGoodsByPrimaryKey(Integer id) {
        goodsMapper.deleteByPrimaryKey(id);
    }

    public List<Goods> getAllGoods() {
        return goodsMapper.selectAllGoods();
    }

    public List<Goods> searchGoods(String name, String describle) {
        return  goodsMapper.searchGoods(name,describle);
    }

    public List<Goods> getGoodsByCatelog(Integer id,String name,String describle) {
        return goodsMapper.selectByCatelog(id,name,describle);
    }

    public void updateGoodsByPrimaryKeyWithBLOBs(int goodsId,Goods goods) {
        goods.setId(goodsId);
        this.goodsMapper.updateByPrimaryKeyWithBLOBs(goods);
    }

    public List<Goods> getGoodsByCatelogOrderByDate(Integer catelogId,Integer limit) {
        return goodsMapper.selectByCatelogOrderByDate(catelogId , limit);
    }

    public List<Goods> getGoodsByUserId(Integer user_id) {
        return goodsMapper.getGoodsByUserId(user_id);
    }

    public List<Goods> getGoodsListByCatlogId(Integer catlogId) {
        return goodsMapper.getGoodsListByCatlogId(catlogId);
    }

    @Override
    public int getGoodsNum() {
        return goodsMapper.getGoodsCount();
    }

    @Override
    public List<Goods> getGoodsPage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum,pageSize);//分页核心代码
        return goodsMapper.selectAllGoods();
    }

}