"""Linear horizontal-product reduction for the 42 hyperelliptic survivors.

This is a necessary-system diagnostic, not an exclusion or a census.
One representative of the already complete five-cycle of dormant opers.
"""
import time

started=time.monotonic()
k=GF(125,'alpha',modulus=PolynomialRing(GF(5),'z')([1,1,0,1]))
alpha=k.gen()
Z=PolynomialRing(k,'z'); z=Z.gen()
sep=z**5+(alpha+1)*z**4+(2*alpha**2-2)*z**3-2*alpha**2*z**2+(-2*alpha**2+alpha+1)*z+2*alpha**2+2*alpha-2
assert sep.is_irreducible()
K=k.extension(sep,'beta'); beta=K.gen()
U=PolynomialRing(K,'u'); u=U.gen()
F=prod(u-K(t) for t in [0,1,2,3,alpha])
b2=beta
b1=b2**2+3*F[4]*b2+3*F[3]
b0=-F[2]+(F[4]+2*b2)*b1
P=2*u**3+b2*u**2+b1*u+b0
r=(4*F*F.derivative(2)+2*F.derivative()**2+P*F)/F**2
assert r.derivative(2)-3*r**2==0

def horizontal(H):
    return F*H.derivative(2)+4*F.derivative()*H.derivative()+(3*F.derivative(2)-P)*H

cols=[horizontal(u**i) for i in range(25)]
M=matrix(K,max(c.degree() for c in cols)+1,25,
         lambda i,j:cols[j][i],implementation='generic')
ker=M.right_kernel()
basis=[sum(v[i]*u**i for i in range(25)) for v in ker.basis()]
assert all(horizontal(H)==0 for H in basis)
print('HORIZONTAL_PRODUCT_MATRIX',M.nrows(),M.ncols(),'rank',M.rank(),flush=True)
print('KERNEL_DIMENSION',len(basis),'degrees',[H.degree() for H in basis],flush=True)
for H in sorted(basis,key=lambda H:H.degree()):
    print('HORIZONTAL_BASIS',H,flush=True)
print('TOTAL_SECONDS',round(time.monotonic()-started,3),flush=True)
