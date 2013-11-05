package com.akun.elibrary.action;

import java.util.List;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Category;
import com.akun.elibrary.bean.CategoryExample;
import com.akun.elibrary.bo.CategoryBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class CategoryAction extends ActionSupport {
    private CategoryBO categoryBO;
    //private Category category;
    private String key;
    private String retvalue;
    private String updateCategoryList;
    private String updateCategoryList2;
    private String idsToDelete;
    private Category category;
    /**
     * 查
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String listCategory(){
    	if(key==null){
    		key="";
    	}
    	CategoryExample categoryExample = new CategoryExample();
    	categoryExample.createCriteria().andCategorynameLike("%"+key+"%");
    	List<Category> list = (List<Category>)categoryBO.selectByExample(categoryExample);
    	retvalue="{\"nodes\":";
    	if(list!=null){
    		retvalue += JSONArray.fromObject(list);
    	}else{
    		retvalue += "[]";
    	}
    	retvalue += "}";
    	System.out.println(retvalue);
    	return SUCCESS;
    }
    
    /**
     * 改
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String updateCategory() {
		int result = categoryBO.update(updateCategoryList,updateCategoryList2);
		switch (result) {
		case 0:
			retvalue = "数据格式不正确";
			break;
		case 1:
			retvalue = "保存的名称已被使用，请重新输入";
			break;
		case 2:
			retvalue = "修改成功";
			break;
		default:
			retvalue = "操作失败";
			break;
		}
		return SUCCESS;
	}
    
    /**
	 * 删一个或多个
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String deleteCategory() {
		System.out.println(idsToDelete);
		int result = categoryBO.deleteByPrimaryKey(idsToDelete);
		switch (result) {
		case 0:
			retvalue = "数据格式不正确";
			break;
		case 1:
			retvalue = "已被引用，禁止删除";
			break;
		case 2:
			retvalue = "删除成功";
			break;
		default:
			retvalue = "操作失败";
			break;
		}
		return SUCCESS;
	}
	/**
	 * 增
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String addCategory() {
			retvalue = "{\"success\":true,\"msg\":";
			int result = categoryBO.add(category);
			switch (result) {
			case -1:
				retvalue += "\"操作失败\"";
				break;
			case 0:
				retvalue += "\"数据格式不正确\"";
				break;
			case 2:
				retvalue += "\"操作成功\"";
				break;
			case 5:
				retvalue += "\"类别名或索引号输入重复\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}
    
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public String getIdsToDelete() {
		return idsToDelete;
	}
	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}
	public String getUpdateCategoryList2() {
		return updateCategoryList2;
	}
	public void setUpdateCategoryList2(String updateCategoryList2) {
		this.updateCategoryList2 = updateCategoryList2;
	}
	public CategoryBO getCategoryBO() {
		return categoryBO;
	}
	public void setCategoryBO(CategoryBO categoryBO) {
		this.categoryBO = categoryBO;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getRetvalue() {
		return retvalue;
	}
	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}
	public String getUpdateCategoryList() {
		return updateCategoryList;
	}
	public void setUpdateCategoryList(String updateCategoryList) {
		this.updateCategoryList = updateCategoryList;
	}
	
}