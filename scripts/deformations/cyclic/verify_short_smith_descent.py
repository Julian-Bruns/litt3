#!/usr/bin/env python3
"""Bounded independent checks of mixed e/e² necessity modulo25.

All leading solutions and all possible final-digit lifts are accounted
for by exact linear algebra. The examples retain off-diagonal additive
couplings and nonlinear deck-equivariant terms. This is a check, not
the proof of the geometric comparison theorem.
"""
import argparse
import itertools
import json
import random
from pathlib import Path

P=5;Q=5;RANK=2;D=Q*RANK

def mm(a,b):
    return [[sum(x*y for x,y in zip(row,col)) for col in zip(*b)] for row in a]

def mv(a,v):return [sum(x*y for x,y in zip(row,v)) for row in a]

def rref(a,n):
    a=[[x%P for x in row] for row in a];piv=[];rr=0
    for j in range(n):
        ii=next((i for i in range(rr,len(a)) if a[i][j]),None)
        if ii is None:continue
        a[rr],a[ii]=a[ii],a[rr];iv=pow(a[rr][j],-1,P)
        a[rr]=[iv*x%P for x in a[rr]]
        for i in range(len(a)):
            if i!=rr and a[i][j]:
                c=a[i][j];a[i]=[(x-c*y)%P for x,y in zip(a[i],a[rr])]
        piv.append(j);rr+=1
    return a,piv

def solve_space(a,b):
    ar,piv=rref([row+[x] for row,x in zip(a,b)],len(a[0]))
    if any(not any(row[:-1]) and row[-1] for row in ar):return None
    n=len(a[0]);v=[0]*n
    for i,j in enumerate(piv):v[j]=ar[i][-1]
    ker=[]
    for j in range(n):
        if j not in piv:
            w=[0]*n;w[j]=1
            for i,k in enumerate(piv):w[k]=-ar[i][j]%P
            ker.append(w)
    return v,ker

e=[[int(j==(i+1)%Q)-int(j==i) for j in range(Q)] for i in range(Q)]
e2=mm(e,e)
l0=[[0]*D for _ in range(D)]
pre=[[0]*D for _ in range(D)]
for i in range(Q):
    for j in range(Q):
        l0[i][j]=e[i][j];l0[Q+i][Q+j]=e2[i][j]
        pre[i][j]=e[i][j];pre[Q+i][Q+j]=int(i==j)
assert mm(pre,l0)==[[e2[i%Q][j%Q] if i//Q==j//Q else 0 for j in range(D)] for i in range(D)]
left=solve_space(list(map(list,zip(*l0))),[0]*D)[1]

def trial(rng,eta0):
    # Additive corrections can mix both nil blocks at every deck shift.
    t=[[[rng.randrange(P) for _ in range(Q)] for _ in range(RANK)] for _ in range(RANK)]
    a=[[l0[i][j]+P*t[i//Q][j//Q][(j-i)%Q] for j in range(D)] for i in range(D)]
    terms=[[(rng.randrange(P),rng.randrange(RANK),rng.randrange(Q),
             rng.randrange(RANK),rng.randrange(Q)) for _ in range(4)] for _ in range(RANK)]
    eta1=[rng.randrange(P) for _ in range(RANK)]
    rhs0=[eta0[i//Q] for i in range(D)]
    origin,kernel=solve_space(l0,rhs0)
    assert len(kernel)==3
    solutions=[];nonconstant=[]
    for cs in itertools.product(range(P),repeat=len(kernel)):
        v=[(origin[i]+sum(c*w[i] for c,w in zip(cs,kernel)))%P for i in range(D)]
        quad=[sum(c*v[u*Q+(i+s)%Q]*v[w*Q+(i+t)%Q]
                  for c,u,s,w,t in terms[i//Q])%P for i in range(D)]
        residual=[(x-eta0[i//Q]-P*eta1[i//Q]-P*quad[i])%(P*P)
                  for i,x in enumerate(mv(a,v))]
        assert all(x%P==0 for x in residual)
        digit=[(-x//P)%P for x in residual]
        if all(sum(x*y for x,y in zip(row,digit))%P==0 for row in left):
            solutions.append(v)
            if any(len(set(v[j*Q:(j+1)*Q]))>1 for j in range(RANK)):nonconstant.append(v)
    return len(solutions),nonconstant

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--cases',type=int,default=80)
ap.add_argument('--output',type=Path)
args=ap.parse_args();rng=random.Random(20260921)
counts=[]
for _ in range(args.cases):
    count,bad=trial(rng,[0,0]);assert not bad
    counts.append(count)
# Dropping the compatible initial reference must not be silently allowed.
witness=None
for case in range(500):
    count,bad=trial(rng,[0,1])
    if bad:witness={'case':case,'leading_solution':bad[0],'liftable_leading_count':count};break
result={'status':'PASS','scope':'Finite mixed-block modulo25 algebra only; actual geometric chart requires prose audit.',
        'checked_cases':args.cases,'leading_vectors_per_case':125,
        'compatible_reference_solution_counts':sorted(set(counts)),
        'unrestricted_reference_nonconstant_witness':witness}
if args.output:args.output.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
