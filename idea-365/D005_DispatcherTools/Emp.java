package com.cfxyz.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Emp implements Serializable{
    private String ename;
    private Double sal;
    private Dept dept = new Dept();
    public Dept getDept() {
        return dept;
    }
    public void setDept(Dept dept) {
        this.dept = dept;
    }
    public String getEname() {
        return ename;
    }
    public void setEname(String ename) {
        this.ename = ename;
    }
    public Double getSal() {
        return sal;
    }
    public void setSal(Double sal) {
        this.sal = sal;
    }
    
}

