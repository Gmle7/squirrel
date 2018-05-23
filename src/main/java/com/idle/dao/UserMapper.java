package com.idle.dao;

import com.idle.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User getUserByPhone(String phone);//通过手机号查询用户

    int updateGoodsNum(@Param("userId") Integer id, @Param("goodsNum") Integer goodsNum);//更改用户的商品数量

    int updateGoodsNum2(@Param("userId") Integer id);//用户的商品数量+1

    List<User> getUserList();

    int getUserCount();

    int updateLastLogin(@Param("lastLogin") String lastLogin,@Param("userId") Integer userId); //修改用户最近登录时间
}