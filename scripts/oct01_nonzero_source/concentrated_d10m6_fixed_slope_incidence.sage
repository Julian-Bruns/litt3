#!/usr/bin/env sage
"""Polynomial cubic-incidence minors on the entire eta1 source line."""
from sage.all import *
import argparse,json,time
from pathlib import Path
from itertools import combinations_with_replacement
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();data=args.work/'data';start=time.time()
E=GF(5**24,'z');B=PolynomialRing(E,'Z');Z=B.gen();beta=(Z**2-Z-3).roots(multiplicities=False)[0]
def bcode(c):return E(c%5)+E(c//5)*beta
alpha=sum((bcode(c)*Z**i for i,c in enumerate((5,2,6,7,1))),B.zero()).roots(multiplicities=False)[0];rho=(Z**3-bcode(6)).roots(multiplicities=False)[0]
cache={}
def decode(code):
    code=int(code)
    if code not in cache:
        n=code;v=E.zero()
        for j in range(3):
            q=n%390625;n//=390625;s=E.zero()
            for i in range(4):s+=bcode(q%25)*alpha**i;q//=25
            v+=s*rho**j
        cache[code]=v
    return cache[code]
inputs=json.loads((data/'concentrated_d10m6_fixed_slope_numerator.json').read_text());auxraw=json.loads((data/'critical_quadratic_fixed_input.json').read_text())['auxiliary_functions']
L=PolynomialRing(E,'lam');lam=L.gen();R=PolynomialRing(E,('x','ll'));x,ll=R.gens();P=sum((bcode(c)*x**i for i,c in enumerate((11,22,18,5,19,20,15,16,9,22,1))),R.zero());Y=PolynomialRing(R,'y');y=Y.gen();A=Y.quotient(y**3-P,'yy');yy=A.gen()
def ep(coeffs):return sum((decode(c)*ll**i for i,c in enumerate(coeffs)),R.zero())
def curve(raw,parameter=True):return sum((sum(((ep(c) if parameter else R(decode(c)))*x**i for i,c in enumerate(component)),R.zero())*yy**j for j,component in enumerate(raw)),A.zero())
U=[list(map(curve,cs)) for cs in inputs['U']];F=list(map(curve,inputs['F']));D=[curve(f,False) for f in inputs['D']];v=curve(inputs['v']);m4=[sum((ep(c)*x**j for j,c in enumerate(f)),A.zero()) for f in inputs['m4']];aux=[[curve(c,False) for c in ns] for ns in auxraw]
J=matrix(E,[[decode(c) for c in row] for row in inputs['auxiliary_endpoint_matrix']]);assert J.det();Ji=J.inverse();forcing=[[ep(f) for f in row] for row in inputs['auxiliary_forcing']];d,c,b,a=D
powers=[A.one()]
for i in range(10):powers.append(powers[-1]*a)
EE=[[A.one(),A.zero(),A.zero()],[A.zero(),A.one(),A.zero()],[A.zero(),A.zero(),A.one()],[-d,-c,-b]];EE.append([-b*t-ad for t,ad in zip(EE[3],[A.zero(),a*d,a*c])])
for i in range(5,13):EE.append([-b*EE[i-1][j]-a*c*EE[i-2][j]-a*a*d*EE[i-3][j] for j in range(3)])
rem=[[powers[10-max(0,i-2)]*t for t in EE[i]] for i in range(13)]
pairs=list(combinations_with_replacement(range(6),2));columns=[]
for ii,jj in pairs:
    factor=1 if ii==jj else 2;gamma=factor*m4[ii]*m4[jj];assert gamma.lift().degree()<=0
    coeffs=[R.zero() for _ in range(5)]
    for (xx,lp),coefficient in R(gamma.lift()[0]).dict().items():coeffs[xx]+=coefficient*ll**lp
    rhs=[sum((forcing[i][k]*coeffs[k] for k in range(5)),R.zero()) for i in range(15)]
    auxiliary_coordinates=[-sum((Ji[i,k]*rhs[k] for k in range(15)),R.zero()) for i in range(15)]
    ns=[sum((coordinate*functions[j] for coordinate,functions in zip(auxiliary_coordinates,aux)),A.zero()) for j in range(3)];n0,n1,n2=ns
    Q=[v*gamma-a*n2-b*n1-c*n0,-a*n1-b*n0,-a*n0]
    raw=[A.zero() for _ in range(13)]
    for i in range(6):
        for j in range(6):raw[i+j]+=factor*U[ii][i]*U[jj][j]
    for i in range(11):
        for j in range(3):raw[i+j]-=F[i]*Q[j]
    columns.append([sum((coefficient*rem[i][j] for i,coefficient in enumerate(raw)),A.zero()) for j in range(3)])
components=[]
for column in columns:
    values=[[R.zero() for _ in range(3)] for _ in range(3)]
    for j,el in enumerate(column):
        for char,poly in enumerate(el.lift().list()):values[j][char]=poly
    components.append(values)
tags=[(j,char,xx) for j in range(3) for char in range(3) for xx in range(1+max(f[j][char].degree(x) for f in components))]
M=matrix(L,len(tags),21)
for col,functions in enumerate(components):
    for row,(j,char,xx) in enumerate(tags):M[row,col]=sum((cc*lam**lp for (xp,lp),cc in functions[j][char].dict().items() if xp==xx),L.zero())
print('MATRIX_READY',M.nrows(),M.ncols(),'DEGREE',max(f.degree() for f in M.list()),'SECONDS',time.time()-start,flush=True)
evaluated=matrix(E,[[f(E.one()) for f in row] for row in M.rows()]);assert evaluated.rank()==21
minors=[];minor_rows=[];multipliers=[];g=L.zero()
for ordering in (list(range(M.nrows())),list(reversed(range(M.nrows()))),sorted(range(M.nrows()),key=lambda j:(j%7,j)),sorted(range(M.nrows()),key=lambda j:(j%13,j))):
    em=evaluated.matrix_from_rows(ordering);selected=[ordering[j] for j in em.transpose().pivots()];f=M.matrix_from_rows(selected).det();assert f
    minor_rows.append(selected);minors.append(f)
    if not g:g=f.monic();multipliers=[L.one()/f.leading_coefficient()]
    else:
        gg,u,w=g.xgcd(f);multipliers=[u*t for t in multipliers]+[w];g=gg
    assert sum((aa*ff for aa,ff in zip(multipliers,minors)),L.zero())==g
    print('MINOR',len(minors),'DEG',f.degree(),'GCDDEG',g.degree(),'SECONDS',time.time()-start,flush=True)
    if g.degree()==0:break
cy=L(sum((decode(cc)*lam**i for i,cc in enumerate(inputs['v'][1][0])),L.zero()));remaining=g;power=0
while True:
    divisor=remaining.gcd(cy)
    if divisor.degree()==0:break
    remaining//=divisor;power+=1
save({'scope':'entire eta1 source line only; allfreevparameters retained','E':E,'beta':beta,'alpha':alpha,'rho':rho,'L':L,'R':R,'A':A,'F':F,'D':D,'U':U,'m4':m4,'auxiliary_matrix':J,'matrix':M,'row_tags':tags,'pairs':pairs,'minor_rows':minor_rows,'minors':minors,'gcd':g,'bezout_multipliers':multipliers,'exact_d10_unit':cy,'saturation_remaining':remaining,'saturation_power':power},str(data/'concentrated_d10m6_fixed_slope_incidence.sobj'))
summary={'scope':'entire eta1 freevsource line only, not full chart','rows':int(M.nrows()),'columns':int(M.ncols()),'max_lambda_degree':int(max(f.degree() for f in M.list())),'minor_degrees':[int(f.degree()) for f in minors],'gcd_degree':int(g.degree()),'remaining_degree':int(remaining.degree()),'completed_line_exclusion':bool(remaining.degree()==0)}
(data/'concentrated_d10m6_fixed_slope_incidence.json').write_text(json.dumps(summary,separators=(',',':'))+'\n');print(summary,flush=True)
