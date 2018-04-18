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

    public int updateGoodsNum(Integer id,Integer goodsNum) {
        return userMapper.updateGoodsNum(id,goodsNum);
    }

    public User selectByPrimaryKey(Integer id) {
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }

    //获取出当前页用户
    public List<User> getPageUser(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum,pageSize);//分页核心代码
        List<User> data= userMapper.getUserList();
        return data;
    }

    //获取出用户的数量
    public int getUserNum() {
        return userMapper.getUserCount();
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