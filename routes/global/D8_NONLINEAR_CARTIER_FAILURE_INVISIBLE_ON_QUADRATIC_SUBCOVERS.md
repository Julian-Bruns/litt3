# A nonlinear D8 Cartier obstruction invisible on every quadratic subcover

Author exact scalar certificates and valuation/representation proofs,
2026-09-05; consolidated2026-09-07. No separate audit claimed.
The degree-four witness is also an input to the separately scoped
[seventy-object destruction theorem](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md).

## 1. Exact statements and actual covers

Over algebraically closed k of characteristic5, take t²=2 and put

    X:y²=x⁵−x, η=dx/y, A₀=(tx+3x²+3tx³)η⁴,
    γ(x,y)=(x/(2x+1),y/(2x+1)³),
    A=γ^*A₀=fη⁴,
    f=tx+(3+t)x²+2x³+(2+4t)x⁴
     =3tx(2x+1)((1−2t)x−t)².

The [quartic certificate](SUPERSPECIAL_GENUS_TWO_QUARTIC_DEGREE_FOUR_CERTIFICATE.md)
gives A₀'s normalization, nonsquareness and twice-reduced zero divisor;
automorphism pullback preserves these. Both A₀ and A are ordinary under
T_A(q)=C₁(Aq), by the scalar certificate below and the
[inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md).

Two DISTINCT facts hold.

* Every connected etale double of X preserves A; so does their maximal
  elementary-abelian degree16 cover. Nevertheless the connected degree4
  cover Y below makes A nonordinary, with kernel dimension1. Its Galois
  closure W/X has group D8 and kernel the standard2-dimensional module.
* A₀ stays ordinary on the specified first double T→X and on ALL63
  connected etale doubles of T. The killing map for A₀ uses that same
  first-double source followed by γ. Thus this positive finite test
  does not reach every degree4 cover of X.

Write h=u⁸−1, ρ=du/v, and take smooth projective normalizations of

    T:v²=h,                   T→X:(x,y)=(u²,uv),
    Y:v²=h, z²=b₊,            b₊=(u−1)(u−3t).

The first double is the nonzero branch-pair class{0,∞} in Pic(X)[2],
since div(x)=2P₀−2P∞. The second is the nonzero even subset{1,3t}
of the eight branch points of T. Its squareclass has even valuations
everywhere and is nontrivial. Both maps are connected etale;
g(T)=3, g(Y)=5. The actual degree4 map killing A₀ is

    x=u²/(2u²+1), y=uv/(2u²+1)³.

On Y the regular nonzero quadratic

    q=(v/z)(u+2+4t)ρ²

satisfies T_(A|Y)(q)=0, or equivalently the pulled-back A₀ equation
for the last map. This is not a common-cover obstruction.

## 2. Shared double-cover calculus

For F=a+bx+cx²+dx³+ex⁴, the pullback of Fη⁴ to T is F(u²)ρ⁴,
since η pulls back to2ρ. The new quadratic subspace has basis
uρ²,u³ρ²,vρ². Before coefficientwise inverse Frobenius its blocks are

    M(F)=[e−2a  d; b  a−2e],  c,
    det M=3(a²+e²)−bd.                                      (1)

For the first two vectors, extract u^(5n+4) coefficients in
F(u²)u^i h². For the last use ρ C(F(u²)du). Valuations at finite
branch points and infinity prove regularity and these three forms
give the full new part. Thus this double is good iff its base is
good and c det M≠0.

Every GL₂(F₅) matrix g=(α,β;γ,δ) lifts to an automorphism of X,
with y-coordinate λy/(γx+δ)³, λ²=det g. Its transformed quartic is

    F^g=(det g)² Σ_i F_i(αx+β)^i(γx+δ)^(4−i).               (2)

The branch pair{g(0),g(∞)} identifies its tested double. Formulae
(1)–(2) below test all15 pairs and all matrix representatives.

For a connected double of T, let S be an even proper branch subset,
modulo complement; choose |S|=2m=2 or4 and put b=∏_(a∈S)(u−a).
On v²=h,z²=b the anti-deck quadratics have basis

    z u^iρ² (0≤i≤4−m),   (v/z)u^jρ² (0≤j≤m).

At infinity ord(ρ)=2, ord(z)=−m, ord(v/z)=m−4; at finite branch
points all these factors have nonnegative order. The six independent
forms equal the dimension12−6. Identities
z/v=(z/v)^5(h/b)² and1/z=(1/z)^5b² give the coefficient blocks

    B_H(P,d)[n,i]=[u^(5n+4−i)]H P², 0≤n,i<d,
    A_block=B_H(h/b,5−m),   B_block=B_H(b,m+1).              (3)

For H=f(u²), b=b₊, these are

    A_block=[2     3+4t  2t    0;
             1     2     2+4t  3t;
             3+3t  3+3t  0     2;
             2     2+2t  3t    4],   det=1,
    B_block=[3+2t  3+4t; 1+2t  2+2t], rank=1,
    B_block*(2+4t,1)^T=0.                                 (4)

The base X and T operators are invertible. Hence(4) proves the
one-dimensional Y kernel, including the displayed regular vector.

## 3. Scalar-only replay of both positive tests and the failure

Python3 encodes a+bt by a+5b. Determinants use the Leibniz formula,
not an extension-field matrix backend. The test covers all63 doubles
of the SPECIFIED T map for A₀, all15 doubles of X for A, and(4).

