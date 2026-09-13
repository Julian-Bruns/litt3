#!/usr/bin/env python3
"""Small F5 test of the candidate initial residual, NOT its geometric proof.

On U=d^5,V=b^5, sigma sends (U,V) to (U,V+U), and tau sends
(U,V) to (U,-V). On the obstruction basis (1,q), tau has signs(-,+).
Test all coefficient vectors of polynomials of total degree<=2 by
linear algebra. Vanishing along U=0 is included. Geometry must still
prove that its actual higher obstruction lies in this degree class.
"""
from math import comb

P=5
monomials=[(0,0),(1,0),(0,1),(2,0),(1,1),(0,2)]

def add(a,b,scale=1):
    out=dict(a)
    for m,c in b.items():
        out[m]=(out.get(m,0)+scale*c)%P
    return {m:c for m,c in out.items() if c}

def shear(a):
    out={}
    for (i,j),c in a.items():
        for h in range(j+1):
            out=add(out,{(i+j-h,h):c*comb(j,h)})
    return out

def constraints(pair):
    a,b=pair
    neg=lambda f:{(i,j):c*(-1)**j%P for (i,j),c in f.items()}
    zero=lambda f:{(i,j):c for (i,j),c in f.items() if i==0}
    polys=[zero(a),zero(b),add(neg(a),a),add(neg(b),b,-1),
           add(shear(a),a,-1),add(add(shear(b),b,-1),a,-1)]
    return [poly.get(m,0)%P for poly in polys for m in monomials]

columns=[]
for block in range(2):
    for monomial in monomials:
        pair=[{},{}];pair[block]={monomial:1}
        columns.append(constraints(pair))
matrix=[list(row) for row in zip(*columns)]
pivots=[];row=0
for col in range(12):
    selected=next((i for i in range(row,len(matrix)) if matrix[i][col]),None)
    if selected is None:
        continue
    matrix[row],matrix[selected]=matrix[selected],matrix[row]
    inv=pow(matrix[row][col],-1,P)
    matrix[row]=[x*inv%P for x in matrix[row]]
    for i in range(len(matrix)):
        if i!=row and matrix[i][col]:
            c=matrix[i][col]
            matrix[i]=[(x-c*y)%P for x,y in zip(matrix[i],matrix[row])]
    pivots.append(col);row+=1
free=[c for c in range(12) if c not in pivots]
assert free==[7,9],free
assert row==10
for U,V in [(1,0),(2,3),(4,4)]:
    assert all(not x for x in constraints(({}, {(1,0):U,(2,0):V})))
print('PASS: degree<=2 equivariant residuals are exactly (0, a*U+b*U^2).')
print('The actual higher inverse-Cartier quadratic coefficient is NOT computed here.')
