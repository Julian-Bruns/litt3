#!/usr/bin/env sage
"""Bounded nonlinear diagnostic at an actual bad etale double.

No common span is constructed. Arithmetic is exact, in one CPU process.
The involution fixing gamma reduces the six-variable problem to four;
the two omitted directions have an invertible linearized block, checked
separately below. The retained zero direction is gamma/F.
"""
import json
import time
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--symbolic', action='store_true')
parser.add_argument('--deform-branch', action='store_true')
parser.add_argument('--field-degree', type=int, choices=[4,13], default=13)
parser.add_argument('--order', type=int, default=3)
args = parser.parse_args()
start = time.monotonic()
F5 = GF(5)
if args.deform_branch:
    kt = PolynomialRing(F5, names=('t','c'))
    k = kt.fraction_field()
    t,c = k.gens()
elif args.symbolic:
    kt = PolynomialRing(F5, 't')
    k = kt.fraction_field()
    t = k.gen()
else:
    kt = PolynomialRing(F5, 'T')
    T = kt.gen()
    modulus = (T**13+4*T**2+3*T+3 if args.field_degree==13 else
               T**4+4*T**3+T**2+4*T+3)
    assert modulus.is_irreducible()
    k = GF(5**args.field_degree, 't', modulus=modulus)
    t = k.gen()
if not args.deform_branch:
    c = k(3)
U = PolynomialRing(k, 'u')
u = U.gen()
K = U.fraction_field()
G = u*(u-1)*(u-2)*(u-c)
F = G*(u-t)
R = u*(u-c)
S = F//R
c0 = (G*(u-t)**2)[4]
A = c0*G
base_quartic = K(A)/F**2
log_derivative = base_quartic.derivative()/base_quartic
r = 3*base_quartic.derivative(2)/base_quartic + log_derivative**2
assert r.derivative(2)-3*r**2 == 3*base_quartic
reference = 2*(K(F.derivative())/F)**2-K(F.derivative(2))/F
correction = (r-reference)*F
assert correction.denominator()==1
assert U(correction).degree()==3 and U(correction)[3]==2

# Pair (a,b) denotes a+b*gamma, gamma^2=S. Every differentiation is d/du.
zero = (K(0), K(0))
one = (K(1), K(0))
def add(a,b):
    return (a[0]+b[0], a[1]+b[1])
def scale(a,c):
    return (c*a[0], c*a[1])
def mul(a,b):
    return (a[0]*b[0]+S*a[1]*b[1], a[0]*b[1]+a[1]*b[0])
def deriv(a):
    return (a[0].derivative(), a[1].derivative()+a[1]*S.derivative()/(2*S))

precision = args.order+1
def sa(a,b):
    return [add(x,y) for x,y in zip(a,b)]
def ss(a,c):
    return [scale(x,c) for x in a]
def sm(a,b):
    out = [zero for _ in range(precision)]
    for i in range(precision):
        for j in range(precision-i):
            out[i+j] = add(out[i+j],mul(a[i],b[j]))
    return out
def sd(a):
    return [deriv(x) for x in a]
def nilpotence(a):
    E = sa(sd(sd(a)),ss(sm(a,a),-3))
    return ss(sa(sm(sd(E),sd(E)),ss(sm(E,sa(sd(sd(E)),ss(sm(a,E),3))),3)),-1)

def invariant_coordinates(a):
    assert a[1] == 0
    h = a[0]*F**5
    assert h.denominator() == 1
    h = U(h)
    assert h.degree() <= 10 and all(not h[i] for i in range(11) if i%5)
    return vector(k,[h[0],h[5],h[10]])

base = [(r,K(0))]+[zero for _ in range(precision-1)]
assert all(a == zero for a in nilpotence(base))
cols=[]
for j in range(3):
    test=list(base)
    test[1]=(K(u**j)/F,K(0))
    cols.append(invariant_coordinates(nilpotence(test)[1]))
linear = matrix(k,cols).transpose()
assert linear.det()!=0

# Omitted kappa,u*kappa directions: actual infinitesimal Cartier block.
AS2 = A*S**2
omitted = matrix(k,2,2,lambda i,j: AS2[5*i+4-j])
assert omitted.det()!=0
if not args.deform_branch:
    assert (A*R**2)[4]==0

solution = list(base)
solution[1] = (K(0),K(1)/F)
if args.deform_branch:
    val = nilpotence(solution)[1]
    assert val[0]==0
    residue = val[1]*F**5/S**2
    assert residue.denominator()==1 and U(residue).degree()<=0
    residue = k(U(residue)[0])
    print(json.dumps(dict(status='PASS',deformed_branch=True,
        linear_zero_direction_coefficient=str(residue.factor()),
        transverse_derivative_at_c3=str(residue.derivative(c).subs(c=3).factor()),
        seconds=float(time.monotonic()-start)),indent=2))
    raise SystemExit(int(0))
corrections={}
obstructions={}
first=None
for order in range(1,precision):
    val=nilpotence(solution)[order]
    if order%2==0:
        rhs=invariant_coordinates(val)
        coeff=linear.solve_right(-rhs)
        solution[order]=(sum(K(coeff[j]*u**j)/F for j in range(3)),K(0))
        assert nilpotence(solution)[order] == zero
        corrections[str(order)]=[str(x) for x in coeff]
    else:
        assert val[0]==0
        residue=val[1]*F**5/S**2
        assert residue.denominator()==1 and U(residue).degree()<=0
        residue=k(U(residue)[0])
        obstructions[str(order)]=str(residue)
        if residue!=0 and first is None:
            first=order

if args.order>=2:
    assert corrections['2']==[str(4*t/(t+1)),str(1/(t+1)),str(k(0))]
if args.order>=3:
    assert obstructions['3']==str(3*(t+1)) and first==3
assert linear.det()==4*t*(t+2)*(t+3)*(t+4)*(t+1)**8
assert omitted.det()==(t+3)*(t+4)*(t+1)**4

print(json.dumps(dict(
    status='PASS',symbolic=args.symbolic,order=args.order,
    parameter=str(t),curve=str(F),double=str(R),gamma_square=str(S),
    base_connection=str(r),kernel_quadratic='gamma/F*(du)^2',
    invariant_linear_matrix=[[str(a) for a in row] for row in linear.rows()],
    invariant_linear_determinant=str(linear.det()),
    omitted_block_determinant=str(omitted.det()),
    even_corrections=corrections,odd_residual_coefficients=obstructions,
    first_nonzero_order=first,seconds=float(time.monotonic()-start),
    scope='Exact nonlinear fixed-curve nilpotent germ, not an actual two-leg Witt obstruction.'
),indent=2))
