# A quartic Cartier eigenform with root-cover degree four

Date: 2026-09-05. Exact computation on one curve over characteristic five.
This gives a degree-four root cover, not a second étale leg or a common-cover
obstruction.

Scoped independent arithmetic check: **PASS**, no breaking objection;
auditor /root/finite_field_matrix_backend_audit, 2026-09-05.
[Audit record](audits/GF25_T_SQUARED_TWO_CURRENT_FRONTIER_AUDIT_2026_09_05.md).
The check covers the corrected extension-field Cartier block and a bounded
exposure scan, not a separate audit of every proof in this note.
The recorded hash predates this audit-link-only metadata addition.

Let k = F̄₅, X: y² = h(x) = x⁵ − x, and η = dx/y. Then div(η) = 2∞,
and H⁰(X, ω⁴) has basis η⁴ times {1,x,x²,x³,x⁴,y,xy}.

**Theorem.** The regular quartic differential

    s = (x⁴ − x²)η⁴

satisfies C₃(s⁴) = s and is not the square of any regular quadratic
differential, even over k. Its fourth-root cover is connected of degree
four, has genus seven, and ramifies with index two exactly above the
Weierstrass points with x = 1 and x = −1.

## The seven equations

Write f = P + Qy, where

    P = a + bx + cx² + dx³ + ex⁴,     Q = u + vx.

In characteristic five set

    U = P⁴ + P²Q²h + Q⁴h²,
    V = 4P³Q + 4PQ³h.

Then f⁴ = U + Vy. Since y⁴ = h², ordinary Cartier gives

    C(f⁴η) = η (Σᵢ₌₀⁴ [x^(4+5i)](Uh²)^(1/5) xⁱ
                 + y Σⱼ₌₀¹ [x^(4+5j)]V^(1/5) xʲ).

The fifth roots here apply to the extracted coefficients. By
C₃(s⁴) = η³C(f⁴η), the normalized equations are precisely

    (a⁵,b⁵,c⁵,d⁵,e⁵)ᵢ = [x^(4+5i)](Uh²),    0 ≤ i ≤ 4,
    (u⁵,v⁵)ⱼ             = [x^(4+5j)]V,         0 ≤ j ≤ 1.

These are explicit coefficient-extraction formulas for seven homogeneous
quartic polynomials on the right. Their leading terms in any graded
monomial order are the seven distinct fifth powers. They form a Gröbner
basis, and their finite scheme has length 5⁷ = 78125. This length is not
a geometric point count.

For the theorem's f, direct expansion is particularly short:

    f⁴h² = x²⁶ + x²⁴ + 4x²² + 4x²⁰ + 4x¹⁶ + 4x¹⁴ + x¹² + x¹⁰.

The only nonzero terms whose exponents are 4 modulo 5 are x²⁴ and
4x¹⁴. Their extracted Cartier polynomial is x⁴ + 4x² = f, proving
the normalized equation exactly over F₅.

## Nonsquareness and cover geometry

A rational function f in k(x) is a square in k(x)(y) only if it is a
square in k(x) or h times a square in k(x). Indeed, expanding
(A+By)² with A,B in k(x) forces AB=0.

Here f=x²(x−1)(x+1) has odd valuation at x=1, so it is not a square
in k(x). Also h/f=(x²+1)/x has odd valuation at x=0, so f/h is not
a square in k(x). Thus f is not a square in k(X). A square root of s
would yield a square root of f after division by η², which is impossible.
As k contains μ₄, Kummer theory shows that k(X)(z), z⁴=f, has degree four.

Write Pₐ for the Weierstrass point with x=a. The zero divisor is

    div(s) = 4P₀ + 2P₁ + 2P₋₁.

The orders of f are 4,2,2 at these points and −8 at infinity. The
Kummer formula m=4/gcd(4,ord(f)) therefore gives ramification index two
at P₁ and P₋₁, and no other ramification. Riemann–Hurwitz gives

    2g(Z)−2 = 4(2g(X)−2) + 2·2 = 12,

so g(Z)=7. The root differential α=zη is regular and Cartier-fixed by
the root-form equivalence. It has order one at each of the four points
above P₀ and order two at each of the two points above each of P₁,P₋₁.

## A constant-multiplicity degree-four example over F₂₅

The preceding F₅ example has mixed zero orders, which matters for
applications requiring a divisor of the form e times a reduced divisor.
There is also an exact example with every zero order equal to two.
Choose t in F₂₅ with t²=2, and set

    s₂₅ = (tx + 3x² + 3tx³)η⁴ = 3t x(x−t)²η⁴.

