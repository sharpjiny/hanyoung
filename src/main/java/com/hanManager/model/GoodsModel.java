package com.hanManager.model;

import javax.validation.Valid;

import com.hanManager.domain.Goods;

public class GoodsModel {

    @Valid
    private Goods goods;

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
}