```python
from itertools import combinations, permutations, product
def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return (-a%5)%5+5*((-(a//5))%5)
def mul(a,b):
    return (a%5*(b%5)+2*(a//5)*(b//5))%5+5*((a%5*(b//5)+(a//5)*(b%5))%5)
def power(a,n):
    r=1
    for _ in range(n): r=mul(r,a)
    return r
def pmul(a,b):
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]=add(r[i+j],mul(x,y))
    return r
def ppow(a,n):
    r=[1]
    for _ in range(n): r=pmul(r,a)
    return r
def proots(rs):
    r=[1]
    for a in rs: r=pmul(r,[neg(a),1])
    return r
def block(p,d):
    return [[p[5*n+4-i] if 0<=5*n+4-i<len(p) else 0
             for i in range(d)] for n in range(d)]
def det(A):
    n=len(A); r=0
    for p in permutations(range(n)):
        s=1
        for i,j in enumerate(p): s=mul(s,A[i][j])
        if sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))%2: s=neg(s)
        r=add(r,s)
    return r
assert all(power(a,25)==a for a in range(25))
roots=[a for a in range(25) if power(a,8)==1]
h=[4,0,0,0,0,0,0,0,1]; hx=[0,4,0,0,0,1]
assert proots(roots)==h
H=[0,0,5,0,3,0,15]; f0=[0,5,3,15]
assert det(block(pmul(f0,ppow(hx,2)),3))
assert det(block(pmul(H,ppow(h,2)),5)) and H[4]
counts={2:0,4:0}
for size in counts:
    for S in combinations(roots,size):
        C=tuple(a for a in roots if a not in S)
        if size==4 and S>C: continue
        m=size//2; b=proots(S); c=proots(C)
        assert pmul(b,c)==h
        assert det(block(pmul(H,ppow(c,2)),5-m))
        assert det(block(pmul(H,ppow(b,2)),m+1))
        counts[size]+=1
assert counts=={2:28,4:35}
f=[0,5,8,2,22]; H=[0]*9
for i,c in enumerate(f): H[2*i]=c
R=pmul(ppow(f,4),ppow(hx,2))
assert [R[5*i+4] for i in range(5)]==[power(c,5) for c in f]
assert det(block(pmul(f,ppow(hx,2)),3))==3
assert det(block(pmul(H,ppow(h,2)),5)) and H[4]
b=proots([1,15]); c=proots([a for a in roots if a not in [1,15]])
assert b==[15,14,1] and pmul(b,c)==h
A=block(pmul(H,ppow(c,2)),4); B=block(pmul(H,ppow(b,2)),2)
assert A==[[2,23,10,0],[1,2,22,15],[18,18,0,2],[2,12,15,4]]
assert B==[[13,23],[11,12]] and det(A)==1 and not det(B) and B[0][0]
assert all(add(mul(row[0],22),row[1])==0 for row in B)
pairs={}
for a,b,c,d in product(range(5),repeat=4):
    D=(a*d-b*c)%5
    if not D: continue
    pair=tuple(sorted([b*pow(d,-1,5)%5 if d else 5,
                       a*pow(c,-1,5)%5 if c else 5]))
    F=[0]*5
    for i,fi in enumerate(f):
        p=pmul(ppow([b,a],i),ppow([d,c],4-i))
        for j,v in enumerate(p): F[j]=add(F[j],mul(mul(D*D%5,fi),v))
    aa,bb,cc,dd,ee=F
    determinant=add(mul(3,add(mul(aa,aa),mul(ee,ee))),neg(mul(bb,dd)))
    good=bool(cc and determinant)
    if pair in pairs: assert pairs[pair]==good
    pairs[pair]=good
assert len(pairs)==15 and all(pairs.values())
print("63 specified second doubles good; all15 first doubles good; degree4 kernel1.")
```

## 4. Actual D8 closure and its nonlinear coefficient factor

Adjoin z′²=b₋=(u+1)(u+3t) to Y. The disjoint supports of b₊,b₋
show that b₊,b₋,b₊b₋ are nonsquares in k(u,v): a rational r(u)
is a square there iff r or r/h is a square in k(u), and each
alternative has an odd branch-root valuation. Thus W/T has degree4;
each double is etale by the preceding valuations.

Let a negate z, b negate z′, and σ:(u,v,z,z′)↦(−u,−v,z′,z).
Then σ²=1, σaσ=b and G=(C₂×C₂)⋊C₂=D8. The subgroup fixing Y
is H=⟨b⟩, whose conjugate⟨a⟩ intersects it trivially. So W is
the Galois closure of the NON-Galois Y/X. Its three quadratic
characters adjoin u,zz′,uzz′, with squares

    x, (x−1)(x−3), x(x−1)(x−3)∼(x−2)(x−4),

the branch pairs{0,∞},{1,3},{2,4}. All pass Section3.

F₅[D8] is split semisimple: four sign characters and one simple S
of dimension2, with a=diag(−1,1),b=diag(1,−1),σ swapping coordinates.
By the [exact coefficient criterion](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md),
all sign coefficient operators are good. F₅[G/H] contains S once,
since dim S^H=1, and two good signs. Thus the coefficient kernel
for S has dimension1. The regular representation contains S twice;
the compatible F₅ isotypic decomposition makes ker(T on W)≅S_k,
of dimension2, not merely a dimension count.

All15 sign tests also make the maximal(C₂)^4 cover good. Nonetheless
the nonlinear D8 factor fails. Neither quadratic tests nor this whole
abelian cover test detect it; changing the first double matters.
No statement excludes another ordinary datum upstairs or an unmarked
common cover. For the separate failure of good common refinements,
see the [destruction note, Section4](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md).
