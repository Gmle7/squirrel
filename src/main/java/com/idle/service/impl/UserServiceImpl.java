package com.idle.service.impl;

import com.github.pagehelper.PageHelper;
import com.idle.dao.UserMapper;
import com.idle.pojo.User;
import com.idle.service.UserService;
import com.idle.util.WriteExcel;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    public void addUser(User user) {
        userMapper.insert(user);
    }

    public User getUserByPhone(String phone) {
        User user  = userMapper.getUserByPhone(phone);
        return  user;
    }

    public void updateUserName(User  user) {
        userMapper.updateByPrimaryKey(user);
    }

    public int updateGoodsNum(Integer userId,Integer goodsNum) {
        return userMapper.updateGoodsNum(userId,goodsNum);
    }

    public int updateGoodsNum2(Integer userId) {
        return userMapper.updateGoodsNum2(userId);
    }

    public User selectByPrimaryKey(Integer userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    //获取出当前页用户
    public List<User> getPageUser(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum,pageSize);//分页核心代码
        return userMapper.getUserList();
    }

    //获取出用户的数量
    public int getUserNum() {
        return userMapper.getUserCount();
    }

    public void updateLastLogin(String lastLogin,int userId){
        userMapper.updateLastLogin(lastLogin,userId);
    }

    public InputStream getInputStream() throws Exception {
        String[] title=new String[]{"序号","手机号","姓名","邮箱","开通时间","商品数量","用户权限"};
        List<User> list=userMapper.getUserList();
        List<Object[]>  dataList = new ArrayList<Object[]>();
        for(int i=0;i<list.size();i++){
            Object[] obj=new Object[7];
            obj[0]=list.get(i).getUserId();
            obj[1]=list.get(i).getPhone();
            obj[2]=list.get(i).getUsername();
            obj[3]=list.get(i).getEmail();
            obj[4]=list.get(i).getCreateAt();
            obj[5]=list.get(i).getGoodsNum();
            obj[6]=list.get(i).getPower();
            dataList.add(obj);
        }
        WriteExcel ex = new WriteExcel(title, dataList);
        InputStream in;
        in = ex.export();
        return in;
    }

    public static HttpSession getSession() {
        HttpSession session = null;
        try {
            session = getRequest().getSession();
        } catch (Exception e) {}
        return session;
    }

    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attrs =(ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attrs.getRequest();
    }

}