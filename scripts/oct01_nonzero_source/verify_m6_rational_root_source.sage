#!/usr/bin/env sage
"""Independent quotient-ring reconstruction and all seven target checks."""
from sage.all import *
import argparse,json,time
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--work',type=Path,required=True);args=parser.parse_args();data=args.work/'data';source=json.loads((data/'m6_rational_root_source_input.json').read_text());start=time.time();reports=[]
for case in range(6):
    raw=load(str(data/('m6_rational_root_source_case_%s.sobj'%case)));cert=load(str(data/('m6_rational_root_source_membership_case_%s.sobj'%case)));M=raw['matrix'];R=M.base_ring();E=R.base_ring();u,v=R.gens();beta=raw['beta'];alpha=raw['alpha']
    def decode(c):return sum(((E(int(c)//int(25)**i%int(25)%int(5))+E(int(c)//int(25)**i%int(25)//int(5))*beta)*alpha**i for i in range(4)),E.zero())
    X=PolynomialRing(R,'x');x=X.gen();Yring=PolynomialRing(X,'Y');Y=Yring.gen();P=sum((X(decode(c))*x**i for i,c in enumerate(source['P'])),X.zero());C=Yring.quotient(Y**3-P,'y');y=C.gen();q=sum((X(decode(c))*x**i for i,c in enumerate(source['q'])),X.zero());Q=X(decode(22))+X(decode(15))*x
    orientation=case%2;j2=case//2;xs=[decode(12),decode(16)];ys=[raw['Y1'],raw['omega']**j2];qs=[decode(5),decode(9)];i=orientation;j=1-i;gamma=qs[i]*ys[i];values=[E.zero(),E.zero()];values[i]=qs[i]*ys[i]**2;values[j]=-qs[j]*ys[j]**2-gamma*ys[j];slope=(values[1]-values[0])/(xs[1]-xs[0]);p0=X(values[0]-slope*xs[0])+X(slope)*x
    n=C(Q)*y**2+C(gamma)*y+C(p0+q*(X(u)+X(v)*x))
    for col,d in enumerate(source['D_basis_finite']):
        f=C.zero()
        for power,coefficient in enumerate(d):
            dd=sum((C(sum((X(decode(c))*x**e for e,c in enumerate(character)),X.zero()))*y**char for char,character in enumerate(coefficient)),C.zero());f+=dd*n**power*C(q)**(3-power)
        reconstructed=C.zero()
        for row,(char,e) in enumerate(raw['row_tags']):reconstructed+=C(X(M[row,col])*x**e)*y**char
        assert f==reconstructed
    assert cert['matrix']==M and cert['target']==vector(R,source['kappa_functional'])
    weights=vector(R,cert['combination']);assert all(not h or h.total_degree()==0 for h in weights)
    checked=[]
    for col in range(7):
        actual=sum((weights[row]*M[row,col] for row in range(M.nrows())),R.zero());assert actual==cert['target'][col];checked.append(col)
    sourceM=matrix(E,[[decode(c) for c in row] for row in source['source_matrix']]);sourceB=matrix(E,[[decode(c) for c in row] for row in source['source_kernel']]);assert (sourceM*sourceB.transpose()).is_zero() and sourceB.rank()==7
    reports.append({'case':int(case),'status':'PASS','quotient_reconstruction_columns':int(7),'constant_target_columns':checked,'nonzero_weights':sum(h!=0 for h in weights),'source_slice_dimension':int(7)})
report={'status':'PASS','scope':'independent quotient-ring implementation reconstructs all31row entries and checks all7target identities for each6conjugacy cases; source slice stored-kernel identities checked','cases':reports,'seconds':time.time()-start}
(data/'m6_rational_root_source_verification.json').write_text(json.dumps(report,default=int)+'\n');print(report)
