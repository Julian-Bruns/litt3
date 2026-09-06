# An ordinary nonsquare indigenous datum becomes nonordinary on an étale degree-four cover

Date: 2026-09-05. Exact finite-field certificate and valuation proof.
Author: `/root/second_double_layer_indigenous_ordinariness_test`.

**Main theorem.** Over an algebraically closed field of characteristic 5,
let t²=2 and X:y²=x⁵−x. The normalized nonsquare quartic datum
s₀=(tx+3x²+3tx³)(dx/y)⁴ is ordinary, but becomes nonordinary on a
connected étale degree-four cover with genus-five source.

An explicit source is the smooth projective normalization of

    Y: v²=u⁸−1,       z²=(u−1)(u−3t).

The map to X that kills s₀ is

    x=u²/(2u²+1),     y=uv/(2u²+1)³.

Indeed let γ be the automorphism (x,y)↦(x/(2x+1),y/(2x+1)³) of X.
Its pullback of s₀ has coefficient

    f=tx+(3+t)x²+2x³+(2+4t)x⁴
     =3t x(2x+1)((1−2t)x−t)².

Under the usual first double T→X, (x,y)=(u²,uv), this becomes
Hρ⁴, with H=f(u²) and ρ=du/v. The anti-deck quadratic differential

    q=(v/z)(u+2+4t)ρ²

is nonzero and regular on Y, and satisfies T_{π*s₀}(q)=0. In the
basis (v/z)ρ², (v/z)uρ² the Cartier block before inverse Frobenius is

    B = [ 3+2t   3+4t ] ,       B [2+4t] = [0].
        [ 1+2t   2+2t ]           [ 1  ]   [0]

The block has rank one. Its determinant is zero by t²=2. The other
anti-deck block is invertible, as is the invariant operator from T;
thus the complete operator on H⁰(Y,ω²) has kernel dimension exactly
one. Explicit checks for this claim are appended below.

The Cartier criterion converts this kernel into failure of indigenous
ordinariness. The cover is connected and étale by the even-branch-subset
construction proved below, and γ is an automorphism, so the displayed
map remains étale of degree four. Riemann–Hurwitz gives g(Y)=5.
This is failure of preservation for one ordinary indigenous datum under
a prime-to-5 étale cover. It is not a common-cover counterexample.

## Why the first search missed this cover

For the original s₀, every one of the 63 doubles of the particular
first double (x,y)=(u²,uv) preserves ordinariness. The killing cover
above uses that same source followed by γ; hence it lies over a
different first-double map to X. Here is the full initial calculation,
which also establishes the block formula used in the main theorem.

Let k be algebraically closed of characteristic 5, choose t²=2, and put

    X: y²=x⁵−x,     η=dx/y,
    s=(tx+3x²+3tx³)η⁴.

The [quartic certificate](SUPERSPECIAL_GENUS_TWO_QUARTIC_DEGREE_FOUR_CERTIFICATE.md)
proves that s is a normalized quartic eigenform, is nonsquare, and has
divisor twice a reduced divisor. The
[inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md)
tests its associated indigenous bundle by T_s(q)=C₁(sq).

**Proposition.** The indigenous datum s is ordinary on X. Its pullback to

    T: v²=u⁸−1,       x=u², y=uv,

is ordinary and stays ordinary on every connected étale double cover of
T. There are exactly 63 such covers up to isomorphism over T. Each
resulting source has genus 5 and maps étale to X with degree 4.

This concerns the specified first double T→X. It does not prove the
corresponding statement for the other fourteen first doubles of X, nor
does it assert stability under arbitrary prime-to-5 étale covers.

## Geometry and Cartier blocks

Write h=u⁸−1 and ρ=du/v. Since η pulls back to 2ρ, s pulls back to
Hρ⁴ with H=tu²+3u⁴+3tu⁶. The cover T→X adjoins a square root of x;
div(x)=2P₀−2P∞ and x is nonsquare, so it is connected and étale.

The eight roots of h lie in F₂₅. Nonzero classes in Pic(T)[2] are
represented by even proper subsets S of these roots, modulo complement.
Choose |S|=2 or 4, taking each size-four subset only once modulo
complement, and set b=∏_{a∈S}(u−a). The resulting cover Y has function
field k(u,v,z), where v²=h and z²=b. Its defining class has even
valuation everywhere on T and is nontrivial, proving connectedness and
étaleness. The counts are 28+35=63.

For |S|=2m, a basis for the anti-deck subspace of H⁰(Y,ω²) is

    α_i=z u^i ρ²,          0≤i≤4−m,
    β_j=(v/z)u^j ρ²,      0≤j≤m.

At finite branch points ρ is a unit differential, and the valuations of
z and v/z are nonnegative. At each point over infinity, ρ has order 2,
z has pole order m, and v/z has pole order 4−m. These give exactly the
displayed degree bounds. The forms are independent, since z and v/z
are independent over k(u). Their total number is 6, the anti-deck
dimension 3g(Y)−3−(3g(T)−3)=12−6.

