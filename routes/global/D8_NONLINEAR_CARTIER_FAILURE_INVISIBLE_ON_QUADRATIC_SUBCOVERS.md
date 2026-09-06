# A nonlinear D8 Cartier obstruction invisible on all quadratic subcovers

Date: 2026-09-05. Exact scalar arithmetic and direct proof.

Work over an algebraically closed field k of characteristic 5, with
t²=2. Put X:y²=x⁵−x, η=dx/y, and

    A=fη⁴,   f=tx+(3+t)x²+2x³+(2+4t)x⁴.

**Proposition.** The connected étale degree-four cover

    Y: u²=x,  v=y/u,  v²=u⁸−1,  z²=(u−1)(u−3t)

has Galois closure W/X with group D8 of order eight. All three
quadratic intermediate covers of W/X preserve the ordinariness of A.
Nevertheless its unique nonlinear simple F₅[D8]-module is bad for
T_A=C₁(A·). The kernel on W is two-dimensional and, as a k[D8]-module,
is the standard irreducible representation. The coefficient operator
for that simple module has a one-dimensional kernel.

Here ordinariness means the indigenous ordinariness detected by T_A.
The eigenform and divisor hypotheses for this particular A, and the
one-dimensional kernel on Y, are established in the
[degree-four witness](ORDINARY_NONSQUARE_INDIGENOUS_DATUM_FAILS_ON_ETALE_DEGREE_FOUR_COVER.md).
The simple-factor interpretation uses the
[twisted Cartier criterion](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md).

## The Galois closure and its quadratic fields

Let T have function field k(u,v), v²=h=u⁸−1. Write
b₊=(u−1)(u−3t), b₋=(u+1)(u+3t), and set

    k(W)=k(u,v,z,z′),   z²=b₊,   z′²=b₋.

The eight roots of h are distinct. The supports {1,3t}, {−1,−3t}
are disjoint. Neither b₊, b₋, nor b₊b₋ is a square in k(u,v): an
element r of k(u) is a square in this quadratic extension precisely
when r or r/h is a square in k(u). For each of these three products,
both alternatives have an odd valuation at a root of h. This proves
independence of the two Kummer classes and [W:T]=4. Each b has even
valuations on T: order two at its two branch points and pole order
two at each infinity. Hence these connected quadratic covers are
étale. Together with the connected étale double T/X, this makes W/X
connected étale of degree eight.

Let a negate z, let b negate z′, and let σ send

    (u,v,z,z′) ↦ (−u,−v,z′,z).

These are automorphisms over X, a and b commute, and σ²=1,
σaσ=b. Thus G=(C₂×C₂)⋊C₂≅D8. The subgroup fixing Y is H=⟨b⟩.
Its conjugate ⟨a⟩ intersects it trivially; H has trivial core.
Consequently W is the Galois closure and Y/X is non-Galois.

There are exactly three nontrivial characters G→{±1}. Their fields
are obtained by adjoining u, zz′, and uzz′ to k(X), respectively.
Their squares are

    x,   (x−1)(x−3),   x(x−1)(x−3).

The last squareclass equals (x−2)(x−4), since
y²=x(x−1)(x−2)(x−3)(x−4). Thus the three branch-pair descriptions
are {0,∞}, {1,3}, {2,4}.

## All three quadratic tests pass

For a quartic F=a+bx+cx²+dx³+ex⁴ on X, the new part of T on the
double associated to {0,∞} has scalar c and matrix, before applying
coefficientwise inverse Frobenius,

    M(F) = [ e−2a    d   ],   det M=3(a²+e²)−bd.
           [  b     a−2e ]

Indeed with ρ=du/v the new quadratic differentials have basis
uρ²,u³ρ²,vρ². Extracting the coefficients of u^(5n+4) in
F(u²)u^i(u⁸−1)² gives M on the first two; the last has scalar c.
The remaining three dimensions are pulled back from X.

The Möbius matrices I, (3,1;1,1), (4,2;1,1) send {0,∞} to the
three pairs above. For g=(α,β;γ,δ) over F₅, the corresponding
automorphism of X has y-coordinate λy/(γx+δ)³, λ²=det g.
Its pullback transforms F into

    (det g)² Σ_i f_i(αx+β)^i(γx+δ)^(4−i).

For our f the resulting coefficients and tests are:

| Pair | Coefficients in increasing degree | c | det M |
|---|---|---|---|
| {0,∞} | 0, t, t+3, 2, 4t+2 | t+3 | t+3 |
| {1,3} | 4t+3, 3t+2, 4, 4t+4, 4t+2 | 4 | 4 |
| {2,4} | 0, 4t, 4t+3, 2, t+2 | 4t+3 | 4t+3 |

