"""Exact Cartier certificate for the explicit genus-nine curve in the question.

Run with Python 3; no third-party packages are required.

Verifies Q' = P*A^2, computes the C^2 orbit of theta=dx/y^2,
checks its order-four relation, and checks the degree-four and degree-five
polynomials used to prove recognition from proportional theta pullbacks.

Scope: this certifies the stated finite-field calculations. It is NOT a
proof of the unrestricted second-Cartier-line recognition implication.
"""

# Exact arithmetic in F_25 = F_5[a]/(a^2-a-3).
def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return (-a%5)%5+5*((-(a//5))%5)
def sub(a,b): return add(a,neg(b))
def mul(a,b):
    a0,a1=a%5,a//5; b0,b1=b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
def power(a,n):
    r=1
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n//=2
    return r
def inv(a):
    assert a
    return power(a,23)
def trim(a):
    while len(a)>1 and not a[-1]:a.pop()
    return a
def padd(a,b):return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def pscale(a,c):return trim([mul(v,c) for v in a])
def pmul(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,u in enumerate(a):
        for j,v in enumerate(b):c[i+j]=add(c[i+j],mul(u,v))
    return trim(c)
def ppow(a,n):
    r=[1]
    while n:
        if n&1:r=pmul(r,a)
        a=pmul(a,a);n//=2
    return r
def deriv(a):return trim([mul(i%5,a[i]) for i in range(1,len(a))])
def cartier_poly(a):return [power(a[i],5) for i in range(4,len(a),5)] or [0]
def matvec(m,v):
    return [sumgf([mul(a,b) for a,b in zip(row,v)]) for row in m]
def sumgf(vals):
    r=0
    for v in vals:r=add(r,v)
    return r
def solve(M,b):
    a=[row[:]+[bb] for row,bb in zip(M,b)]
    m,n=len(M),len(M[0]);r=0;piv=[]
    for j in range(n):
        ii=next((i for i in range(r,m) if a[i][j]),None)
        if ii is None:continue
        a[r],a[ii]=a[ii],a[r]
        a[r]=[mul(v,inv(a[r][j])) for v in a[r]]
        for i in range(m):
            if i!=r and a[i][j]:
                c=a[i][j]
                a[i]=[sub(u,mul(c,v)) for u,v in zip(a[i],a[r])]
        piv.append(j);r+=1
    if any(all(not u for u in row[:n]) and row[n] for row in a):return None
    x=[0]*n
    for i,j in enumerate(piv):x[j]=a[i][-1]
    return x,piv,a
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
assert deriv(Q)==pmul(P,ppow(A,2))
# C(b dx/y^2) = C(b P dx)/y; C(c dx/y) = C(c P^3 dx)/y^2.
def C2(b):return cartier_poly(pmul(cartier_poly(pmul(b,P)),ppow(P,3)))
cols=[C2([0]*i+[1])+[0]*6 for i in range(6)]
M=[[cols[j][i] for j in range(6)] for i in range(6)]
print('C2 matrix rows:',M)
v=[[1,0,0,0,0,0]]
for i in range(4):v.append(matvec(M,v[-1]))
print('iterates e0:',v)
rel=solve([[v[j][i] for j in range(4)] for i in range(6)],v[4]);print('relation M4e0 = sum coeff Mje0:',rel[0], 'piv',rel[1])
# Find degrees available in span M e0, M2 e0, M3 e0.
rr=solve([list(reversed(vv)) for vv in v[1:4]],[0]*3)
print('rowreduce reversed stable vectors:',rr)
q5=[10,11,24,0,0,1]
q4=[6,23,14,0,1,0]
q3=[18,15,1,1,0,0]
for name,q in [('q5',q5),('q4',q4),('q3',q3)]:
    ans=solve([[v[j][i] for j in range(1,4)] for i in range(6)],q)
    assert ans is not None
    coefficients=ans[0]
    assert matvec([[v[j][i] for j in range(1,4)] for i in range(6)],coefficients)==q
    print(name,'=',q, '; coefficients in (C2,C4,C6):',coefficients)
assert rel[0]==[0,13,24,10] and len(rel[1])==4
assert len(rr[1])==3
print('All asserted finite-field identities passed.')
