package com.akun.elibrary.bo.imp;

import java.util.List;

import com.akun.elibrary.bean.Classes;
import com.akun.elibrary.bean.ClassesExample;
import com.akun.elibrary.bo.ClassesBO;
import com.akun.elibrary.dao.ClassesDAO;

/**
 * 作          者：杨宗昆<br>
 * 创建日期： 2012-4-2 下午07:11:26<br>
 * 版          本： 1.00<br>
 * 版权所有
 */
public class ClassesBOImp implements ClassesBO {
    private ClassesDAO classesDAO;
    
	public ClassesDAO getClassesDAO() {
		return classesDAO;
	}

	public void setClassesDAO(ClassesDAO classesDAO) {
		this.classesDAO = classesDAO;
	}

	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.ClassesBO#listClasses(com.akun.elibrary.bean.ClassesExample)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List listClasses() {
		ClassesExample example = new ClassesExample();
		List<Classes> list = classesDAO.selectByExample(example);
		return list;
	}
	
	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.ClassesBO#listClasses(com.akun.elibrary.bean.ClassesExample)
	 */
	@Override
	public Classes listClasses(String classnumber) {
		Classes theclass = classesDAO.selectByPrimaryKey(classnumber);
		return theclass;
	}
	
	/* (non-Javadoc)
	 * @see com.akun.elibrary.bo.ClassesBO#listClasses(com.akun.elibrary.bean.ClassesExample)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List listClasses(ClassesExample example) {
        List<Classes> list = (List<Classes>)classesDAO.selectByExample(example);
		return list;
	}

}
