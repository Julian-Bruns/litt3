#!/usr/bin/env python3
"""Sparse open norm charts from P=L^2+M, retaining the leading inverse.

For even positive deg(P)=2l, choose the polynomial part L of sqrt(P),
with sign fixed by the leading term of R. Then deg(M)<l and
R=L^3+4LM+N. The norm equation bounds deg(N) by
max(l-2,10+3deg(Q)-3l). This is an exact chart, not a generic ansatz.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from scripts.atlases.algebra.export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('out',type=Path)
p.add_argument('--q-degree',type=int,choices=[0,1,2],default=0)
p.add_argument('--p-degree',type=int,choices=[4,6],default=6)
p.add_argument('--groebner',action='store_true')
p.add_argument('--algorithm',choices=['std','slimgb'],default='slimgb')
p.add_argument('--seconds',type=int,default=120)
p.add_argument('--full-degree',type=int,default=1)
args=p.parse_args();start=time.monotonic()
assert args.p_degree==6 or args.q_degree==0
l=args.p_degree//2;d=args.q_degree;ndegree=max(l-2,10+3*d-3*l)
Fp=GF(5);Az=PolynomialRing(Fp,'a');az=Az.gen()
K=GF(25,'a',modulus=az**2+4*az+2);a=K.gen()
names=(['l%d'%i for i in range(l+1)]+['m%d'%i for i in range(l)]
       +['n%d'%i for i in range(ndegree+1)]+['q%d'%i for i in range(d)]+['lead_inv'])
R=PolynomialRing(K,len(names),names=names,order='degrevlex')
RX=PolynomialRing(R,'x');x=RX.gen()
F=x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6+4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+(2*a+1)
L=sum(R('l%d'%i)*x**i for i in range(l+1))
M=sum(R('m%d'%i)*x**i for i in range(l))
N=sum(R('n%d'%i)*x**i for i in range(ndegree+1))
Q=x**d+sum(R('q%d'%i)*x**i for i in range(d))
P=L**2+M;RR=L**3+4*L*M+N
normal=2*L**2*M**2+M**3+F*Q**3-2*L**3*N-3*L*M*N-N**2
assert P**3+F*Q**3-RR**2==normal
eq=[f for f in normal.list() if f]+[R('l%d'%l)*R('lead_inv')-1]
summary=dict(p_degree=args.p_degree,q_degree=d,n_degree=ndegree,variables=R.ngens(),
    equations=len(eq),terms=sum(len(f.dict()) for f in eq),
    max_degree=int(max(f.total_degree() for f in eq)),construction_seconds=time.monotonic()-start,
    scope='Exact even-P-degree norm chart with original monic Q and explicit leading inverse')
print(json.dumps(summary),flush=True)
export_system(R,eq,args.out,c_degree=0,field_only=True,full_degree=args.full_degree,eliminate_linear=False)
(args.out/'squarepart_provenance.json').write_text(json.dumps(summary,indent=2)+'\n')
(args.out/'norm_reconstruction.txt').write_text('P='+str(P)+'\nQ='+str(Q)+'\nR='+str(RR)+'\n')
if args.groebner:
    t=time.monotonic();alarm(args.seconds)
    try:
        basis=list(R.ideal(eq).groebner_basis(algorithm='libsingular:'+args.algorithm))
        summary.update(status='complete',unit=(basis==[R.one()]),basis_size=len(basis))
        (args.out/'groebner_basis.txt').write_text('\n'.join(map(str,basis))+'\n')
    except AlarmInterrupt:summary.update(status='time_limit',unit=None)
    finally:cancel_alarm()
    summary.update(algorithm=args.algorithm,groebner_seconds=time.monotonic()-t)
    (args.out/'groebner_result.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary),flush=True)
