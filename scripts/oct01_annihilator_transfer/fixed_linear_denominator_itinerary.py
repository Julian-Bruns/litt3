#!/usr/bin/env python3
"""Seconds-only exact F25 check; no source chart or cover enumeration."""
import json
from pathlib import Path

def add(a,b):return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a):return (-a%5)+5*((-(a//5))%5)
def mul(a,b):
    x,y=a%5,a//5;z,w=b%5,b//5
    return (x*z+3*y*w)%5+5*((x*w+y*z+y*w)%5)
def power(a,n):
    q=1
    while n:
        if n&1:q=mul(q,a)
        a=mul(a,a);n//=2
    return q
def inv(a):
    assert a
    return power(a,23)
def trim(a):
    a=a[:]
    while a and not a[-1]:a.pop()
    return a
def padd(a,b):return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def scale(a,c):return trim([mul(x,c) for x in a])
def pmul(a,b):
    q=[0]*(len(a)+len(b)-1) if a and b else []
    for i,x in enumerate(a):
        for j,y in enumerate(b):q[i+j]=add(q[i+j],mul(x,y))
    return trim(q)
def divrem(a,b):
    a=trim(a);b=trim(b);assert b
    q=[0]*max(0,len(a)-len(b)+1)
    while len(a)>=len(b):
        k=len(a)-len(b);c=mul(a[-1],inv(b[-1]));q[k]=c
        a=padd(a,[0]*k+scale(b,neg(c)))
    return trim(q),a
def egcd(a,b):
    r0,r1=a,b;s0,s1=[1],[];t0,t1=[],[1]
    while r1:
        q,r=divrem(r0,r1)
        r0,r1=r1,r;s0,s1=s1,padd(s0,scale(pmul(q,s1),4));t0,t1=t1,padd(t0,scale(pmul(q,t1),4))
    z=inv(r0[-1]);return scale(r0,z),scale(s0,z),scale(t0,z)

A=[1,21,14,22,13]
P=[11,22,18,5,19,20,15,16,9,22,1]
Z=[15,19,24,12,10,19,3,24,18,16]
remainders=[divrem([0]*j+Z,P)[1] for j in range(4)]
rows=[[a[i] if i<len(a) else 0 for a in remainders] for i in [9,8]]
assert rows==[[16,5,14,10],[18,16,2,16]]
# Q_j(r)=[x^j] A(x)/(x-r), with A(r)=0; this symbolic quotient
# is valid before reduction modulo A(r).
quotient_coeffs=[[A[i] for i in range(j+1,len(A))] for j in range(4)]
forms=[]
for row in rows:
    h=[]
    for c,q in zip(row,quotient_coeffs):h=padd(h,scale(q,c))
    forms.append(h)
g,s,t=egcd(A,forms[0]);h,u,w=egcd(g,forms[1])
bezout=[pmul(u,s),pmul(u,t),w]
identity=[]
for a,b in zip([A,*forms],bezout):identity=padd(identity,pmul(a,b))
assert h==identity==[1]
quadratic=[13,18,24]
def dot(a,b):
    c=0
    for x,y in zip(a,b):c=add(c,mul(x,y))
    return c
assert [dot(row[:3],quadratic) for row in rows]==[0,0]
row7=[a[7] if len(a)>7 else 0 for a in remainders]
assert dot(row7[:3],quadratic)==7
aq,ar=divrem(A,quadratic)
assert aq==[20,22,20] and ar==[2,5]
assert add(ar[0],mul(ar[1],9))==0
q_at_9=0
for coefficient in reversed(quadratic):q_at_9=add(mul(q_at_9,9),coefficient)
assert q_at_9==18
gq,sq,tq=egcd(A,quadratic)
qidentity=padd(pmul(A,sq),pmul(quadratic,tq))
assert gq==qidentity==[1]
# Degree-eleven first-moment constraints: all three forbidden gap rows.
cubic_rows=[[a[i] if i<len(a) else 0 for a in remainders] for i in [9,8,7]]
assert cubic_rows==[[16,5,14,10],[18,16,2,16],[24,0,13,18]]
matrix=[row[:3]+[neg(row[3])] for row in cubic_rows]
for j in range(3):
    pivot=next(i for i in range(j,3) if matrix[i][j])
    matrix[j],matrix[pivot]=matrix[pivot],matrix[j]
    matrix[j]=[mul(x,inv(matrix[j][j])) for x in matrix[j]]
    for i in range(3):
        if i==j:continue
        factor=matrix[i][j]
        matrix[i]=[add(x,neg(mul(factor,y))) for x,y in zip(matrix[i],matrix[j])]
cubic=[matrix[j][3] for j in range(3)]+[1]
assert [dot(row,cubic) for row in cubic_rows]==[0,0,0]
cubic_derivative=[mul(j,cubic[j]) for j in range(1,4)]
gc,sc,tc=egcd(cubic,cubic_derivative)
gp,sp,tp=egcd(cubic,P)
assert gc==padd(pmul(cubic,sc),pmul(cubic_derivative,tc))==[1]
assert gp==padd(pmul(cubic,sp),pmul(P,tp))==[1]
quadratic_derivative=[quadratic[1],mul(2,quadratic[2])]
gqp,sqp,tqp=egcd(quadratic,P)
gqd,sqd,tqd=egcd(quadratic,quadratic_derivative)
assert gqp==padd(pmul(quadratic,sqp),pmul(P,tqp))==[1]
assert gqd==padd(pmul(quadratic,sqd),pmul(quadratic_derivative,tqd))==[1]
def evaluate(poly,r):
    value=0
    for coefficient in reversed(poly):value=add(mul(value,r),coefficient)
    return value
assert [evaluate(quadratic,r) for r in [12,16]]==[0,0]
assert [evaluate(P,r) for r in [12,16]]==[6,1]
# Monic x-division with polynomial coefficients in the pencil parameter.
pencil=[[cubic[j],quadratic[j]] for j in range(3)]+[[1]]
symbolic_remainder=[[x] if x else [] for x in P]
while len(symbolic_remainder)>=4:
    shift=len(symbolic_remainder)-4
    lead=symbolic_remainder[-1]
    for j,coefficient in enumerate(pencil):
        symbolic_remainder[shift+j]=padd(symbolic_remainder[shift+j],scale(pmul(lead,coefficient),4))
    while symbolic_remainder and not symbolic_remainder[-1]:symbolic_remainder.pop()
symbolic_remainder += [[]]*(3-len(symbolic_remainder))
gr,sr,tr=egcd(symbolic_remainder[0],symbolic_remainder[1])
ga,sa,ta=egcd(gr,symbolic_remainder[2])
pencil_bezout=[pmul(sa,sr),pmul(sa,tr),ta]
pencil_identity=[]
for coefficient,multiplier in zip(symbolic_remainder,pencil_bezout):
    pencil_identity=padd(pencil_identity,pmul(coefficient,multiplier))
assert ga==pencil_identity
out={"field":"F25, beta^2=beta+3, code a+5b","A":A,"P":P,"Z":Z,
     "translation_rows_x9_x8":rows,"kernel_cubic_forms_in_excluded_root":forms,
     "gcd":[1],"bezout_multipliers_A_form9_form8":bezout,"verified_sum":[1],
     "quadratic_kernel":quadratic,"kernel_gap11_value":7,
     "A_div_quadratic":{"quotient":aq,"remainder":ar,"remainder_root":9,"quadratic_at_root":q_at_9},
     "A_quadratic_bezout":[sq,tq],"A_quadratic_verified_sum":qidentity,
     "degree_eleven_gap_rows":cubic_rows,"degree_eleven_monic_cubic_kernel":cubic,
     "cubic_derivative":cubic_derivative,"cubic_squarefree_bezout":[sc,tc],
     "cubic_P_bezout":[sp,tp],"cubic_squarefree_verified_sum":[1],"cubic_P_verified_sum":[1],
     "quadratic_P_bezout":[sqp,tqp],"quadratic_squarefree_bezout":[sqd,tqd],
     "quadratic_roots":[12,16],"P_at_quadratic_roots":[6,1],"quadratic_new_verified_sums":[[1],[1]],
     "P_mod_cubic_pencil_coefficients":symbolic_remainder,
     "pencil_remainder_gcd":ga,"pencil_remainder_bezout":pencil_bezout,
     "pencil_remainder_verified_sum":pencil_identity}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct01_local_continuation/annihilator_transfer/fixed_linear_denominator_itinerary.json')
dest.parent.mkdir(parents=True,exist_ok=True)
dest.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({"rows":rows,"forms":forms,"bezout":bezout,"identity":identity,"output":str(dest)}))
print(json.dumps({"quadratic":quadratic,"division":[aq,ar],"value_at_9":q_at_9,"bezout":[sq,tq],"identity":qidentity}))
print(json.dumps({"degree_eleven_cubic":cubic,"squarefree_bezout":[sc,tc],"P_bezout":[sp,tp],"identities":[gc,gp]}))
print(json.dumps({"quadratic_P_bezout":[sqp,tqp],"quadratic_squarefree_bezout":[sqd,tqd],"P_values":[6,1]}))
print(json.dumps({"pencil_remainder":symbolic_remainder,"gcd":ga,"bezout":pencil_bezout,"identity":pencil_identity}))
