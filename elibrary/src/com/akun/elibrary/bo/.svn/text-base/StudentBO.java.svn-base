package com.akun.elibrary.bo;

import java.util.List;

import com.akun.elibrary.bean.Student;
import com.akun.elibrary.bean.StudentExample;

/**
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-1 下午01:52:46<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public interface StudentBO {
    /**
     * 
     * @author 杨宗昆<br>
     * 方法说明：添加学生<br>
     * @param item
     * @return: 0表示数据格式不正确，1重名，2添加成功，-1添加失败
     */
	int addStudent(Student item);
    
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：删除学生<br>
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
	int update(String studentJson);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：学生查询<br>
	 * @param 略过多少条数据，行数，关键字
	 * @return list
	 */
	List<Student> selectByCondition(int skipResults, int rows, String key);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：返回记录数，用于分页<br>
	 * @param
	 * @return:
	 */
	int countByExample(StudentExample example);
	
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：查询<br>
	 * @param
	 * @return:
	 */
	List<Student> selectByExample(StudentExample example);
}
