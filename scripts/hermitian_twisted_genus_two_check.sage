#!/usr/bin/env sage
"""Exact small checks for the actual nonliftable Hermitian atlas family.

Connectedness and global etaleness use the proof, not a finite point sample.
"""
import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument('--output')
args = parser.parse_args()
k = GF(25, 'a')
zeta = k.multiplicative_generator()**8
beta = k(3).sqrt()
assert zeta.multiplicative_order() == 3
assert beta**9 == beta

R = PolynomialRing(k, names=('A','B','C'))
A,B,C = R.gens()
s=A+B+C
c=A*B*C
delta=(A-B)*(B-C)*(C-A)
assert R.ideal(A*A+B*B+C*C).reduce(delta**2-s**6-3*c**2) == 0

P = PolynomialRing(k, 't')
t = P.gen()
K = P.fraction_field()
a = K(beta*t/(t*t-1))
b = K((4*t*t-1)/(t*t-1))
assert b*b == 1+3*a*a
assert (b-1)/a == beta*t

def valuation_at(f, point):
    f=K(f)
    if point == 'infinity':
        return f.denominator().degree()-f.numerator().degree()
    def mult(poly):
        value=0
        divisor=t-k(point)
        while poly(point)==0:
            poly,rem=poly.quo_rem(divisor)
            assert rem==0
            value+=1
        return value
    return mult(f.numerator())-mult(f.denominator())

points=(0,1,-1,'infinity')
ordinary_rad=K(t*(t-1)/(t+1))
zero_cartier_rad=K(t/(t*t-1))
assert [valuation_at(ordinary_rad,p) for p in points] == [1,1,-1,-1]
assert [valuation_at(zero_cartier_rad,p) for p in points] == [1,-1,-1,1]

def cm(h):
    assert gcd(h,h.derivative()) == 1
    q=h**2
    return matrix(k,2,2,lambda i,j:q[5*(i+1)-(j+1)])

MC=cm(t**6+t**3+1)
MQ=cm(1-t**6)
assert MC == matrix(k,[[0,2],[2,0]]) and MC.det()!=0
assert MQ.is_zero()
assert (1+t**3)**2+4*t**3 == t**6+t**3+1

def normalize(M):
    lead=next(x for x in M.list() if x)
    return M/lead

D1=diagonal_matrix(k,[zeta,1,1])
D2=diagonal_matrix(k,[1,zeta,1])
cycle=matrix(k,[[0,1,0],[0,0,1],[1,0,0]])
group={tuple(normalize(D1**i*D2**j*cycle**r).list())
       for i in range(3) for j in range(3) for r in range(3)}
assert len(group)==27
matrices=[matrix(k,3,3,x) for x in group]
assert all(normalize(M**3)==identity_matrix(k,3) for M in matrices)
kernel=[M for M in matrices if M.det()**2==1]
assert len(kernel)==9
assert all(normalize(U*V)==normalize(V*U) for U in kernel for V in kernel)

report={
    'status':'PASS_exact_small_identities',
    'group_order':len(group),
    'PSU_intersection_order':len(kernel),
    'group_exponent':3,
    'ordinary_C_Cartier_matrix':[[int(x) for x in row] for row in MC.rows()],
    'Q_Cartier_matrix':[[int(x) for x in row] for row in MQ.rows()],
    'branch_points':['0','1','-1','infinity'],
    'C_Kummer_valuations':[1,1,-1,-1],
    'Q_Kummer_valuations':[1,-1,-1,1],
    'global_proof':'Solutions/Sol_nonliftable_hermitian_atlas_family.md',
    'scope':'Exact identities and finite group check, not a replacement for the connectedness/etaleness proof.'
}
print(json.dumps(report,indent=2,default=int))
if args.output:
    with open(args.output,'w') as handle:
        json.dump(report,handle,indent=2,default=int)
        handle.write('\n')
