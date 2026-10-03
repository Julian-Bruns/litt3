#!/usr/bin/env sage
"""Literal denominator-free cubic incidence, at retained fixed tuples only."""
from sage.all import *
import argparse,json,time
from pathlib import Path
from itertools import combinations_with_replacement
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();start=time.time()
K=GF(5**8,'z');B=PolynomialRing(K,'Z');Z=B.gen();beta=(Z**2-Z-3).roots(multiplicities=False)[0]
def bcode(c):return K(c%5)+K(c//5)*beta
alpha=sum((bcode(c)*Z**i for i,c in enumerate((5,2,6,7,1))),B.zero()).roots(multiplicities=False)[0]
cache={}
def decode(c):
    c=int(c)
    if c not in cache:
        n=c;v=K.zero()
        for i in range(4):v+=bcode(n%25)*alpha**i;n//=25
        cache[c]=v
    return cache[c]
data=args.work/'data';inputs=json.loads((data/'critical_quadratic_fixed_input.json').read_text())
R=PolynomialRing(K,'x');x=R.gen();P=sum((decode(c)*x**i for i,c in enumerate(inputs['P'])),R.zero())
Y=PolynomialRing(R,'y');y=Y.gen();A=Y.quotient(y**3-P,'yy');yy=A.gen()
def curve(raw):return sum((sum((decode(c)*x**i for i,c in enumerate(component)),R.zero())*yy**j for j,component in enumerate(raw)),A.zero())
aux=[[curve(c) for c in functions] for functions in inputs['auxiliary_functions']]
for record in inputs['records']:
    saved_path=data/(record['name']+'_critical_quadratic_coefficients.sobj')
    if saved_path.exists():
        saved=load(str(saved_path));M=saved['matrix'];ker=saved['kernel'];piv=saved['pivot_rows']
        (data/(record['name']+'_critical_quadratic_coefficients.json')).write_text(json.dumps({'scope':'fixed tuple only; no universal rank or actual source decision','rows':int(M.nrows()),'columns':int(M.ncols()),'rank':int(M.ncols()-ker.nrows()),'kernel_dimension':int(ker.nrows()),'auxiliaries':int(15),'pseudo_scale':int(10),'pivot_rows':list(map(int,piv))},separators=(',',':'))+'\n')
        print('RETAINED_MATRIX',record['name'],flush=True);continue
    F=list(map(curve,record['F']));D=list(map(curve,record['D']));U=[list(map(curve,cs)) for cs in record['U']]
    v=curve(record['v']);m4=list(map(curve,record['m4']));d,c,b,a=D
    assert a
    powers=[A.one()]
    for i in range(8):powers.append(powers[-1]*a)
    E=[[A.one(),A.zero(),A.zero()],[A.zero(),A.one(),A.zero()],[A.zero(),A.zero(),A.one()],[-d,-c,-b]]
    E.append([-b*t-ad for t,ad in zip(E[3],[A.zero(),a*d,a*c])])
    for i in range(5,11):E.append([-b*E[i-1][j]-a*c*E[i-2][j]-a*a*d*E[i-3][j] for j in range(3)])
    remainders=[[powers[8-max(0,i-2)]*t for t in E[i]] for i in range(11)]
    def reduce(cs):return [sum((coefficient*remainders[i][j] for i,coefficient in enumerate(cs)),A.zero()) for j in range(3)]
    pairs=list(combinations_with_replacement(range(len(U)),2));cols=[]
    for ii,jj in pairs:
        raw=[A.zero() for _ in range(11)]
        for i in range(6):
            for j in range(6):raw[i+j]+=U[ii][i]*U[jj][j]
        scalar=v*m4[ii]*m4[jj]
        raw=[raw[i]-F[i]*scalar for i in range(11)]
        factor=1 if ii==jj else 2;cols.append([factor*t for t in reduce(raw)])
    for i in range(11,13):E.append([-b*E[i-1][j]-a*c*E[i-2][j]-a*a*d*E[i-3][j] for j in range(3)])
    for n0,n1,n2 in aux:
        q=[a*n2+b*n1+c*n0,a*n1+b*n0,a*n0];raw=[A.zero() for _ in range(13)]
        for i in range(11):
            for j in range(3):raw[i+j]+=F[i]*q[j]
        # Pcrit has degree two, so F*Pcrit has degree twelve. Extend the same homogeneous remainders.
        cols.append(raw)
    # F times a quadratic requires pseudo scale a^10; multiply earlier product columns by a^2.
    cols[:len(pairs)]=[[a*a*t for t in col] for col in cols[:len(pairs)]]
    powers.extend([powers[-1]*a,powers[-1]*a*a])
    rem12=[[powers[10-max(0,i-2)]*t for t in E[i]] for i in range(13)]
    for col in range(len(pairs),len(cols)):
        raw=cols[col];cols[col]=[sum((coefficient*rem12[i][j] for i,coefficient in enumerate(raw)),A.zero()) for j in range(3)]
    components=[[[R.zero() for _ in range(3)] for _ in range(3)] for _ in cols]
    for i,col in enumerate(cols):
        for j,el in enumerate(col):
            for char,poly in enumerate(el.lift().list()):components[i][j][char]=poly
    tags=[(j,char,n) for j in range(3) for char in range(3) for n in range(1+max(component[j][char].degree() for component in components))]
    M=matrix(K,[[component[j][char][n] for component in components] for j,char,n in tags]);rank=M.rank();ker=M.right_kernel_matrix()
    piv=M.transpose().pivots();assert len(piv)==rank
    print('MATRIX',record['name'],M.nrows(),M.ncols(),'RANK',rank,'SECONDS',time.time()-start,flush=True)
    save({'scope':'literal polynomial coefficient identity at a retained fixed source only','K':K,'beta':beta,'alpha':alpha,'R':R,'A':A,'F':F,'D':D,'U':U,'m4':m4,'aux':aux,'pairs':pairs,'row_tags':tags,'matrix':M,'pivot_rows':list(piv),'kernel':ker,'pseudo_scale':10},str(data/(record['name']+'_critical_quadratic_coefficients.sobj')))
    (data/(record['name']+'_critical_quadratic_coefficients.json')).write_text(json.dumps({'scope':'fixed tuple only; no universal rank or actual source decision','rows':int(M.nrows()),'columns':int(M.ncols()),'rank':int(rank),'kernel_dimension':int(ker.nrows()),'auxiliaries':int(15),'pseudo_scale':int(10),'pivot_rows':list(map(int,piv))},separators=(',',':'))+'\n')
