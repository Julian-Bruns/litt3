#!/usr/bin/env sage
"""Focused independent plain-curve check of all uncanceled incidence columns."""
from sage.all import *
import argparse,time,json,numpy as np
from pathlib import Path
from itertools import combinations_with_replacement
p=argparse.ArgumentParser();p.add_argument('--work',type=Path,required=True);p.add_argument('--root',type=int,default=145049);args=p.parse_args();data=args.work/'data';start=time.time();s=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));m=load(str(data/f'twisted_d10m6_uncleared_compact_metadata_{args.root}.sobj'));K=s['K'];RR=s['RR'];plain=PolynomialRing(K,'x');x=plain.gen();Y=PolynomialRing(plain,'y');y=Y.gen();A=Y.quotient(y**3-plain([K(c) for c in s['P'].list()]),'yy');yy=A.gen();ep=K.one();lp=K(2)
def es(f):return K(RR(f)(ep,lp))
def ef(f):return sum((plain([es(c) for c in component.list()])*yy**j for j,component in enumerate(f.lift().list())),A.zero())
F=list(map(ef,s['F']));D=list(map(ef,s['D']));U=[list(map(ef,cs)) for cs in s['U_top_eight']];v=ef(s['v']);aux=[[ef(f) for f in ns] for ns in s['auxiliary_functions']];d,c,b,a=D;raw=np.load(data/f'twisted_d10m6_uncleared_compact_{args.root}.npz')['coefficients'];codes=np.zeros(raw.shape[:2],dtype=np.uint64);prime=int(5)
weights=np.tile(np.array([1,2,4],dtype=np.uint64),raw.shape[2]//int(3))
for digit in range(8):codes+=((((raw//np.uint32(prime**digit))%np.uint32(prime)).astype(np.uint64)*weights).sum(axis=int(2))%np.uint64(prime))*np.uint64(prime**digit)
mv=matrix(K,[[K.from_integer(int(cc)) for cc in row] for row in codes]);pairs=list(combinations_with_replacement(range(8),2));assert pairs==m['pairs'];powers=[A.one()]
for i in range(10):powers.append(powers[-1]*a)
E=[[A.one(),A.zero(),A.zero()],[A.zero(),A.one(),A.zero()],[A.zero(),A.zero(),A.one()],[-d,-c,-b]];E.append([-b*t-ad for t,ad in zip(E[3],[A.zero(),a*d,a*c])])
for i in range(5,13):E.append([-b*E[i-1][j]-a*c*E[i-2][j]-a*a*d*E[i-3][j] for j in range(3)])
remainders=[[powers[10-max(0,i-2)]*t for t in E[i]] for i in range(13)]
for col in range(51):
    rawpoly=[A.zero()]*13
    if col<36:
        i,j=pairs[col];factor=1 if i==j else 2;Q=[factor*v*x**(i+j),A.zero(),A.zero()] if j<3 else [A.zero()]*3
        for ii in range(6):
            for jj in range(6):rawpoly[ii+jj]+=factor*U[i][ii]*U[j][jj]
    else:
        n0,n1,n2=aux[col-36];Q=[-a*n2-b*n1-c*n0,-a*n1-b*n0,-a*n0]
    for ii in range(11):
        for jj in range(3):rawpoly[ii+jj]-=F[ii]*Q[jj]
    expected=[sum((coefficient*remainders[k][j] for k,coefficient in enumerate(rawpoly)),A.zero()) for j in range(3)]
    for row,tag in enumerate(m['row_tags']):
        if tag[0]=='critical':
            _,degree,char,xx=tag;component=expected[degree].lift().list();value=component[char][xx] if char<len(component) else K.zero();assert mv[row,col]==value,(row,col)
        elif tag[0]=='auxiliary_endpoint':
            ll=tag[1]
            if col<36:i,j=pairs[col];value=(1 if i==j else 2)*es(s['auxiliary_forcing'][ll][i+j]) if j<3 else K.zero()
            else:value=K(s['auxiliary_matrix'][ll,col-36](ep))
            assert mv[row,col]==value,(row,col,'endpoint')
        elif tag[0]=='compatibility':
            _,ll,zz=tag
            if col>=36:value=K.zero()
            else:
                i,j=pairs[col];value=es(s['top_compatibility'][ll,zz]) if i==j==zz else es(s['top_compatibility'][ll,j]) if i==zz else es(s['top_compatibility'][ll,i]) if j==zz else K.zero()
            assert mv[row,col]==value,(row,col,'compatibility')
    if col%12==0:print('DIRECT_UNCLEARED_COLUMN_PASS',col,'SECONDS',time.time()-start,flush=True)
assert mv.rank()==51
report={'status':'PASS','root':int(args.root),'plain_curve_columns':int(51),'rank':int(51),'eta':int(1),'lambda':int(2),'endpoint_rows_checked':int(15),'compatibility_rows_checked':int(16),'seconds':time.time()-start};(data/f'twisted_d10m6_uncleared_verification_{args.root}.json').write_text(json.dumps(report)+'\n');print('DIRECT_UNCLEARED_PASS',report,flush=True)
