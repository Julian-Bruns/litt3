"""Exact certificate for the twisted-adjunction obstruction on X.

Run with Python 3. No third-party packages are required.

Field codes n0+5*n1 denote n0+n1*a, where a*a=a+3.
All polynomial coefficient lists are ascending.

This verifies a base-curve interpolation obstruction. It is NOT a
certificate of emptiness for arbitrary non-descending divisors on
finite etale covers.
"""

p=5
add=lambda x,y: ((x%5+y%5)%5)+5*((x//5+y//5)%5)
neg=lambda x: ((-x%5)%5)+5*((-(x//5))%5)
def mul(x,y):
    a,b=x%5,x//5;c,d=y%5,y//5
    return (a*c+3*b*d)%5+5*((a*d+b*c+b*d)%5)
def powf(x,n):
    a=1
    while n:
        if n&1:a=mul(a,x)
        x=mul(x,x);n//=2
    return a
def inv(x):
    assert x
    return powf(x,23)
def tr(a):
    a=list(a)
    while len(a)>1 and a[-1]==0:a.pop()
    return a
def pa(a,b):
    return tr([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def pn(a):return [neg(x) for x in a]
def ps(a,b):return pa(a,pn(b))
def pm(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=add(c[i+j],mul(x,y))
    return tr(c)
def pp(a,n):
    r=[1]
    while n:
        if n&1:r=pm(r,a)
        a=pm(a,a);n//=2
    return r
def pd(a):return tr([mul(i%5,a[i]) for i in range(1,len(a))] or [0])
def pe(a,x):
    r=0
    for c in reversed(a):r=add(mul(r,x),c)
    return r
def pdiv(a,b):
    a=tr(a);b=tr(b);q=[0]*max(1,len(a)-len(b)+1)
    while a!=[0] and len(a)>=len(b):
        j=len(a)-len(b);c=mul(a[-1],inv(b[-1]));q[j]=c
        a=ps(a,[0]*j+[mul(c,v) for v in b])
    return tr(q),a
def pgcd(a,b):
    while b!=[0]:a,b=b,pdiv(a,b)[1]
    return [mul(c,inv(a[-1])) for c in a]
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
def solve(M,b):
    m,n=len(M),len(M[0]);T=[list(M[i])+[b[i]] for i in range(m)];ps=[];r=0
    for j in range(n):
        i=next((i for i in range(r,m) if T[i][j]),None)
        if i is None:continue
        T[r],T[i]=T[i],T[r];z=inv(T[r][j]);T[r]=[mul(z,a) for a in T[r]]
        for i in range(m):
            if i!=r and T[i][j]:
                z=T[i][j];T[i]=[add(a,neg(mul(z,b))) for a,b in zip(T[i],T[r])]
        ps.append(j);r+=1
        if r==m:break
    for i in range(r,m):
        if T[i][-1]:return None
    ans=[0]*n
    for i,j in enumerate(ps):ans[j]=T[i][-1]
    return ans


# Obtain the unique B of degree <10 for which B^5 = -Q modulo P.
columns = []
for i in range(10):
    column = pdiv([0] * (5 * i) + [1], P)[1]
    columns.append(column + [0] * (10 - len(column)))
matrix = [list(row) for row in zip(*columns)]
rhs = pdiv([neg(c) for c in Q], P)[1]
rhs += [0] * (10 - len(rhs))
b5 = solve(matrix, rhs)
assert b5 is not None
B = [powf(c, 5) for c in b5]  # inverse of fifth-power Frobenius on F_25
assert B == [22, 16, 11, 3, 15, 11, 2, 6, 12, 14]
assert pdiv(pa(pp(B, 5), Q), P)[1] == [0]
assert pd(Q) == pm(P, pp(A, 2))
assert pgcd(P, pd(P)) == [1]
assert pgcd(P, A) == [1]

# If deg U <=4 and B-U vanishes at nine roots of P, the missing root r
# must satisfy B-U=B_9*P/(x-r). Comparison of x^8 forces r below.
r = add(mul(B[8], inv(B[9])), neg(P[9]))
assert r == 18
assert pe(P, r) == 12  # Nonzero, so this cannot be a root of P.

print('Q_prime_equals_P_A_squared = True')
print('P_squarefree = True')
print('P_and_A_coprime = True')
print('B =', B)
print('(B^5+Q) mod P =', pdiv(pa(pp(B, 5), Q), P)[1])
print('forced_missing_root_code =', r)
print('P_at_forced_root_code =', pe(P, r))
print('certificate = PASS')
