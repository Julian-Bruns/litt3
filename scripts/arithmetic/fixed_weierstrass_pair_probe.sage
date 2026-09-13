"""Bounded symbolic test for exactly one Weierstrass support point.

Not an exclusion certificate: every singular/denominator stratum must be
accounted for before promoting any generic calculation. Checkpoints live
outside the repository; never rerun a completed interpolation stage.
"""
from pathlib import Path
from time import monotonic
from math import comb
import argparse, json

ap=argparse.ArgumentParser()
ap.add_argument('--directory',required=True)
ap.add_argument('--resume',action='store_true')
args=ap.parse_args()
out=Path(args.directory); out.mkdir(parents=True,exist_ok=True)
start=monotonic()
def log(stage,**kw):
    print(json.dumps(dict(stage=stage,seconds=float(monotonic()-start),**kw),default=str),flush=True)

if args.resume and (out/'pair_matrix.sobj').exists():
    data=load(str(out/'pair_matrix.sobj'))
    K,a,u,c,R,b,L,z,F,cp,M,rhs,TP,TQ=data
    log('matrix_resumed')
else:
    K=GF(5**12,'c')
    P=PolynomialRing(K,'t'); t=P.gen()
    a=(t*t+4*t+2).roots(multiplicities=False)[0]
    G=t**6+(a+4)*t**5+(3*a+2)*t**4+(2*a+2)*t**3+t*t+4*a*t+4*a+4
    u=G.roots(multiplicities=False)[0]
    FF=t**10+(4*a+2)*t**9+(a+4)*t**8+(3*a+1)*t**7+3*a*t**6+4*a*t**5+(3*a+4)*t**4+a*t**3+(3*a+3)*t*t+(4*a+2)*t+2*a+1
    c=(t**3-FF(u)).roots(multiplicities=False)[0]
    cp=FF(u)
    assert cp!=0 and c**3==cp
    R=FunctionField(K,'b'); b=R.gen()
    Z=PolynomialRing(R,'z'); zz=Z.gen()
    F=R(FF(b))
    L=R.extension(zz**3-F/cp,'z'); z=L.gen()
    S=PolynomialRing(K,'s'); ss=S.gen()
    local_rhs=S(FF(u+ss))/cp
    HP=(local_rhs**17).truncate(9)
    assert (HP**3-local_rhs).truncate(9)==0
    TP=[((u+ss)**i*HP).truncate(9) for i in range(6)]
    TQ=[((u+ss)**i*HP**2).truncate(9) for i in range(3)]
    def hd(poly,n,at):
        return sum(K(comb(i,n))*poly[i]*at**(i-n) for i in range(n,poly.degree()+1))
    f2=FF**2
    HQ=[(F**5*hd(f2,n,b)+(3*hd(FF,1,b)**5*hd(f2,n-5,b) if n>=5 else 0))/F**7 for n in range(9)]
    HQ2=[sum(HQ[i]*HQ[n-i] for i in range(n+1)) for n in range(9)]
    # All rows are multiplied by F(b)^7; this changes no nonbranch fiber.
    M=matrix(L,9,9)
    for n in range(9):
        for i in range(6):
            M[n,i]=F**7*(z*sum(K(comb(i,j))*b**(i-j)*HQ[n-j] for j in range(min(i,n)+1))-hd(TP[i],n,b-u))
        for i in range(3):
            M[n,6+i]=F**7*(z**2*sum(K(comb(i,j))*b**(i-j)*HQ2[n-j] for j in range(min(i,n)+1))-hd(TQ[i],n,b-u))
    rhs=vector(L,[-F**7*K(comb(9,n))*(b-u)**(9-n) for n in range(9)])
    save((K,a,u,c,R,b,L,z,F,cp,M,rhs,TP,TQ),str(out/'pair_matrix.sobj'))
    log('matrix_saved',shape=[9,9])

if args.resume and (out/'pair_solution.sobj').exists():
    sol=load(str(out/'pair_solution.sobj')); log('solution_resumed')
else:
    sol=M.solve_right(rhs)
    assert M*sol==rhs
    save(sol,str(out/'pair_solution.sobj'))
    log('solution_saved')

P=PolynomialRing(L,'x'); x=P.gen()
B=sum(sol[i]*x**i for i in range(6))
C=sum(sol[6+i]*x**i for i in range(3))
A=(x-u)**9-sum(sol[i]*P(TP[i](x-u)) for i in range(6))-sum(sol[6+i]*P(TQ[i](x-u)) for i in range(3))
FF=x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6+4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x*x+(4*a+2)*x+2*a+1
N=A**3+B**3*(FF/cp)+C**3*(FF/cp)**2-3*A*B*C*(FF/cp)
Q,rem=N.quo_rem(((x-u)*(x-b))**9)
assert rem==0 and Q.degree()==9 and Q[9]==1
E7=Q[7]-Q[8]**2; E6=Q[6]-Q[8]**3
save((A,B,C,Q,E7,E6),str(out/'pair_norm.sobj'))
log('norm_conditions_saved',first_nonzero=bool(E7),second_nonzero=bool(E6))
