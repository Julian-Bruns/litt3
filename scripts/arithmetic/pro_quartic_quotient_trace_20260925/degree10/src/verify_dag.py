#!/usr/bin/env python3
"""Verify a polynomial-ideal identity, not a Groebner-basis algorithm.
Usage: python verify_dag.py norm_inputs.json norm_certificate.dag
Only the Python standard library is required.
"""
import json, sys, time
from pathlib import Path

def fadd(a,b):
    a0,a1=divmod(a,5);b0,b1=divmod(b,5)
    return 5*((a0+b0)%5)+(a1+b1)%5

def fmul(a,b):
    # Multiply two degree-one polynomials, then reduce beta^2=beta+3.
    aa=[a%5,a//5]; bb=[b%5,b//5]; cc=[0,0,0]
    for i in range(2):
        for j in range(2): cc[i+j]+=aa[i]*bb[j]
    cc[0]+=3*cc[2];cc[1]+=cc[2]
    return cc[0]%5+5*(cc[1]%5)
ADD=[[fadd(a,b) for b in range(25)] for a in range(25)]
MUL=[[fmul(a,b) for b in range(25)] for a in range(25)]

def main():
    if len(sys.argv)!=3:
        raise SystemExit('usage: verify_dag.py INPUT.json CERTIFICATE.dag')
    data=json.loads(Path(sys.argv[1]).read_text())
    n=len(data['variables']); ni=len(data['equations']); width=16
    def pack(es):
        if len(es)!=n or any(not isinstance(e,int) or not 0<=e<65536 for e in es):
            raise ValueError('bad exponent vector')
        return sum(e<<(width*i) for i,e in enumerate(es))
    inputs=[]
    for eq in data['equations']:
        p={}
        for es,c in eq['terms']:
            if not isinstance(c,int) or not 1<=c<25:raise ValueError('bad coefficient')
            m=pack(es)
            if m in p: raise ValueError('duplicated input monomial')
            p[m]=c
        inputs.append(p)
    ps={}; bounds={}; start=time.monotonic(); multiplications=0;edges_total=0;max_terms=0
    with open(sys.argv[2]) as f:
        hdr=f.readline().split()
        if hdr[:1]!=['IDEAL_DAG_V1'] or list(map(int,hdr[1:3]))!=[n,ni]:raise ValueError('bad header')
        count,root=map(int,hdr[3:]); last=-1
        for ix in range(count):
            line=f.readline().split()
            if line[:1]!=['NODE'] or len(line)!=5:raise ValueError('bad node record')
            node,inp,terms,edges=map(int,line[1:])
            if node<=last:raise ValueError('nodes not topologically ordered')
            last=node
            if inp>=0:
                if inp>=ni or edges:raise ValueError('invalid input node')
                p=inputs[inp].copy()
                bound=tuple(max(((m>>(width*i))&65535) for m in p) for i in range(n))
            else:
                if inp!=-1 or edges<=0:raise ValueError('invalid derived node')
                p={};bound=[0]*n
                for _ in range(edges):
                    vals=list(map(int,f.readline().split()))
                    if len(vals)!=n+2:raise ValueError('bad edge')
                    parent,c,*es=vals
                    if parent not in ps or not 1<=c<25:raise ValueError('bad edge reference or coefficient')
                    shift=pack(es)
                    for i in range(n):
                        v=es[i]+bounds[parent][i]
                        if v>=65536:raise ValueError('packed exponent overflow')
                        bound[i]=max(bound[i],v)
                    row=MUL[c]
                    for m,a in ps[parent].items():
                        m2=m+shift; z=ADD[p.get(m2,0)][row[a]]
                        if z:p[m2]=z
                        elif m2 in p:del p[m2]
                    multiplications+=len(ps[parent]);edges_total+=1
                bound=tuple(bound)
            if len(p)!=terms:raise ValueError(f'node {node}: expected {terms} terms, got {len(p)}')
            ps[node]=p;bounds[node]=bound;max_terms=max(max_terms,len(p))
            if (ix+1)%100==0:
                print(f'checked {ix+1}/{count} nodes; scalar products={multiplications}; elapsed={time.monotonic()-start:.3f}s',flush=True)
        if f.read().strip():raise ValueError('trailing certificate data')
    if ps.get(root)!={0:1}:raise ValueError('root is not the polynomial 1')
    print(f'PASS: final node {root} is exactly 1 in the input ideal over F25.')
    print(f'PASS: {count} nodes, {edges_total} edges, {multiplications} scalar products, max {max_terms} terms per node.')
    print(f'Elapsed seconds: {time.monotonic()-start:.3f}')
    return 0
if __name__=='__main__':sys.exit(main())
