package com.ldu.util;

import com.ldu.pojo.Goods;
import com.ldu.pojo.GoodsExtend;
import com.ldu.pojo.Image;
import com.ldu.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by T005 on 2018/4/12.
 */
public class GoodsExtendAndImage {
    @Autowired
    ImageService imageService;

    public void goodsExtend(List<Goods> goodsList, List<GoodsExtend> goodsExtendList) {
        if(null==goodsList){
            return;
        }
        for (int i = 0; i < goodsList.size(); i++) {
            //将用户信息和image信息封装到GoodsExtend类中，传给前台
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsList.get(i);
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            goodsExtendList.add(i, goodsExtend);
        }
    }
}
