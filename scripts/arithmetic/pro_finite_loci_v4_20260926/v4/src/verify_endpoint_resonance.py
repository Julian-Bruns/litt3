#!/usr/bin/env python3
"""Check the first free endpoint jet. This is not an actual-curve search."""
from __future__ import annotations
import argparse,json
from pathlib import Path
import verify_moments as K
from trace_field import certificate
A=[1,21,14,22,13]
P=[11,22,18,5,19,20,15,16,9,22,1]

def add(a,b):
    return [K.add8(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))]
def neg(a):return [K.neg8(x) for x in a]
def mul(a,b,n):
    c=[0]*(n+1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            if i+j<=n:c[i+j]=K.add8(c[i+j],K.mul8(x,y))
    return c
def power(a,d,n):
    r=[1]
    for _ in range(d):r=mul(r,a,n)
    return r
def scale(a,c):return [K.mul8(x,c) for x in a]
def evaluate(p,a,n):
    r=[]
    for c in reversed(p):r=add(mul(r,a,n),[c])
    return r
def derivative(a):return [K.mul8(a[i],i%5) for i in range(1,len(a))]
def divide(a,b):
    if not b:raise ZeroDivisionError
    return K.mul8(a,K.power8(b,390623))

def check(alpha,B,c,d):
    q=[B,c,d]
    rhs=[0]+scale(power(q,4,3),13)[:3]
    u=[alpha];ap=evaluate(derivative(A),[alpha],0)[0]
    for i in range(1,4):
        u.append(0)
        u[i]=divide(K.add8(rhs[i],K.neg8(evaluate(A,u,i)[i])),ap)
    assert add(evaluate(A,u,3),neg(rhs))==[0]*4
    dq=add(scale(q,2),[0]+derivative(q))
    lhs=mul(power(dq,3,2),power(evaluate(P,u,2),2,2),2)
    rhs=mul(power(derivative(u),3,2),power(q,20,2),2)
    defect=add(lhs,neg(rhs));assert defect==[0]*3
    return u,defect

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True);ap.add_argument('--reference',type=Path)
    args=ap.parse_args();tc=certificate(P,A)
    alpha=25;B=K.encode8(tc['canonical_B']);c=K.encode8(tc['canonical_c']);rows=[]
    for root_type in range(4):
        u0,defect0=check(alpha,B,c,0);u1,defect1=check(alpha,B,c,1)
        slope=divide(K.mul8(4,u0[1]),B)
        assert K.add8(u1[3],K.neg8(u0[3]))==slope
        rows.append({'root_type':root_type,'u_coefficients_d0':[list(K.decode8(z)) for z in u0],
                     'u3_slope_in_d':list(K.decode8(slope)),
                     'differential_defect_coefficients_for_d0':defect0,'differential_defect_coefficients_for_d1':defect1})
        alpha=K.power8(alpha,25);B=K.power8(B,25);c=K.power8(c,25)
    out={'scope':'finite endpoint jets only; free coefficient d, no new exclusion or model',
         'rows':rows,'all_four_root_types_checked':True,'tested_d_values':[0,1],
         'arbitrary_d_claim':'proved by affine dependence and cancellation in REPORT Appendix G',
         'all_116_label_claim':'proved by Frobenius and mu_29 homogeneity in REPORT Appendix G',
         'epsilon_enters_value_at_order':4,'epsilon_enters_normalized_differential_at_order':3}
    if args.reference:assert out==json.loads(args.reference.read_text())
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: exact value jets through t^3 and differential jets through t^2 for four root types and d=0,1')
    print('NO EXCLUSION: the next coefficient is free at this finite-jet order; no infinite local solution asserted')
if __name__=='__main__':main()