This is normalized: C₃(s₂₅⁴)=s₂₅. To check this while retaining the
inverse-Frobenius normalization, for arbitrary t write f₀=x(x−t)² and
let R(f₀) be the coefficient-extracted polynomial before fifth roots.
Then

    R(f₀) = 4t³x³ + (t⁸+1)x² + 4t⁵x.

For t⁸=1 this equals 4t³ times the polynomial obtained by taking the
fifth power of each coefficient of f₀. Consequently λf₀ is normalized
for λ=4t³. When t²=2 this is λ=3t and gives the displayed formula.

Since t is not a branch value, let Q₊,Q₋ be the two points above x=t.
Then

    div(s₂₅) = 2P₀ + 2P∞ + 2Q₊ + 2Q₋.

The square class of its coefficient is that of x. The function x is
neither a square in k(x) nor h times a square, since h/x=x⁴−1 has
four simple zeros. Therefore its root cover has degree four. It
ramifies with index two at each of these four zeros, giving
2g(Z)−2=8+8=16 and g(Z)=9. The Cartier-fixed root differential has
order two at all eight points above these four zeros.

There is a small classification over k within the hyperelliptic-invariant
subspace u=v=0: among normalized nonzero eigenforms whose positive zero
orders are all equal and belong to {2,4,8}, exactly 25 are squares and
60 are nonsquares. The nonsquares all have zero order two everywhere.
This statement concerns that subspace only.

Here is a proof of the restricted classification. Regard P as a binary
quartic on P¹, including its zero at infinity. At a branch value, a base
zero of multiplicity m gives order 2m upstairs; elsewhere it gives two
zeros of order m. If the constant order is four or eight, every base
multiplicity is even, so the quartic is a square. If the constant order
is two, a nonsquare must have either four simple branch zeros, or two
simple branch zeros and one double nonbranch zero. The group PGL₂(F₅)
preserves the six branch values and lifts to automorphisms of X over k;
it acts transitively on their unordered pairs. Cartier naturality
preserves the normalized equation under these lifts.

For four simple branch zeros, move the omitted pair to {0,∞}. The
representative is x⁴−1, whose extracted polynomial R is zero, excluding
every nonzero scalar multiple. For two simple branch zeros, move them
to {0,∞}. The representative is x(x−t)² with t finite and nonzero.
The equations R(f₀)=λ f₀^[5] are equivalent to

    t⁸=1,     λ=4t³,

where f₀^[5] means coefficientwise Frobenius. The four roots of t⁴=1
are branch values and yield the mixed divisor orders (2,2,4). The four
roots of t⁴=−1 are nonbranch values and yield constant order two.
For each of the 15 unordered branch pairs there are thus exactly four
nonsquare constant-multiplicity forms, each with a unique normalized
scalar. This gives 60. Their branch pair and double base zero determine
them uniquely. The squares are precisely the 25 squares from the
quadratic certificate: 15 have orders (4,4) and ten have orders
(2,2,2,2). Indeed, for a quadratic tensor q the identity
C₃((q²)⁴)=q C₁(q³) shows that q² is normalized exactly when q is.

This proves that the constant-multiplicity filter does not exclude
degree-four root covers on this superspecial curve. It makes no claim
that these tensors arise as primitive invariants of a common-cover
construction.

## Exhaustive F₅ check, with its scope stated

Enumerating all 5⁷ coefficient tuples gives exactly 86 F₅-rational
solutions, including zero. All have u=v=0. Of the 85 nonzero solutions,
25 are squares of the 50 normalized quadratic eigenforms classified in
[the quadratic certificate](SUPERSPECIAL_GENUS_TWO_QUADRATIC_CARTIER_EIGENFORMS_CERTIFICATE.md),
and 60 are nonsquares over k(X). Their divisor types are:

| Type | Number | Positive zero orders |
|---|---:|---|
| Square, split quadratic | 15 | 4,4 |
| Square, nonsplit quadratic | 10 | 2,2,2,2 |
| Nonsquare | 60 | 2,2,4 |

The 25 squares are all defined over F₅, although some of their normalized
quadratic square roots require F₂₅. This finite-field enumeration is not
a classification of the quartic solutions over F̄₅. In particular, it
does not exclude solutions with nonzero y or xy coordinate over extensions.

## Reproducible Sage certificate

Executed with `sage -python` on 2026-09-05. The following code constructs
all seven equations, exhausts F₅⁷, checks the quadratic-square subset,
and verifies the displayed counterexample and divisor counts.