All entries in the last two columns are nonzero. The operator on X
is invertible (its coefficient matrix has determinant 3). Pullback by
an automorphism preserves this property, so the three doubles are
ordinary.

In fact **all fifteen connected étale doubles of X preserve A**.
For a genus-two hyperelliptic curve these are precisely the fifteen
unordered branch pairs among F₅∪{∞}. The following additional bounded
certificate checks them all, including consistency across all matrix
representatives. It uses only scalar arithmetic as above.

```python
from itertools import product
def add(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def neg(a): return (-a%5)%5+5*((-(a//5))%5)
def mul(a,b):
    return (a%5*(b%5)+2*(a//5)*(b//5))%5+5*((a%5*(b//5)+(a//5)*(b%5))%5)
def pmul(a,b):
    r=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]=add(r[i+j],mul(x,y))
    return r
def ppow(a,n):
    r=[1]
    for _ in range(n): r=pmul(r,a)
    return r
f=[0,5,8,2,22]; pairs={}
for a,b,c,d in product(range(5),repeat=4):
    D=(a*d-b*c)%5
    if not D: continue
    im0=b*pow(d,-1,5)%5 if d else 5
    iminf=a*pow(c,-1,5)%5 if c else 5  # 5 denotes infinity
    pair=tuple(sorted([im0,iminf])); F=[0]*5
    for i,fi in enumerate(f):
        p=pmul(ppow([b,a],i),ppow([d,c],4-i))
        for j,v in enumerate(p): F[j]=add(F[j],mul(mul(D*D%5,fi),v))
    aa,bb,cc,dd,ee=F
    determinant=add(mul(3,add(mul(aa,aa),mul(ee,ee))),neg(mul(bb,dd)))
    good=bool(cc and determinant)
    if pair in pairs: assert pairs[pair]==good
    pairs[pair]=good
assert len(pairs)==15 and all(pairs.values())
print('All 15 double covers preserve A.')
```

For completeness, the scalar computations were independently rerun
using Python integers a+5b to represent a+bt. Addition is componentwise
modulo 5 and multiplication is (a,b)(c,d)=(ac+2bd,ad+bc). Polynomial
convolution, coefficient extraction, and the Leibniz determinant
formula give exactly the table. No extension-field matrix backend
is used. They also independently give the Y blocks

    A₄ = [ 2      3+4t    2t      0  ]
         [ 1      2       2+4t    3t ]
         [ 3+3t   3+3t    0       2  ]
         [ 2      2+2t    3t      4  ],      det A₄=1,

    B₂ = [ 3+2t   3+4t ],                 det B₂=0,
         [ 1+2t   2+2t ]                  rank B₂=1.

These are extracted from f(u²)(h/b₊)² and f(u²)b₊², respectively,
by the block rule D[n,i]=[u^(5n+4−i)]P. Since T is ordinary,
the invariant part contributes no kernel and dim ker T on Y is one.

## The obstruction is the nonlinear simple factor

The algebra F₅[D8] is split semisimple: its simple modules are the
four one-dimensional sign characters and one absolutely simple
two-dimensional module S. One model for S has

    a=diag(−1,1),  b=diag(1,−1),  σ=[0 1;1 0].

The ordinary base and the three ordinary quadratic subcovers imply
that all four one-dimensional coefficient operators are bijective.
The sheet module F₅[G/H] contains S with multiplicity dim S^H=1;
its other constituents are the two characters trivial on H. The
direct-sum coefficient construction therefore identifies its kernel
dimension with dim ker T_(A,S). The calculation on Y makes this one.

The regular representation contains each character once and S twice.
Thus dim ker T on W is two. More precisely, the standard isotypic
decomposition, defined over F₅ and compatible with semilinear Cartier,
identifies this kernel as S_k tensored with the one-dimensional
coefficient kernel. Its deck representation is S_k. This argument
does not require guessing any additional Cartier blocks on W.

As a further consequence, the maximal elementary abelian 2-cover of
X, with group (C₂)⁴ and degree sixteen, preserves A: all its simple
F₅ representations are the trivial character and the fifteen
characters already tested. This follows directly from the same
simple-factor criterion. Thus even checking every quadratic cover of
X, or this entire abelian cover, misses the D8 obstruction.

This rules out testing a fixed datum on only the quadratic quotients
of its tame Galois closure: all such tests can pass while a nonlinear
simple factor fails. Characters do not exhaust the necessary
simple-factor tests, even for a 2-group in characteristic 5.
It does not rule out a different ordinary datum on a cover, or a
different common cover, and is not a counterexample to Litt's
common-cover question.
