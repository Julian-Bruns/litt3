"""One tiny native exact F5 polynomial gate; no external CAS or census."""
import json,signal,time
from pathlib import Path
signal.alarm(3)
start=time.process_time()
def trim(a):
    a=[x%5 for x in a]
    while a and not a[-1]:a.pop()
    return a
def add(a,b):return trim([(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def neg(a):return trim([-x for x in a])
def sub(a,b):return add(a,neg(b))
def mul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,u in enumerate(a):
        for j,v in enumerate(b):c[i+j]+=u*v
    return trim(c)
def divrem(a,b):
    a=trim(a);b=trim(b);assert b
    q=[0]*max(0,len(a)-len(b)+1);inv=pow(b[-1],-1,5)
    while len(a)>=len(b):
        k=len(a)-len(b);c=a[-1]*inv%5;q[k]=c
        for j,z in enumerate(b):a[j+k]=(a[j+k]-c*z)%5
        a=trim(a)
    return trim(q),a
def mod(a,p):return divrem(a,p)[1]
def pm(a,n,p):
    z=[1]
    while n:
        if n&1:z=mod(mul(z,a),p)
        a=mod(mul(a,a),p);n//=2
    return z
def xgcd(a,b):
    r0,r1=a,b;s0,s1=[1],[];t0,t1=[],[1]
    while r1:
        q,r=divrem(r0,r1)
        r0,r1=r1,r;s0,s1=s1,sub(s0,mul(q,s1));t0,t1=t1,sub(t0,mul(q,t1))
    inv=pow(r0[-1],-1,5)
    return mul(r0,[inv]),mul(s0,[inv]),mul(t0,[inv])
p=[4,3,3,0,3,2,4,1,0,1,1]
r=[4,0,3];num=pm([3,1],3,p)
gr,ar,br=xgcd(p,r);assert gr==[1]
assert add(mul(ar,p),mul(br,r))==[1]
Q=mod(mul(num,br),p)
comparison=sub(pm(Q,125,p),Q)
g,A,B=xgcd(p,comparison)
assert add(mul(A,p),mul(B,comparison))==g
degrees={}
for d in (3,6,9):
    gp,_,_=xgcd(p,sub(pm([0,1],5**d,p),[0,1]))
    degrees[str(d)]=len(gp)-1
out={'P10':p,'Q_numerator':num,'Q_denominator':r,'denominator_bezout':[ar,br],
     'Q_representative':Q,'Q125_minus_Q':comparison,'gcd':g,'bezout':[A,B],
     'frobenius_x_gcd_degrees':degrees,'cpu_seconds':time.process_time()-start}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct03_backup42_differential_shape')
dest.mkdir(parents=True,exist_ok=True)
(dest/'fixed_cone_two_finite_field_gate.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out))