```python
from sage.all import *
from itertools import product
F = GF(5)
R = PolynomialRing(F, names=('a','b','c','d','e','u','v'))
coords = R.gens()
a,b,c,d,e,u,v = coords
S = PolynomialRing(R, 'x'); x = S.gen(); h = x**5-x
P = a+b*x+c*x**2+d*x**3+e*x**4; Q = u+v*x
U = P**4+P**2*Q**2*h+Q**4*h**2
V = 4*P**3*Q+4*P*Q**3*h
rhs = [(U*h**2)[4+5*i] for i in range(5)]
rhs += [V[4+5*i] for i in range(2)]
eqs = [z**5-r for z,r in zip(coords,rhs)]
assert all(r.total_degree() == 4 for r in rhs)
assert all(e.lm() == z**5 for e,z in zip(eqs,coords))
evaluate = [fast_callable(r, vars=coords, domain=F) for r in rhs]
solutions = [v for v in product(range(5),repeat=7)
             if all(fn(*v) == z for fn,z in zip(evaluate,v))]
assert len(solutions) == 86
assert all(v[5:] == (0,0) for v in solutions)

T = PolynomialRing(F,'x'); x = T.gen(); h = x**5-x
squares = set()
for a,b,c in product(F,repeat=3):
    if not any((a,b,c)) or next(t for t in (a,b,c) if t) != 1:
        continue
    q = a*c+b*b
    if q:
        g = 3*q*(a+b*x+c*x*x)**2
        squares.add(tuple(int(g[i]) for i in range(5))+(0,0))
assert len(squares) == 25 and squares <= set(solutions)

counts = {}
for vec in solutions:
    if not any(vec):
        continue
    f = T(list(vec[:5])); factors = list(f.factor())
    # Over Fbar_5 a polynomial is square up to scalar exactly when
    # every factor multiplicity is even. For deg(f)<=4, it cannot
    # be h times a rational square: h has six odd branch valuations.
    is_square = all(m % 2 == 0 for p,m in factors)
    assert is_square == (vec in squares)
    orders = []
    for p,m in factors:
        orders.extend(([2*m] if p.divides(h) else [m,m])*p.degree())
    if f.degree() < 4:
        orders.append(8-2*f.degree())
    key = (is_square,tuple(sorted(orders)))
    counts[key] = counts.get(key,0)+1
assert counts == {(True,(4,4)):15, (True,(2,2,2,2)):10,
                  (False,(2,2,4)):60}
f = x**4-x**2
assert sum((f**4*h**2)[4+5*i]*x**i for i in range(5)) == f
assert not all(m % 2 == 0 for p,m in f.factor())
assert h/f == (x*x+1)/x

# The constant-multiplicity family, with coefficientwise Frobenius.
B = PolynomialRing(F,'t'); t = B.gen()
BT = PolynomialRing(B,'x'); x = BT.gen(); h = x**5-x
f0 = x*(x-t)**2
out = sum((f0**4*h**2)[4+5*i]*x**i for i in range(5))
assert out == 4*t**3*x**3+(t**8+1)*x**2+4*t**5*x
minors = [f0[i]**5*out[j]-f0[j]**5*out[i]
          for i in range(5) for j in range(i+1,5)]
assert gcd(minors).monic() == t**8-1
assert all(((x**4-1)**4*h**2)[4+5*i] == 0 for i in range(5))
E = GF(25,'t',modulus=[3,0,1]); t = E.gen()
ET = PolynomialRing(E,'x'); x = ET.gen(); h = x**5-x
f = t*x+3*x**2+3*t*x**3
assert t**2 == 2 and f == 3*t*x*(x-t)**2
# In F25, taking fifth roots is also taking fifth powers.
assert sum(((f**4*h**2)[4+5*i])**5*x**i for i in range(5)) == f
assert h(t) != 0
print('86 F5 points: zero, 25 squares, 60 nonsquares; degree-four example verified')
print('F25 constant-order-two degree-four example verified; genus 9')
```

## Cartier on the genus-nine cover and its root characters

For the constant-order example t²=2, after rescaling the fourth root
over k, the genus-nine cover W has presentation

    u²=x,    v=y/u,    v²=u⁸−1,    z²=u(u²−t).

It is biquadratic over the u-line. Its three nontrivial quadratic
quotients are

    T: v²=u⁸−1                      (genus 3),
    E: z²=u³−tu                     (genus 1),
    H: w²=(u⁸−1)u(u²−t),   w=vz    (genus 5).

Their defining polynomials are squarefree. For a hyperelliptic equation
r²=F(u), use the ordered basis uʲdu/r for 0≤j<g and let columns be
images under Cartier. Its matrix is

    Mᵢⱼ = ([u^(5(i+1)−(j+1))]F(u)²)^(1/5).

