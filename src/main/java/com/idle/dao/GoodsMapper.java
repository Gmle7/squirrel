package com.idle.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.idle.pojo.Goods;

public interface GoodsMapper {
    /**
     * 通过主键删除
     * @param goodsId
     * @return
     */
    int deleteByPrimaryKey(Integer goodsId);

    /**
     * 添加物品
     * @param record
     * @return
     */
    int insert(Goods record);

    int downGood(Integer goodsId);
    /**
     *
     * @param record
     * @return
     */
    int insertSelective(Goods record);

    /**
     * 通过id查询
     * @param goodsId
     * @return
     */
    Goods selectByPrimaryKey(Integer goodsId);

    /**
     * 通过主键更改信息
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(Goods record);

    /**
     * 通过主键更改信息，包括大文本信息
     * @param record
     * @return
     */
    int updateByPrimaryKeyWithBLOBs(Goods record);

    /**
     * 通过主键更改信息
     * @param record
     * @return
     */
    int updateByPrimaryKey(Goods record);

    /**
     * 查询所有的商品
     * @return
     */
    List<Goods> selectAllGoods();

    List<Goods> searchGoods(@Param("goodsName") String goodsName,@Param("description") String description);

    /**
     * 根据商品分类的id，查询商品
     * @param categoryId
     * @return
     */
    List<Goods> selectByCategoryId(@Param("categoryId") Integer categoryId);

    /**
     * 根据时间先后获取商品信息，进行分页查询
     * 未在xml中实现
     * @return
     */
    List<Goods> selectByDate(int page,int maxResults);

    /**
     * 根据category_id查询商品信息，结果按擦亮时间排序，最新的在前
     * @return
     */
    List<Goods> selectByCategoryOrderByDate(@Param("categoryId")Integer categoryId,@Param("limit")Integer limit);

    /**
     * 查询登录用户的所有闲置商品
     * @param userId
     * @return
     */
    List<Goods> getGoodsByUserId(Integer userId);

    /**
     * 根据种类ID查ID下所有商品
     * @param categoryId
     * @return
     */
    List<Goods> getGoodsListByCategoryId(Integer categoryId);

    /**
     * 查询一共有多少条商品记录
     * @return
     */
    int getGoodsCount();

    /**
     * 查询
     * @return
     */
    List<Goods> selectAllGoodsAndCategoryNameAndUserName();
    //查询最新发布的8条商品信息带图片
    List<Goods> getNewGoods();
}