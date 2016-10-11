package com.cfxyz.util;

public class StringUtils {
    public static String initcap(String str) {
        if(str == null || "".equals(str)) {
            return str;
        }
        if(str.length() == 1) {
            return str.toUpperCase();
        }else{
            return str.substring(0,1).toUpperCase() + str.substring(1);
        }
    }
}

