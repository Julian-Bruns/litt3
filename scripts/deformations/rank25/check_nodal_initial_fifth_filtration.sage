"""Small exact integral filtration checks for the next nodal fifth step.

These universal regular-module checks are not a higher-Cartier comparison.
The multiplication is POINTWISE in Fun(C5^2,Z/25), not group multiplication.
"""
from sage.all import ZZ, QQ, GF, matrix, identity_matrix, vector
from itertools import product

G=list(product(range(5),repeat=2)); at={g:i for i,g in enumerate(G)}
I=identity_matrix(ZZ,25)
e=[]
for axis in range(2):
    S=matrix(ZZ,25,25)
    for i,g in enumerate(G):
        h=list(g);h[axis]=(h[axis]+1)%5
        S[i,at[tuple(h)]]=1
    e.append(S-I)

def augmentation(r):
    return block_columns([e[0]**j*e[1]**(r-j) for j in range(r+1)])

def block_columns(blocks):
    out=matrix(ZZ,25,0)
    for B in blocks:out=out.augment(B)
    return out

def lattice_basis(C):
    H=C.transpose().hermite_form()
    return matrix(ZZ,[row for row in H.rows() if row]).transpose()

C={r:augmentation(r) for r in (2,3,4,5,6,7,9)}
source=lattice_basis(C[7].augment(25*I))
target=lattice_basis(C[6].augment(5*C[2]).augment(25*I))
target_inv=target.change_ring(QQ).inverse()
for a in source.columns():
    for b in source.columns():
        z=target_inv*vector(ZZ,[x*y for x,y in zip(a,b)])
        assert all(c in ZZ for c in z)
print('PASS: (I^7 Fun)^2 subset I^6 Fun +5 I^2 Fun mod25;625 lattice pairs')

for r in (6,7,9):
    H=lattice_basis(C[r].augment(25*I))
    H5=H.change_ring(GF(5));ker=H5.right_kernel().basis()
    colon=[]
    for a in ker:
        numerator=H*vector(ZZ,[ZZ(c) for c in a])
        assert all(x%5==0 for x in numerator)
        colon.append(vector(GF(5),[x//5 for x in numerator]))
    colon.extend(H5.columns())
    image=C[r-4].change_ring(GF(5)).column_space()
    assert all(v in image for v in colon)
    print('PASS: ((I^%d Fun intersect5 Fun)/5) mod5 subset I^%d Fun'%(r,r-4))

# Explicit second residue on the three-dimensional F1 leading slice.
# Use U=e1+a*e2,V=e1-a*e2 over unramified F25, a^2=2.
from sage.all import PolynomialRing, NumberField
P=PolynomialRing(QQ,'a');a=P.gen();K=NumberField(a*a-2,'a');a=K.gen()
U=e[0].change_ring(K)+a*e[1];V=e[0].change_ring(K)-a*e[1]
F=U*V
R=PolynomialRing(GF(5),'t');t=R.gen()
k=GF(25,'t',modulus=t*t-2);aa=k.gen()
red=lambda x:k([GF(5)(c) for c in x.list()])
res=lambda Z:matrix(k,Z.nrows(),Z.ncols(),[red(c) for c in Z.list()],implementation='generic')
base=vector(K,25);base[0]=1
target_low=matrix(k,C[2].nrows(),C[2].ncols(),C[2].list(),implementation='generic').column_space()
vectors=[]
for X in (U**4*V**3,U**3*V**4,U**4*V**4):
    x0=X*base;v0=F*x0
    assert all(c/5 in K and all(ZZ(z.denominator())%5 for z in (c/5).list()) for c in v0)
    rhs=-vector(k,[red(c/5) for c in v0])
    x1=res(F).solve_right(rhs)
    lift=vector(K,[sum(QQ(ZZ(c))*a**i for i,c in enumerate(z.polynomial().list())) for z in x1])
    v=F*(x0+5*lift)/25
    assert all(all(ZZ(z.denominator())%5 for z in c.list()) for c in v)
    vectors.append(vector(k,[red(c) for c in v]))
joined=matrix(k,target_low.basis()+vectors[:2],implementation='generic').rank()
assert joined==target_low.dimension()+2
assert vectors[2] in target_low
print('PASS: second linear residue gives two independent classes mod I^2; invariant digit gives zero')