On F₂₅, inverse Frobenius is the fifth-power map, so the associated
semilinear operation on a coefficient column c is M c^[5]. Exact
calculation gives

    M_T = diag(0,3,0),       M_E = [2t],

           [2t  0  2  0   0]
           [ 0  0  0  1   0]
    M_H =  [ 3  0  t  0   1].
           [ 0  2  0  0   0]
           [ 0  0  1  0  2t]

Thus T has p-rank one, E has p-rank one, and H is ordinary with p-rank
five: det(M_H)=2t≠0. The prime-to-five biquadratic character decomposition
of the Jacobian gives p-rank(W)=1+1+5=7. In particular W itself is not
ordinary, despite the invertibility on both faithful order-four characters
computed next.

Choose i=2 in F₅ and take the generator

    σ(u,v,z)=(-u,-v,iz).

On E, du/z has character i. On H, uʲdu/w has character (−1)ʲ/i, so
the odd indices j=1,3 have character i and the even indices j=0,2,4
have character −i. The T summand has only characters 1 and −1.
Consequently the two faithful-character Cartier matrices on W are

           [2t  0  0]                 [2t  2   0]
    M_i =  [ 0  0  1],     M_−i =    [ 3  t   1].
           [ 0  2  0]                 [ 0  1  2t]

Their determinants are t and 4t, respectively. Both are invertible.
Because i∈F₅, Cartier preserves these character spaces despite its
inverse-Frobenius semilinearity. Both faithful root-character Cartier
kernels therefore vanish. This is a statement about the root cover and
its differentials; no assertion of eigenform-scheme smoothness is needed.

The following additional certificate checks all matrices and semilinear
stable ranks. Its small determinants are evaluated directly by the
Leibniz formula in the specified field. Matrix products explicitly use
Sage's generic implementation: the installed Sage 10.9 specialized
`Matrix_gfpn_dense` backend gave incorrect products for this custom
non-Conway field modulus. Generic products are additionally checked
entry by entry below. Frobenius matrices are also explicitly constructed
as generic matrices, since `apply_map` resets that implementation choice.

```python
from sage.all import *
from itertools import permutations
F = GF(25,'t',modulus=[3,0,1]); t = F.gen()
R = PolynomialRing(F,'u'); u = R.gen()
def direct_det(A):
    n = A.nrows()
    return sum((-1)**sum(p[i]>p[j] for i in range(n)
                        for j in range(i+1,n))
               * prod(A[i,p[i]] for i in range(n))
               for p in permutations(range(n)))
matrices = []
stable_ranks = []
for f in [u**8-1, u**3-t*u, (u**8-1)*u*(u*u-t)]:
    assert gcd(f,f.derivative()) == 1
    g = (f.degree()-1)//2
    M = matrix(F,g,g,lambda i,j:(f**2)[5*(i+1)-(j+1)]**5,
               implementation='generic')
    matrices.append(M)
    N = matrix(F,g,g,lambda i,j:F(i==j),implementation='generic')
    for step in range(2*g):
        NF = matrix(F,g,g,lambda i,j:N[i,j]**5,implementation='generic')
        product_matrix = M*NF
        assert all(product_matrix[i,j] == sum(M[i,k]*NF[k,j]
                   for k in range(g)) for i in range(g) for j in range(g))
        N = product_matrix
    stable_ranks.append(N.rank())
MT,ME,MH = matrices
assert MT == diagonal_matrix(F,[0,3,0])
assert ME == matrix(F,[[2*t]])
assert MH == matrix(F,[[2*t,0,2,0,0],[0,0,0,1,0],
                      [3,0,t,0,1],[0,2,0,0,0],[0,0,1,0,2*t]])
odd = MH.matrix_from_rows_and_columns([1,3],[1,3])
even = MH.matrix_from_rows_and_columns([0,2,4],[0,2,4])
Mi = block_diagonal_matrix(ME,odd)
assert Mi == matrix(F,[[2*t,0,0],[0,0,1],[0,2,0]])
assert all(MH[i,j] == 0 for i in range(5) for j in range(5)
           if (i-j)%2)
assert direct_det(MH) == 2*t
assert direct_det(Mi) == t and direct_det(even) == 4*t
assert MH.det() == direct_det(MH)
assert stable_ranks == [1,1,5] and sum(stable_ranks) == 7
print('p-ranks T,E,H,W = 1,1,5,7; both faithful Cartier blocks invertible')
```

No assertion here concerns a second étale map, further covers, or the
existence or nonexistence of a common étale cover.
