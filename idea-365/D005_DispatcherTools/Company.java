package com.cfxyz.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Company implements Serializable {
    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}

