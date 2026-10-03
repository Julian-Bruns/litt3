#!/usr/bin/env python3
"""Verify the fixed F25 congruences for arbitrary-degree annihilator traces.

There are no source parameters or bounded searches. Generated JSON belongs
outside litt3; pass its path as the sole optional argument.
"""
from itertools import combinations, permutations
from pathlib import Path
import json
import sys

P = [11,22,18,5,19,20,15,16,9,22,1]
A = [1,21,14,22,13]
Z = [15,19,24,12,10,19,3,24,18,16]


def add(a,b):
    return (a%5+b%5)%5 + 5*((a//5+b//5)%5)


def neg(a):
    return (-a%5)+5*((-(a//5))%5)


def mul(a,b):
    a0,a1,b0,b1=a%5,a//5,b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)


def power(a,n):
    out=1
    while n:
        if n&1: out=mul(out,a)
        a=mul(a,a); n//=2
    return out


def inv(a):
    assert a
    out=power(a,23)
    assert mul(a,out)==1
    return out


def trim(p):
    p=list(p)
    while p and not p[-1]: p.pop()
    return p


def plus(p,q):
    p=list(p)+[0]*max(0,len(q)-len(p))
    for i,c in enumerate(q): p[i]=add(p[i],c)
    return trim(p)


def scale(p,c): return trim([mul(x,c) for x in p])


def times(p,q):
    if not p or not q: return []
    out=[0]*(len(p)+len(q)-1)
    for i,a in enumerate(p):
        for j,b in enumerate(q): out[i+j]=add(out[i+j],mul(a,b))
    return trim(out)


def divide(p,q):
    p=trim(p); q=trim(q); assert q
    out=[0]*max(0,len(p)-len(q)+1)
    while len(p)>=len(q):
        i=len(p)-len(q); c=mul(p[-1],inv(q[-1])); out[i]=c
        p=plus(p,[0]*i+scale(q,neg(c)))
    return trim(out),p


def mod(p): return divide(p,P)[1]


def inverse_mod(p):
    r,s,r1,s1=list(p),[1],P[:],[]
    while r1:
        q,r2=divide(r,r1)
        r,r1,s,s1=r1,r2,s1,plus(s,scale(times(q,s1),4))
    assert len(r)==1
    out=mod(scale(s,inv(r[0])))
    assert mod(times(p,out))==[1]
    return out


def entry(p,i): return p[i] if i<len(p) else 0


def det(a):
    n=len(a); assert all(len(r)==n for r in a)
    out=0
    for p in permutations(range(n)):
        term=1
        for i,j in enumerate(p): term=mul(term,a[i][j])
        if sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))%2:
            term=neg(term)
        out=add(out,term)
    return out


def verify():
    # Every nonzero residue field element is invertible; the polynomial
    # z^2-z-3 has no F5 root, so this code is the declared F25.
    assert all((i*i-i-3)%5 for i in range(5))
    for a in range(1,25): assert mul(a,inv(a))==1
    ai=inverse_mod(A)
    R=mod(times(ai,Z)); R2=mod(times(ai,times(Z,Z)))
    assert R==[0,15,9,19,18,17,4,20,1,22]
    assert R2==[12,9,15,19,0,14,0,14,10,3]

    columns=[mod([0]*j+R) for j in range(5)]
    k1=[[entry(c,i) for c in columns] for i in range(5,10)]
    assert det(k1)==0
    p=[3,5,15,24,1]; q=[4,13,16,17]
    assert not mod(plus(times(Z,p),times(A,q)))
    assert not mod(plus(times(R,p),q))
    minor=None
    for rows in combinations(range(5),4):
        matrix=[[k1[i][j] for j in range(4)] for i in rows]
        d=det(matrix)
        if d:
            minor={'rows':[i+5 for i in rows], 'columns':[0,1,2,3],
                   'matrix':matrix,'determinant':d}
            break
    assert minor is not None  # Rank exactly four; p spans its kernel.
    zq=mod(times(Z,q)); assert entry(zq,9)==10

    columns2=[R2,mod([0]+R2),scale(Z,2)]
    k2=[[entry(c,i) for c in columns2] for i in [5,6,7]]
    assert k2==[[14,15,8],[0,19,1],[14,7,18]]
    assert det(k2)==15

    columns3=[mod([0]*j+Z) for j in range(3)]
    k3=[[entry(c,i) for c in columns3] for i in [7,8,9]]
    assert k3==[[24,0,13],[18,16,2],[16,5,14]]
    assert det(k3)==23
    return {'field':'F5(beta), beta^2=beta+3; code a+5b',
            'P':P,'A':A,'Z':Z,'R_Z_over_A':R,'R_Z_squared_over_A':R2,
            'K1':{'matrix':k1,'determinant':0,'rank':4,'minor':minor,
                  'kernel_p':p,'kernel_q':q,'Zq_mod_P':zq,
                  'next_congruence_degree9_obstruction':10},
            'K2':{'rows':[5,6,7],'matrix':k2,'determinant':15},
            'K3':{'rows':[7,8,9],'matrix':k3,'determinant':23}}


if __name__=='__main__':
    record=verify()
    if len(sys.argv)>1:
        target=Path(sys.argv[1]); target.parent.mkdir(parents=True,exist_ok=True)
        target.write_text(json.dumps(record,indent=2)+'\n')
    print('PASS: full-A K1 rank4 + degree9 obstruction[10]; '
          'K2 determinant[15]; K3 determinant[23].')
