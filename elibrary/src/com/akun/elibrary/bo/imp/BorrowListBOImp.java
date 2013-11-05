package com.akun.elibrary.bo.imp;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.akun.elibrary.bean.Borrowinfo;
import com.akun.elibrary.bean.BorrowinfoExample;
import com.akun.elibrary.bean.Literature;
import com.akun.elibrary.bean.LiteratureExample;
import com.akun.elibrary.bean.Literatureforborrow;
import com.akun.elibrary.bean.LiteratureforborrowExample;
import com.akun.elibrary.bean.Student;
import com.akun.elibrary.bean.StudentExample;
import com.akun.elibrary.bo.BorrowListBO;
import com.akun.elibrary.dao.BorrowinfoDAO;
import com.akun.elibrary.dao.LiteratureDAO;
import com.akun.elibrary.dao.LiteratureforborrowDAO;
import com.akun.elibrary.dao.StudentDAO;

public class BorrowListBOImp implements BorrowListBO {
	private static final Logger LOGGER = Logger.getLogger(BorrowListBOImp.class);
	private LiteratureforborrowDAO literatureforborrowDAO;
	private BorrowinfoDAO borrowinfoDAO;
	private StudentDAO studentDAO;
	private LiteratureDAO literatureDAO;
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：返回未归还借阅信息列表<br>
	 * @param 
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Literatureforborrow> listBorrowListNotReturned(String key, int start, int limit) {
		List<Literatureforborrow> results = new ArrayList<Literatureforborrow>();
		int flag=0;
		limit = 9999;
		try {
			results = literatureforborrowDAO.getBorrowListNotReturned(key, start, limit);
			//判断当前日期是否超过expectecReturnTime,若是则flag=1过期，否则flag=0未过期
			String nowDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        	//System.out.println(nowDatetime);
        	int year = Integer.parseInt(nowDatetime.substring(0, 4));
        	int month = Integer.parseInt(nowDatetime.substring(5, 7));
        	int day = Integer.parseInt(nowDatetime.substring(8, 10));
        	//System.out.println(day);
			for(Literatureforborrow item:results){
				
				String theexpectedreturntime = item.getExpectedreturntime();
				int expectedyear = Integer.parseInt(theexpectedreturntime.substring(0,4));
				int expectedmonth = Integer.parseInt(theexpectedreturntime.substring(5, 7));
				int expectedday = Integer.parseInt(theexpectedreturntime.substring(8, 10));
				//System.out.println(year);
				//System.out.println(month);
				//System.out.println(year);
				//System.out.println(month);
				//System.out.println(expectedyear);
				//System.out.println(expectedmonth);
				if(year==expectedyear){
					if(month-expectedmonth>=1){
						flag=1;
					}else if(month==expectedmonth){
						if(day>expectedday){
							flag=1;
						}
					}
				}else if(year>expectedyear){
					if(12-expectedmonth+month>1){
						flag=1;
					}else if(12-expectedmonth+month==1){
						if(day-expectedday>0){
							flag=1;
						}
					}
				}
			item.setExpired(flag);
			}
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
		}
		return results;
	}
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：续借<br>
	 * @param deferBorrowids, deferExpectedReturnTimes
	 * @return 1成功，0失败
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int deferBorrow(String deferBorrowids, String deferExpectedReturnTimes) {
		int result = 0;
		try {
			if(deferBorrowids!=null&&!"".equals(deferBorrowids)&&deferExpectedReturnTimes!=null
			   &&!"".equals(deferExpectedReturnTimes)){
				String[] ids = deferBorrowids.split(",");
				String[] deferTimes = deferExpectedReturnTimes.split(",");
				for(int i=0;i<ids.length;i++){
					//获取具体的borroinfo
					BorrowinfoExample example = new BorrowinfoExample();
					example.createCriteria().andBorrowidEqualTo(Integer.parseInt(ids[i]));
					List<Borrowinfo> list =(List<Borrowinfo>) borrowinfoDAO.selectByExample(example);
					Borrowinfo item = list.get(0);
					//判断是否已经续借过
					String oldDeferTime = deferTimes[i];
					String borrowtime = item.getBorrowtime();
					int yearjudgeborrow = Integer.parseInt(borrowtime.substring(0, 4));
			    	int monthjudgeborrow = Integer.parseInt(borrowtime.substring(5, 7));
			    	int yearjudgedefer = Integer.parseInt(oldDeferTime.substring(0, 4));
			    	int monthjudgedefer = Integer.parseInt(oldDeferTime.substring(5, 7));
			    	if(yearjudgeborrow==yearjudgedefer){
			    		if(monthjudgedefer-monthjudgeborrow>1){
			    			return result;
			    		}
			    	}else if(yearjudgedefer>yearjudgeborrow){
			    		if(12-monthjudgeborrow+monthjudgedefer>1){
			    			return result;
			    		}
			    	}
					//转换时间为一月之后
					int year = Integer.parseInt(oldDeferTime.substring(0, 4));
			    	int month = Integer.parseInt(oldDeferTime.substring(5, 7));
			    	String day = oldDeferTime.substring(8, 10);
			    	String time = oldDeferTime.substring(11, 19);
			    	int returnYear, returnMonth;
			    	String dayAndTime=day+" "+time;
			    	if(month==12){
			    		 returnYear = year+1;
			    		 returnMonth = month;
			    	}else{
			    		returnYear = year;
			    		returnMonth = month+1;
			    	}
			    	String newDeferTime = returnYear+"-"+returnMonth+"-"+dayAndTime;
			    	//System.out.println(year+"~"+month+"~"+day+"~"+time);
					//System.out.println(newDeferTime);
			    	//更新表,因无法更新列borrowid,故建新item
			    	Borrowinfo newitem = new Borrowinfo();
			    	newitem.setBorrownum(item.getBorrownum());
			    	newitem.setBorrowtime(item.getBorrowtime());
			    	newitem.setExpectedreturntime(newDeferTime);
			    	newitem.setSid(item.getSid());
			    	borrowinfoDAO.updateByExampleSelective(newitem, example);
				}
			}
			result = 1;
		}
		catch (NumberFormatException e) {
			result = 0;
		}
		
		
		return result;
	}
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：获取借阅列表记录数<br>
	 * @param key
	 * @return
	 */
	@Override
	public int countBorrowList(String key) {
		int result = 0;
		try {
			result = literatureforborrowDAO.getBorrowCount(key);
		}
		catch (Exception e) {
		    LOGGER.error(e.toString());
		}
		return result;
	}
	 /**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：获取借阅列表，分页<br>
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Literatureforborrow> listBorrowList(String key, int start, int limit) {
		List<Literatureforborrow> results = new ArrayList<Literatureforborrow>();
		int flag=0;
		try {
			results = literatureforborrowDAO.getBorrowList(key, start, limit);
			//判断当前日期是否超过expectecReturnTime,若是则flag=1过期，否则flag=0未过期
			String nowDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        	//System.out.println(nowDatetime);
        	int year = Integer.parseInt(nowDatetime.substring(0, 4));
        	int month = Integer.parseInt(nowDatetime.substring(5, 7));
        	int day = Integer.parseInt(nowDatetime.substring(8, 10));
        	//System.out.println(day);
			for(Literatureforborrow item:results){
				
				String theexpectedreturntime = item.getExpectedreturntime();
				int expectedyear = Integer.parseInt(theexpectedreturntime.substring(0,4));
				int expectedmonth = Integer.parseInt(theexpectedreturntime.substring(5, 7));
				int expectedday = Integer.parseInt(theexpectedreturntime.substring(8, 10));
				//System.out.println(year);
				//System.out.println(month);
				//System.out.println(year);
				//System.out.println(month);
				//System.out.println(expectedyear);
				//System.out.println(expectedmonth);
				if(year==expectedyear){
					if(month-expectedmonth>=1){
						flag=1;
					}else if(month==expectedmonth){
						if(day>expectedday){
							flag=1;
						}
					}
				}else if(year>expectedyear){
					if(12-expectedmonth+month>1){
						flag=1;
					}else if(12-expectedmonth+month==1){
						if(day-expectedday>0){
							flag=1;
						}
					}
				}
			item.setExpired(flag);
			}
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
		}
		return results;
	}
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：按图书名称获取借阅列表，分页<br>
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Literatureforborrow> listBorrowListByName(String key, int start, int limit) {
		List<Literatureforborrow> results = new ArrayList<Literatureforborrow>();
		try {
			results = literatureforborrowDAO.getBorrowListByName(key, start, limit);
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
		}
		return results;
	}
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：按图书名称Group获取借阅列表，分页<br>
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Literatureforborrow> listBorrowListByGroup(String key, int start, int limit) {
		List<Literatureforborrow> results = new ArrayList<Literatureforborrow>();
		try {
			results = literatureforborrowDAO.getBorrowListByGroup(key, start, limit);
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
		}
		return results;
	}
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：按图书名称Group获取借阅列表，分页<br>
	 * @param key
	 * @param start
	 * @param limit
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Literatureforborrow> listBorrowListByCategory(String key, int start, int limit) {
		List<Literatureforborrow> results = new ArrayList<Literatureforborrow>();
		try {
			results = literatureforborrowDAO.getBorrowListByCategory(key, start, limit);
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
		}
		return results;
	}
	/**
	 * 
	 * @author 杨宗昆<br>
	 * 方法说明：获取已登录学生的借阅过的书籍列表<br>
	 * @param key
	 * @return
	 */
	@Override
	public List<Literatureforborrow> listBorrowListBySnumber(String theLoginedSnumber, int start,
			int limit) {
		List<Literatureforborrow> results = new ArrayList<Literatureforborrow>();
		try {
			results = literatureforborrowDAO.getBorrowListBySnumber(theLoginedSnumber, start, limit);
		}
		catch (Exception e) {
			LOGGER.error(e.toString());
		}
		return results;
	}
	/**
	 * 删除借阅信息
	 */
	@Override
	public int deleteBorrowInfo(String ids) {
		int result = 1;
		if (ids != null && !"".equals(ids)) {
			String[] borrowids = ids.split(",");

			try {
				for (String id : borrowids) {
					try {
						int value=Integer.parseInt(id);
						BorrowinfoExample example = new BorrowinfoExample();
						example.createCriteria().andBorrowidEqualTo(value);
						borrowinfoDAO.deleteByExample(example);
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

		} else {
			result = 0;
		}
		return result;
	}
	/**
	 * 添加借阅信息
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean addBorrowInfo(String snumber, String detailJsonArray) {
		//System.out.println(detailJsonArray);
		//System.out.println(snumber);
		//转换能写入表的数据
		JSONArray array = JSONArray.fromObject(detailJsonArray);
		 for(int i = 0; i < array.size(); i++) {
	        	JSONObject item = JSONObject.fromObject(array.get(i));
	        	//判断借阅数是否大于剩余数
	        	int judgeBorrownum = Integer.parseInt(item.get("borrownum").toString());
	        	int judgeTotalnum = Integer.parseInt(item.get("num1").toString());
	        	int judgeOutnum = Integer.parseInt(item.get("outnum1").toString());
	        	if(judgeBorrownum>judgeTotalnum-judgeOutnum){
	        		return false;
	        	}
	        	//处理借阅与归还日期，分别为nowDatetime,returnDatetime
	        	String nowDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	        	//System.out.println(nowDatetime);
	        	int year = Integer.parseInt(nowDatetime.substring(0, 4));
	        	int month = Integer.parseInt(nowDatetime.substring(5, 7));
	        	String day = nowDatetime.substring(8, 10);
	        	String time = nowDatetime.substring(11, 19);
	        	int returnYear, returnMonth;
	        	String dayAndTime=day+" "+time;
	        	if(month==12){
	        		 returnYear = year+1;
	        		 returnMonth = month;
	        	}else{
	        		returnYear = year;
	        		returnMonth = month+1;
	        	}
	        	String returnDatetime = returnYear+"-"+returnMonth+"-"+dayAndTime;
	        	//System.out.println(returnDatetime);
	        	
	        	
		        //转换说number为sid
	        	StudentExample studentexample = new StudentExample();
		        studentexample.createCriteria().andSnumberEqualTo(snumber);
		        List<Student> studentlist = studentDAO.selectByExample(studentexample);
		        int thesid = studentlist.get(0).getSid();
		        //System.out.println(thesid+"~~~~~~~~~~~~~~~~~~~`");
		        //转换literaturename为literatureid
		        LiteratureExample literatureexample = new LiteratureExample();
		        String literaturename = item.get("literaturename1").toString();
		        //System.out.println(literaturename);
		        literatureexample.createCriteria().andLiteraturenameLike(literaturename);
		        List<Literature> literaturelist = literatureDAO.selectByExample(literatureexample);
		        int theliteratureid = literaturelist.get(0).getLiteratureid();
		        //System.out.println(theliteratureid+"~~~~~~~~~~~~~~~~");
	        	try {
					//写入borrowInfo表
					Borrowinfo borrowinfo = new Borrowinfo();
					borrowinfo.setSid(thesid);
					borrowinfo.setBorrowtime(nowDatetime);
					borrowinfo.setExpectedreturntime(returnDatetime);
					//borrowinfo.setBorrownum(Integer.parseInt(item.get("borrownum").toString()));
					borrowinfoDAO.insertSelective(borrowinfo);
					//写入literatureforborrow表
					
					Literatureforborrow literatureforborrow = new Literatureforborrow();
					literatureforborrow.setLiteratureid(theliteratureid);
					literatureforborrow.setNum(Integer.parseInt(item.get("borrownum").toString()));
					short giant = 0;
					literatureforborrow.setReturned(giant);
					    //根据borrowtime获取borrowid
					BorrowinfoExample borrowinfoexample = new BorrowinfoExample();
					borrowinfoexample.createCriteria().andBorrowtimeEqualTo(nowDatetime);
					List<Borrowinfo> borrowinfolist = borrowinfoDAO.selectByExample(borrowinfoexample);
					int theborrowid = borrowinfolist.get(0).getBorrowid();
					literatureforborrow.setBorrowid(theborrowid);
					literatureforborrowDAO.insertSelective(literatureforborrow);
				}
				catch (NumberFormatException e) {
					LOGGER.error(e.toString());
					System.out.println("error~~~~~~~~~~~~~~~~");
					throw e;
				}
		}       
		return true;
	}
	/**
	 * 还书
	 */
	@SuppressWarnings("unchecked")
	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.BorrowListBO#returnBorrowInfo(java.lang.String)
	 */
	@Override
	public double returnBorrowInfo(String returnJsonArray) {
		System.out.println(returnJsonArray);
		JSONArray array = JSONArray.fromObject(returnJsonArray);
		double totalForfeit=0.0;
		 for(int i = 0; i < array.size(); i++) {
	        	JSONObject item = JSONObject.fromObject(array.get(i));
	        	//找到borrowid对应的literatureForBorrow记录
	        	LiteratureforborrowExample literatureforborrowexample = new LiteratureforborrowExample();
	        	literatureforborrowexample.createCriteria().andBorrowidEqualTo(Integer.parseInt(item.get("borrowid").toString()));
	        	List<Literatureforborrow> literatureforborrowList = (List<Literatureforborrow>) literatureforborrowDAO.selectByExample(literatureforborrowexample);
	        	Literatureforborrow borrowUnit = literatureforborrowList.get(0);
	        	//找到borrowid对应的borrowInfo记录
	        	BorrowinfoExample borrowinfoexample = new BorrowinfoExample();
	        	borrowinfoexample.createCriteria().andBorrowidEqualTo(Integer.parseInt(item.get("borrowid").toString()));
	        	List<Borrowinfo> borrowinfoList = borrowinfoDAO.selectByExample(borrowinfoexample);
	        	Borrowinfo borrowinfoUnit = borrowinfoList.get(0);
	        	//写入LiteratureForBorrow表  归还为true
	        	Short digit = 1;
	        	borrowUnit.setReturned(digit);
	        	System.out.println(borrowUnit.getReturned());
	        	//写入归还时间
	        	String returnDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	        	System.out.println(returnDatetime);
	        	borrowUnit.setReturntime(returnDatetime);
	        	literatureforborrowDAO.updateByExampleSelective(borrowUnit, literatureforborrowexample);
	        	//检测是否按时归还，如未按时归还则根据算法产生相应数额罚款，约为1天5毛钱
	        	String theExpectedReturnTime = borrowinfoUnit.getExpectedreturntime();
	        	int expectedYear = Integer.parseInt(theExpectedReturnTime.substring(0,4));
	        	int expectedMonth = Integer.parseInt(theExpectedReturnTime.substring(5,7));
	        	int expectedDay = Integer.parseInt(theExpectedReturnTime.substring(8,10));
	        	int returnYear = Integer.parseInt(returnDatetime.substring(0,4));
	        	int returnMonth = Integer.parseInt(returnDatetime.substring(5,7));
	        	int returnDay = Integer.parseInt(returnDatetime.substring(8,10));
	        	//System.out.println(expectedYear+"~"+expectedMonth+"~"+expectedDay);
	        	//System.out.println(returnYear+"~"+returnMonth+"~"+returnDay);
	        	int differenceYear = returnYear-expectedYear;
	        	int differenceMonth = returnMonth - expectedMonth;
	        	int differenceDay = returnDay-expectedDay;
	        	int flag=1;//0表未超期限；1表超期限
	        	double forfeit=0.0;
	        	if(differenceYear<0){
	        		flag=0;
	        	}else if (differenceYear>1){
	        		forfeit=300;
	        	}else if(differenceYear==1&&differenceMonth<0){
	        		differenceMonth = 12-expectedMonth + returnMonth;
	        		forfeit = differenceMonth*15 + differenceDay*0.5; 
	        	}else if(differenceYear==1&&differenceMonth>=0){
	        		forfeit = (12 + differenceMonth)*15 + differenceDay*0.5;
	        	}else if(differenceYear==0&&differenceMonth<0){
	        		flag=0;
	        	}else if(differenceYear==0&&differenceMonth>0){
	        		forfeit =  differenceMonth*15 + differenceDay*0.5;
	        	}else if(differenceYear==0&&differenceMonth==0&&differenceDay<=0){
	        		flag=0;
	        	}else if(differenceYear==0&&differenceMonth==0&&differenceDay>0){
	        		forfeit = differenceDay*0.5;
	        	}
	        	if(flag==0){
	        		forfeit=0;
	        	}
	        	totalForfeit+=forfeit;
		 }   	
		return totalForfeit;
	}
	public StudentDAO getStudentDAO() {
		return studentDAO;
	}
	public void setStudentDAO(StudentDAO studentDAO) {
		this.studentDAO = studentDAO;
	}
	public LiteratureDAO getLiteratureDAO() {
		return literatureDAO;
	}
	public void setLiteratureDAO(LiteratureDAO literatureDAO) {
		this.literatureDAO = literatureDAO;
	}
	public BorrowinfoDAO getBorrowinfoDAO() {
		return borrowinfoDAO;
	}
	public void setBorrowinfoDAO(BorrowinfoDAO borrowinfoDAO) {
		this.borrowinfoDAO = borrowinfoDAO;
	}
	public LiteratureforborrowDAO getLiteratureforborrowDAO() {
		return literatureforborrowDAO;
	}
	public void setLiteratureforborrowDAO(LiteratureforborrowDAO literatureforborrowDAO) {
		this.literatureforborrowDAO = literatureforborrowDAO;
	}
    
}
