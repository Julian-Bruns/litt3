#!/usr/bin/env sage
"""Independent exact field and small source-restriction certificate checks."""
from sage.all import *
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--work',type=Path,required=True);a=p.parse_args();data=a.work/'data';start=time.time();raw=json.loads((data/'degree_eleven_inseparable_critical_kernel.json').read_text())
K=GF(5**8,'z');R=PolynomialRing(K,'T');T=R.gen();beta=(T**2-T-3).roots(multiplicities=False)[0]
def base(c):return K(int(c)%5)+K(int(c)//5)*beta
alpha=sum((base(c)*T**i for i,c in enumerate((5,2,6,7,1))),R.zero()).roots(multiplicities=False)[0]
def decode(c):return sum((base((int(c)//int(25)**i)%int(25))*alpha**i for i in range(4)),K.zero())
def mat(rows):return matrix(K,[[decode(c) for c in row] for row in rows])
M=mat(raw['source_matrix']);B=mat(raw['source_kernel']);E=mat(raw['extra_rows_in14coordinates']);L=mat(raw['restricted_kernel']);target=vector(K,list(map(decode,raw['kappa_functional_in14coordinates'])))
assert (M*B.transpose()).is_zero() and B.rank()==14 and E.rank()==9 and L.rank()==5 and (E*L.transpose()).is_zero()
w=vector(K,E.nrows());
for i,c in raw['kappa_exclusion_witness']:w[int(i)]=decode(c)
assert w*E==target and (L*target).is_zero() and target==vector(K,[0]*13+[1])
report={'status':'PASS','source_kernel_dimension':int(14),'restriction_rank':int(9),'restricted_dimension':int(5),'kappa_functional_vanishes':True,'witness_terms':len(raw['kappa_exclusion_witness']),'seconds':time.time()-start,'scope':'independent field arithmetic and stored source/restriction identities; original coefficient construction retained in producer'}
(data/'degree_eleven_inseparable_critical_verification.json').write_text(json.dumps(report)+'\n');print(report)
