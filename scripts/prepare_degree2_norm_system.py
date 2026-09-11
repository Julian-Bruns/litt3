#!/usr/bin/env python3
"""Fixed-X norm charts: measure sparse original and residue coordinates.

All nonzero Q are covered by the three monic degree0/1/2 charts.
No geometric exclusion follows from construction or a bounded solve.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF,PolynomialRing,LaurentPolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('out',type=Path)
p.add_argument('--q-degree',type=int,choices=[0,1,2],default=2)
p.add_argument('--coordinates',choices=['original','residue'],default='original')
p.add_argument('--full-degree',type=int,default=1)
p.add_argument('--groebner',action='store_true')
p.add_argument('--low-p-chart',action='store_true',
               help='q0:degP<=3,R monic5; q2:degP<=5,R monic8, solve R recursively')
p.add_argument('--leading-p-degree',type=int,choices=[4,6],
               help='Open leading-P chart; P leading=lead²,R leading=lead³, retain inverse')
p.add_argument('--seconds',type=float,default=120,
               help='bounded Groebner construction wall-time; source saved first')
args=p.parse_args();start=time.monotonic()
F5=GF(5);Aa=PolynomialRing(F5,'a');aa=Aa.gen()
K=GF(25,'a',modulus=aa**2+4*aa+2);a=K.gen()
d=args.q_degree
if args.leading_p_degree:
    assert not args.low_p_chart and args.coordinates=='original'
    assert args.leading_p_degree==6 or d==0
    pdegree=args.leading_p_degree
    names=['p%d'%i for i in range(pdegree)]+['q%d'%i for i in range(d)]+['lead','lead_inv']
elif args.low_p_chart:
    assert args.coordinates=='original' and d in (0,2)
    pdegree=3 if d==0 else 5
    names=['p%d'%i for i in range(pdegree+1)]+['q%d'%i for i in range(d)]
elif args.coordinates=='original':
    names=['p%d'%i for i in range(7)]+['r%d'%i for i in range(10)]+['q%d'%i for i in range(d)]
else:names=['s%d'%i for i in range(10)]+['q%d'%i for i in range(d)]
R=PolynomialRing(K,len(names),names=names,order='degrevlex')
X=PolynomialRing(R,'x');x=X.gen()
F=x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6+4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+(2*a+1)
Q=x**d+sum(R('q%d'%i)*x**i for i in range(d))
equations=[]
if args.leading_p_degree:
    L=LaurentPolynomialRing(K,names=names[:-1],order='degrevlex')
    LX=PolynomialRing(L,'x');lx=LX.gen();lead=L('lead')
    P=lead**2*lx**pdegree+sum(L('p%d'%i)*lx**i for i in range(pdegree))
    lQ=lx**d+sum(L('q%d'%i)*lx**i for i in range(d))
    lF=LX({i:L(K(c)) for i,c in enumerate(F.list())})
    target=P**3+lF*lQ**3;rdegree=3*pdegree//2
    RR=lead**3*lx**rdegree
    for j in range(rdegree-1,-1,-1):
        RR+=(target-RR**2)[rdegree+j]/(2*lead**3)*lx**j
    remainder=target-RR**2
    assert all(remainder[j]==0 for j in range(rdegree,2*rdegree+1))
    equations=[];clearing=[]
    for j in range(rdegree):
        f=remainder[j]
        if not f:continue
        shift=max(0,-min(e[L.ngens()-1] for e in f.dict()))
        ff=f*lead**shift
        assert all(all(int(v)>=0 for v in e) for e in ff.dict())
        equations.append(R({tuple(int(v) for v in e)+(0,):c for e,c in ff.dict().items()}))
        clearing.append(dict(coefficient=j,lead_power=int(shift)))
    equations.append(R('lead')*R('lead_inv')-1)
    Q=lQ
elif args.low_p_chart:
    P=sum(R('p%d'%i)*x**i for i in range(pdegree+1))
    target=P**3+F*Q**3
    rdegree=5 if d==0 else 8
    RR=x**rdegree
    for j in range(rdegree-1,-1,-1):
        RR+=(target-RR**2)[rdegree+j]/2*x**j
    assert all((target-RR**2)[j]==0 for j in range(rdegree,2*rdegree+1))
elif args.coordinates=='original':
    P=sum(R('p%d'%i)*x**i for i in range(7))
    RR=sum(R('r%d'%i)*x**i for i in range(10))
else:
    S=sum(R('s%d'%i)*x**i for i in range(10))
    fullP=(S*S)%F;RR=(S**3)%F
    equations=[fullP[i] for i in range(7,10)]
    P=sum(fullP[i]*x**i for i in range(7))
if not args.leading_p_degree:
    norm=P**3+F*Q**3-RR**2
    equations += norm.list()
equations=[f for f in equations if f]
summary=dict(coordinates=args.coordinates,q_degree=d,variables=R.ngens(),
    equations=len(equations),terms=sum(len(f.dict()) for f in equations),
    max_degree=int(max(f.total_degree() for f in equations)),construction_seconds=time.monotonic()-start,
    scope=('Open P-degree%d chart with explicit leading inverse'%args.leading_p_degree
           if args.leading_p_degree else
           'Closed low-P subchart, R sign identified; not the whole Q chart'
           if args.low_p_chart else
           'Complete monic-Q norm chart, with etaleness to test separately on solutions'))
print(json.dumps(summary),flush=True)
export_system(R,equations,args.out,c_degree=0,field_only=True,
    full_degree=args.full_degree,eliminate_linear=False)
(args.out/'norm_provenance.json').write_text(json.dumps(summary,indent=2)+'\n')
if args.low_p_chart or args.leading_p_degree:
    (args.out/'norm_reconstruction.txt').write_text('P='+str(P)+'\nQ='+str(Q)+'\nR='+str(RR)+'\n')
if args.leading_p_degree:
    (args.out/'denominator_clearance.json').write_text(json.dumps(clearing,indent=2)+'\n')
if args.groebner:
    print('GROEBNER_STARTED',flush=True)
    basis_start=time.monotonic()
    alarm(args.seconds)
    try:
        G=R.ideal(equations).groebner_basis()
        summary.update(groebner_status='complete',
            basis_size=len(G),unit=(len(G)==1 and G[0]==1),
            dimension=int(R.ideal(G).dimension()))
        (args.out/'groebner_basis.txt').write_text('\n'.join(str(f) for f in G)+'\n')
    except AlarmInterrupt:
        summary.update(groebner_status='time_limit',unit=None)
    finally:
        cancel_alarm()
    summary.update(groebner_seconds=time.monotonic()-basis_start)
    (args.out/'groebner_result.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary),flush=True)
