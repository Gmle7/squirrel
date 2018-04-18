package com.idle.service.impl;

import com.idle.dao.ImageMapper;
import com.idle.pojo.Image;
import com.idle.service.ImageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by lenovo on 2017/5/12.
 */
@Service("imageService")
public class ImageServiceImpl implements ImageService {
    @Resource
    private ImageMapper imageMapper;
    public int insert(Image record) {
        return imageMapper.insert(record);
    }
    public List<Image> getImagesByGoodsPrimaryKey(Integer goodsId) {
        List<Image> images = imageMapper.selectByGoodsPrimaryKey(goodsId +"");
        return images;
    }
    public int deleteImagesByGoodsPrimaryKey(Integer goodsId) {
        return imageMapper.deleteImagesByGoodsPrimaryKey(goodsId +"");
    }
}
