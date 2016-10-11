package com.cfxyz.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Dept implements Serializable {
    private String dname;
    private int deptno;
    private double sal;
    private String[] loc;
    private Double[] ids;
    public void setIds(Double[] ids) {
        this.ids = ids;
    }
    public Double[] getIds() {
        return ids;
    }
    public void setLoc(String[] loc) {
        this.loc = loc;
    }
    public String[] getLoc() {
        return loc;
    }
    public int getDeptno() {
        return deptno;
    }
    public void setDeptno(int deptno) {
        this.deptno = deptno;
    }
    public double getSal() {
        return sal;
    }
    public void setSal(double sal) {
        this.sal = sal;
    }
    private Company company = new Company(); //必须实例化
    public Company getCompany() {
        return company;
    }
    public void setCompany(Company company) {
        this.company = company;
    }
    public void setDname(String dname) {
        this.dname = dname;
    }
    public String getDname() {
        return dname;
    }
}

