package com.idle.pojo;

import com.idle.util.UserGrid;

import java.util.List;

public class GoodsExtend {
	private Goods goods;
    private UserGrid userGrid;
    private List<Image> images;

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public UserGrid getUserGrid() {
		return userGrid;
	}

	public void setUserGrid(UserGrid userGrid) {
		this.userGrid = userGrid;
	}

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}
}