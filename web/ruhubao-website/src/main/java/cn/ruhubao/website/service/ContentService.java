package cn.ruhubao.website.service;

import cn.ruhubao.website.pojo.Content;
import cn.ruhubao.website.pojo.DataGridResult;
import cn.ruhubao.website.pojo.DataGridResult2;

public interface ContentService extends BaseService<Content>{

	/**
	 * 根据内容分类id查询该分类的分页内容列表
	 * @param categoryId 分类id
	 * @param page 页号
	 * @param rows 页大小
	 * @return
	 */
	DataGridResult queryContentListByPage(Long categoryId, Integer page, Integer rows);

	DataGridResult2 queryContentListByPage2(Long categoryId, Integer page, Integer rows);
	
	DataGridResult queryAllContentListByPage(Integer page, Integer rows);

	DataGridResult queryAllContentListByCategroryId(Long id, Integer page, Integer rows);

	

	


	
	
}
