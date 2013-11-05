package com.akun.elibrary.bo.imp;

import java.util.List;

import org.apache.log4j.Logger;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Category;
import com.akun.elibrary.bean.CategoryExample;
import com.akun.elibrary.bo.CategoryBO;
import com.akun.elibrary.dao.CategoryDAO;

public class CategoryBOImp implements CategoryBO {
	private static final Logger LOGGER = Logger.getLogger(CategoryBOImp.class);
    private CategoryDAO categoryDAO;
	
	/**
	 * 增
	 * return 2添加成功，-1添加失败,5 重复
	 */
    @Override
	@SuppressWarnings("unchecked")
	public int add(Category item) {
		int result = -1;
		//验证重复列别名
		CategoryExample example = new CategoryExample();
		example.createCriteria().andCategorynameLike("%"+item.getCategoryname()+"%");
		List<Category> list1 = (List<Category>)categoryDAO.selectByExample(example);
		//验证重复索引号
		CategoryExample example2 = new CategoryExample();
		example2.createCriteria().andCindexEqualTo(item.getCindex());
		List<Category> list2 = (List<Category>)categoryDAO.selectByExample(example2);
		if (list1.size() == 0&&list2.size()==0) {
		try {
			categoryDAO.insertSelective(item);
			result = 2;
		}
		catch (Exception e) {
		    LOGGER.error(e.toString());
		}
		}else{
			result = 5;
		}
		return result;
	}
    /**
     * 删
     * return 0数据格式不正确，1不允许删除，2删除成功
     */
	@Override
	public int deleteByPrimaryKey(String idsToDelete) {
		int result = 1;
		if(idsToDelete != null && !"".equals(idsToDelete)){
			String[] stringIds = idsToDelete.split(",");
//			int[] ids = null;
//			for(int i=0;i<stringIds.length;i++){
//				ids[i]=Integer.parseInt(stringIds[i]);
//			}
			//System.out.println(ids[0]);
			try {
				for(int j=0;j<stringIds.length;j++){
					try {
						CategoryExample example = new CategoryExample();
						example.createCriteria().andCategoryidEqualTo(stringIds[j]);
						categoryDAO.deleteByExample(example);
					}
					catch (Exception e) {
					    LOGGER.error(e.toString());
					}
				}
				result = 2;
			}
			catch (Exception e) {
			    result = 0;
			}
			
		}else{
			result = 0;
		}
		return result;
	}
    /**
     * 查
     */
	@SuppressWarnings("unchecked")
	@Override
	public List<Category> selectByExample(CategoryExample example) {
		List<Category> list = (List<Category>)categoryDAO.selectByExample(example);
		return list;
	}
    /**
     * 改
     * return 0数据格式不正确，2修改成功，-1修改失败
     */
	@SuppressWarnings("unchecked")
	@Override
	public int update(String categoryJson, String categoryJson2) {
		int result = 0;
		if (categoryJson != null && !"".equals(categoryJson)) {
			System.out.println(categoryJson);
			JSONArray jsonArray = JSONArray.fromObject(categoryJson);
			List<Category> categoryList = (List<Category>) JSONArray.toCollection(jsonArray,
					Category.class);
			JSONArray jsonArray2 = JSONArray.fromObject(categoryJson2);
			List<Category> categoryList2 = (List<Category>) JSONArray.toCollection(jsonArray2,
					Category.class);
			CategoryExample example = new CategoryExample();
			if (result == 0) {
				int updatecount = 0;
				for(int i=0;i<categoryList.size();i++){
					example.createCriteria().andCategoryidEqualTo(categoryList.get(i).getCategoryid());
					try {
						categoryDAO.updateByExampleSelective(categoryList2.get(i), example);
						updatecount++;
					}
					catch (Exception e) {
				    		LOGGER.error(e.toString());
					}
				}
				if (updatecount == categoryList.size()) {
					result = 2;
				} else {
					result = -1;
				}
			} else {
				result = 0;
			}
		} else {
			result = -1;
		}

		return 2;
	}

	public CategoryDAO getCategoryDAO() {
		return categoryDAO;
	}
	public void setCategoryDAO(CategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
	}
	@Override
	public int update(String categoryJson) {
		// TODO Auto-generated method stub
		return 0;
	}

    
	
}
