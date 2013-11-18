package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Literature;
import com.akun.elibrary.bean.LiteratureExample;


/**
 * 
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-6 上午10:41:17<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public interface LiteratureBO {
	 /**
     * 
     * @author 杨宗昆<br>
     * 方法说明：添加<br>
     * @param item
     * @return: 0表示数据格式不正确，1重名，2添加成功，-1添加失败
     */
	int add(Literature item);
    
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
	int update(String literatureJson);
	int update(String literatureJson1,String literatureJson2);
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：查询<br>
	 * @param
	 * @return:
	 */
	List<Literature> selectByExample(LiteratureExample example);

	/**
	 * @author 杨宗昆<br>
	 * 方法说明：通过图书名搜索数据<br>
	 * @param
	 * @return:
	 */
	List<Literature> selectByKey(String key);
	
	List<Literature> selectByNameAndAuthor(String name,String author);
}