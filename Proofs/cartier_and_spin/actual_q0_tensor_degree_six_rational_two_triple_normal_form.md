# Proof: integrate the square derivative and retain the complete branch polynomial

Version1,3 October2026. Frozen pending independent review; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_rational_two_triple_normal_form.md).

The actual [coarse reduction](actual_q0_tensor_cubic_coarse_curve_reduction.md) gives the separating degree-SIX xi with only local indices ONE orTHREE, branch values in the fixed ELEVEN P/∞ values, and the common reduced q0-zero divisor. The [two-triple reduction](actual_q0_tensor_degree_six_two_triple_disjoint_reduction.md) gives disjoint degree-TWO triple pole divisors and B equal to its joint x-field. Nothing in this proof assigns a Y-map to B.

## Individual projection shape

Fix ONE xi and choose a coordinate v on the rational B with its TWO poles ZERO and infinity. Its differential has poles FOUR at each of them. Rational Hurwitz gives total different TEN: the TWO poles account for FOUR, leaving THREE finite ramification points of index THREE. Since dv has pole TWO at infinity, f′=df/dv has only even divisor orders and is a rational square over the algebraically closed constant field. Its exact poles and zeros give
\[
f'=\kappa H_3(v)^2/v^4,\quad
H_3=v^3+a v^2+b v+c,\quad \kappa\ne0,
\]
with c≠ZERO and three distinct roots, none ZERO. Exactness forces the v^-1 coefficient of the derivative to vanish: TWO c+TWO ab=ZERO, hence c=−ab and ab≠ZERO. Integrating all remaining coefficients gives exactly
\[
f=\kappa\left(2v^3+a v^2+(a^2+2b)v
+(2a^2b-b^2)v^{-1}+ab^2v^{-2}+3a^2b^2v^{-3}\right)+m.
\]
There is no invisible nonconstant fifth-power ambiguity inside this pole budget: a rational fifth power with poles at most THREE at ZERO and infinity has no poles at all, and is constant. Thus the displayed primitive is complete, not merely ONE convenient solution.

Put v=a t and λ=b/a². The source-coordinate factor a³ is absorbed into the nonzero target scale. The critical polynomial becomes t³+t²+λt−λ. Its discriminant is λ(λ+THREE)², up to the harmless nonzero sixth power a6 before scaling. λ=ZERO contradicts b≠ZERO. λ=TWO makes the polynomial (t−THREE)³ and its derivative zero order SIX at a finite point; this cannot be a tame index-THREE point and is forbidden by the actual local hypotheses. Thus λ≠ZERO,TWO; neither condition removes a legitimate boundary.

An imprimitive monodromy would give a degree-TWO intermediate factor in one of the TWO orders. A degree-TWO first factor must be étale because every composite local index is odd, but P1 has no connected étale double cover. A degree-TWO terminal factor ramifies somewhere, giving a forbidden even index. Thus monodromy is primitive. Its inertia is even, and its normal closure of THREE-cycle conjugates is transitive; the connected-support proof in the [nonuniform monodromy reduction](actual_q0_tensor_degree_six_nonuniform_elliptic_monodromy_reduction.md) gives A6 as soon as a single THREE-cycle occurs. Hurwitz gives FIVE ramified points, so not all fibers can pair them into (THREE,THREE) profiles; a single-cycle inertia necessarily occurs.

Let b2 count paired THREE fibers and b1 single THREE fibers. Then TWO b2+b1=FIVE and b2≥ONE from infinity. The possibilities are (ONE,THREE) or(TWO,ONE). In the latter the individual A6 Galois closure has THREE tame branch values, all inertia THREE, and Hurwitz makes its genus ONE. That is impossible: a finite group of automorphisms of an elliptic curve has an abelian translation normal subgroup and solvable stabilizer (in characteristic FIVE the stabilizer has order TWO,FOUR orSIX). A6 is nonsolvable and simple, so cannot act faithfully there. Thus b2=ONE,b1=THREE. This proves exactly THREE distinct finite branch values, all fixed P-roots. It does not choose them or execute a candidate census.

