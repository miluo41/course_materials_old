# -*- coding: utf-8 -*-
"""
Created on Wed May 10 13:08:10 2017

@author: miluo
"""
import datetime
a='3 Oct 2016 17:00:10'
a2='6 Oct 2016 17:00:10'
b=datetime.datetime.strptime(a,'%d %b %Y %X')
b2=datetime.datetime.strptime(a2,'%d %b %Y %X')
print(b2>b)


