#!/usr/bin/env sage
"""Independent Singular Groebner check with parser-independent coefficients."""
import pickle
import sys
import time
from pathlib import Path
from sage.all import PolynomialRing, GF
input_path=Path(sys.argv[1])
names,polys=pickle.loads(input_path.read_bytes())
R=PolynomialRing(GF(5),names=names,order='degrevlex')
converted=[]
for p in polys:
    d={}
    for mon,c in p.items():
        exp=[0]*len(names)
        for i in mon:exp[i]+=1
        d[tuple(exp)]=c
    converted.append(R(d))
start=time.monotonic()
I=R.ideal(converted)
print('input verified:',len(names),'variables;',len(converted),'polynomials',flush=True)
print(I.groebner_basis(),flush=True)
print('seconds',time.monotonic()-start,flush=True)
