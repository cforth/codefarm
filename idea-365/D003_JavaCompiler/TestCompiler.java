package com.cfxyz.demo;

import java.net.URL;
import java.net.URLClassLoader;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

public class TestCompiler {
    public static void main(String[] args) throws Exception {
        //编译java源代码文件
        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
        String javaFile = "F:\\MyBook.java"; //磁盘上的java源代码路径
        int compilationResult = compiler.run(null, null, null, javaFile);
        System.out.println(compilationResult);
        
        //加载class
        URL[] urls = new URL[] { new URL("file:F:/") };  
        Class<?> c = new URLClassLoader(urls).loadClass("MyBook");  
        System.out.println(c.getName());       
        System.out.println(c.newInstance());

    }
}
