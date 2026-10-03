#!/usr/bin/env sage
"""Tiny new universal connection calculation; no global-rank sweep."""
from pathlib import Path
exec(preparse(Path('scripts/oct02_reciprocal_complement_global_jets.sage').read_text().split('rows=[]')[0]))
def connection(g):
    return [zero]+[add(der(g[j]),scale(g[j+1],-(j+1))) if j<4 else der(g[j]) for j in range(1,5)]
k1,k2=direct
v=connection(k2)
def inverse(a):
    den=a[0]**2-F*a[1]**2
    return (a[0]/den,-a[1]/den)
det=add(mul(k1[1],k2[2]),scale(mul(k1[2],k2[1]),-1))
a=mul(add(mul(v[1],k2[2]),scale(mul(v[2],k2[1]),-1)),inverse(det))
b=mul(add(mul(k1[1],v[2]),scale(mul(k1[2],v[1]),-1)),inverse(det))
assert all(v[j]==add(mul(a,k1[j]),mul(b,k2[j])) for j in range(1,5))
assert b==scale(tau,-4)
print('connection K2 = a K1 -4 tau K2; a =',a)
# Search the intrinsic minimal five-pole solution of dr+tau*r=-2s*eta.
R=L['z']; zz=R.gen(); ff=(zz**4-1)*(zz+s**2)
columns=[]
for j in range(6):
    aa=zz**j; bb=R.zero()
    columns.append((aa.derivative()+2*s*zz*bb,2*ff*bb.derivative()+ff.derivative()*bb+4*s*zz*aa))
for j in range(3):
    aa=R.zero(); bb=zz**j
    columns.append((aa.derivative()+2*s*zz*bb,2*ff*bb.derivative()+ff.derivative()*bb+4*s*zz*aa))
mat=matrix(L,[[c[e][j] for c in columns] for e in range(2) for j in range(8)])
rhs=vector(L,[L.zero() if e==0 else (-4*s*(zz**5+s**2))[j] for e in range(2) for j in range(8)])
sol=mat.solve_right(rhs); ker=mat.right_kernel_matrix()
print('r numerator A=',sum(sol[j]*zz**j for j in range(6)))
print('r numerator B=',sum(sol[6+j]*zz**j for j in range(3)))
print('homogeneous dimension=',ker.nrows())
QQ=R.quotient(zz**5+s**2,'aa'); aa=QQ.gen()
vm=-s*(aa**4-1)/aa**2
anum=sum(sol[j]*zz**j for j in range(6)); bnum=sum(sol[6+j]*zz**j for j in range(3))
ahom=sum(ker[0,j]*zz**j for j in range(6)); bhom=sum(ker[0,6+j]*zz**j for j in range(3))
lam=-(QQ(anum)+QQ(bnum)*vm)/(QQ(ahom)+QQ(bhom)*vm)
print('unique homogeneous constant cancelling opposite pole=',lam)
assert lam==QQ(3*s**4)
an=anum+3*s**4*ahom; bn=bnum+3*s**4*bhom
den=zz**5+s**2
assert QQ(an)+QQ(bn)*vm==0
assert QQ(an)-QQ(bn)*vm!=0
norm=an**2-ff*bn**2
assert norm%den==0
print('minimal A=',an,'minimal B=',bn)
print('minimal numerator norm / denominator=',norm//den)
en=zz*an+den; eo=zz*bn
evalnorm=en**2-ff*eo**2
assert evalnorm%den==0
print('M adjunction zero norm degree7=',(evalnorm//den).factor())
for mark,nn in [('O',N0),('finite_form_x',Nx)]:
    print('projection coefficients chart',mark)
    for power in [2,3]:
        print(power,[pair(jpow(nn,power),g) for g in [k1,k2]])
g2=jet(scale(tau,2),scale(tau,2))
print('pairings canonical A2 with N0,Nx=',[pair(nn,g2) for nn in [N0,Nx]])
