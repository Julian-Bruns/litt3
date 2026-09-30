"""Independent Sage check of the returned degree-four quadratic cross map.

Run with sage -python and the quadratic-symbol certificate JSON as argument.
"""
from sage.all import *
import ast
import json
import sys
from pathlib import Path

data = json.loads(Path(sys.argv[1]).read_text())
base = PolynomialRing(GF(5), 'T')
T = base.gen()
k = GF(125, name='t', modulus=T**3+T+1)
t = k.gen()
poly = PolynomialRing(k, names=('s1','s2','s3'))
variables = poly.gens()
truncated = poly.quotient([x**5 for x in variables])

def fld(code):
    return k(code % 5) + (code//5 % 5)*t + (code//25)*t*t

def coefficients(p):
    return {tuple(ex): c for ex, c in p.dict().items()}

def monomial(ex):
    return prod(x**e for x,e in zip(variables,ex))

q = sum((fld(c)*monomial(ast.literal_eval(m))
         for m,c in data['scalar_f'].items()
         if sum(ast.literal_eval(m)) == 2),poly(0))
H5_CODES = {(3,1,1):12,(1,0,4):29,(1,1,3):16,(1,2,2):58,
            (1,3,1):15,(3,0,2):73,(3,2,0):93,(1,4,0):9}
h5 = sum((fld(c)*monomial(ex) for ex,c in H5_CODES.items()),poly(0))
assert truncated(q*h5) == 0
monomials = {d:[tuple(ex) for ex in cartesian_product([range(5)]*3)
                 if sum(ex)==d] for d in range(13)}

def action(d):
    columns = [coefficients(truncated(q*monomial(ex)).lift())
               for ex in monomials[d]]
    return matrix(k,len(monomials[d+2]),len(columns),
                  lambda i,j:columns[j].get(monomials[d+2][i],0),
                  implementation='generic')

def falling(e):
    return prod(range(5-e,5))

def macaulay(p):
    return sum((c*prod(falling(e) for e in ex)*
                monomial(tuple(4-e for e in ex))
                for ex,c in coefficients(p).items()),poly(0))

def inverse_macaulay(p):
    return sum((c/prod(k(falling(4-e)) for e in ex)*
                monomial(tuple(4-e for e in ex))
                for ex,c in coefficients(p).items()),poly(0))

def derivative(p,ex):
    for x,e in zip(variables,ex):
        for _ in range(e):
            p = p.derivative(x)
    return p

kernel_matrix = action(8)
# Explicit generic elimination avoids finite-field implementation changes in
# convenience methods returning subspaces.
echelon = kernel_matrix.echelon_form()
pivots = echelon.pivots()
free = [i for i in range(kernel_matrix.ncols()) if i not in pivots]
kernel = []
for column in free:
    v = [k(0)]*kernel_matrix.ncols()
    v[column] = k(1)
    for row,pivot in enumerate(pivots):
        v[pivot] = -echelon[row,column]
    assert all(sum(kernel_matrix[i,j]*v[j]
                   for j in range(kernel_matrix.ncols())) == 0
               for i in range(kernel_matrix.nrows()))
    kernel.append(v)
assert len(kernel)==9
C = {ast.literal_eval(ex):fld(c)
     for ex,c in data['effective_quadratic_symbol']['3'].items()}
first = macaulay(h5)
ordinary_image = action(2)
rank = ordinary_image.rank()
assert rank==6
for index,v in enumerate(kernel):
    h8 = sum((c*monomial(ex) for c,ex in zip(v,monomials[8])),poly(0))
    second = macaulay(h8)
    out = sum((c*(derivative(first,ex[:3])*derivative(second,ex[3:])+
                  derivative(second,ex[:3])*derivative(first,ex[3:]))
               for ex,c in C.items()),poly(0))
    normal = coefficients(inverse_macaulay(truncated(out).lift()))
    assert all(sum(ex)==4 for ex in normal)
    vector_values = [normal.get(ex,0) for ex in monomials[4]]
    joined = matrix(k,len(vector_values),ordinary_image.ncols()+1,
                    lambda i,j:ordinary_image[i,j] if j<ordinary_image.ncols()
                    else vector_values[i],implementation='generic')
    assert joined.rank()==rank, (index,normal,joined.rank())
print('PASS: all 9 degree-eight kernel directions have zero degree-four')
print('polarized quadratic class at H5#, in the exact fixed normalization.')
