"""Exact necessary ideals excluding the backup wild (120,20,27;3) atlas.

The divisor/local-extension dictionary and all three charts passed a
focused independent audit. Run every --chart; each asserts basis [1].
Optional multiplier extraction may be much slower. Writes no data.
"""
import argparse,time
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--chart',choices=('generic','infinity','even'),default='generic')
parser.add_argument('--certificate',action='store_true',help='Construct and replay an explicit polynomial unit identity.')
args=parser.parse_args()
started=time.monotonic()
def report(label, **values):
    print(label, 'seconds=', round(time.monotonic()-started,3), values, flush=True)

F5=GF(5); Kz=PolynomialRing(F5,'z'); z=Kz.gen()
k=GF(125,'alpha',modulus=z**3+z+1); alpha=k.gen()
Uk=PolynomialRing(k,'u'); uk=Uk.gen()
Fk=prod(uk-t for t in [k(0),k(1),k(2),k(3),alpha])
# S=A(u)+v with A cubic, leading coefficient nonzero; v^2=F.
# R=P+vQ has D R=S^2. The additive constants in P are r0+r1*u^5.
R=PolynomialRing(k,names=('r0','r1','a0','a1','a2','a3','a3inv','lam'),order='degrevlex')
r0,r1,a0,a1,a2,a3,a3inv,lam=R.gens()
U=PolynomialRing(R,'u'); u=U.gen(); F=U(list(Fk))
A=a0+a1*u+a2*u**2+a3*u**3
c=k(0) if args.chart=='even' else k(1)
matrix_Q=matrix(k,9,6,lambda i,j:(Fk*(uk**j).derivative()+Fk.derivative()*uk**j/2)[i],implementation='generic')
assert matrix_Q.rank()==6
rows=list(matrix_Q.transpose().pivots())
right=vector(R,[(A*A+c*c*F)[i] for i in rows])
pivot_matrix=matrix_Q.matrix_from_rows(rows)
inverse_matrix=pivot_matrix.inverse()
assert pivot_matrix*inverse_matrix==identity_matrix(k,6)
assert pivot_matrix.change_ring(R)*inverse_matrix.change_ring(R)==identity_matrix(R,6)
Qcoeff=inverse_matrix.change_ring(R)*right
Q=sum(Qcoeff[j]*u**j for j in range(6))
error=F*Q.derivative()+F.derivative()*Q/2-A*A-c*c*F
report('MATRIX_RECONSTRUCTION', rows=rows,
    pivot_errors=[str(error[i]) for i in rows],
    linear_errors=[str((matrix_Q.change_ring(R)*Qcoeff-vector(R,[(A*A+c*c*F)[i] for i in range(9)]))[i]) for i in rows])
quadrics=[c for c in error.list() if c]
chart_equations={'generic':[a3*a3inv-1,lam-3*Q[5]],
    'infinity':[a3,a3inv], 'even':[a3-1,a3inv-1,lam-3*Q[5]]}[args.chart]
base=R.ideal(quadrics+chart_equations)
gb=base.groebner_basis()
report('PRIMITIVE', chart=args.chart, quadrics=len(quadrics),base_basis=len(gb),base_dimension=base.dimension(),
    Q_degree=Q.degree(),Q5=str(Q[5]),max_base_degree=max(g.degree() for g in gb))
if base.dimension()==-1:
    for q in quadrics:
        print('PRIMITIVE_EQUATION',q,flush=True)
    raise RuntimeError('Empty primitive chart: check reconstruction before interpreting mathematically.')
Qring=R.quotient(base,names=R.variable_names()); V=PolynomialRing(Qring,'u'); v=V.gen()
AA=V(A); FF=V(F); QQ=V(Q)
if args.chart=='generic':
    N=(AA**2-FF)*Qring(a3inv**2)
elif args.chart=='infinity':
    N=FF-AA**2
else:
    N=AA
assert N.is_monic() and N.degree()=={'generic':6,'infinity':5,'even':3}[args.chart]
PP=V(c*(2*a0*u+a1*u**2+4*a2*u**3+3*a3*u**4)+r0+r1*u**5)
lambda_value=Qring(lam)
report('QUOTIENT_READY', lambda_value=str(lambda_value))
if args.chart=='even':
    D2S=(FF*AA.derivative(2)+FF.derivative()*AA.derivative()/2)%N
    DS5_factor=(FF**2*AA.derivative()**5)%N
    even_equation=(QQ*FF*DS5_factor-lambda_value*pow(D2S,5,N))%N
    odd_equation=(PP*DS5_factor)%N
    eqs=[R(coefficient.lift()) for equation in (even_equation,odd_equation)
         for coefficient in equation.list() if coefficient]
else:
    DS=(-AA*AA.derivative()+FF.derivative()/2)%N
    D2S=(FF*AA.derivative(2)+FF.derivative()*AA.derivative()/2-AA*FF.derivative(2)/2)%N
    equation=((PP-AA*QQ)*pow(DS,5,N)-lambda_value*pow(D2S,5,N))%N
    eqs=[R(coefficient.lift()) for coefficient in equation.list() if coefficient]
report('LOCAL_EQUATIONS', equations=len(eqs),degrees=[f.degree() for f in eqs],
    monomials=[len(f.monomials()) for f in eqs])
ideal=R.ideal(list(gb)+eqs)
answer=ideal.groebner_basis()
report('GROEBNER', basis_length=len(answer),unit=answer==[R(1)],
    dimension=ideal.dimension(),degrees=[f.degree() for f in answer])
for polynomial in answer:
    print('GB',polynomial,flush=True)
assert answer==[R(1)], 'The required unit ideal has not been verified.'
if args.certificate and answer==[R(1)]:
    coefficients=list(R(1).lift(ideal))
    assert sum(coefficient*generator for coefficient,generator in zip(coefficients,ideal.gens()))==1
    report('UNIT_IDENTITY', multiplier_monomials=sum(len(f.monomials()) for f in coefficients),
        multiplier_max_degree=max(f.degree() for f in coefficients if f))
