#!/usr/bin/env sage
"""Bounded support test against the scroll UNION the new isolated point.

Uses a retained exact standard basis. A failed bounded test is not a
geometric counterexample. This script deliberately avoids saturation.
"""
from sage.all import *
from pathlib import Path
import argparse, json, time

ap=argparse.ArgumentParser()
ap.add_argument('--input',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--max-power',type=int,default=4)
ap.add_argument('--min-power',type=int,default=1)
args=ap.parse_args();args.output.mkdir(parents=True,exist_ok=True)
R0=PolynomialRing(GF(5),'b');b=R0.gen()
F=GF(25,'beta',modulus=b**2-b-3);beta=F.gen()
def co(v):return F(v%5)+F(v//5)*beta
M=matrix(F,6,6,map(co,[17,8,18,15,24,10,17,12,7,22,17,1,
17,12,19,21,19,8,12,5,5,20,9,11,2,1,1,19,5,0,7,24,0,15,4,1]))
p=M.inverse()*vector(F,map(co,[1,10,15,16,5,8]))
R=PolynomialRing(F,names=['z%d'%i for i in range(6)],order='degrevlex');z=R.gens()
anchor=next(i for i in range(6) if p[i])
linears=[p[anchor]*z[i]-p[i]*z[anchor] for i in range(6) if i!=anchor]
q=[z[0]*z[2]-z[1]**2,z[0]*z[4]-z[1]*z[3],z[0]*z[5]-z[1]*z[4],
z[1]*z[4]-z[2]*z[3],z[1]*z[5]-z[2]*z[4],z[3]*z[5]-z[4]**2]
singular.eval((args.input/'input.sing').read_text())
singular.eval((args.input/'basis.sing').read_text())
singular.eval('attrib(G,"isSB",1); module E=freemodule(15); module Remainder;')
start=time.monotonic();records=[]
for a,qa in enumerate(q):
 for j,l in enumerate(linears):
  f=qa*l; passed=None
  for exponent in range(args.min_power,args.max_power+1):
   size=int(singular.eval('Remainder=reduce((%s)^%d*E,G);size(Remainder);'%(f,exponent)).strip())
   if size==0:passed=exponent;break
  records.append({'quadric':a,'point_linear':j,'polynomial':str(f),'power':passed})
  print(a,j,passed,round(time.monotonic()-start,2),flush=True)
  if passed is None:
   (args.output/'result.json').write_text(json.dumps({'status':'first bounded test failed; no geometric conclusion','max_power':args.max_power,'checks':records},indent=2)+'\n')
   raise SystemExit(0)
(args.output/'result.json').write_text(json.dumps({'status':'all products annihilate the quotient module; proof lifts still required','checks':records},indent=2)+'\n')
