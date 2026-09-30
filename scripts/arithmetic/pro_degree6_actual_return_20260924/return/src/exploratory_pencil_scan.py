#!/usr/bin/env python3
"""Reproduce earlier BASE-FIELD diagnostics. NOT a geometric exhaustion.

python src/exploratory_pencil_scan.py --negative
python src/exploratory_pencil_scan.py --degrees
The full geometric results use polynomial certificates in verify.py instead.
"""
import argparse
from negative_quotient import *

def main():
 p=argparse.ArgumentParser(description=__doc__)
 g=p.add_mutually_exclusive_group(required=True)
 g.add_argument('--negative',action='store_true');g.add_argument('--degrees',action='store_true')
 args=p.parse_args()
 if args.negative:
  A,B,Q,S,L=build_negative(5,-1);C=Q.transpose(2,1,0)
  for r in range(25):
   N=ADD[C[0],MUL[r,C[1]]];ker=kernel(N)
   if ker.shape[1]:print('rankdrop n=1+r*x',r,'rank',19-ker.shape[1],ker.T.tolist())
  print('infinity rank',len(rref(C[1])[1]))
  build_negative(25,-1)
 else:
  for d in [-1,0,1]:
   A,B,Q,S,L=build_negative(5,d);C=Q.transpose(2,1,0)
   for r in range(25):
    N=ADD[C[0],MUL[r,C[1]]];R,piv=rref(N)
    if len(piv)<19:print('q5d',d,'n=1+r*x',r,'rank',len(piv),flush=True)
   print('q5d',d,'infinity rank',len(rref(C[1])[1]),flush=True)
if __name__=='__main__':main()
