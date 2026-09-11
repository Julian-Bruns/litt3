from math import comb
import numpy as np

q, p, mod = 125, 5, 625
B = np.array([[comb(s, i) % mod if i <= s else 0 for i in range(q)] for s in range(q)], dtype=np.int64)
D = np.array([[((-1)**(i-j)*comb(i,j)) % mod if j<=i else 0 for j in range(q)] for i in range(q)], dtype=np.int64)
assert np.array_equal((D @ B) % mod, np.eye(q,dtype=np.int64))

def add(x,y): return (x+y)%mod
def mul(x,y):
    return np.stack(((x[:,0]*y[:,0]+2*x[:,1]*y[:,1])%mod,
                     (x[:,0]*y[:,1]+x[:,1]*y[:,0])%mod),axis=1)
def phi(x): return np.stack((x[:,0],-x[:,1]),axis=1)%mod
def alpha(x): return np.stack((2*x[:,1],x[:,0]),axis=1)%mod
def shift(x,n=1): return np.roll(x,-n,axis=0)
def e(x): return (shift(x)-x)%mod
def ee(x): return e(e(x))
def M(x):
    # Multiplication by alpha and Phi do not commute: Phi(alpha)=-alpha.
    return (alpha(x)+phi(x)+e(alpha(phi(x)))+2*e(e(phi(x))))%mod
def A(x): return (ee(x)+5*M(x))%mod

def coeffs(x): return (D @ x)%mod

def integ2(x):
    c=coeffs(x)
    assert not np.any(c[123:]), 'Degree too large for this right inverse'
    d=np.zeros_like(c)
    d[2:]=c[:-2]
    return (B@d)%mod

def in_filtration(x, segments):
    c=coeffs(x)
    for i in range(q):
        levels=[v for v,degree in segments if i<=degree]
        divisor=5**min(levels) if levels else mod
        if np.any(c[i] % divisor): return False
    return True

F1=[(1,2),(2,5),(3,8)]
E1=[(1,4),(2,7),(3,10)]
F2=[(2,4),(3,6)]
E2=[(2,6),(3,8)]

def absorb(f, target):
    z=np.zeros_like(f)
    for _ in range(3):
        err=(f-A(z))%mod
        if not np.any(err): break
        z=(z+integ2(err))%mod
    assert np.array_equal(A(z),f)
    assert in_filtration(z,target)
    return z

counts=[]
for FF,EE in [(F1,E1),(F2,E2)]:
    count=0
    for v,degree in FF:
        for j in range(degree+1):
            for basis in [0,1]:
                f=np.zeros((q,2),dtype=np.int64)
                f[:,basis]=5**v*B[:,j]%mod
                assert in_filtration(f,FF)
                absorb(f,EE)
                count+=1
    counts.append(count)

rng=np.random.default_rng(1252026)
def random_poly(degree):
    cs=rng.integers(0,mod,size=(degree+1,2),dtype=np.int64)
    return (B[:,:degree+1]@cs)%mod

def Q2(x): return (mul(M(x),shift(phi(x),3))+alpha(mul(shift(x,7),x)))%mod

def Q3(x): return mul(mul(x,shift(phi(x),2)),alpha(shift(x,5)))

def Q4(x): return mul(mul(x,x),mul(shift(phi(x),4),shift(x,9)))

for _ in range(200):
    y=(random_poly(1)+5*random_poly(4)+25*random_poly(7))%mod
    f=(5*Q2(y)+25*Q3(y)+125*Q4(y))%mod
    assert in_filtration(f,F1)
    absorb(f,E1)
    y=(random_poly(2)+5*random_poly(4))%mod
    f=25*Q2(y)%mod
    assert in_filtration(f,F2)
    absorb(f,E2)

# The supplied pure first carry, interpreted as actual functions.
delta=np.zeros((q,2),dtype=np.int64); delta[-1,0]=1
powers=[delta]
for i in range(124): powers.append(e(powers[-1]))
v0=powers[123]
v1=(powers[23]+2*powers[48]+2*powers[73]+powers[98])%mod
y=(v0+5*v1)%25
cy=coeffs(y)%25
assert not np.any(cy[2:])
# Test full square before extracting the digit 5^4.
g=5*y%125
# Changing a lift of y mod25 can affect g^2 mod625; use the exact affine lift.
y_aff=(B[:,:2]@cy[:2])%mod
sq=25*mul(y_aff,y_aff)%mod
assert not np.any(coeffs(sq)[3:])
print('absorption-generator checks over (Z/625)[alpha]/(alpha^2-2):',counts)
print('nonlinear filtered tests:', 400)
print('pure first repaired function coefficients modulo25:',cy[:2].tolist())
print('combined affine graph square: all binomial coefficients above degree2 vanish')
print('ALL CHECKS PASSED')

# Exhaust the 25 residue coefficients in F25 for the pure third linear carry.
# Coordinates in D are (coefficient of B124, coefficient of B123).
for d0 in range(5):
    for d1 in range(5):
        dc=np.zeros((q,2),dtype=np.int64); dc[:,0]=d0; dc[:,1]=d1
        y=mul(phi(dc),powers[123])
        for digit in (1,2):
            val=ee(y)
            assert not np.any(val % (5**digit))
            residual=(val//(5**digit))%5
            bc=coeffs(residual)%5
            assert not np.any(bc[123:])
            ic=np.zeros_like(bc); ic[2:]=bc[:-2]
            correction=(-(B@ic))%5
            y=(y+(5**digit)*correction)%mod
        val=ee(y)
        assert not np.any(val%125)
        bc=coeffs((val//125)%5)%5
        assert np.array_equal(bc[124],np.array([0,0]))
        assert np.array_equal(bc[123],np.array([-d0,d1])%5)
print('All 25 coefficient-Frobenius tests passed: linear residue = -Phi(d) e')
