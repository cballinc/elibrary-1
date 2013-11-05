package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Libuser;
import com.akun.elibrary.bean.LibuserExample;

/**
 * 
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-1 上午09:43:01<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public interface LibuserBO {
   /**
    * 登录验证
    */
	Libuser validateUser(String username,String userpwd);
	
	 /**
     * 
     * @author 杨宗昆<br>
     * 方法说明：添加<br>
     * @param item
     * @return: 0表示数据格式不正确，1重名，2添加成功，-1添加失败
     */
	int add(Libuser item);
    
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：删除<br>
	 * @param example
	 * @return: 0数据格式不正确，1不允许删除，2删除成功
	 */
	int deleteByPrimaryKey(String idsToDelete);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：更新数据<br>
	 * @param json数据
	 * @return: 0数据格式不正确，1名称重复，2修改成功，-1修改失败
	 */
	int update(String libuserJson);
	int update(String libuserJson,String libuserJson2);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：查询<br>
	 * @param
	 * @return:
	 */
	List<Libuser> selectByExample(LibuserExample example);
	/**
	 * 更改密码
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @param libuser
	 * @param pwd
	 * @param pwd2
	 * @return
	 */
	int changePwd(String username,String pwd, String pwd2);
}
