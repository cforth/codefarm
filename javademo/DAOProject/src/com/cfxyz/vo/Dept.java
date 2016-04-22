package com.cfxyz.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Dept implements Serializable {
	private Integer deptno;
	private String dname ;
	private String loc ;
	public Integer getDeptno() {
		return deptno;
	}
	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
}
