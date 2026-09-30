#!/usr/bin/env python3
"""Exact finite-field test for the degree-seven primitive trace obstruction."""
import argparse
import json
from pathlib import Path

def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return (-a%5)%5+5*((-(a//5))%5)
def mul(a,b):
    a0,a1=a%5,a//5; b0,b1=b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
def power(a,n):
    r=1
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n//=2
    return r
def trim(a):
    while len(a)>1 and a[-1]==0:a.pop()
    return a
def padd(a,b):
    return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0)
                 for i in range(max(len(a),len(b)))])
def pmul(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
    return trim(c)
def pdiv(a,b):
    a=trim(a[:]); b=trim(b[:]); assert b!=[0]
    q=[0]*max(1,len(a)-len(b)+1); inv=power(b[-1],23)
    while a!=[0] and len(a)>=len(b):
        k=len(a)-len(b); c=mul(a[-1],inv);q[k]=c
        for i,x in enumerate(b):a[k+i]=add(a[k+i],neg(mul(c,x)))
        trim(a)
    return trim(q),a
def ppowmod(a,n,m):
    r=[1]
    while n:
        if n&1:r=pdiv(pmul(r,a),m)[1]
        a=pdiv(pmul(a,a),m)[1];n//=2
    return r
def determinant(a):
    a=[r[:] for r in a]; det=1
    for i in range(len(a)):
        j=next((j for j in range(i,len(a)) if a[j][i]),None)
        if j is None:return 0
        if j!=i:a[i],a[j]=a[j],a[i];det=neg(det)
        t=a[i][i];det=mul(det,t);inv=power(t,23)
        for j in range(i+1,len(a)):
            c=mul(a[j][i],inv)
            for k in range(i,len(a)):a[j][k]=add(a[j][k],neg(mul(c,a[i][k])))
    return det

P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
assert [mul(i%5,Q[i]) for i in range(1,len(Q))]==pmul(P,pmul(A,A))
B=ppowmod(pdiv(Q,P)[1],5**7,P)
assert ppowmod(B,5,P)==pdiv(Q,P)[1]
B5=[0]*(5*(len(B)-1)+1)
for i,x in enumerate(B):B5[5*i]=power(x,5)
assert pdiv(padd(Q,[neg(x) for x in B5]),pmul(P,P))[1]==[0]
cols=[pdiv([0]*i+B,P)[1] for i in range(3)]
matrix=[[row[i] if i<len(row) else 0 for row in cols] for i in (7,8,9)]
det=determinant(matrix)
assert det==23
matrix9=[[row[i] if i<len(row) else 0
          for row in [pdiv([0]*j+B,P)[1] for j in range(4)]]
         for i in (8,9)]
kernel9=[[1,0,18,20],[0,1,15,11]]
for row in matrix9:
    for k in kernel9:
        value=0
        for x,y in zip(row,k):value=add(value,mul(x,y))
        assert value==0
assert determinant([row[:2] for row in matrix9])
print('B(x):',B)
print('high-coefficient matrix of B(x)*v(x) mod P:',matrix)
print('determinant:',det)
print('degree-nine matrix:',matrix9,'kernel:',kernel9)
out={'field':'F25: beta^2-beta-3, code a+5b', 'P':P,'A':A,'Q':Q,
     'B':B, 'matrix':matrix,'determinant':det,
     'degree_nine_matrix':matrix9,'degree_nine_kernel':kernel9,
     'checks':['Qprime=P*A^2','B^5=Q mod P','Q-B^5 divisible by P^2']}
if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
