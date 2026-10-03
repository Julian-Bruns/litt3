# Proof: exact four-pair factorization and actual target lowering

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/wild140_actual_degree_ten_target_lowering.md). [Independent whole-implication review PASS](../../Research/audits/ACTUAL_COARSE_FACTOR_LOWERING_AUDIT_2026_10_03.md).

Use the accepted [ordinary four-pair theorem](../../Theorems/cartier_and_spin/wild140_ordinary_four_pair_reduction.md). Write f=y+v, where y²=w⁵+qw⁴+s and v²=2s. Expansion in characteristic five gives
\[
f^4=w^{10}+2qw^9+q^2w^8+4sw^5+4qsw^4+2s^2
 +4vy(w^5+qw^4+3s).
\]
Multiplication by 2c/q matches every term of the accepted G formula except its independent Cw¹⁰ term. Hence G=(2c/q)f⁴+Cw¹⁰ exactly. Since U=f²/w⁵, we have F²⁰=w⁷⁰U¹⁰ and G⁷=w⁷⁰(AU²+C)⁷, proving β=R(U).

At w=0 there are two points with y²=s. Since v²=2s≠s, f is a unit at both. Thus U has poles of order FIVE there. Its only zeros are the five simple zeros of f, each of order TWO; they are the distinct nonzero roots of w⁵+qw⁴−s. It follows that degU=10. Its differential is
\[
dU=4qf w^{-2}\sigma,\qquad \sigma=dw/y,\quad\operatorname{div}\sigma=2P.
\]
At the two poles its order is−2, giving different eight. At each of its five zeros the order is one and the local index is two. At P, the order is one. Also
\[
U=1+q/w+3s/w^5+2vy/w^5,
\]
so U(P)=1 and U−1 has exact order two, since q≠0. These different contributions sum to2·8+5·1+1=22, the full different of a separating degree-ten map from genus two. There is no further ramification.

The numerator and denominator of R are coprime, C≠0, so degR=14. Its derivative is
\[
dR=4A(AU^2+C)^6U^{-9}\,dU.
\]
As a map of rational curves, R has local index TEN and different ELEVEN at U=0, tame local index FOUR and different THREE at U=∞, and local index SEVEN at each of the two distinct roots of AU²+C. The derivative has no other zero. These contributions sum to11+3+2·6=26, the entire rational-curve Hurwitz different.

At U=1, R is unramified: A+C=0 would imply C²=A², hence c²q³/s=4c²/q² and q⁵=4s, contrary to the selected endpoint condition. The [actual coarse-factor lowering lemma](../../Theorems/cartier_and_spin/actual_coarse_factor_etale_carrier_lowering.md) therefore applies with C=P¹_U and e=14. It constructs Γ′=Γk(U) INSIDE T and proves Γ′→Γ étale using actual q and φ completions, rather than abstract numerical local types. All spin identities, original sections, canonical different and its primitive coefficient survive, while φ′ has degree ten on the SAME T.

For completeness its quotient signature follows from these same actual local towers. Over U=∞, the old Γ/B inertia has order twenty and its tame subextension C∞/B∞ has index four and different three. Thus Γ′/C has inertia five and different23−5·3=8. Over U=0, the old inertia twenty is divided by the local C/B index ten; since Γ′/Γ is étale, different transitivity gives23=δ(Γ′/C)+2·11, hence its inertia is two and different one. At the two roots of AU²+C, the old tame-seven completion is exactly absorbed by R, leaving no inertia. Elsewhere both old quotient and R are unramified. The old distinguished quotient point is ordinary and R is unramified at U(P)=1, so it remains ordinary. The resulting carrier is precisely the faithful canonical wild-five/tame-two degree-ten branch.

Nothing in this proof changes either original endpoint map or replaces the original source by a presumed common Galois closure.
