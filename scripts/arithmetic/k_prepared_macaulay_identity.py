#!/usr/bin/env python3
"""Find a bounded total-degree identity for1 by exact coefficient algebra.

A failed degree bound is inconclusive. A successful output contains
only the input equations and exact multipliers, expanded to F5.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, vector


def exponents(n,degree):
    for d in range(degree+1):
        for entries in itertools.combinations_with_replacement(range(n),d):
            e=[0]*n
            for i in entries:e[i]+=1
            yield tuple(e)


def encode(f):return [[list(e),int(c)] for e,c in sorted(f.dict().items())]


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('input',type=Path)
    ap.add_argument('--degree',type=int,required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();start=time.time()
    data=json.loads(args.input.read_text())
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'w')([2,4,1]))
    R=PolynomialRing(k,data['variables'],order='degrevlex')
    f=[R(s) for s in data['equations']];n=R.ngens()
    rows=list(exponents(n,args.degree));index={e:i for i,e in enumerate(rows)}
    columns=[(j,e) for j,g in enumerate(f) for e in exponents(n,args.degree-g.total_degree())]
    receipt={'status':'RUNNING','method':'Exact bounded Macaulay coefficient system over F25',
             'degree_bound':args.degree,'matrix_shape':[len(rows),len(columns)],
             'input_sha256':hashlib.sha256(args.input.read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('BUILD MACAULAY',len(rows),len(columns),flush=True)
    M=matrix(k,len(rows),len(columns))
    terms=[g.dict() for g in f]
    for j,(which,e) in enumerate(columns):
        for ee,c in terms[which].items():M[index[tuple(a+b for a,b in zip(e,ee))],j]=c
    rhs=vector(k,len(rows));rhs[index[(0,)*n]]=1
    print('SOLVE MACAULAY',flush=True)
    try:v=M.solve_right(rhs)
    except ValueError:
        receipt.update(status='NO_IDENTITY_AT_BOUND',seconds=time.time()-start)
        args.output.write_text(json.dumps(receipt,indent=2)+'\n')
        print(receipt['status'],receipt['seconds'],flush=True);return
    assert M*v==rhs
    multipliers=[R.zero() for _ in f]
    for (j,e),c in zip(columns,v):
        if c:multipliers[j]+=R({e:c})
    assert sum(g*h for g,h in zip(f,multipliers))==1
    S=PolynomialRing(GF(5),data['variables']+['a'],order='degrevlex');a=S('a')
    original=[S(s) for s in data['equations']]
    def expand(g):
        return S({tuple(e)+(j,):int(c.polynomial()[j])
                  for e,c in g.dict().items() for j in (0,1) if c.polynomial()[j]})
    lifted=[expand(g) for g in multipliers]
    last,rest=(1-sum(h*g for h,g in zip(lifted,original))).quo_rem(a*a-a+2)
    assert not rest
    original.append(a*a-a+2);lifted.append(last)
    assert sum(h*g for h,g in zip(lifted,original))==1
    receipt.update(status='COMPLETE',empty=True,variables=list(S.variable_names()),
                   equations=[encode(g) for g in original],multipliers=[encode(h) for h in lifted],
                   witness_terms=sum(len(h.dict()) for h in lifted),seconds=time.time()-start)
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
    print('CERTIFIED',receipt['witness_terms'],'terms',receipt['seconds'],flush=True)


if __name__=='__main__':main()
