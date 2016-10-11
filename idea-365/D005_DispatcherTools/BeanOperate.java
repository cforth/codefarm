package com.cfxyz.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;

public class BeanOperate {
    private Object currentObj; //表示当前程序的保存对象
    private String attribute;
    private String value;
    private String [] arrayValue;
    private Field field; //存放对象的属性
    /**
     * 进行操作数据的接收，接收后才可以进行数据的设置操作
     * @param obj 表示当前要操作此功能的类对象
     * @param attribute 包含了“对象.属性.属性...”字符串
     * @param value 表示属性的内容。
     */
    public BeanOperate(Object obj,String attribute,String value) {
        this.currentObj = obj; //保存当前的操作对象
        this.attribute = attribute;
        this.value = value;
        this.handleParameter();
        this.setValue();
    }
    
    /**
     * 进行数组数据的操作
     * @param obj
     * @param attribute
     * @param arrayValue 
     */
    public BeanOperate(Object obj,String attribute,String[] arrayValue) {
        this.currentObj = obj; //保存当前的操作对象
        this.attribute = attribute;
        this.arrayValue = arrayValue;
        this.handleParameter();
        this.setValue();
    }
    
    private void handleParameter() { //针对传入的数据进行处理
        try {
            String result [] = this.attribute.split("\\.");
            for(int x = 0; x < result.length - 1 ; x ++) {  //能处理单级和多级操作
                Method getMet = this.currentObj.getClass()
                        .getMethod("get" + StringUtils.initcap(result[x]));
                this.currentObj = getMet.invoke(this.currentObj);
            }
            this.field = this.currentObj.getClass().getDeclaredField(result[result.length-1]); //取得对象成员
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    private void setValue() { //定义一个专门设置属性内容的方法，调用setter
        try {
            Method setMet = this.currentObj.getClass()
                    .getMethod("set" + StringUtils.initcap(this.field.getName()), this.field.getType());
            String type = this.field.getType().getSimpleName();
            if("int".equalsIgnoreCase(type) || "integer".equalsIgnoreCase(type)) {
                if(this.value.matches("\\d+")) {
                    setMet.invoke(this.currentObj, Integer.parseInt(this.value));
                }
            } else if("double".equalsIgnoreCase(type)) {
                if(this.value.matches("\\d+(\\.\\d+)?")) {
                    setMet.invoke(this.currentObj, Double.parseDouble(this.value));
                }
            } else if("string".equalsIgnoreCase(type)) {
                setMet.invoke(this.currentObj, this.value);
            } else if("date".equalsIgnoreCase(type)) {
                if(this.value.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    setMet.invoke(this.currentObj, new SimpleDateFormat("yyyy-MM-dd").parse(this.value));
                } else if(this.value.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")) {
                    setMet.invoke(this.currentObj, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(this.value));
                }
            } else if("string[]".equalsIgnoreCase(type)) { //数组数据设置
                setMet.invoke(this.currentObj, new Object[]{this.arrayValue});
            } else if ("int[]".equalsIgnoreCase(type)) {
                if(arrayMatches(this.arrayValue, "\\d+")) { //验证数组内每个成员的类型
                    int data[] = new int[this.arrayValue.length];
                    for(int x = 0; x < this.arrayValue.length; x++) {
                        if(this.arrayValue[x].matches("\\d+")) {
                            data[x] = Integer.parseInt(this.arrayValue[x]);
                        }
                    }
                    setMet.invoke(this.currentObj, new Object[]{data});
                }
            } else if ("integer[]".equalsIgnoreCase(type)) {
                if(arrayMatches(this.arrayValue, "\\d+")) {
                    Integer data[] = new Integer[this.arrayValue.length];
                    for(int x = 0; x < this.arrayValue.length; x++) {
                        data[x] = Integer.parseInt(this.arrayValue[x]);
                    }
                    setMet.invoke(this.currentObj, new Object[]{data});
                }
            } else if ("double[]".equals(type)) {
                if(arrayMatches(this.arrayValue, "\\d+(\\.\\d+)?")) { //验证数组内每个成员的类型
                    double data[] = new double[this.arrayValue.length];
                    for(int x = 0; x < this.arrayValue.length; x++) {
                        if(this.arrayValue[x].matches("\\d+")) {
                            data[x] = Double.parseDouble(this.arrayValue[x]);
                        }
                    }
                    setMet.invoke(this.currentObj, new Object[]{data});
                }
            } else if ("Double[]".equals(type)) {
                if(arrayMatches(this.arrayValue, "\\d+(\\.\\d+)?")) {
                    Double data[] = new Double[this.arrayValue.length];
                    for(int x = 0; x < this.arrayValue.length; x++) {
                        data[x] = Double.parseDouble(this.arrayValue[x]);
                    }
                    setMet.invoke(this.currentObj, new Object[]{data});
                }
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    private boolean arrayMatches(String[] array, String regx) {
        for(int x = 0; x < array.length; x++) {
            if(!array[x].matches(regx)) {
                return false;
            }
        }
        return true;
    }
}

