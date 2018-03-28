package com.ldu.service;

import com.ldu.pojo.User;

import java.io.InputStream;
import java.util.List;

public interface UserService {
    void addUser(User user);
    User getUserByPhone(String phone);
    void updateUserName(User user);
    int updateGoodsNum(Integer id,Integer goodsNum);
    User selectByPrimaryKey(Integer id);
    List<User> getPageUser(int pageNum,int pageSize);
    int getUserNum();
    InputStream getInputStream() throws Exception;
}