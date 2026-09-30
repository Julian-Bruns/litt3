#!/usr/bin/env sage
"""Exact module-membership experiment on the pure-v quotient tensor.

This computes the cokernel of each transposed block. Annihilation by powers
of all scroll quadrics proves its support is contained in that scroll.
Annihilation by powers of all variables proves projective emptiness.
Failure within a bounded power range proves neither converse.
All output and generated Singular source belong outside the prose workspace.
"""
from sage.all import *
from pathlib import Path
import argparse, json, time
import numpy as np

ap = argparse.ArgumentParser()
ap.add_argument('--data', type=Path, required=True)
ap.add_argument('--output', type=Path, required=True)
ap.add_argument('--block', type=int, choices=[0,1,2], required=True)
ap.add_argument('--max-power', type=int, default=4)
args = ap.parse_args()
args.output.mkdir(parents=True, exist_ok=True)
T = np.load(args.data/'hom_tensor.npz', allow_pickle=False)['T'][13:19]
adj = np.any(T != 0, axis=0)
unseen = set(range(35)); components = []
while unseen:
    cols = {min(unseen)}; rows = set()
    while True:
        nr = set(map(int, np.flatnonzero(np.any(adj[:,sorted(cols)], axis=1))))
        nc = set(map(int, np.flatnonzero(np.any(adj[sorted(nr)], axis=0))))
        if nr == rows and nc == cols:
            break
        rows,cols = nr,nc
    unseen -= cols
    components.append((sorted(rows),sorted(cols)))
rows,cols = components[args.block]
R0 = PolynomialRing(GF(5),'b')
b = R0.gen()
F = GF(25,'beta',modulus=b**2-b-3)
beta = F.gen()
R = PolynomialRing(F,names=['z%d'%i for i in range(6)],order='degrevlex')
z = R.gens()
def code(c):
    return F(int(c)%5)+F(int(c)//5)*beta
M = matrix(F,6,6,[code(c) for c in [
17,8,18,15,24,10,17,12,7,22,17,1,17,12,19,21,19,8,
12,5,5,20,9,11,2,1,1,19,5,0,7,24,0,15,4,1]])
assert M.det() != 0
eta = M*vector(R,z)
block = matrix(R, len(rows),len(cols),
 [sum((code(T[k,r,c])*eta[k] for k in range(6)), R.zero())
  for r in rows for c in cols])
start=time.monotonic()
source = 'ring r=(5,beta),('+','.join(map(str,z))+'),dp;\n'
source += 'minpoly=beta^2-beta-3;\n'
source += 'module U='+','.join('['+','.join(str(p) for p in row)+']' for row in block.rows())+';\n'
(args.output/'input.sing').write_text(source)
print('Starting exact module Groebner basis',args.block,block.dimensions(),flush=True)
singular.eval(source)
cache=(args.output/'basis.sing').resolve()
if cache.exists():
    singular.eval('execute(read("%s"));'%cache)
else:
    singular.eval('module G=std(U);')
    singular.eval('write("%s","module G="+string(G)+";");'%cache)
def integer_output(command):
    return int(singular.eval(command).strip().splitlines()[-1])
ng=integer_output('size(G);')
print('Groebner basis completed',ng,'generators;',round(time.monotonic()-start,3),'seconds',flush=True)
singular.eval('module E=freemodule(%d);'%len(cols))
singular.eval('module V; module REM; matrix W;')
if args.block==1:
    A=matrix(R,2,4,[z[0],z[1],z[3],z[4],z[1],z[2],z[4],z[5]])
    targets=[A.matrix_from_columns([i,j]).det() for i in range(4) for j in range(i+1,4)]
    meaning='support contained in the known quartic scroll'
else:
    targets=list(z)
    meaning='no projective support'
records=[]
for i,q in enumerate(targets):
    passed=None
    for power in range(1,args.max_power+1):
        check='V=(%s)^%d*E; REM=reduce(V,G); size(REM);'%(q,power)
        remainder_size=integer_output(check)
        if remainder_size==0:
            passed=power
            witness=singular.eval('W=lift(U,V); print(W);')
            (args.output/('lift_%d.txt'%i)).write_text(witness+'\n')
            break
    records.append({'polynomial':str(q),'annihilating_power':passed,'checked_through':args.max_power if passed is None else passed})
    print('target',i,'power',passed,flush=True)
result={'block':args.block,'rows':rows,'columns':cols,'basis_size':ng,'targets':records,
        'proved_support_conclusion':meaning if all(a['annihilating_power'] is not None for a in records) else None,
        'failure_meaning':'No conclusion from failure in the bounded power range.',
        'seconds':time.monotonic()-start,'sage_version':version()}
(args.output/'result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2),flush=True)
