# Proof: the dormant model and a determinantal second-height test

[Statement](../../Theorems/deformations/pointed_extensions_frobenius.md).

## 1. The final Frobenius step is the actual dormant jet model

Put E'=F^(h−1)*E and b=5^(h−1), with det E'=omega_1^b.
The first-instability argument in
[joint tangent dormancy, Section4](pointed_bundle_instability.md)
makes E' semistable and the maximal line N⊂F*E' have degree5b+1.
Its nonhorizontal second fundamental map is an isomorphism
N→Q⊗omega_0, where Q=F*E'/N. Hence

    Q²=omega_0^(5b−1),   Q=omega_0^((5b−1)/2)⊗tau.

Pullback by relative Frobenius identifies the two-torsion on C1 and C0;
write tau=F*tau1. Set L1=omega_1^((1−b)/2)⊗tau1.
The canonical flat bundle H=F*(E'⊗L1) has oper sequence

    0→omega_0³→H --q--> omega_0²→0

and determinant omega_0^5 with its canonical Frobenius connection.
Its quotient and connection define

    H→J¹(omega_0²),
    v↦j¹(q(v))−inclusion(q(nabla v)).                       (3)

Leibniz makes this map O-linear. On quotient and kernel it is the
identity and minus the second fundamental isomorphism, respectively,
so it is an isomorphism.

In jet coordinates a horizontal vector is (a,a'), with scalar equation
a''=r a+c a'. The determinant of (3) is an automorphism of omega_0^5,
hence constant; both determinant connections are canonical. Thus c=0.
Regularity, the projective transformation rule and zero p-curvature
give a regular dormant r. The [jet realization of V_r](../projective_connections/tangent_bundle_cyclic_refinements.md#1-dormant-tangent-bundle-and-its-stability)
identifies its Cartier descent with E'⊗L1, proving (1).

## 2. Sections recover the first-height pointed extensions

The jet determinant gives det V_r=omega_1. A nonzero section of the
stable degree-two bundle E=V_r⊗tau1 is nowhere zero: its saturation
O(D) has deg D<1. Its quotient is therefore omega_1, and the extension
is nonsplit by stability. The oper line omega_0³⊗tau destabilizes F*E.

There is at most one section up to scalar. Two independent sections
with zero wedge would generate the same trivial line and be constant
multiples. A nonzero wedge is a canonical section and has a zero;
at that point a nontrivial constant linear combination vanishes,
again impossible. This proves the first-height classification.

For h>=2, the bundle in (1) has degree2b. Serre duality and
V_r^dual⊗omega_1≅V_r reduce H¹ to the dual of

    H⁰(V_r⊗omega_1^((1−b)/2)⊗tau1)=0.

Its slope is negative. Riemann–Roch gives h⁰=2b−2.
The additional pointed-extension condition is imposed by the next test.

## 3. One cohomology matrix tests the second height

For C_T:v²=F_T(u)=u(u−1)(u−2)(u−3)(u−T), use the infinity
uniformizer z=u²/v and omega=O(2O). In its frame of transition z^-2,
H¹(omega^-1) has Čech basis z^-3,z^-1,z. At height two, P=25,
every nonzero pulled-back extension class has the form

    lambda0 z^(-3P)+lambda1 z^(-P)+lambda2 z^P.               (4)

The lambda coordinates are P-th powers of the original coordinates,
so over k they cover all P².

For tau∈Pic(C_T)[2], set N=omega^((P+1)/2)⊗tau.
Applying Hom(N,−) to the pulled-back extension gives the connecting map

    H⁰(O((P−1)O)⊗tau) → H¹(O(−(P+1)O)⊗tau),                (5)

multiplication by (4). Since H⁰(N^-1)=0, its kernel is Hom(N,F^(2)*E).
A nonzero map has saturated image of degree at least P+1 and destabilizes.

Conversely, if the first unstable height is two, the maximal line is
omega^13⊗tau by Section1. If it is one, its pullback is omega^15⊗tau,
which also admits a map from omega^13⊗tau. Thus F^(2)*E is semistable
exactly when (5) is injective for every tau.

## 4. Scalar bases and exact Laurent precision

Represent the sixteen torsion labels by R=1, the five monic linear
factors of F_T, and their ten pairwise products; put d=deg R.
On the possibly split double torsor kappa²=R(u), the anti-invariant
affine module has k[u]-basis

    kappa, v/kappa.

For nontrivial R, the normalization is the Klein-four cover with
equations kappa²=R, (v/kappa)²=F_T/R. Their disjoint simple branch loci
make the affine ring smooth. For R=1 the basis is1,v on a component,
with the sign character of the split torsor.

At the chosen infinity component these monomials have leading
Laurent coefficient one and pole orders

    d+2i, i>=0;   5−d+2j, j>=0.

Orders at most P−1 give the P−2 source columns. For the target, cancel
principal parts by these monic affine functions, from largest pole down.
Retain the two missing orders in0,...,4 and the exponents1,...,P.
These P+2 coordinates describe Laurent series modulo affine
anti-invariants and z^(P+1)k[[z]]; a missing order zero is retained.

Multiply each source basis element by the three terms of (4) and
reduce. Since u is even and v is odd in z, the resulting27-by23
matrix reverses parity. Its two blocks have sizes15-by13 and12-by10
for R=1, and14-by12 and13-by11 otherwise. Each has two more rows
than columns.

For the exact expansions, let x=1/u and Ftilde(x)=x^5F_T(1/x).
Solve

    x=z²Ftilde(x),   u=x^-1,   v=u²/z

by Newton iteration, and likewise compute z^d kappa as the square
root with constant term one. The verifier uses precision Nprec=6P+30.
It checks residual orders at least Nprec−4 and Nprec−8, respectively.
Both implicit derivatives are units, so all basis monomials have
relative precision at least Nprec−8. The largest input pole is4P−1;
the remaining absolute precision is therefore at least2P+23>P.
The verifier also checks precision>P before and after every reduction.

## 5. Replace the projective charts by a published resultant

Use Busé's notation: a block transpose defines
phi:O(-1)^(n+2)→O^n on P², with rank threshold r=n−1.
[Busé, Propositions5.2 and5.4](https://arxiv.org/pdf/math/0209404),
specialized to m=n+2, d_i=1, k_i=0 and d=n, identify its resultant
with the determinant of the square maximal-minor coefficient map

    sigma_n:k^binomial(n+2,2)→k[x0,x1,x2]_n.

Thus phi has rank n at every geometric projective point exactly when
det(sigma_n)!=0. This principal case is valid in every characteristic,
as explained in Busé, Section3.3; its algebraic input is
[Bruns–Vetter, Theorem2.16](https://www.home.uni-osnabrueck.de/wbruns/brunsw/detrings.pdf),
the Eagon–Northcott resolution.

Set (x0,x1,x2)=(lambda0,lambda1,lambda2). At T=alpha,
alpha³+alpha+1=0, the [verifier](../../scripts/deformations/verify_pointed_extensions.sage)
rebuilds both blocks for all sixteen labels and finds all32 determinants
nonzero. Dehomogenizing x0=1 identifies degree-n forms with polynomials
of total degree at most n, so the coefficient calculation retains
points on x0=0. Run

    sage scripts/deformations/verify_pointed_extensions.sage

for the complete exact test. It writes no files; --verbose prints
the individual determinants. All32 checks pass in about90 seconds.

## 6. Transfer by the intrinsic coefficient degrees

For a pole-order-w basis monomial, its coefficient at z^(-w+2j)
is polynomial in T of degree at most j. Indeed U=(1/u)/z² satisfies

    U=1+sum_(i=1)^5 c_i(T)z^(2i)U^i,

where deg c_i<=1 and U has constant term one. Coefficient recursion
preserves this filtration, as do multiplication, inversion and square
roots with constant term one. The same applies to the factors
z²u−c z² for c∈{0,1,2,3,T}, and hence to every basis monomial.

Let w_j be a source pole order, l_i a retained target exponent and
e_h∈{−3P,−P,P} the exponent of the chosen term in (4).
The corresponding matrix coefficient has T-degree at most

    (w_j+l_i−e_h)/2.                                       (6)

Triangular reduction preserves this bound: a cancellation at pole w
uses degrees at most (w_j−e_h−w)/2 and (w+l_i)/2.
A negative bound means that coefficient is zero.

For a block with n columns, write q=binomial(n+2,2).
A coefficient of lambda^beta in the minor on row set I has degree
at most (sum_j w_j+sum_(i∈I)l_i−sum_h e_h beta_h)/2.
Each determinant term of sigma_n uses every row set and every
degree-n monomial once. Each target row occurs in binomial(n+1,2)
row sets, and symmetry gives sum_(|beta|=n)beta_h=nq/3.
Since sum e_h=−3P, its determinant H(T) consequently satisfies

    deg H ≤ [q sum w + binomial(n+1,2)sum l + Pnq]/2.        (7)

The two blocks, ordered by column count, give:

| deg R | (n, sum w, sum l) | Degree bounds from (7) |
|---|---|---|
| 0 | (13,156,165), (10,140,156) | 32760,17160 |
| 1 | (12,144,154), (11,154,169) | 26208,22308 |
| 2 | (12,156,168), (11,143,156) | 27300,21450 |

These weights and dimensions are also checked by the verifier.
Each H belongs to F5[T] and is nonzero by the specialization in Section5.
Thus none vanishes at any t with [F5(t):F5]>32760.
This proves (2), separately for every block; no product of the
determinants or enlargement of the degree bound is required.

The [joint-tangent theorem](pointed_bundle_instability.md) supplies
a finite first-instability height for a nonzero shared tangent over
bar(F5). On these endpoints Sections3–6 exclude heights one and two.
At height three the model still has48 sections before the further
Frobenius compatibility conditions, so no all-height conclusion follows.

The original [second-height audit](../../Research/audits/POINTED_FROBENIUS_HEIGHT2_AUDIT_2026_09_09.md)
covers the cohomology dictionary, precision and old specialization test.
The 2026-09-14 bounded medium check by /root/audit_finite_rank_condensation
covers the determinantal criterion and weighted degree sum.
Section1 retains author-proof status.
