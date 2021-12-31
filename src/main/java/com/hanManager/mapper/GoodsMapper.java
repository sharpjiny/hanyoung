package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.Goods;
import com.hanManager.domain.PackingInspection;
import com.hanManager.domain.Stock;


public interface GoodsMapper {

	Integer selectGoodsPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectGoodsList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectGoodsPagingList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectGoodsStatistics(HashMap<String, Object> paramMap);

	Goods selectGoods(Goods goods);

	int insertGoods(Goods goods);

	int updateGoods(Goods goods);
	int updateGoodsSub(Goods goods);

	int deleteGoods(Goods goods);
	int deleteGoodsSub(Goods goods);
	int deleteGoodsKey(Goods goods);

	int confirmGoods(Goods goods);
}
