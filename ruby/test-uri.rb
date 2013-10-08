# encoding: utf-8
require "open-uri"

s = "http://www.kuqin.com/rubycndocument/man/addlib/open-uri.html" 


open(s) {|f|
  f.each_line {|line| p line}
  }
