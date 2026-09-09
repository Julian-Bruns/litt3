# Proof: use the quotient jet map, not only the underlying oper bundle

Author /root,2026-09-09. Sections1--4 are author prose using the canonical
first-instability and scalar-jet constructions.
Version2 adds Sections5--8: an exact second-height computation and a
proved transfer to high-degree family parameters, not just a sampled
specialization.
Fresh medium audit PASS, /root/audit_height2_frobenius_transfer, same date:
no blockers; all48 charts independently replayed in22.1591s.
[Audit verdict](../Research/audits/POINTED_FROBENIUS_HEIGHT2_AUDIT_2026_09_09.md).
Scope is NEW Sections5--8, not earlier dependencies or an all-height result.

## 1. The final Frobenius step

Keep the relative Frobenius F:C0->C1 explicit and put E'=F^(n-1)*E,
so det(E')=omega_1^b with b=5^(n-1). Genus2 makes E semistable, and
first-instability minimality makes E' semistable. The argument in
[joint_tangent_clump_dormancy, Section4](Sol_joint_tangent_clump_dormancy.md)
uses only these one-leg facts: the maximal line N of F*E' has degree
5b+1 and its second fundamental map

    N -> Q tensor omega_0,       Q=(F*E')/N

is an isomorphism. Indeed it cannot be horizontal, and the integer
inequality5b<degN<=5b+1 is sharp. Thus Q²=omega_0^(5b-1).

Choose tau in Pic(C0)[2] with
Q=omega_0^((5b-1)/2) tensor tau. There is a unique tau1 in Pic(C1)[2]
with F*tau1=tau: pullback is an isomorphism on prime-to5 torsion. Set

    L1=omega_1^((1-b)/2) tensor tau1,
    H=F*(E' tensor L1),

with its canonical zero-p-curvature connection. Its oper sequence is

    0 -> omega_0^3 -> H --q--> omega_0^2 -> 0,              (2)

and its determinant, including connection, is canonically omega_0^5.
The tau1² trivialization is horizontal after pullback. No arbitrary
connection on the twisting line is substituted here.

## 2. The actual jet/connection identification

The connection and quotient in(2) define an O-linear jet map

    H -> J^1(omega_0^2),
    v |-> j^1(q(v)) - inclusion(q(nabla v)).                (3)

Leibniz makes the two derivative terms cancel, so(3) is O-linear.
It induces the identity on the quotient omega_0² and minus the second
fundamental isomorphism on the kernel omega_0³. It is therefore an
everywhere bundle isomorphism.

Transport the connection by(3). A horizontal vector has coordinates
(a,a') in local jet coordinates, hence satisfies a''=r a+c a'. Both
determinant connections are the canonical one on omega_0^5: the
determinant of(3), expressed in their global identifications, is an
automorphism of omega_0^5 and so a constant. Thus c=0. The remaining
coefficient r transforms by the stated projective-connection rule and
is regular. Its p-curvature is zero because the original connection was
a Frobenius pullback. It is the induced dormant oper, with the same
potential as the scalar equation a''=r a.

By the DEFINITION and proved jet realization of V_r in
[tangent_bundle_cyclic_refinements, Section1](Sol_tangent_bundle_cyclic_refinements.md),
Cartier descent of this very connection is V_r. Cartier descent applied
to(3) therefore gives E' tensor L1 ≅ V_r, which is exactly(1).

This proves an isomorphism of the connections, not a numerical
identification of two rank-two bundles with the same determinant.

## 3. Converse at the first step

The same scalar jet model has determinant omega_0^5 with its canonical
Frobenius connection, so det V_r=omega_1. If H0(V_r tensor tau1)!=0,
put E=V_r tensor tau1 and choose a nonzero section e. Stability and
deg E=2 show that the saturation O(D) of its image has degD<1.
Thus D=0: e is nowhere zero, and det E=omega_1 gives quotient omega_1.
The extension is nonsplit because E is stable. Its Frobenius pullback
has the oper line omega_0³ tensor tau of degree6>5, hence destabilizes.

There cannot be two independent sections of E. If their wedge is zero,
one nowhere-zero section makes the other a constant multiple. If it is
nonzero, it is a section of omega_1 and has a zero. At that point a
nontrivial constant linear combination of the sections vanishes,
contradicting the preceding nowhere-zero conclusion. This also shows
that each effective V_r tensor tau1 gives a single projective pointed
extension class, rather than a positive-dimensional family.

## 4. The selected endpoint and the precise limit

[genus_two_active_critical_quartics](Sol_genus_two_active_critical_quartics.md),
Section4, proves ALL Pic[2]-twisted dormant tangent vanishings for the
selected Y_t. Its degree hypothesis is preserved by constant-field
Frobenius conjugation. Section3 therefore excludes first instability
n=1, including for the pointed extensions of any shared curve tangent.

For n>=2, b>=5. The bundle in(1) has degree2b and rank2. Serre duality
and V_r^dual tensor omega_1=V_r identify its H1 with the dual of
H0(V_r tensor omega_1^((1-b)/2) tensor tau1). The latter stable bundle
has negative slope, so has no sections. Riemann--Roch gives

    h0=2b-2=2(5^(n-1)-1).

In particular n=2 leaves an eight-dimensional POSITIVELY twisted space.
Its sections still must arise by Frobenius pullback of the pointed
extension and be nowhere zero. The model alone does not exclude them;
Sections5--8 use the full pointed-extension condition to do so on our
family. Dropping that condition would no longer model the shared tangent.

## 5. An exact second-height matrix, covering every extension

We now use the family C_T: v²=F_T(u)=u(u-1)(u-2)(u-3)(u-T).
Put z=u²/v, a uniformizer at its unique infinity O; omega=O(2O).
In the omega frame with transition z^-2, pointed extension classes have
the Cech basis z^-3,z^-1,z of H^1(omega^-1). At Frobenius height n,
P=5^n, every nonzero pulled-back class has representative

            lambda0 z^(-3P)+lambda1 z^(-P)+lambda2 z^P.    (4)

The lambda coordinates are the P-th powers of the original extension
coordinates. Over the perfect algebraically closed field this still
covers the WHOLE projective plane, not just a finite set of extensions.

For tau in Pic(C_T)[2], let N=omega^((P+1)/2) tensor tau.
The connecting map obtained by applying Hom(N,-) to the pulled-back
pointed extension is multiplication by(4):

 H0(O((P-1)O) tensor tau) -> H1(O(-(P+1)O) tensor tau).    (5)

There is no H0(N^-1), so its kernel is precisely Hom(N,F^(n)*E).
A nonzero map from N has saturated image of degree at least P+1 and
therefore destabilizes the degree2P bundle.

Conversely, at n=2 any instability supplies such a map. If the first
unstable index is2, the HN line is exactly omega^13 tensor tau. If it
is1, its Frobenius pullback is omega^15 tensor tau, and multiplication
by any nonzero canonical-square section gives a map from omega^13 tau.
The initial nonsplit E is semistable. Thus ALL maps(5) being injective,
for P=25 and all16 tau, is EQUIVALENT to semistability of F^(2)*E.

## 6. Scalar bases and finite precision

The sixteen torsion classes are represented by R=1, the five monic
linear factors of F_T, and their ten pairwise products. Write d=deg R.
On the possibly split etale double torsor kappa²=R(u), the anti-invariant
affine functions form the free k[u]-module with basis

                         kappa, v/kappa.                  (6)

For nontrivial R this follows also by normalizing the Klein-four cover:
the affine equations kappa²=R and (v/kappa)²=F_T/R have disjoint simple
branch loci, so their affine ring is smooth and already normal.
For R=1, (6) is the ordinary basis1,v on a component, with the sign
character of the split torsor. These are precisely sections of tau
after the eigensheaf identification; no ramified cover is substituted.

On a chosen infinity component the two basis families have pole orders

       d+2i, i>=0;              5-d+2j, j>=0,

and leading Laurent coefficient1. Their parities differ. Those of pole
order at most P-1 give the P-2 columns of(5). For the target, reduce
principal parts from largest pole down by these monic affine functions.
Keep the two missing orders in0,...,4, and the powers z,...,z^P.
These give P+2 independent cohomology coordinates: the quotient is the
Laurent space modulo affine anti-invariants and z^(P+1)k[[z]].
An order0 gap is retained for a nontrivial tau, not silently removed.

Multiplying each source basis element by each of the three monomials
in(4), then applying this reduction, gives the three coefficient
matrices of(5). Maximal input pole order is4P-1. Since u is even in z
and v is odd, the map reverses parity and splits into TWO blocks, each
with two more rows than columns. A kernel in EITHER block is a genuine
kernel; both blocks must be excluded.

For P=25 the full matrix is27 by23. The trivial twist has blocks
15 by13 and12 by10. The nontrivial twists have blocks14 by12 and13
by11, possibly in the opposite order.

Here are explicit series and sufficient precision. With x=1/u and
Ftilde(x)=x^5 F_T(1/x), solve

                x=z² Ftilde(x),   u=x^-1,   v=u²/z.

The script uses precision Nprec=6P+30 and Newton iteration for this
equation and for the square root z^d kappa. It checks the first residual
has order at least Nprec-4 and the square-root residual at least Nprec-8.
The first derivative in the implicit equation and twice the root are
units. Thus the relative precision of every basis monomial is at least
Nprec-8. Even at pole4P-1 this leaves absolute precision at least

              Nprec-8-(4P-1)=2P+23>P.

All retained coefficients are consequently determined exactly.
The script additionally asserts known absolute precision>P before and
after every cohomology reduction. Membership at infinity is fully
included; the three extension-parameter charts are projective charts,
not a replacement for curve-point regularity.

## 7. Executed exclusion on C_alpha

[scripts/pointed_frobenius_theta_diagnostic.sage](../scripts/pointed_frobenius_theta_diagnostic.sage)
implements(4)--(6). The single-process complete command is

```sh
sage scripts/pointed_frobenius_theta_diagnostic.sage --height 2 --all
```

For each of16 torsion labels it checks the three DISJOINT charts
[1:a:b], [0:1:a], [0:0:1]. On each affine chart maximal minors of
EACH block generate the unit ideal. Every reported unit is explicitly
replayed as a Bezout identity against the original minors, using
extended Euclid for the univariate chart. The last point is checked
by exact finite-field rank. Thus each exclusion holds over the full
algebraic closure, not just F125-rational extension parameters.

The [complete receipt](../Research/computations/pointed_frobenius_height2_verified.jsonl)
records48/48 verified charts with both blocks retained, in22.252s on
ONE core. The earlier16 univariate API failures were checker failures,
not mathematical exceptions; this consolidated run supersedes them.
It proves F^(2)*E semistable for EVERY nonsplit pointed E on C_alpha.

## 8. A proved parameter-degree transfer, rather than a specialization guess

All three matrix coefficients before specializing T lie in F5[T].
More precisely, for a pole-order-w monomial in(6), its coefficient of
z^(-w+2j) is a polynomial in T of degree at most j.

To verify this bound, set U=(1/u)/z². The preceding implicit equation is

 U=1+c1(T)z²U+c2(T)z^4U²+c3(T)z^6U³+c4(T)z^8U^4+c5(T)z^10U^5.

Each c_i(T) has degree at most1, the constant term of U is1,
and the implicit derivative at that term is a nonzero constant.
Coefficient recursion therefore preserves deg_T(coefficient of z^(2j))
<=j. Multiplication and inversion of series with constant term1 preserve
this filtration, as does the square-root recursion (division only by2).
Each factor z²u-c z² with c in{0,1,2,3,T} has the same property.
This proves it for z^d kappa, u, v and all basis monomials.

For input pole p0<=4P-1, the coefficient at exponent l consequently
has T-degree at most(p0+l)/2. Triangular affine reduction preserves
this bound: a subtraction coefficient at pole w has degree
<=(p0-w)/2, and its monomial's coefficient at l has degree<=(w+l)/2.
At l<=P we therefore obtain the uniform entry bound

                         B=floor((5P-1)/2).               (7)

For P=25, B=62. Consider either homogeneous block with c columns;
its maximal minors are degree-c homogeneous forms in three lambda
variables, with T-coefficient degree at most cB. Here c<=13.

We use the following elementary finite-degree argument. If homogeneous
degree-c forms have no common point in P² at T=alpha, then THREE general
linear combinations have no common projective zero over barF5: take
the first two with no common component, then avoid their finitely many
intersection points with the third. The Koszul sequence, twisted to
degree D=3c-2, and H1(P²,O(j))=0, H2(P²,O(-2))=0 show that all degree-D
forms are generated by their degree-(D-c) multiples. Hence the matrix
of multiples of ALL original maximal minors is surjective in degree D
at alpha, already over F125.

This latter matrix is defined over F5[T], so SOME full-row minor is a
polynomial H(T) with H(alpha)!=0. Its number of rows is binom(3c,2);
every entry has T-degree<=cB. Therefore

                 0<=deg H<=binom(3c,2)cB
                           <=binom(39,2)*13*62=597246.     (8)

It is not necessary to construct the large matrix or choose H explicitly.
Its existence and degree bound are sufficient. If T=t has field degree
over F5 greater than600000, no nonzero polynomial of this degree can
vanish at t. Thus the same matrix is surjective at t, and the maximal
minors have no common projective zero there. This applies to all32 blocks.
No multiplication of their degree bounds is required.

Sections5--8 prove F^(2)*E semistable for every nonsplit pointed E on
every C_t with [F5(t):F5]>600000, as well as on the checked C_alpha.
The selected main parameter has much larger degree: its defining prime
over F25 exceeds the effective count using B=336000, and its degree
over F5 is at least that prime. Constant-field Frobenius preserves this
degree. Thus every nonzero joint tangent for the CURRENT pair has first
instability index n>=3.

This is a finite-height conclusion. It does not imply strong semistability
at all heights. At n=3 the general bundle model leaves a48-dimensional
space H0(V_r tensor omega^12 tensor tau), subject to further Frobenius
compatibility. We do not automatically repeat the finite computation
or call this an exclusion of common covers.
