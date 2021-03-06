package com.idle.controller;

import com.idle.pojo.*;
import com.idle.service.*;
import com.idle.util.DateUtil;
import com.idle.util.GoodsExtendAndImage;
import com.idle.util.UserGrid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping(value = "/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private UserService userService;
    @Autowired
    private CommentsService commentsService;

    /**
     * 首页显示商品，每一类商品查询6件，根据最新上架排序 key的命名为categoryGoods1、categoryGoods2....
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/homeGoods")
    public ModelAndView homeGoods() throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        //long startTime = System.currentTimeMillis(); // 获取开始时间
        //商品种类数量
        int categorySize = 9;
        //每个种类显示商品数量
        //int goodsSize = 8;
        //获取最新的8条商品信息
        List<Goods> goodsListNew=goodsService.getNewGoods();
        modelAndView.addObject("goodsListNew",goodsListNew);
        for (int i = 1; i <= categorySize; i++) {
            List<Goods> goodsList = goodsService.getGoodsListByCategoryId(i);
            /*List<Goods> goodsList = null;
            List<GoodsExtend> goodsAndImage = null;
            goodsList = goodsService.getGoodsByCategoryOrderByDate(i, goodsSize);
            goodsAndImage = new ArrayList<GoodsExtend>();
            for (int j = 0; j < goodsList.size() ; j++) {
                //将用户信息和image信息封装到GoodsExtend类中，传给前台
                GoodsExtend goodsExtend = new GoodsExtend();
                Goods goods = goodsList.get(j);
                long startTime = System.currentTimeMillis(); // 获取开始时间
                Image image = imageService.getImagesByGoodsPrimaryKey(goods.getId());
                long endTime = System.currentTimeMillis(); // 获取结束时间
                System.out.println("程序运行时间： " + (endTime - startTime) + "ms");
                goodsExtend.setGoods(goods);
                goodsExtend.setImages(image);
                goodsAndImage.add(j, goodsExtend);
            }*/
            String key = "category" + "Goods" + i;
            modelAndView.addObject(key, goodsList);
        }
        //long endTime = System.currentTimeMillis(); // 获取结束时间
        //System.out.println("程序运行时间： " + (endTime - startTime) + "ms");
        modelAndView.setViewName("goods/homeGoods");
        return modelAndView;
    }

    @RequestMapping(value = "/search")
    public ModelAndView searchGoods(@RequestParam(value = "str",required = false) String str,@RequestParam(defaultValue = "1",value = "pageNum") int pageNum, @RequestParam(defaultValue = "16",value = "pageSize")int pageSize)throws Exception {
        UserGrid<Goods> userGrid= goodsService.searchGoods(str,str,pageNum,pageSize);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userGrid", userGrid);
        modelAndView.addObject("search",str);
        modelAndView.setViewName("/goods/searchGoods");
        return modelAndView;
    }

    /**
     * 查询该类商品
     * @param str
     * 要求该参数不为空
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/category/{categoryId}")
    public ModelAndView categoryGoods(@PathVariable("categoryId") Integer categoryId,
                                     @RequestParam(value = "str",required = false) String str,@RequestParam(defaultValue = "1",value = "pageNum") int pageNum, @RequestParam(defaultValue = "4",value = "pageSize")int pageSize) throws Exception {
        UserGrid<Goods>  userGrid = goodsService.getGoodsByCategoryId(categoryId,pageNum,pageSize);
        //Category category = categoryService.selectByPrimaryKey(categoryId);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("userGrid", userGrid);
        //modelAndView.addObject("category", category);
        //modelAndView.addObject("search",str);
        modelAndView.setViewName("/goods/categoryGoods");
        return modelAndView;
    }

    /**
     * 根据商品id查询该商品详细信息
     * @param goodsId
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/goodsId/{goodsId}")
    public ModelAndView getGoodsById(@PathVariable("goodsId") Integer goodsId) throws Exception {
        Goods goods = goodsService.getGoodsByPrimaryKey(goodsId);
        List<Comments> commentsList=commentsService.selectCommentsByGoodsId(goodsId);
        User seller = userService.selectByPrimaryKey(goods.getUserId());
        GoodsExtend goodsExtend = new GoodsExtend();
        List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(goodsId);
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(imageList);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("goodsExtend", goodsExtend);
        modelAndView.addObject("seller", seller);
        modelAndView.addObject("commentsList", commentsList);
        modelAndView.setViewName("/goods/detailGoods");
        return modelAndView;
    }

    /**
     * 修改商品信息
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editGoods/{goodsId}")
    public ModelAndView editGoods(@PathVariable("goodsId") Integer goodsId) throws Exception {
        Goods goods = goodsService.getGoodsByPrimaryKey(goodsId);
        List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(goodsId);
        GoodsExtend goodsExtend = new GoodsExtend();
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(imageList);
        ModelAndView modelAndView = new ModelAndView();
        // 将商品信息添加到model
        modelAndView.addObject("goodsExtend", goodsExtend);
        modelAndView.setViewName("/goods/editGoods");
        return modelAndView;
    }

    /**
     * 提交商品更改信息
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editGoodsSubmit")
    public String editGoodsSubmit(Goods goods) throws Exception {
        goods.setPolishTime(DateUtil.getNowTime());
        goodsService.updateGoodsByPrimaryKeyWithBLOBs(goods);
        return "redirect:/user/allGoods";
    }

    /**
     * 商品下架
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/downGood/{goodsId}")
    public void downGoods(@PathVariable int goodsId) throws Exception {
        goodsService.downGood(goodsId);
    }

    /**
     * 用户删除商品
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteGoods/{goodsId}")
    public String deleteGoods(HttpServletRequest request,@PathVariable("goodsId") Integer goodsId) throws Exception {
        //Goods goods = goodsService.getGoodsByPrimaryKey(goodsId);
        //删除商品后，category的number-1，user表的goods_num-1，image删除,更新session的值
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        //goods.setUserId(cur_user.getUserId());
        int number = cur_user.getGoodsNum();
        //Integer categoryId_id = goods.getCategoryId();
        //Category category = categoryService.selectByPrimaryKey(categoryId_id);
        //categoryService.updateCategoryNum(categoryId_id, category.getNumber()-1);
        //userService.updateGoodsNum(cur_user.getUserId(),number-1);
        cur_user.setGoodsNum(number-1);
        request.getSession().setAttribute("cur_user",cur_user);//修改session值
        //imageService.deleteImagesByGoodsPrimaryKey(goodsId);
        goodsService.deleteGoodsByPrimaryKey(goodsId);
        return "redirect:/user/allGoods";
    }
    /**
     * 发布商品
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/publishGoods")
    public String publishGoods(HttpServletRequest request) {
        //可以校验用户是否登录
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        if(cur_user == null) {
            return "/goods/homeGoods";
        } else {
            return "/goods/pubGoods";
        }
    }
    /**
     * 提交发布的商品信息
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/publishGoodsSubmit")
    public String publishGoodsSubmit(HttpServletRequest request,Goods goods) throws Exception {
        //查询出当前用户cur_user对象，便于使用id
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        goods.setUserId(cur_user.getUserId());
        //上传多张图片截取imgUrl
        String imgUrl=goods.getImgUrl();
        imgUrl=imgUrl.substring(0,imgUrl.length()-1);//去掉最后一个逗号
        String[] imgUrlList=imgUrl.split(",");//截取逗号分隔
        goodsService.addGood(goods);//在goods表中插入物品
        //返回插入的该物品的id
        for (int i=0;i<imgUrlList.length;i++) {
            Image image=new Image();
            image.setGoodsId(goods.getGoodsId() + "");
            image.setImgUrl(imgUrlList[i]);
            imageService.insert(image);//在image表中插入商品图片
        }
        //发布商品后，category的number+1，user表的goods_num+1，更新session的值
        int number = cur_user.getGoodsNum();
        //Category category = categoryService.selectByPrimaryKey(goods.getCategoryId());
        //categoryService.updateCategoryNum2(goods.getCategoryId());数据库触发器实现
        //userService.updateGoodsNum2(cur_user.getUserId());
        cur_user.setGoodsNum(number+1);
        request.getSession().setAttribute("cur_user",cur_user);//修改session值
        return "redirect:/user/allGoods";
    }

    /**
     * 上传物品
     * @param session
     * @param myFile
     * @return
     * @throws IllegalStateException
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping(value = "/uploadFile")
    public  Map<String,Object> uploadFile(HttpSession session,MultipartFile myFile) throws IllegalStateException, IOException{
        //原始名称
          String oldFileName = myFile.getOriginalFilename(); //获取上传文件的原名
        //存储图片的物理路径
        String file_path = session.getServletContext().getRealPath("upload");
        //上传图片
        if(myFile!=null && oldFileName!=null && oldFileName.length()>0){
            //新的图片名称
            String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
            //新图片
            File newFile = new File(file_path+"/"+newFileName);
            //将内存中的数据写入磁盘
            myFile.transferTo(newFile);
            //将新图片名称返回到前端
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("success", "成功啦");
            map.put("imgUrl",newFileName);
            return  map;
        }else{
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("error","图片不合法");
            return map;
        }
    }
}