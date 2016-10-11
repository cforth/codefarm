package com.cfxyz.test;

import java.util.Arrays;

import com.cfxyz.util.BeanOperate;
import com.cfxyz.vo.Dept;
import com.cfxyz.vo.Emp;

public class TestDemo {
    private Emp emp = new Emp();
    public Emp getEmp() {
        return emp;
    }
    private Dept dept = new Dept();
    public Dept getDept() {
        return dept;
    }
    
    public static void main(String[] args) {
        {
            String attribute = "dept.sal"; //表示的属性，单级属性
            String value = "8000.55";
            TestDemo td = new TestDemo();
            //此时就表示设置内容
            BeanOperate bo = new BeanOperate(td, attribute, value);
            System.out.println("单级属性设置：" + td.getDept().getSal());
        }
        System.out.println("================================");
        {
            String attribute = "emp.dept.company.title"; //表示的属性,多级属性
            String value = "HELLO公司";
            TestDemo td = new TestDemo();
            //此时就表示设置内容
            BeanOperate bo = new BeanOperate(td, attribute, value);
            System.out.println("多级属性设置：" + td.getEmp().getDept().getCompany().getTitle());
        }
        System.out.println("================================");
        {
            String attribute = "dept.loc"; //数组设置
            String [] value = {"上海","北京","重庆"};
            TestDemo td = new TestDemo();
            //此时就表示设置内容
            BeanOperate bo = new BeanOperate(td, attribute, value);
            System.out.println("数组属性设置：" + Arrays.toString(td.getDept().getLoc()));
        }
        System.out.println("================================");
        {
            String attribute = "dept.ids"; //数组设置
            String [] value = {"1","2.8","3"};
            TestDemo td = new TestDemo();
            //此时就表示设置内容
            BeanOperate bo = new BeanOperate(td, attribute, value);
            System.out.println("数组属性设置：" + Arrays.toString(td.getDept().getIds()));
        }
    }
} 

