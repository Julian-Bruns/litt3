# Two-prime rectangles: ordinary mixed factors and exact axis descent

Authors /root and/root/gluing_cohomology_rigidity,2026-09-05.
AUTHOR proof, consolidated2026-09-07; not independently audited.
Includes the earlier nonisogenous-simple case and its actual-component
proof. The coprime descent input retains its separate author provenance.
No core-existence, cofinality or common-cover exclusion is claimed.

## 1. One theorem, two exact choices of directions

Over k=bar(F_p), fix an ACTUAL finite etale span X←f Z→g Y of
smooth projective connected hyperbolic curves. Put A_X=J(X^(1)),
A_Y=J(Y^(1)), B_Z=F_(Z/k)*O_Z/O_(Z^(1)), and ASSUME

    D={(L,M):h⁰(Z^(1),B_Z⊗f^(1)*L⊗g^(1)*M)≠0}
                                                ⊂A_X×A_Y is PROPER.

Closedness follows from semicontinuity; properness does not follow
from simplicity, nonisogeny or minimality. Choose DISTINCT primes
ℓ_X,ℓ_Y≠p. Either of these choices is allowed:

* If BOTH endpoint Jacobians are geometrically simple, choose ANY
  finite-rank pro-ℓ_X/pro-ℓ_Y abelian quotient directions, including
  the maximal abelian exponent towers. No nonisogeny or Hom-zero
  hypothesis: X=Y and f=g are allowed.
* For arbitrary endpoint Jacobians, choose cyclic directions from
  a product of two open dense full-Haar-measure sets in their
  ℓ-adic projective Tate spaces, specified in Section2.

Let X_m/X,Y_n/Y be the actual exponent-ℓ_X^m,ℓ_Y^n covers in
these directions. There are cutoffs a,b such that EVERY compatible
component choice W_(m,n) of Z×_X X_m×_Y Y_n, m≥a,n≥b, has
actual etale maps to Z,X_m,Y_n and

    Gal(W_(m,n)/W_(a,b))=K_X×K_Y,

where the full axis tail groups have coprime orders. Their quotients
are W_(a,n),W_(m,b). The mixed quotient

    J(W_(m,n))/(Im J(W_(m,b))+Im J(W_(a,n)))

is ordinary, and

    Δ(W_(m,n))=Δ(W_(m,b))+Δ(W_(a,n))−Δ(W_(a,b)), Δ=g−f.    (1)

For every hyperbolic T with NO ordinary simple factor in J(T),
every nonconstant map W_(m,n)→T descends through an entire tail
factor. In particular, identifying actual etale maps with pullbacks,

    Et(W_(m,n),T)=Et(W_(m,b),T)∪Et(W_(a,n),T),
    Et(W_(m,b),T)∩Et(W_(a,n),T)=Et(W_(a,b),T).             (2)

The axes need not have bounded defect or stabilize in a finite level.

## 2. Distinct primes, not nonisogeny, separate the bad directions

The [finite-support torsion-coset theorem, Section3](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md)
writes the S={ℓ_X,ℓ_Y}-primary points of D as finitely many
t_i+B_i[S∞], with t_i+B_i⊂D and each B_i proper. Diagonals
and graphs of isogenies are permitted.

For B⊂A_X×A_Y define the possibly disconnected reduced axis
subgroups H_X=B∩(A_X×0), H_Y=B∩(0×A_Y). On geometric points,

    B∩(Γ_X×Γ_Y)=(Γ_X∩H_X)×(Γ_Y∩H_Y)                     (3)

for ANY primary subgroups Γ_X⊂A_X[ℓ_X∞],Γ_Y⊂A_Y[ℓ_Y∞].
Indeed CRT applied to the two point orders projects (x,y)∈B
to (x,0) and (0,y). Nonreduced kernels add no prime-to-p points.

If t+B meets Γ_X×Γ_Y, choose h in the intersection. Its intersection
is h plus the product in(3). For SIMPLE endpoints, each H_i is finite
or the entire axis; a proper B cannot contain both axes. Thus every
such intersection has a finite coordinate factor.

For arbitrary endpoints, put C_i=H_i^0 and choose each cyclic Prüfer
direction whose rational Tate line avoids every proper V_ℓ(C_i)
arising from these finitely many B's. This excludes finitely many
proper projective linear subspaces: the complement is open dense
and has full Haar measure. If Γ_i∩H_i were infinite it would be all
of Γ_i, since proper subgroups of a rank-one Prüfer group are finite.
The divisible Γ_i has zero image in the finite component group
H_i/C_i, contradicting the avoided Tate subspace. Hence each proper
axis intersection is finite. For every proper B at least one axis
identity component is proper, giving the same finite-factor conclusion.

Choose representatives of the finitely many nonempty coset intersections.
Their coordinate orders and the finite-factor orders give a_θ,b_θ with

    L∉Γ_X[ℓ_X^a_θ], M∉Γ_Y[ℓ_Y^b_θ]  ⇒ (L,M)∉D.          (4)

This is genericity of directions, not of curves over finite fields.
No arithmetic-Frobenius invariance of a chosen direction is required.