## Common polynomial system

Choose a common rational coordinate u with its infinity avoiding every pole, critical point, q0-zero and P-preimage of either map. This is possible over the infinite constant field. Write xi=Ai/Bi³, where Bi is a squarefree quadratic cutting out its TWO poles. Initially Ai has degree at most SIX and each Hi=Ai²+Bi6 has degree TWELVE and exactly the common TWELVE simple q0-zero roots. Thus H1,H2 are proportional. Rescaling Bi by a sixth root of a constant and Ai by its cube, preserving xi exactly, makes BOTH numerators equal to ONE H. Their q-ratio is now exactly (B1/B2)6; no marked scalar root is lost.

Differentiate. The polynomial Ai′Bi−THREE AiBi′ has exactly THREE finite double critical roots, avoids Bi and has degree SIX: infinity was chosen unramified and Bi4 has degree EIGHT, so xi′ has order TWO at infinity. It is therefore an exact polynomial square Ci² with deg Ci=THREE, choosing either sign of Ci. The Ci are squarefree. This proves the derivative identity with no extra unknown scaling.

The homogenized fixed P numerator has degree SIXTY because infinity was chosen outside its P-preimages. Its THREE finite critical points lie over THREE P-roots and have exact P-zero multiplicity THREE. Every other P-preimage is unramified and has multiplicity ONE. Thus
\[
P_{\mathrm{hom}}(A_i,B_i^3)=\kappa_i R_i C_i^3,
\quad\deg R_i=51,
\]
with Ri squarefree and disjoint from Ci and Bi. The actual cube identity P(x2)/P(x1)=t_y³ forces R1 andR2 to have the SAME root set: their quotient has valuations only ZERO or±ONE at any noncommon root, incompatible with a cube. Rescaling the nonzero κi makes Ri=R. The fixed P and q0 root sets are disjoint, so R andH are also disjoint; no unsupported saturation is introduced. The original joint-field generation gives k(x1,x2)=k(u).

With these exact identities one can also see the original tensor directly:
\[
\tau_i=q(x_i)^8\frac{(dx_i)^3}{P(x_i)^2}
=\kappa_i^{-2}\frac{H^8}{R^2}(du)^3.
\]
All Bi,Ci factors cancel. This is an exact identity, not a replacement of the full fixed-P condition by a derivative norm.

## Actual étale converse

Assume the complete polynomial packet and its genuine opens. The rational maps xi have exactly triple poles at the Bi roots and simple critical Ci roots with different TWO, hence local index THREE. At all other finite points they are unramified; their infinity is unramified because the derivative numerator has degree SIX. The P numerator identity makes every critical value a fixed P-root; the poles lie over the fixed infinity value. Thus the precise local hypotheses of the accepted [ramification-free cubic converse](actual_q0_tensor_cubic_coarse_curve_reduction.md) hold.

Set z=(B1/B2)² and choose a constant cube root δ³=κ2/κ1. Then
\[
q(x_2)/q(x_1)=z^3,\quad
P(x_2)/P(x_1)=t_y^3,
\quad t_y=\delta(C_2/C_1)(B_1/B_2)^{10},
\]
\[
\frac{dx_2}{dx_1}=(C_2/C_1)^2(B_1/B_2)^4
=\delta^{-2}t_y^2/z^8.
\]
The squarefree R has valuation ONE at its roots, so P(x1) is not a cube. Consequently C0:y1³=P(x1),y2=t_y y1 is connected and has TWO actual finite étale degree-SIX maps to the fixed X, with proportional τ. Its two embedded X-fields jointly generate C0 because xi jointly generate k(u). Its genus is49, as also follows from the FIFTY-ONE branch points of its cubic map to B. This constructs precisely the two-X object under study; no original Y-map is supplied.

The packet retains all pole, ramification, branch and common-divisor hypotheses. It is a complete rational-stratum reformulation, not its exclusion, and does not bound or resolve the other quotient genera or cubic-root index ONE.
