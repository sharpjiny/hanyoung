package com.bogoManager.model;

import javax.validation.Valid;

import com.bogoManager.domain.Stock;

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
