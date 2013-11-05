package com.akun.elibrary.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.akun.elibrary.bean.Classes;
import com.akun.elibrary.bean.Student;
import com.akun.elibrary.bean.StudentExample;
import com.akun.elibrary.bo.ClassesBO;
import com.akun.elibrary.bo.StudentBO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 作 者：杨宗昆<br>
 * 创建日期： 2012-4-1 下午01:51:09<br>
 * 版 本： 1.00<br>
 * 版权所有
 */
@SuppressWarnings("serial")
public class StudentAction extends ActionSupport {
	private StudentBO studentBO;
	private ClassesBO classesBO;
	private String retvalue;
	private int start, limit;
	private String key;
	private List<Student> studentList;
	private String updateStudentList;
	private Student student;
	private String snumbersToDelete;
    private String loginSnumber;
    private String loginStudentPwd;
    private String addSnumber;
	/**
	 * 学生登录查询页面studentPage
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @return
	 */
    public String studentLogin(){
    	System.out.println(loginSnumber);
    	System.out.println(loginStudentPwd);
		StudentExample loginstudentexample = new StudentExample();
		loginstudentexample.createCriteria().andSnumberEqualTo(loginSnumber).andPwdEqualTo(loginStudentPwd);
		List<Student> studentLoginList = (List<Student>)studentBO.selectByExample(loginstudentexample);
    	Student loginedStudent = studentLoginList.get(0);
		if(studentLoginList.size()==0||studentLoginList==null){
    		retvalue="{success:true,\"error\":\"true\"}";
    	}else{
     	    ServletActionContext.getRequest().getSession().setAttribute("loginedStudent", loginedStudent);
     	    retvalue = "{success:true,\"error\":\"false\"}";
    	}
     	return SUCCESS;
	}
    /**
     * 学生注销
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @param
     * @return:
     */
    public String studentLogout(){
    	ServletActionContext.getRequest().getSession().removeAttribute("loginedStudent");
    	return SUCCESS;
    }
	
    /**
	 * 分页显示学生列表
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：分页功能还未完成<br>
	 * @param
	 * @return:
	 */
	public String showStudent() {
		retvalue = "{\"total\":";
		if (key == null) {
			key = "";
		}
		List<Student> theStudentList = studentBO.selectByCondition(start, limit, key);
		// 将theStudentList中classid替换成cname再生成JSON
		for (Student theStudent : theStudentList) {
			if (theStudent.getClassnumber() != null && !"".equals(theStudent.getClassnumber())) {
				Classes theClass = classesBO.listClasses(theStudent.getClassnumber());
				theStudent.setClassnumber(theClass.getCname());
			} else {
				continue;
			}
		}
		StudentExample example = new StudentExample();
		example.createCriteria().andSnameLike("%" + key + "%");
		int totalRecords = studentBO.countByExample(example);
		if (theStudentList != null) {
			retvalue += totalRecords + ",\"nodes\":";
			retvalue += JSONArray.fromObject(theStudentList);
		} else {
			retvalue += 0 + ",\"nodes\":[]";
		}
		retvalue += "}";
		return SUCCESS;
	}

	/**
	 *更新学生信息
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String updateStudent() {
		int result = studentBO.update(updateStudentList);
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
	 * 添加学生信息
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String addStudent() {
		// 验证学号是否重复
			retvalue = "{\"success\":true,\"msg\":";
			int result = studentBO.addStudent(student);
			switch (result) {
			case -1:
				retvalue += "\"操作失败\"";
				break;
			case 0:
				retvalue += "\"数据格式不正确\"";
				break;
			case 1:
				retvalue += "\"名称已被使用，请重新输入\"";
				break;
			case 2:
				retvalue += "\"操作成功\"";
				break;
			case 5:
				retvalue += "\"学号输入重复\"";
			default:
				break;
			}
			retvalue += "}";

		
		return SUCCESS;
	}
	/**
	 * 添加学生时check学号是否已存在
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @return
	 */
	public String checkSnumber(){
		//System.out.println(addSnumber);
		StudentExample studentExample = new StudentExample();
		studentExample.createCriteria().andSnumberEqualTo(addSnumber);
		List<Student> list = studentBO.selectByExample(studentExample);
		//System.out.println(list.size());
		if(list.size()>0){
			retvalue="学号已存在！";
		}else{
			retvalue="合法学号";
		}
		return SUCCESS;
	}

	/**
	 * 删除学生信息一个或多个
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @param
	 * @return:
	 */
	public String deleteStudents() {
		int result = studentBO.deleteByPrimaryKey(snumbersToDelete);
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

	public ClassesBO getClassesBO() {
		return classesBO;
	}

	public void setClassesBO(ClassesBO classesBO) {
		this.classesBO = classesBO;
	}

	public String getSnumbersToDelete() {
		return snumbersToDelete;
	}

	public void setSnumbersToDelete(String snumbersToDelete) {
		this.snumbersToDelete = snumbersToDelete;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public String getUpdateStudentList() {
		return updateStudentList;
	}

	public void setUpdateStudentList(String updateStudentList) {
		this.updateStudentList = updateStudentList;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	public StudentBO getStudentBO() {
		return studentBO;
	}

	public void setStudentBO(StudentBO studentBO) {
		this.studentBO = studentBO;
	}

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String getLoginSnumber() {
		return loginSnumber;
	}

	public void setLoginSnumber(String loginSnumber) {
		this.loginSnumber = loginSnumber;
	}

	public String getLoginStudentPwd() {
		return loginStudentPwd;
	}

	public void setLoginStudentPwd(String loginStudentPwd) {
		this.loginStudentPwd = loginStudentPwd;
	}
	public String getAddSnumber() {
		return addSnumber;
	}
	public void setAddSnumber(String addSnumber) {
		this.addSnumber = addSnumber;
	}
    
}
