#!/usr/bin/env sage
"""Bounded literal bivariate necessary D(c)=0 source matrices."""
from sage.all import *
import argparse,json,time
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--work',type=Path,required=True);parser.add_argument('--cases',default='0,1');args=parser.parse_args();data=args.work/'data';raw=json.loads((data/'m6_rational_root_source_input.json').read_text());start=time.time()
K=GF(5**8,'z0');KR=PolynomialRing(K,'T');T=KR.gen();beta=(T**2-T-3).roots(multiplicities=False)[0]
def base(c):return K(int(c)%5)+K(int(c)//5)*beta
alpha=sum((base(c)*T**i for i,c in enumerate((5,2,6,7,1))),KR.zero()).roots(multiplicities=False)[0]
def decode(c):return sum((base((int(c)//int(25)**i)%int(25))*alpha**i for i in range(4)),K.zero())
assert base(6)**((K.order()-1)//3)!=1
E=K.extension(T**3-base(6),'z1');Y1=E.gen();ER=PolynomialRing(E,'T');omega=(ER.gen()**2+ER.gen()+1).roots(multiplicities=False)[0]
assert Y1**3==E(base(6)) and omega**3==1 and omega!=1
A=PolynomialRing(E,names=('u','v','x'));u,v,x=A.gens();B=PolynomialRing(E,names=('u','v'));bu,bv=B.gens()
P=sum((A(decode(c))*x**i for i,c in enumerate(raw['P'])),A.zero());q=sum((A(decode(c))*x**i for i,c in enumerate(raw['q'])),A.zero());Q=A(base(22))+A(base(15))*x
def add(f,g):return [f[i]+g[i] for i in range(3)]
def scale(f,c):return [h*c for h in f]
def mul(f,g):
    h=[A.zero() for _ in range(5)]
    for i in range(3):
        for j in range(3):h[i+j]+=f[i]*g[j]
    h[0]+=P*h[3];h[1]+=P*h[4]
    return h[:3]
def power(f,n):
    out=[A.one(),A.zero(),A.zero()]
    for j in range(n):out=mul(out,f)
    return out
Ds=[[[sum((A(decode(c))*x**i for i,c in enumerate(character)),A.zero()) for character in coefficient] for coefficient in column] for column in raw['D_basis_finite']]
def unit_reduce(M):
    R=matrix(M);remaining_rows=list(range(R.nrows()));remaining_cols=list(range(R.ncols()));piv=[]
    while True:
        found=next(((i,j) for i in remaining_rows for j in remaining_cols if R[i,j] and R[i,j].total_degree()==0),None)
        if found is None:break
        i,j=found;R.rescale_row(i,R[i,j].constant_coefficient()**(-1))
        for ii in remaining_rows:
            if ii!=i and R[ii,j]:R.add_multiple_of_row(ii,i,-R[ii,j])
        remaining_rows.remove(i);remaining_cols.remove(j);piv.append((i,j))
    return R,piv,remaining_rows,remaining_cols
reports=[]
for case in [int(c) for c in args.cases.split(',')]:
    orientation=case%2;j2=case//2;ys=[Y1,omega**j2];xs=[E(base(12)),E(base(16))];ps=[E(base(6)),E.one()];qs=[E(base(5)),E(base(9))];i=orientation;j=1-i;gamma=qs[i]*ys[i]
    targets=[E.zero(),E.zero()];targets[i]=qs[i]*ys[i]**2;targets[j]=-qs[j]*ys[j]**2-gamma*ys[j]
    slope=(targets[1]-targets[0])/(xs[1]-xs[0]);p0=A(targets[0]-slope*xs[0])+A(slope)*x
    n=[p0+q*(u+v*x),A(gamma),Q];np=[power(n,jj) for jj in range(4)];functions=[]
    for d in Ds:
        out=[A.zero(),A.zero(),A.zero()]
        for jj in range(4):out=add(out,scale(mul(d[jj],np[jj]),q**(3-jj)))
        functions.append(out)
    entries={}
    for col,f in enumerate(functions):
        for char,h in enumerate(f):
            for (a,b,e),c in h.dict().items():
                key=(char,int(e));entries.setdefault(key,[B.zero() for _ in Ds]);entries[key][col]+=B(c)*bu**a*bv**b
    tags=sorted(entries);M=matrix(B,[entries[tag] for tag in tags]);assert all(h.total_degree()<=3 for h in M.list())
    reduced,piv,rr,cc=unit_reduce(M);residual=reduced.matrix_from_rows_and_columns(rr,cc);constant=matrix(E,[[h(0,0) for h in row] for row in M.rows()]);rank0=constant.rank();kernel0=constant.right_kernel_matrix();kappa0=vector(E,raw['kappa_functional'])
    save({'matrix':M,'row_tags':tags,'unit_reduced':reduced,'pivots':piv,'remaining_rows':rr,'remaining_columns':cc,'field':E,'beta':E(beta),'alpha':E(alpha),'Y1':Y1,'omega':omega,'case':case,'source_kappa':raw['kappa_functional']},str(data/('m6_rational_root_source_case_%s.sobj'%case)))
    report={'case':case,'orientation':orientation,'fiber2_root_index':j2,'rows':M.nrows(),'source_columns':M.ncols(),'coefficient_total_degree':max(h.total_degree() for h in M.list()),'unit_pivots':len(piv),'remaining_columns':cc,'residual_rows':residual.nrows(),'rank_at_shift0':int(rank0),'kappa_can_be_nonzero_at_shift0':not (kernel0*kappa0).is_zero(),'residual_max_degree':max((h.total_degree() for h in residual.list()),default=-1),'complete_source_exclusion':len(piv)==M.ncols(),'seconds_so_far':time.time()-start}
    reports.append(report);print(report,flush=True)
report={'status':'literal necessary matrices and bounded unit reductions completed','source_dimension':raw['homogeneous_dimension'],'coefficient_field_order':str(E.order()),'cases':reports,'symmetry':'Frobenius25^4 fixes K and fiber2 roots, cycles three fiber1 roots; six cases represent all18 itineraries','seconds':time.time()-start}
(data/'m6_rational_root_source_matrix_summary.json').write_text(json.dumps(report,default=int)+'\n')
