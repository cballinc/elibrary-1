package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Category;
import com.akun.elibrary.bean.CategoryExample;

/**
 * 
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-5 下午03:43:26<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public interface CategoryBO {
	 /**
     * 
     * @author 杨宗昆<br>
     * 方法说明：添加<br>
     * @param item
     * @return: 0表示数据格式不正确，1重名，2添加成功，-1添加失败
     */
	int add(Category item);
    
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：删除<br>
	 * @param example
	 * @return: 0数据格式不正确，1不允许删除，2删除成功
	 */
	int deleteByPrimaryKey(String ids);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：更新数据<br>
	 * @param json数据
	 * @return: 0数据格式不正确，1名称重复，2修改成功，-1修改失败
	 */
	int update(String categoryJson);
	int update(String catogaryJson1,String categoryJson2);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：查询<br>
	 * @param
	 * @return:
	 */
	List<Category> selectByExample(CategoryExample example);
}
