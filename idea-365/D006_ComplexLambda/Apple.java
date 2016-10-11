package com.cfxyz.vo;

public class Apple {
    private String color ;
    private Integer weight ;
    private String country ;
    public Apple(Integer weight, String color, String country) {
        this.weight = weight ;
        this.color = color ;
        this.country = country ;
    }
    public Integer getWeight() {
        return weight;
    }
    public void setWeight(Integer weight) {
        this.weight = weight;
    }
    public String getColor() {
        return color;
    }
    public void setColor(String color) {
        this.color = color;
    }
    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
    }
    @Override
    public String toString() {
        return "Apple [color=" + color + ", weight=" + weight + ", country=" + country + "]";
    }
    
}

