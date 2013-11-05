package com.akun.elibrary.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClassesExample {

	/**
	 * This field was generated by Apache iBATIS ibator. This field corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected String orderByClause;
	/**
	 * This field was generated by Apache iBATIS ibator. This field corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected List oredCriteria;

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public ClassesExample() {
		oredCriteria = new ArrayList();
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected ClassesExample(ClassesExample example) {
		this.orderByClause = example.orderByClause;
		this.oredCriteria = example.oredCriteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public void setOrderByClause(String orderByClause) {
		this.orderByClause = orderByClause;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public String getOrderByClause() {
		return orderByClause;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public List getOredCriteria() {
		return oredCriteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public void or(Criteria criteria) {
		oredCriteria.add(criteria);
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public Criteria createCriteria() {
		Criteria criteria = createCriteriaInternal();
		if (oredCriteria.size() == 0) {
			oredCriteria.add(criteria);
		}
		return criteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected Criteria createCriteriaInternal() {
		Criteria criteria = new Criteria();
		return criteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public void clear() {
		oredCriteria.clear();
	}

	/**
	 * This class was generated by Apache iBATIS ibator. This class corresponds to the database table dbo.classes
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public static class Criteria {
		protected List criteriaWithoutValue;
		protected List criteriaWithSingleValue;
		protected List criteriaWithListValue;
		protected List criteriaWithBetweenValue;

		protected Criteria() {
			super();
			criteriaWithoutValue = new ArrayList();
			criteriaWithSingleValue = new ArrayList();
			criteriaWithListValue = new ArrayList();
			criteriaWithBetweenValue = new ArrayList();
		}

		public boolean isValid() {
			return criteriaWithoutValue.size() > 0 || criteriaWithSingleValue.size() > 0
					|| criteriaWithListValue.size() > 0 || criteriaWithBetweenValue.size() > 0;
		}

		public List getCriteriaWithoutValue() {
			return criteriaWithoutValue;
		}

		public List getCriteriaWithSingleValue() {
			return criteriaWithSingleValue;
		}

		public List getCriteriaWithListValue() {
			return criteriaWithListValue;
		}

		public List getCriteriaWithBetweenValue() {
			return criteriaWithBetweenValue;
		}

		protected void addCriterion(String condition) {
			if (condition == null) {
				throw new RuntimeException("Value for condition cannot be null");
			}
			criteriaWithoutValue.add(condition);
		}

		protected void addCriterion(String condition, Object value, String property) {
			if (value == null) {
				throw new RuntimeException("Value for " + property + " cannot be null");
			}
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("value", value);
			criteriaWithSingleValue.add(map);
		}

		protected void addCriterion(String condition, List values, String property) {
			if (values == null || values.size() == 0) {
				throw new RuntimeException("Value list for " + property
						+ " cannot be null or empty");
			}
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("values", values);
			criteriaWithListValue.add(map);
		}

		protected void addCriterion(String condition, Object value1, Object value2, String property) {
			if (value1 == null || value2 == null) {
				throw new RuntimeException("Between values for " + property + " cannot be null");
			}
			List list = new ArrayList();
			list.add(value1);
			list.add(value2);
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("values", list);
			criteriaWithBetweenValue.add(map);
		}

		public Criteria andClassnumberIsNull() {
			addCriterion("classNumber is null");
			return this;
		}

		public Criteria andClassnumberIsNotNull() {
			addCriterion("classNumber is not null");
			return this;
		}

		public Criteria andClassnumberEqualTo(String value) {
			addCriterion("classNumber =", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberNotEqualTo(String value) {
			addCriterion("classNumber <>", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberGreaterThan(String value) {
			addCriterion("classNumber >", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberGreaterThanOrEqualTo(String value) {
			addCriterion("classNumber >=", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberLessThan(String value) {
			addCriterion("classNumber <", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberLessThanOrEqualTo(String value) {
			addCriterion("classNumber <=", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberLike(String value) {
			addCriterion("classNumber like", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberNotLike(String value) {
			addCriterion("classNumber not like", value, "classnumber");
			return this;
		}

		public Criteria andClassnumberIn(List values) {
			addCriterion("classNumber in", values, "classnumber");
			return this;
		}

		public Criteria andClassnumberNotIn(List values) {
			addCriterion("classNumber not in", values, "classnumber");
			return this;
		}

		public Criteria andClassnumberBetween(String value1, String value2) {
			addCriterion("classNumber between", value1, value2, "classnumber");
			return this;
		}

		public Criteria andClassnumberNotBetween(String value1, String value2) {
			addCriterion("classNumber not between", value1, value2, "classnumber");
			return this;
		}

		public Criteria andClassleaderIsNull() {
			addCriterion("classLeader is null");
			return this;
		}

		public Criteria andClassleaderIsNotNull() {
			addCriterion("classLeader is not null");
			return this;
		}

		public Criteria andClassleaderEqualTo(String value) {
			addCriterion("classLeader =", value, "classleader");
			return this;
		}

		public Criteria andClassleaderNotEqualTo(String value) {
			addCriterion("classLeader <>", value, "classleader");
			return this;
		}

		public Criteria andClassleaderGreaterThan(String value) {
			addCriterion("classLeader >", value, "classleader");
			return this;
		}

		public Criteria andClassleaderGreaterThanOrEqualTo(String value) {
			addCriterion("classLeader >=", value, "classleader");
			return this;
		}

		public Criteria andClassleaderLessThan(String value) {
			addCriterion("classLeader <", value, "classleader");
			return this;
		}

		public Criteria andClassleaderLessThanOrEqualTo(String value) {
			addCriterion("classLeader <=", value, "classleader");
			return this;
		}

		public Criteria andClassleaderLike(String value) {
			addCriterion("classLeader like", value, "classleader");
			return this;
		}

		public Criteria andClassleaderNotLike(String value) {
			addCriterion("classLeader not like", value, "classleader");
			return this;
		}

		public Criteria andClassleaderIn(List values) {
			addCriterion("classLeader in", values, "classleader");
			return this;
		}

		public Criteria andClassleaderNotIn(List values) {
			addCriterion("classLeader not in", values, "classleader");
			return this;
		}

		public Criteria andClassleaderBetween(String value1, String value2) {
			addCriterion("classLeader between", value1, value2, "classleader");
			return this;
		}

		public Criteria andClassleaderNotBetween(String value1, String value2) {
			addCriterion("classLeader not between", value1, value2, "classleader");
			return this;
		}

		public Criteria andCnameIsNull() {
			addCriterion("cname is null");
			return this;
		}

		public Criteria andCnameIsNotNull() {
			addCriterion("cname is not null");
			return this;
		}

		public Criteria andCnameEqualTo(String value) {
			addCriterion("cname =", value, "cname");
			return this;
		}

		public Criteria andCnameNotEqualTo(String value) {
			addCriterion("cname <>", value, "cname");
			return this;
		}

		public Criteria andCnameGreaterThan(String value) {
			addCriterion("cname >", value, "cname");
			return this;
		}

		public Criteria andCnameGreaterThanOrEqualTo(String value) {
			addCriterion("cname >=", value, "cname");
			return this;
		}

		public Criteria andCnameLessThan(String value) {
			addCriterion("cname <", value, "cname");
			return this;
		}

		public Criteria andCnameLessThanOrEqualTo(String value) {
			addCriterion("cname <=", value, "cname");
			return this;
		}

		public Criteria andCnameLike(String value) {
			addCriterion("cname like", value, "cname");
			return this;
		}

		public Criteria andCnameNotLike(String value) {
			addCriterion("cname not like", value, "cname");
			return this;
		}

		public Criteria andCnameIn(List values) {
			addCriterion("cname in", values, "cname");
			return this;
		}

		public Criteria andCnameNotIn(List values) {
			addCriterion("cname not in", values, "cname");
			return this;
		}

		public Criteria andCnameBetween(String value1, String value2) {
			addCriterion("cname between", value1, value2, "cname");
			return this;
		}

		public Criteria andCnameNotBetween(String value1, String value2) {
			addCriterion("cname not between", value1, value2, "cname");
			return this;
		}
	}
}