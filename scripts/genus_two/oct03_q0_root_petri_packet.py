#!/usr/bin/env python3
"""New genus31-root Petri vector against the SETTLED fixed-X H block.

Literal stored input; no fixed-X Cartier/kernel/eigenform replay.
Field code c+5d represents c+d*nu, nu^2=nu+3.
"""
import json, time
from pathlib import Path
started=time.process_time()
def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return (-a%5)%5+5*((-a//5)%5)
def mul(a,b):
    c,d,e,f=a%5,a//5,b%5,b//5
    return (c*e+3*d*f)%5+5*((c*f+d*e+d*f)%5)
def power(a,n):
    out=1
    while n:
        if n&1: out=mul(out,a)
        a=mul(a,a); n//=2
    return out
def dot(a,b):
    out=0
    for x,y in zip(a,b): out=add(out,mul(x,y))
    return out
def matvec(m,v): return [dot(row,v) for row in m]
q0=[24,2,1]
Q=[0,3,14,11,10,0,21,0,5,10,0,17,12,2]
H=[[17,1,13],[16,18,20],[21,5,5]]
product=[0]*(len(Q)+len(q0)-1)
for i,a in enumerate(Q):
    for j,b in enumerate(q0): product[i+j]=add(product[i+j],mul(a,b))
A=[power(product[j],5) for j in [4,9,14]]
D=[[power(c,5) for c in row] for row in H]
DA=matvec(D,A); D2A=matvec(D,DA)
O=[[A[i],DA[i],D2A[i]] for i in range(3)]
positive=add(add(mul(mul(O[0][0],O[1][1]),O[2][2]),mul(mul(O[0][1],O[1][2]),O[2][0])),mul(mul(O[0][2],O[1][0]),O[2][1]))
negative=add(add(mul(mul(O[0][2],O[1][1]),O[2][0]),mul(mul(O[0][0],O[1][2]),O[2][1])),mul(mul(O[0][1],O[1][0]),O[2][2]))
determinant=add(positive,neg(negative))
assert A[2]==18  # 3+3nu, from the independent leading-coefficient argument.
out={'field_modulus':'nu^2-nu-3','encoding':'c+5d means c+d*nu',
     'settled_source':'primitive_mixed_theta_20260915/fixed_x_cartier_petri.json',
     'q0':q0,'primitive_Q':Q,'settled_H_N_M5':H,'actual_C2_matrix_D_H5':D,
     'Qq0_coefficients_4_9_14':[product[j] for j in [4,9,14]],
     'S2_A':A,'D_A':DA,'D2_A':D2A,'packet_determinant':determinant,
     'cpu_seconds':time.process_time()-started}
dest=Path('/Users/julian/Documents/litt3-computation-data/oct03_q0_root_petri_packet')
dest.mkdir(parents=True,exist_ok=True)
(dest/'packet.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out))
