"""Largest Cartier-fixed differential space with a double zero at O."""
import json
import sys
from pathlib import Path
F5=GF(5); R0=PolynomialRing(F5,'b'); bb=R0.gen()
F=GF(25,'beta',modulus=bb**2-bb-3); beta=F.gen()
def dec(a):return F(a%5)+F(a//5)*beta
R=PolynomialRing(F,'x'); x=R.gen()
P=R([dec(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
A=R([dec(a) for a in (1,21,14,22,13)])
basis=[(i,j) for j in range(3) for i in range(10) if 3*i+10*j<=29]
assert len(basis)==21
index={a:i for i,a in enumerate(basis)}
M=matrix(F,21,21)
for col,(i,j) in enumerate(basis):
    H=x**i*A**4
    if j==0:H*=P; outj=1
    elif j==1:H*=P**3;outj=0
    else:outj=2
    for degree in range(4,int(H.degree())+1,5):
        target=((degree-4)//5,outj)
        c=H[degree]**5
        if c:
            assert target in index
            M[index[target],col]=c
mode=sys.argv[2] if len(sys.argv)>2 else 'double_zero'
if mode=='no_constant_term':
    forbidden=[index[(6,1)]]
else:
    forbidden=[i for i,(a,b) in enumerate(basis) if 3*a+10*b>26]
L=matrix(F,[[(1 if t==i else 0) for t in range(21)] for i in forbidden])
nullities=[]
stack=matrix(F,0,21)
for stage in range(22):
    stack=stack.stack(L)
    nullities.append(21-int(stack.rank()))
    newL=(L*M).apply_map(lambda c:c**5)
    if stack.stack(newL).rank()==stack.rank():break
    L=newL
ker=stack.right_kernel().basis_matrix()
K=ker.transpose()
N=M.apply_map(lambda c:c**5)
K5=K.apply_map(lambda c:c**5)
induced=K5.solve_right(N*K)
assert K5*induced==N*K
product=induced
unitranks=[]
for i in range(22):
    unitranks.append(int(product.rank()))
    new=product.apply_map(lambda c:c**5)*induced
    if new.rank()==product.rank():break
    product=new

# Rational differentials U(x) dx/A(x) are represented by y^2 U/A theta.
# A double zero at O means degree(U)<=2.
expected=matrix(F,[[(1 if ij==(i,2) else 0) for ij in basis]
                   for i in range(4 if mode=='no_constant_term' else 3)])
contained=all(v in ker.row_space() for v in expected.rows())
same=contained and ker.nrows()==expected.nrows()
image_same=(N*K).column_space()==expected.transpose().column_space()
assert image_same
result={'mode':mode,'basis':basis,'constraint_nullities':nullities,'stable_kernel_dimension':ker.nrows(),
        'unit_ranks':unitranks,'rational_log_space_contained':contained,
        'stable_kernel_is_rational_log_space':same,
        'image_is_rational_log_space':image_same,
        'Cartier_matrix':[[int(c[0])+5*int(c[1]) for c in row] for row in M.rows()],
        'kernel':[[int(c[0])+5*int(c[1]) for c in row] for row in ker.rows()]}
if len(sys.argv)>1:Path(sys.argv[1]).write_text(json.dumps(result,indent=2,default=int)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ('basis','Cartier_matrix','kernel')},indent=2,default=int))
