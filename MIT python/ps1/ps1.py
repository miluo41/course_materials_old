# -*- coding: utf-8 -*-
"""
Created on Wed May  3 16:50:05 2017

@author: miluo
"""
import pdb
import os
annual_salary=float(input('Enter you annual salary:'))
total_cost=1000000
semi_annual_raise=0.07
current_savings=0
portion_down_payment=0.25
monthly_salary=annual_salary/12
r=0.04
low=0
high=10000
epsilon=100
iteration=0
month=0

while month<=36:
        current_savings=current_savings*(1+r/12)+monthly_salary*1
        month+=1
        if month%6==0 and month>0:
            monthly_salary = monthly_salary*(1+semi_annual_raise)
            
if current_savings <total_cost*portion_down_payment-epsilon:
    print('It is not possible to pay the down payment in three years')
else:
    current_savings=0
    while abs(current_savings-total_cost*portion_down_payment)>epsilon:
        guess=(high+low)//2
        month=0
        current_savings=0
        monthly_salary=annual_salary/12
        while month<=36:
            current_savings=current_savings*(1+r/12)+monthly_salary*guess/10000
            month+=1
            if month%6==0 and month>0:
                monthly_salary = monthly_salary*(1+semi_annual_raise)
        print(current_savings)
        if current_savings<total_cost*portion_down_payment-epsilon:
            low=guess
        if current_savings>total_cost*portion_down_payment+epsilon:
            high=guess
        iteration+=1
        print(iteration,'guess=',guess/10000)

    print('Best savings rate:',guess/10000)
    print('Steps in bisection search:',iteration)
    
    