The identities z/v=(z/v)^5(h/b)² and 1/z=(1/z)^5b² give two
Cartier blocks before coefficientwise inverse Frobenius:

    A[n,i]=[u^(5n+4)] H u^i(h/b)²,     0≤n,i<5−m,
    B[n,j]=[u^(5n+4)] H u^j b²,        0≤n,j<m+1.

Thus the anti-deck operator is invertible exactly when both displayed
matrices are invertible. Inverse Frobenius does not change rank.

On X the corresponding block, before inverse Frobenius, is

    [ 3    t    0  ]
    [ 4t   4    3t ]
    [ 0    3t   3  ].

On T the polynomial part has block

    [ 3    0    t    0    0  ]
    [ 0    0    0    3t   0  ]
    [ 4t   0    4    0    3t ]
    [ 0    t    0    0    0  ]
    [ 0    0    3t   0    3  ],

and the remaining vector vρ² has scalar block 3. These blocks are
invertible. The invariant part on Y is the pullback of the T operator.
The following exact computation proves invertibility on every
anti-deck part and therefore the proposition.

## Reproducible certificate using scalar arithmetic only

The code uses ordinary Python integers to encode a+bt as a+5b. It uses
neither a finite-field matrix backend nor numerical arithmetic. The
determinant is computed directly by the Leibniz formula. Executed with
Python 3; output: `{2: 28, 4: 35}`.

```python
from itertools import combinations, permutations

def add(a,b):
    return (a%5+b%5)%5 + 5*((a//5+b//5)%5)
def neg(a):
    return (-a%5)%5 + 5*((-(a//5))%5)
def mul(a,b):
    x,y=a%5,a//5; z,w=b%5,b//5
    return (x*z+2*y*w)%5 + 5*((x*w+y*z)%5)
def power(a,n):
    r=1
    for _ in range(n): r=mul(r,a)
    return r
def pmul(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): c[i+j]=add(c[i+j],mul(x,y))
    return c
def product_roots(rs):
    p=[1]
    for r in rs: p=pmul(p,[neg(r),1])
    return p
def block(p,d):
    return [[p[5*n+4-i] if 0<=5*n+4-i<len(p) else 0
             for i in range(d)] for n in range(d)]
def det(A):
    d=len(A); r=0
    for p in permutations(range(d)):
        s=1
        for i,j in enumerate(p): s=mul(s,A[i][j])
        if sum(p[i]>p[j] for i in range(d) for j in range(i+1,d))%2:
            s=neg(s)
        r=add(r,s)
    return r

assert all(power(a,25)==a for a in range(25))
roots=[a for a in range(25) if power(a,8)==1]
h=[4,0,0,0,0,0,0,0,1]
assert product_roots(roots)==h
H=[0,0,5,0,3,0,15]
f=[0,5,3,15]; hx=[0,4,0,0,0,1]
assert det(block(pmul(f,pmul(hx,hx)),3))
assert det(block(pmul(H,pmul(h,h)),5)) and H[4]
counts={2:0,4:0}
for size in (2,4):
    for S in combinations(roots,size):
        C=tuple(a for a in roots if a not in S)
        if size==4 and S>C: continue
        m=size//2; b=product_roots(S); c=product_roots(C)
        assert pmul(b,c)==h
        A=block(pmul(H,pmul(c,c)),5-m)
        B=block(pmul(H,pmul(b,b)),m+1)
        assert det(A) and det(B), (S,b,A,B)
        counts[size]+=1
assert counts=={2:28,4:35}
print(counts)
```

## Exact check of the failure

Run after the preceding code, using the same scalar-field functions.
The eigenform equation is independently checked, in addition to its
proof by pullback under γ. Rank of the 4×4 block is checked by its
nonzero determinant. The 2×2 block is nonzero and singular.

```python
f=[0,5,8,2,22]
H=[0]*9
for i,c in enumerate(f): H[2*i]=c
f2=pmul(f,f)
R=pmul(pmul(f2,f2),pmul(hx,hx))
assert [R[5*i+4] for i in range(5)]==[power(c,5) for c in f]
assert det(block(pmul(f,pmul(hx,hx)),3))
assert det(block(pmul(H,pmul(h,h)),5)) and H[4]
b=product_roots([1,15])
c=product_roots([a for a in roots if a not in [1,15]])
assert b==[15,14,1] and pmul(b,c)==h
A=block(pmul(H,pmul(c,c)),4)
B=block(pmul(H,pmul(b,b)),2)
assert A==[[2,23,10,0],[1,2,22,15],[18,18,0,2],[2,12,15,4]]
assert B==[[13,23],[11,12]]
assert det(A) and not det(B) and B[0][0]
assert all(add(mul(row[0],22),row[1])==0 for row in B)
print('Verified: ordinary on X and T; kernel dimension one on Y.')
```
