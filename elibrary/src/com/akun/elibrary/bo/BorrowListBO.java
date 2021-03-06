package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Literatureforborrow;

/**
 * 
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-11 上午09:55:11<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public interface BorrowListBO {
     /**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：获取借阅列表，分页<br>
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
   public List<Literatureforborrow> listBorrowList(String key, int start, int limit);
   /**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：按图书名称获取借阅列表,分页<br>
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
  public List<Literatureforborrow> listBorrowListByName(String key, int start, int limit);
   /**
    * 
    * @author 杨宗昆<br>
    * 方法说明：获取借阅列表记录数<br>
    * @param key
    * @return
    */
   public int countBorrowList(String key);
   /**
    * 
    * @author 杨宗昆<br>
    * 方法说明：删除借阅信息<br>
    * @param ids
    * @return
    */
   public int deleteBorrowInfo(String ids);
   public boolean addBorrowInfo(String snumber,String detailJsonArray);
   public double returnBorrowInfo(String returnJsonArray);
/**
 * @author 杨宗昆<br>
 * 方法说明：按图书名称group获取借阅列表,分页<br>
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListByGroup(String key, int start, int limit);
/**
 * @author 杨宗昆<br>
 * 方法说明：按图书category获取借阅列表,分页<br>
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListByCategory(String key, int start, int limit);
/**
 * @author 杨宗昆<br>
 * 方法说明：获取已登录学生的借阅过的书籍列表<br>
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListBySnumber(String theLoginedSnumber, int start,
		int limit);
/**
 * 
 * @author 杨宗昆<br>
 * 方法说明：续借<br>
 * @param deferBorrowids
 * @param deferExpectedReturnTimes
 * @return
 */
public int deferBorrow(String deferBorrowids, String deferExpectedReturnTimes);
/**
 * @author 杨宗昆<br>
 * 方法说明：获取未归还的信息列表<br>
 * @param
 * @return:
 */
public List<Literatureforborrow> listBorrowListNotReturned(String key, int start, int limit);
   
}
