"""Twisted necessary ideals for the backup wild (240,40,47;6) atlas.

The actual-double and twisted normal-form dictionary has a focused
geometric audit PASS. One CPU; --all runs all 30 charts. The exceptional
chart forces lambda=0, not the unlocalized unit ideal.
"""
import argparse
import itertools
import time

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--twist',type=int,choices=range(15),default=0)
parser.add_argument('--chart',choices=('generic','infinity'),default='generic')
parser.add_argument('--all',action='store_true')
args=parser.parse_args()

F5=GF(5)
Kz=PolynomialRing(F5,'z'); z=Kz.gen()
k=GF(125,'alpha',modulus=z**3+z+1); alpha=k.gen()
Uk=PolynomialRing(k,'u'); uk=Uk.gen()
roots=[k(0),k(1),k(2),k(3),alpha]
Fk=prod(uk-t for t in roots)
twists=[(i,) for i in range(5)]+list(itertools.combinations(range(5),2))
matrix_Q=matrix(k,9,6,lambda i,j:
    (Fk*(uk**j).derivative()+Fk.derivative()*uk**j/2)[i],implementation='generic')
assert matrix_Q.rank()==6
rows=list(matrix_Q.transpose().pivots())
pivot_matrix=matrix_Q.matrix_from_rows(rows)
inverse_matrix=pivot_matrix.inverse()
assert pivot_matrix*inverse_matrix==identity_matrix(k,6)

def run_chart(twist,chart):
    started=time.monotonic()
    def report(label,**values):
        print(label,'twist=',twist,'branches=',twists[twist],'chart=',chart,
              'seconds=',round(time.monotonic()-started,3),values,flush=True)
    R=PolynomialRing(k,names=('r0','r1','a0','a1','a2','b0','b1','lam'),order='degrevlex')
    r0,r1,a0,a1,a2,b0,b1,lam=R.gens()
    U=PolynomialRing(R,'u'); u=U.gen()
    F=U(list(Fk))
    Ek=prod(uk-roots[i] for i in twists[twist]); Jk=Fk//Ek
    assert Ek*Jk==Fk
    E=U(list(Ek)); J=U(list(Jk)); degree_E=E.degree()
    A=a0+a1*u+a2*u**2; B=b0+b1*u
    rhs=E*A**2+J*B**2
    assert pivot_matrix.change_ring(R)*inverse_matrix.change_ring(R)==identity_matrix(R,6)
    Qcoeff=inverse_matrix.change_ring(R)*vector(R,[rhs[i] for i in rows])
    Q=sum(Qcoeff[j]*u**j for j in range(6))
    error=F*Q.derivative()+F.derivative()*Q/2-rhs
    assert all(error[i]==0 for i in rows)
    quadrics=[v for v in error.list() if v]
    derivative_P=2*A*B
    P=r0+r1*u**5+sum(derivative_P[i]*u**(i+1)/k(i+1) for i in range(4))
    assert P.derivative()==derivative_P
    if chart=='generic':
        normalization=[(b1 if degree_E==1 else a2)-1,lam-3*Q[5]]
    elif degree_E==1:
        normalization=[b1,a2-1]
    else:
        normalization=[a2,b1-1]
    base=R.ideal(quadrics+normalization)
    gb=base.groebner_basis()
    report('PRIMITIVE',quadrics=len(quadrics),base_basis=len(gb),
           base_dimension=base.dimension(),Q_degree=Q.degree(),Q5=str(Q[5]))
    if gb==[R(1)]:
        report('GROEBNER',unit=True,stage='primitive')
        return 'unit'
    Qring=R.quotient(base,names=R.variable_names())
    V=PolynomialRing(Qring,'u')
    AA=V(A); BB=V(B); EE=V(E); JJ=V(J); PP=V(P); QQ=V(Q)
    lambda_value=Qring(lam)
    N=EE*AA**2-JJ*BB**2
    if (degree_E==1 and chart=='generic') or (degree_E==2 and chart=='infinity'):
        N=-N
    assert N.is_monic() and N.degree()==(6 if chart=='generic' else 5)
    C1=(JJ*BB.derivative()+JJ.derivative()*BB/2)%N
    G1=(EE*AA.derivative()+EE.derivative()*AA/2)%N
    # Differentiate the actual polynomials before quotient reduction.
    C1_full=JJ*BB.derivative()+JJ.derivative()*BB/2
    G1_full=EE*AA.derivative()+EE.derivative()*AA/2
    C2=(JJ*G1_full.derivative()+JJ.derivative()*G1_full/2)%N
    G2=(EE*C1_full.derivative()+EE.derivative()*C1_full/2)%N
    L1=(PP*EE**2*pow(C1,5,N)+JJ**3*QQ*pow(G1,5,N)
        -lambda_value*EE**2*pow(C2,5,N))%N
    L2=(PP*JJ**2*pow(G1,5,N)+EE**3*QQ*pow(C1,5,N)
        -lambda_value*JJ**2*pow(G2,5,N))%N
    even=(EE*AA*L1-JJ*BB*L2)%N
    odd=(AA*L2-BB*L1)%N
    equations=[R(coefficient.lift()) for equation in (even,odd)
               for coefficient in equation.list() if coefficient]
    report('LOCAL_EQUATIONS',equations=len(equations),
           degrees=[f.degree() for f in equations],
           monomials=[len(f.monomials()) for f in equations])
    ideal=R.ideal(list(gb)+equations)
    answer=ideal.groebner_basis()
    unit=answer==[R(1)]
    report('GROEBNER',unit=unit,basis_length=len(answer),dimension=ideal.dimension(),
           degrees=[f.degree() for f in answer])
    if not unit:
        for polynomial in answer:
            print('RESIDUAL_GB',polynomial,flush=True)
        zero_lambda=lam.reduce(answer)==0
        report('LOCAL_GALOIS_DOMAIN',forced_zero_lambda=zero_lambda,
               lambda_required_nonzero=True)
        if zero_lambda:
            return 'zero_lambda'
    return 'unit' if unit else 'unresolved'

jobs=[(i,c) for i in range(15) for c in ('generic','infinity')] if args.all else [(args.twist,args.chart)]
results=[]
for i,c in jobs:
    results.append((i,c,run_chart(i,c)))
print('SUMMARY',results,flush=True)
print('UNIT_CHARTS',sum(status=='unit' for i,c,status in results),'/',len(results),flush=True)
print('FORCED_ZERO_LAMBDA',sum(status=='zero_lambda' for i,c,status in results),flush=True)
print('EXCLUDED_CHARTS',sum(status!='unresolved' for i,c,status in results),'/',len(results),flush=True)
assert all(status in ('unit','zero_lambda') for i,c,status in results)
if args.all:
    assert sum(status=='unit' for i,c,status in results)==29
    assert [(i,c) for i,c,status in results if status=='zero_lambda']==[(4,'infinity')]
