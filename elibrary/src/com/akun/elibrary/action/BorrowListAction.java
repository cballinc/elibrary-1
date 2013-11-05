package com.akun.elibrary.action;

//import java.text.SimpleDateFormat;
//import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.akun.elibrary.bean.Borrowinfo;
import com.akun.elibrary.bean.Literatureforborrow;
import com.akun.elibrary.bean.Student;
import com.akun.elibrary.bo.BorrowListBO;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class BorrowListAction extends ActionSupport {
	private static final Logger LOGGER = Logger.getLogger(BorrowListAction.class);
	String pmderrorretvalue = "{success:true,\"error\":\"true\"}";
	private BorrowListBO borrowListBO;
	private String key;
	private int start, limit;
	private String retvalue;
	private String idsToDelete;
	private Borrowinfo borrowinfo;
    private String detailJsonArray;
    private String snumber;
    private String returnJsonArray;
    private int theliteratureid;
    private int thecategoryid;
    private String returnborrowids;
    private String deferBorrowids;
    private String deferExpectedReturnTimes;
    /**
     * 为解决借阅和归还预先载入空数据问题，return空json
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String returnEmptyJson(){
//    	retvalue = "{success:true,\"error\":\"false\",list:[";
//    	retvalue += "{\"literaturename1\":\""+ 
//    	"\",\"categoryid1\":\"" +  "\", \"author1\":\""  + "\",\"press1\":\""+ "\",\"price1\":\"" + "\",\"num1\":\"" 
//		+ "\",\"lindex1\":\"" + "\",\"literatureid1\":\"" + "\",\"outnum1\":\"" + "\"}";
//    	retvalue += "]}";
    	retvalue = "{success:true,\"error\":\"false\",list:[]";
    	//System.out.println(retvalue);
    	return SUCCESS;
    }
    /**
     * 续借操作
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @return
     */
    public String deferBorrow(){
    	//System.out.println(deferExpectedReturnTimes);
    	//System.out.println(deferBorrowids);
    	int result = borrowListBO.deferBorrow(deferBorrowids,deferExpectedReturnTimes);
    	if(result==0){
    		retvalue = "不能重复续借";
    	}else{
    		retvalue = "续借成功";
    	}
    	
    	return SUCCESS;
    }
	/**
	 * 获取已登录学生的借阅过的书籍列表
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @param
	 * @return:
	 */
    public String listLoginedStudentBorrowedLiterature(){
    	Student loginedStudent = (Student)ServletActionContext.getRequest().getSession().getAttribute("loginedStudent");
		System.out.println(loginedStudent.getSnumber());
    	String theLoginedSnumber = loginedStudent.getSnumber();
		List<Literatureforborrow> listBorrowedLiteratureBySnumber = (List<Literatureforborrow>)borrowListBO.listBorrowListBySnumber(
				theLoginedSnumber,start,limit);
		retvalue = "{success:true,\"error\":\"false\",list:[";
		try {
			for (Literatureforborrow item : listBorrowedLiteratureBySnumber) {
				retvalue += "{\"borrowedcategoryname\":\"" + item.getCategoryname()
						+ "\",\"borrowedliteraturename\":\"" + item.getLiteraturename()
						+ "\", \"borrowedborrownum\":\"" + item.getNum() + "\",\"borrowedborrowtime\":\""
						+ item.getBorrowtime() + "\",\"borrowedexpectedreturntime\":\"" + item.getExpectedreturntime()
						+ "\",\"borrowedlindex\":\"" + item.getLindex()
						+ "\",\"borrowedborrowid\":\"" + item.getBorrowid()
						+ "\"},";
			}
			if (listBorrowedLiteratureBySnumber.size() > 0) {
				retvalue = retvalue.substring(0, retvalue.length() - 1);
			}
			retvalue += "]}";
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
			retvalue = "{success:true,\"error\":\"true\",list:[]";
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
    /**
	 * 借阅信息列表
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @return
	 */
	public String listBorrowList() {
		if (key == null) {
			key = "";
		}
		if(limit == 0){
			limit=9999;
		}
		//System.out.println(key);
		List<Literatureforborrow> list = (List<Literatureforborrow>) borrowListBO.listBorrowList(
				key, start, limit);
		retvalue = "{success:true,\"error\":\"false\",total:" + borrowListBO.countBorrowList(key)
		+ ",list:[";
		try {
			for (Literatureforborrow item : list) {
				System.out.println(item.getLiteratureid());
				String lindex_snumber = (item.getLindex().trim()+item.getSnumber().trim()+"").trim(); 
				retvalue += "{\"categoryname\":\"" + item.getCategoryname()
						+ "\",\"literaturename\":\"" + item.getLiteraturename()
						+ "\", \"totalnum\":\"" + item.getTotalnum() + "\",\"num\":\""
						+ item.getNum() + "\",\"returntime\":\"" + item.getReturntime()
						+ "\",\"returned\":\"" + item.getReturned() + "\",\"borrowtime\":\""
						+ item.getBorrowtime() + "\",\"sname\":\""
						+ item.getSname() + "\",\"snumber\":\"" + item.getSnumber()
						+ "\",\"borrowid\":\"" + item.getBorrowid() + "\",\"expectedreturntime\":\""
						+ item.getExpectedreturntime() + "\",\"lindex\":\""
						+ item.getLindex() + "\",\"literatureid\":\""
						+ item.getLiteratureid() + "\",\"lindex_snumber\":\""
						+ lindex_snumber + "\",\"expired\":\""
						+ item.getExpired() + 
						"\"},";
			}
			if (list.size() > 0) {
				retvalue = retvalue.substring(0, retvalue.length() - 1);
			}
			retvalue += "]}";
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
			retvalue = "{success:true,\"error\":\"true\",list:[]";
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * 借阅信息列表未归还
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @return
	 */
	public String listBorrowListNotReturned() {
		if (key == null) {
			key = "";
		}
		if(limit == 0){
			limit=9999;
		}
		//System.out.println(key);
		List<Literatureforborrow> list = (List<Literatureforborrow>) borrowListBO.listBorrowListNotReturned(
				key, start, limit);
		retvalue = "{success:true,\"error\":\"false\",total:" + borrowListBO.countBorrowList(key)
		+ ",list:[";
		try {
			for (Literatureforborrow item : list) {
				System.out.println(item.getLiteratureid());
				String lindex_snumber = (item.getLindex().trim()+item.getSnumber().trim()+"").trim(); 
				retvalue += "{\"categoryname\":\"" + item.getCategoryname()
						+ "\",\"literaturename\":\"" + item.getLiteraturename()
						+ "\", \"totalnum\":\"" + item.getTotalnum() + "\",\"num\":\""
						+ item.getNum() + "\",\"returntime\":\"" + item.getReturntime()
						+ "\",\"returned\":\"" + item.getReturned() + "\",\"borrowtime\":\""
						+ item.getBorrowtime() + "\",\"sname\":\""
						+ item.getSname() + "\",\"snumber\":\"" + item.getSnumber()
						+ "\",\"borrowid\":\"" + item.getBorrowid() + "\",\"expectedreturntime\":\""
						+ item.getExpectedreturntime() + "\",\"lindex\":\""
						+ item.getLindex() + "\",\"literatureid\":\""
						+ item.getLiteratureid() + "\",\"lindex_snumber\":\""
						+ lindex_snumber + "\",\"expired\":\""
						+ item.getExpired() + 
						"\"},";
			}
			if (list.size() > 0) {
				retvalue = retvalue.substring(0, retvalue.length() - 1);
			}
			retvalue += "]}";
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
			retvalue = "{success:true,\"error\":\"true\",list:[]";
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * 按图书id查询借书信息
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @param
	 * @return:
	 */
	public String listBorrowListByid() {
		List<Literatureforborrow> listByid = (List<Literatureforborrow>) borrowListBO.listBorrowListByName(
				theliteratureid+"", start, limit);
		retvalue = "{success:true,\"error\":\"false\",list:[";
		try {
			for (Literatureforborrow item : listByid) {
				retvalue += "{\"categoryname\":\"" + item.getCategoryname()
						+ "\",\"literaturename\":\"" + item.getLiteraturename()
						+ "\", \"totalnum\":\"" + item.getTotalnum() + "\",\"num\":\""
						+ item.getOutnum() + "\"},";
			}
			if (listByid.size() > 0) {
				retvalue = retvalue.substring(0, retvalue.length() - 1);
			}
			retvalue += "]}";
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
			retvalue = "{success:true,\"error\":\"true\",list:[]";
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * 按图书名group查询借书信息
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @param
	 * @return:
	 */
	public String listBorrowListByGroup() {
		List<Literatureforborrow> listByid = (List<Literatureforborrow>) borrowListBO.listBorrowListByGroup(
				"", start, limit);
		retvalue = "{success:true,\"error\":\"false\",list:[";
		try {
			for (Literatureforborrow item : listByid) {
				retvalue += "{\"categoryname\":\"" + item.getCategoryname()
						+ "\",\"literaturename\":\"" + item.getLiteraturename()
						+ "\", \"totalnum\":\"" + item.getTotalnum() + "\",\"num\":\""
						+ item.getOutnum() + "\",\"categoryid\":\""
						+ item.getCategoryid() + "\"},";
			}
			if (listByid.size() > 0) {
				retvalue = retvalue.substring(0, retvalue.length() - 1);
			}
			retvalue += "]}";
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
			retvalue = "{success:true,\"error\":\"true\",list:[]";
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * 按图书category查询借书信息
	 * @author 杨宗昆<br>
	 * 方法说明：<br>
	 * @param
	 * @return:
	 */
	public String listBorrowListByCategory() {
		List<Literatureforborrow> listByid = (List<Literatureforborrow>) borrowListBO.listBorrowListByCategory(
				thecategoryid+"", start, limit);
		retvalue = "{success:true,\"error\":\"false\",list:[";
		try {
			for (Literatureforborrow item : listByid) {
				retvalue += "{\"categoryname\":\"" + item.getCategoryname()
						+ "\",\"literaturename\":\"" + item.getLiteraturename()
						+ "\", \"totalnum\":\"" + item.getTotalnum() + "\",\"num\":\""
						+ item.getOutnum() +  "\"},";
			}
			if (listByid.size() > 0) {
				retvalue = retvalue.substring(0, retvalue.length() - 1);
			}
			retvalue += "]}";
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
			retvalue = "{success:true,\"error\":\"true\",list:[]";
		}
		System.out.println(retvalue);
		return SUCCESS;
	}
	/**
	 * 删除借阅信息
	 * 
	 * @author 杨宗昆<br>
	 *         方法说明：<br>
	 * @return
	 */
	public String deleteBorrowInfo() {
		System.out.println(idsToDelete);
		int result = borrowListBO.deleteBorrowInfo(idsToDelete);
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
     * 添加借书信息
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @param
     * @return:
     */
    public String addBorrowInfo(){
    	try {
    		boolean i = borrowListBO.addBorrowInfo(snumber,detailJsonArray);
    		System.out.println(i);
			if (i) {
				retvalue = "{success:true,\"error\":\"false\"}";
			}else {
				retvalue = pmderrorretvalue;
				return ERROR;
			}			
		}
		catch (Exception e) {			
			retvalue = pmderrorretvalue;
			LOGGER.error(e.toString());
		}
		
		return SUCCESS;
    }
    /**
     * 还书
     * @author 杨宗昆<br>
     * 方法说明：<br>
     * @param
     * @return:
     */
    public String returnBorrowInfo(){
    	try {
    		double totalForfeit = borrowListBO.returnBorrowInfo(returnJsonArray);
    		//totalForfeit=5.0;
    		//System.out.println(totalForfeit);
			retvalue = "{success:true,\"msg\":'归还时间逾期，罚款"+totalForfeit+"元',\"error\":\"false\",\"forfeit\":"+totalForfeit+"}";
		}
		catch (Exception e) {			
			retvalue = pmderrorretvalue;
			LOGGER.error(e.toString());
		}
		//System.out.println(retvalue);
		return SUCCESS;
    }
//	/**
//	 * @author 杨宗昆<br>
//	 *         方法说明：将日期类型转为string类型<br>
//	 * @param date
//	 * @return String
//	 */
//	private String getDateStr(Date date) {
//		try {
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			return sdf.format(date);
//		}
//		catch (Exception e) {
//			return "";
//		}
//	}
    
	public String getPmderrorretvalue() {
		return pmderrorretvalue;
	}

	public void setPmderrorretvalue(String pmderrorretvalue) {
		this.pmderrorretvalue = pmderrorretvalue;
	}

	public Borrowinfo getBorrowinfo() {
		return borrowinfo;
	}

	public void setBorrowinfo(Borrowinfo borrowinfo) {
		this.borrowinfo = borrowinfo;
	}

	public String getDetailJsonArray() {
		return detailJsonArray;
	}

	public void setDetailJsonArray(String detailJsonArray) {
		this.detailJsonArray = detailJsonArray;
	}

	public String getSnumber() {
		return snumber;
	}

	public void setSnumber(String snumber) {
		this.snumber = snumber;
	}

	public String getIdsToDelete() {
		return idsToDelete;
	}

	public void setIdsToDelete(String idsToDelete) {
		this.idsToDelete = idsToDelete;
	}

	public BorrowListBO getBorrowListBO() {
		return borrowListBO;
	}

	public void setBorrowListBO(BorrowListBO borrowListBO) {
		this.borrowListBO = borrowListBO;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
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

	public String getRetvalue() {
		return retvalue;
	}

	public void setRetvalue(String retvalue) {
		this.retvalue = retvalue;
	}

	public String getReturnJsonArray() {
		return returnJsonArray;
	}

	public void setReturnJsonArray(String returnJsonArray) {
		this.returnJsonArray = returnJsonArray;
	}
	public int getTheliteratureid() {
		return theliteratureid;
	}
	public void setTheliteratureid(int theliteratureid) {
		this.theliteratureid = theliteratureid;
	}
	public int getThecategoryid() {
		return thecategoryid;
	}
	public void setThecategoryid(int thecategoryid) {
		this.thecategoryid = thecategoryid;
	}
	public String getReturnborrowids() {
		return returnborrowids;
	}
	public void setReturnborrowids(String returnborrowids) {
		this.returnborrowids = returnborrowids;
	}
	public String getDeferBorrowids() {
		return deferBorrowids;
	}
	public void setDeferBorrowids(String deferBorrowids) {
		this.deferBorrowids = deferBorrowids;
	}
	public String getDeferExpectedReturnTimes() {
		return deferExpectedReturnTimes;
	}
	public void setDeferExpectedReturnTimes(String deferExpectedReturnTimes) {
		this.deferExpectedReturnTimes = deferExpectedReturnTimes;
	}
    
}
