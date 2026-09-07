# Quadratic coefficient coarsening: compression and parity

Author proof; self-check recorded2026-09-04, not independently audited.
Exposition version2,2026-09-07: original theorem scopes and numbering
retained; the group/genus calculation uses the parameterized
[coefficient sieve](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md#6-quadratic-coefficient-maps-uniformly-in-r-and-s),
and two identical adjunction arguments use
[actual Rosati factorization](../../Theorems/Thm_etale_rosati_factorization.md).
Neither reference is represented as a new audit of this note.

## Hypotheses and notation

Over k=Fbar5 assume an ACTUAL seven-diamond

    V --a--> Y,     V --p--> C --c--> X,
    deg(p)=7,      deg(a)=deg(c)=M>=2,

with all maps finite etale, p a C7-torsor, a beta!=a, and

    X:v^2=x^7-x+1,       Y:z^2=1-t^31.

The norm polynomial P(T)=Nm_(V/C)(T-t) has coefficient map q:C->B
of degree TWO, with involution delta. Put

    b=g(B),  w=dim W_P,  F=k(C),  K=k(V),  E=k(B)(t).
    g(C)=2M+1, g(V)=14M+1,
    [K:F]=[E:k(B)]=7, [K:E]=[F:k(B)]=2, [E:k(t)]=M.

No additional hypothesis on3<=w<=8 or on M is implicit. The fixed-X
arithmetic input from [53](53_M9_GENUS_ONE_COARSENING_IS_HYPERELLIPTIC.md) is

    End^0(JX)=Q(sqrt(-11)) x Q(sqrt(-19)) x Q(i),
    its Rosati-fixed algebra is Q^3,  Aut(X)={1,iota_X}.

The simplicity of JY and the degree-seven norm lemma give

    h=p_*a^*!=0,  dim im(h)=15,  c_*h=0.              (A)

For the norm lemma and its hypotheses see
[68, section2](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md#2-norm-obstruction-lemma-682-theorem-683-corollary-684).

## 1. Group and scalar spectrum

### Theorem67.1

K/k(B) is Galois with group C14 or D14. The reduced branch divisor
Delta of q and the spectral genus satisfy

    |Delta|=4(M-b+1),
    g(E)=7b-6       for C14,
    g(E)=6M+b       for D14.

In particular b=0 is impossible. If z belongs to E, then M is even,
b=M+1 and q is etale; every ramified q therefore has z not in E.

**Proof.** Apply section6 of the parameterized coefficient sieve with
r=7,s=2,e=2. It proves normality from the splitting field, computes
inertia and the two genera, and excludes b=0 by Castelnuovo--Severi.
If z belongs to E, compare with g(E)=7M+1 from etale E->Y of degree
M/2; either genus formula gives b=M+1. QED.

### Lemma67.2

Put u=c_*delta^*c^* and S=sum_i lambda_i, where lambda_i are its scalar
coordinates in the three elliptic factors of JX. Then

    lambda_i are integers,  -M<=lambda_i<=M.
    If b=1, at least two lambda_i equal -M.

**Proof.** The actual self-adjoint endomorphism u belongs to Q^3; its
coordinates are algebraic integers and hence integers. The identities

    M id +/- u=c_*(1 +/- delta^*)c^*

are Rosati-positive semidefinite. For s=q_*c^*, one has
s^dagger s=M id+u. When b=1 its H^1-rank is at most2, so at most one
of the three two-dimensional scalar blocks M+lambda_i is nonzero. QED.

We use two consequences for the actual cycle Z=(c,c delta)_*[C].
If its intersections with the indicated graphs are proper,

    Z . diagonal_X=2M-2S,
    Z . Graph(iota_X)=2M+2S.                          (B)

Each fixed point of delta contributes one to the first intersection:
in a tame parameter delta(w)=-w, and etaleness of c gives a nonzero
linear term in c(w)-c(-w). Also, if all lambda_i belong to {M,-M},
Rosati factorization gives c delta=alpha c for an ACTUAL automorphism
alpha of X. A mixed sign pattern is therefore impossible by Aut(X).

## 2. Genus-one compression

### Theorem67.3

If b=1, then c delta=iota_X c. The function x c descends to a degree-M
map r_X:B->P1_x, and C is the normalization of B x_(P1_x) X.
The map r_X is unramified away from the eight hyperelliptic branch
values A_X and has only indices1 or2 above them. If the fiber over
xi in A_X has profile1^(a_xi)2^(b_xi), then

    a_xi+2b_xi=M,   sum a_xi=4M,   sum b_xi=2M.       (C)

**Proof.** Here |Delta|=4M>0, so c delta=c is impossible at a fixed
point of delta. Equation(B) gives4M<=2M-2S, hence S<=-M.
If Z were not supported on Graph(iota_X), its nonnegative intersection
with that graph would give S>=-M. Lemma67.2 would force the mixed
pattern(-M,-M,M), which Rosati factorization excludes. Thus
c delta=iota_X c.

The anti-invariant function v c generates k(C)/k(B) and satisfies

    (v c)^2=r_X^7-r_X+1.

This proves the normalized fiber-product description. Local normalization
of the tame double-cover pullback and etaleness of c allow exactly
indices1 or2 over A_X, and no ramification elsewhere. The index-one
points are precisely Delta. Counting them and summing the eight fiber
degrees proves(C). QED.

## 3. Prym rank and the high-genus band

### Theorem67.4

Assume z not in E. Then, for every ell!=5,

    rank_Qell(M id-u | H^1(JX))<=2(2M-b-14).          (D)

No ramified q can have2M-15<=b<=M; the band is nonempty only for M<=15.
At the etale endpoint b=M+1, if M<=16 then c delta=c, so M is even.
In particular that endpoint is impossible for odd M<=16.

**Proof.** The unconditional square-root dichotomy in
[68, section4B](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md#b-z-does-not-belong-to-e--unconditional-part)
gives q_*h=0. Thus A=im(h) is15-dimensional inside P_q=Prym(C/B),
and delta^*=-1 on A. By(A), c^*JX is orthogonal to A, as is
delta^*c^*JX. Consequently

    T=im((1-delta^*)c^*) subset P_q intersect A^perp,
    dim T<=g(C)-b-15=2M-b-14.

The endomorphism M id-u factors through T, proving(D).
If b>=2M-15, at least two lambda_i equal M; hence S>=M. For a
ramified q the diagonal intersection is proper and its fixed points
would give0<|Delta|<=2M-2S<=0, a contradiction.

At b=M+1, existence first forces M>=15 by dim P_q>=15. For M<=16,
(D) again makes two lambda_i=M. If Z is not supported on the diagonal,
proper-intersection positivity forces S=M, hence the impossible mixed
pattern(M,M,-M). Thus c delta=c and c factors through q, giving2|M.
QED.

## 4. Odd dihedral genus-one case

Assume G=D14, b=1 and M odd. The reflection gamma fixing E fixes t,
negates z, and satisfies

    p gamma=delta p,  a gamma=iota_Y a.

Here z not in E by Theorem67.1, and c delta=iota_X c by Theorem67.3.
Put A_Y=mu31 union {infinity}, let pi:E->B, and define

    Z_alpha=pi_*t^*(alpha),   U_alpha=odd support of Z_alpha on Delta,
    Delta_xi={x in B:r_X(x)=xi, e_x(r_X)=1}.

### Lemma67.5

The sets U_alpha partition Delta, and |U_alpha|=a_alpha when the
fiber of t over alpha has profile1^(a_alpha)2^(b_alpha). The eight
Delta_xi also partition Delta; each has odd cardinality at most M.
For rho_alpha=(|U_alpha intersect Delta_xi| mod2)_xi in F2^8,

    rho_alpha+rho_infinity belongs to {0,all-ones}.   (E)

**Proof.** A reflection has cycle type1 2^3 on E/B. Above x in Delta,
there is one unramified sheet e_x, where V/E ramifies, and three
ramified sheets. The map V/E is the normalized pullback of the
hyperelliptic Y->P1 through t. Etaleness of V/Y forces indices1 or2
above A_Y and no others; the index-one points are precisely the
branch points of V/E. Thus e_x lies above a unique alpha in A_Y.
The norm-divisor formula

    mult_x Z_alpha=sum_(e above x, t(e)=alpha) e_e(t)

is odd exactly when alpha=t(e_x): the other sheets contribute even
terms. This proves the first assertions. The assertions about Delta_xi
follow from(C) and odd M.

For the ramified double cover q, branch coordinates identify

    P_q[2]/q^*JB[2]
       = {even subsets of Delta}/<Delta>,

with the induced Weil pairing given by intersection parity. The
coordinate of the pullback of a two-Weierstrass-point class from X is
Delta_xi symmetric-difference Delta_xi0. The norm-divisor identity
of [44](44_NORMED_HYPERELLIPTIC_BRANCH_PENCIL.md) is

    q^*Z_alpha=2D_alpha,
    O_C(D_alpha-D_infinity)=h([P_alpha-P_infinity]).

Thus the latter class has coordinate U_alpha symmetric-difference
U_infinity. Both c^*JX and h(JY) are anti-invariant and orthogonal by(A).
Their pairing with every Delta_xi symmetric-difference Delta_xi0 is
zero. Hence all coordinates of rho_alpha+rho_infinity agree, proving(E).
QED.

### Theorem67.6

The odd dihedral genus-one configuration is impossible for M<=15.

**Proof.** By Theorem67.1, g(E)=6M+1. Riemann--Hurwitz for t gives

    sum_alpha b_alpha=14M,
    sum_alpha ((M-1)/2-b_alpha)=2M-16.

This is negative for M<=7. Otherwise at least32-(2M-16)=48-2M
fibers have a_alpha=1. Their U_alpha are distinct singleton points.
By(E), their coordinate vectors lie in one complementary pair in F2^8,
which contains at most one weight-one vector. All these points must
therefore lie in the same Delta_xi, of size at most M. But
48-2M>M for M<=15. QED.

## 5. The remaining M=9 row and the general boundary

The preceding results retain their full all-w scope. At M=9, case A is
impossible and the direct Prym inequality gives b<=4. Theorems67.1,67.4
exclude b=0,3,4. For b=2, the local arguments in files56,58,60 use full
coefficient span only to PRODUCE the quadratic quotient; once e=2,b=2
are assumed, they force c delta=iota_X c. Then the orthogonal
15-dimensional h(JY) and3-dimensional c^*JX cannot fit inside the
17-dimensional Prym. This is a combined consequence, not a replacement
proof of those local inputs.

Theorem67.6 excludes the dihedral b=1 row. Only

    G=C14, b=1, z not in E

remains, and the [weighted-grid theorem](66_WEIGHTED_GRID_CYCLIC_INTERVAL_EXCLUSION.md)
excludes it for w>=5. The cases w=3,4 remain open here.

For general M, cyclic genus-one cases outside that weighted-grid range,
and middle-genus cases b<2M-15, are not excluded. In the latter range
the Prym complement can have dimension at least2, so(D) no longer
forces two extremal scalar coordinates. No simultaneous Galois closure
of the original pair and no missing tower hypothesis has been assumed.
