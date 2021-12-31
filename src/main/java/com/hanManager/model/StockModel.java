package com.hanManager.model;

import javax.validation.Valid;

import com.hanManager.domain.Stock;

public class StockModel {

    @Valid
    private Stock stock;

	public Stock getStock() {
		return stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}
}
