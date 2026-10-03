#!/usr/bin/env sage
"""Check the native encoding against direct polynomial arithmetic."""
from sage.all import *
import argparse,time,json
from pathlib import Path
from itertools import combinations_with_replacement
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);args=ap.parse_args();data=args.work/'data';start=time.time()
s=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));m=load(str(data/f'twisted_d10m6_incidence_matrix_{args.root}.sobj'));K=s['K'];RR=s['RR'];R=PolynomialRing(K,'x');x=R.gen();Y=PolynomialRing(R,'y');y=Y.gen();A=Y.quotient(y**3-R([K(c) for c in s['P'].list()]),'yy');yy=A.gen();eveta=K.one();evlambda=K(2)
def evaluate_scalar(f):return K(RR(f)(eveta,evlambda))
def evaluate_function(f):return sum((R([evaluate_scalar(c) for c in p.list()])*yy**j for j,p in enumerate(f.lift().list())),A.zero())
F=list(map(evaluate_function,s['F']));D=list(map(evaluate_function,s['D']));U=[list(map(evaluate_function,cs)) for cs in s['U_top_eight']];v=evaluate_function(s['v']);aux=[[evaluate_function(f) for f in ns] for ns in s['auxiliary_functions']];d,c,b,a=D;delta=K(s['auxiliary_delta'](eveta));Gamma=s['cleared_auxiliary_solution'].apply_map(evaluate_scalar)
powers=[A.one()]
for i in range(10):powers.append(powers[-1]*a)
E=[[A.one(),A.zero(),A.zero()],[A.zero(),A.one(),A.zero()],[A.zero(),A.zero(),A.one()],[-d,-c,-b]];E.append([-b*t-ad for t,ad in zip(E[3],[A.zero(),a*d,a*c])])
for i in range(5,13):E.append([-b*E[i-1][j]-a*c*E[i-2][j]-a*a*d*E[i-3][j] for j in range(3)])
remainders=[[powers[10-max(0,i-2)]*t for t in E[i]] for i in range(13)]
assert m['pairs']==list(combinations_with_replacement(range(8),2));matrix_value=m['matrix'].apply_map(evaluate_scalar)
for column,(i,j) in enumerate(m['pairs']):
    factor=1 if i==j else 2;Q=[A.zero()]*3
    if j<3:
        n=[-factor*sum((Gamma[k,i+j]*functions[h] for k,functions in enumerate(aux)),A.zero()) for h in range(3)];n0,n1,n2=n
        Q=[factor*delta*v*x**(i+j)-a*n2-b*n1-c*n0,-a*n1-b*n0,-a*n0]
    raw=[A.zero()]*13
    for ii in range(6):
        for jj in range(6):raw[ii+jj]+=factor*delta*U[i][ii]*U[j][jj]
    for ii in range(11):
        for jj in range(3):raw[ii+jj]-=F[ii]*Q[jj]
    expected=[sum((coefficient*remainders[k][h] for k,coefficient in enumerate(raw)),A.zero()) for h in range(3)]
    for row,tag in enumerate(m['row_tags']):
        if tag[0]=='critical':
            _,degree,char,xx=tag;coefficient=expected[degree].lift()[char][xx] if char<len(expected[degree].lift().list()) else K.zero()
            assert matrix_value[row,column]==coefficient,(row,column)
    if (column+1)%12==0:print('VERIFIED_COLUMNS',column+1,'SECONDS',time.time()-start,flush=True)
assert matrix_value.rank()==36
summary={'root':int(args.root),'eta':int(1),'lambda':int(2),'direct_plain_arithmetic_columns':int(36),'rank':int(36),'native_encoding_specialization_pass':True,'seconds':time.time()-start}
(data/f'twisted_d10m6_matrix_verification_{args.root}.json').write_text(json.dumps(summary,separators=(',',':'))+'\n');print(summary,flush=True)
