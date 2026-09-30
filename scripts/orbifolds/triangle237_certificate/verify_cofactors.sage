"""Verify the horizontal basis, signed cofactors and full differential identity."""
import itertools
import time

started=time.monotonic()
K=GF(5**15,'a')
U0=PolynomialRing(K,'u'); u0=U0.gen()
alpha=(u0**3+u0+1).roots(multiplicities=False)[0]
beta=(u0**5+(alpha+1)*u0**4+(2*alpha**2-2)*u0**3-2*alpha**2*u0**2+
      (-2*alpha**2+alpha+1)*u0+2*alpha**2+2*alpha-2).roots(multiplicities=False)[0]
F0=prod(u0-t for t in [K(0),K(1),K(2),K(3),alpha])
b1=beta**2+3*F0[4]*beta+3*F0[3]
b0=-F0[2]+(F0[4]+2*beta)*b1
P0=2*u0**3+beta*u0**2+b1*u0+b0
def ode0(h):
    return F0*h.derivative(2)+4*F0.derivative()*h.derivative()+(3*F0.derivative(2)-P0)*h
columns=[ode0(u0**j) for j in range(5)]
M0=matrix(K,8,5,lambda i,j:columns[j][i],implementation='generic')
basis=M0.right_kernel().basis()
assert len(basis)==2
hs=[sum(v[j]*u0**j for j in range(5)) for v in basis]
assert all(ode0(h)==0 for h in hs)
wr=hs[0]*hs[1].derivative()-hs[0].derivative()*hs[1]
assert wr and wr % F0 == 0 and (wr//F0).degree()==0
assert hs[0].gcd(hs[1])==1

R=PolynomialRing(K,['c%d'%i for i in range(6)],order='degrevlex')
cv=R.gens(); RT=PolynomialRing(R,'T'); T=RT.gen()
# C*u^j reduced modulo u^5=T; the last columns encode -H0,-H1.
mat=[[RT.zero() for j in range(6)] for i in range(5)]
for j in range(4):
    for power,coef in enumerate(list(cv)+[R.one()]):
        mat[(power+j)%5][j]+=coef*T**((power+j)//5)
for j,h in enumerate(hs):
    for i in range(5):mat[i][4+j]=-h[i]
perms=list(itertools.permutations(range(5)))
signs=[(-1)**sum(p[i]>p[j] for i in range(5) for j in range(i+1,5)) for p in perms]
def minor_without(j):
    keep=[i for i in range(6) if i!=j]
    return sum(sign*prod(mat[i][keep[p[i]]] for i in range(5))
               for p,sign in zip(perms,signs))
cof=[(-1)**j*minor_without(j) for j in range(6)]
assert any(cof)
assert all(sum(mat[i][j]*cof[j] for j in range(6))==0 for i in range(5))
RU=PolynomialRing(R,'u'); u=RU.gen()
def inflate(poly):return sum(coef*u**(5*i) for i,coef in enumerate(poly.list()))
A=sum(u**j*inflate(cof[j]) for j in range(4))
C=u**6+sum(cv[i]*u**i for i in range(6))
F=RU(F0); P=RU(P0); H=A*C
assert F*H.derivative(2)+4*F.derivative()*H.derivative()+(3*F.derivative(2)-P)*H==0
assert all(A[i]==0 for i in (4,9,14))
assert A.degree()<=18
print('HORIZONTAL_BASIS_DEGREES',[h.degree() for h in hs],flush=True)
print('WRONSKIAN_IS_NONZERO_CONSTANT_TIMES_F',True,flush=True)
print('COFACTOR_T_DEGREES',[f.degree() for f in cof],flush=True)
print('A_DEGREE',A.degree(),'LEADING_C_DEGREE',A[18].total_degree(),
      'LEADING_TERMS',A[18].number_of_terms(),flush=True)
print('A_COEFFICIENT_TERM_TOTAL',sum(c.number_of_terms() for c in A),
      'MAX_COEFFICIENT_C_DEGREE',max(c.total_degree() for c in A if c),flush=True)
print('COFACTOR_AND_ORIGINAL_ODE_IDENTITIES_PASS',flush=True)
print('TOTAL_SECONDS',round(time.monotonic()-started,3),flush=True)