## 3. Full rectangles, actual components and restricted projectors

The FULL rectangle R_(m,n)=Z×_X X_m×_Y Y_n is a torsor under
the product of the two axis groups; it may be disconnected. Its
relative-Frobenius kernel on character(L,M) is

    H⁰(Z^(1),B_Z⊗f^(1)*L⊗g^(1)*M),

up to scalar twist. [The twist calculation, Section4](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md)
includes nontrivial pairs pulling back to O_Z: Frobenius on the
preceding constants is an isomorphism. Absolute Frobenius sends labels
to(L^p,M^p), preserving both orders. The high-high block in(4)
is invariant and kernel-free, hence bijective, not merely first-kernel
bounded.

The image of π₁(Z) in the chosen free pro-ℓ_X deck lattice has
index dividing deg f, hence contains ℓ_X^v_(ℓ_X)(deg f) times that
lattice. Likewise for Y. Take

    a≥max(a_θ,v_(ℓ_X)(deg f)), b≥max(b_θ,v_(ℓ_Y)(deg g)).  (5)

The full tail K_X from level m to a then preserves each connected
axis component U_m and U_m/K_X=U_a; component numbers stabilize.
The same holds for V_n and K_Y. The connected Galois covers U_m/Z,
V_n/Z have coprime degrees, hence are linearly disjoint. Their product
is W_(m,n); all compatible rectangle components have this form.
Thus the tail group and its two actual quotients are exactly those
of Section1, without assuming that the full original deck group
preserves an individual component.

The prime-to-p averaging projectors e_X,e_Y act on Jacobians up to
isogeny and on coherent H¹. On the full rectangle,(1−e_X)(1−e_Y)
selects exactly the high-high tail characters of(4). By(5) it restricts
componentwise and its image is Frobenius-bijective, hence ordinary.
The remaining projectors e_Xe_Y,(1−e_X)e_Y,e_X(1−e_Y) give the
actual corner and the two axis pullback factors. Isogeny additivity
of dimension and p-rank proves(1).

## 4. Exact map sets and one-sided minimal joint images

The ordinary mixed factor has no homomorphism to J(T) for the
targets in Section1. Thus their maps kill every mixed difference.
The [coprime-product descent proof](MIXED_JACOBIAN_VANISHING_AND_BOUNDED_RESIDUAL_DESCENT.md#2-retained-universal-axis-and-solvable-quotient-theorem)
makes each nonconstant map descend through an ENTIRE tail factor,
retaining etaleness when present. This proves the union in(2).
A map descending through both is fixed by their product and descends
to the corner, proving the intersection. Each finite-level Et set is
finite: its degree is fixed by Riemann–Hurwitz, proper π₁(T) has
finitely many covers of that degree, and source automorphisms are finite.
In the direct limit these maps form the union of TWO boundary towers,
not a finite set or a uniform finite-level stabilization theorem.

Write a stabilized rectangle W=P×_B Q and retain its specified
projection q_Q. For an actual etale r:W→T, the minimal joint image
of(r,q_Q) is Q if r descends to Q. Otherwise choose its descent
r_P:P→T and let P' normalize k(B)r_P^*k(T)⊂k(P). Then the image is

    P'×_B Q,        with field k(Q)r^*k(T).               (6)

P'→B and P'→T are actual etale intermediate maps. The product
in(6) is connected since Q/B is Galois and the two degrees are
coprime. This is the actual minimal image, not just a dominating curve.

## 5. Limits and a concrete failure of cofinality

For fixed P,Q over B their product is the unique minimal span whose
maps commute with those to B, by the compositum/universal property.
Arbitrary minimal spans need not respect B or refine into this grid.
Boundary Jacobians generally have ordinary factors and are not
automatically allowed targets. Two allowed target maps may choose
OPPOSITE axes; individual axis descent is not simultaneous descent.
Maps already descending to Z are compatible with every conclusion.

After reaching an axis, no mixed direction remains in this grid.
Iterating requires new properness input; no bounded recursion depth
or decreasing complexity is proved. There is also a concrete
obstruction to cofinality among ALL etale covers: a grid is abelian
over its corner, and finite chains of abelian refinements have
solvable Galois closure there. Inductively the conjugate abelian top
extensions have abelian compositum over the preceding Galois closure;
subcovers and finite composita stay solvable.

In characteristic5 every hyperbolic corner has an etale Galois
SL₂(F7)-cover, of order336, impossible to dominate by such refinements.
Use the usual prime-to-5 surface-group quotients:
[Milne, revised ChapterI, RemarkI.5.2(j), p39](https://www.jmilne.org/math/Books/ECpup1.pdf)
and [Stacks, prime-to-p specialization](https://stacks.math.columbia.edu/tag/0C0R).
Send two surface generators to the elementary upper/lower unipotents
and their paired generators to1; the relation holds and these generate
SL₂(F7). Conjugation by diag(2,4) writes upper/lower unipotents
as commutators, with nonzero multipliers3,1; the group is perfect.
This cover is not a new minimal span between prescribed endpoints:
extra refinements can disappear in the joint image. No coverage theorem
for arbitrary minimal correspondences or common core follows.
