# Proof: the actual half-genus comparison also applies to split fields

Version1, 3 October2026. [Fresh independent seven-check scope audit PASS](../../Research/audits/CANONICAL_TEN_SPLIT_SMALL_RESIDUAL_EXCLUSION_AUDIT_2026_10_03.md), with no required corrections. The stronger standalone two-map geometric results are retained.

Write E=C₀, F=k(t), n=[E:F]=r−c, e=[T:E] and m=[Γ:F]. The zeros and poles of t are simple after canceling J, and n>0, so t is separating. The original Γ·X_i=T gives ΓE=T. Both E→X and T→E are finite étale by the original actual intermediate towers; g(E)−1=8r. The degree formula gives
\[
en=10m.
\]
It also implies n≥10, since the selected component over Γ already has degree ten.

For 11≤n≤19 apply [the arbitrary-base small-complement theorem](canonical_ten_small_complement_arbitrary_base_exclusion.md) with its R=P¹_t, E=C₀, A=Γ and SAME T. Its required separating E/R, actual compositum, étale T/E and degree-ten S10 T/A are exactly the retained data. Étale Hurwitz and the original canonical identity give
\[
e(2g(E)-2)=2g(T)-2=20(2g(\Gamma)-2).
\]
Dividing by en=10m therefore yields
\[
u_\Gamma=\frac{2g(\Gamma)-2}{m}
=\frac{2g(E)-2}{2n}=u_E/2,
\qquad u_E=16r/n\ge16.
\]
The accepted theorem excludes all these n, in every joint degree and with every overlap. No degree of the spin line or common spin divisor has been guessed.

It remains to examine n=10. The finite tensor product E⊗FΓ has total Γ-dimension ten and maps onto its actual compositum T of Γ-degree ten. Hence it is a field, and T is the normalization of the WHOLE connected fiber product. Every geometric pair (p,γ) over a common t-value has a point above it on T.

The common infinity divisor pulled to T is both the pullback of J from E and the common zero divisor of the original two Γ spin sections. If p∈J has t-value a, choose ANY γ above a. A point of T over (p,γ) forces both spin sections to vanish at γ. For ANY other p′ above a, the point over (p′,γ) then forces p′∈J. Thus J is a union of complete set-theoretic t-fibers. This uses the original sections and whole product, and is not valid for one selected component of a larger product.

The local part of [the complete ten-sheet shared-infinity proof](canonical_ten_full_bridge_shared_infinity_profile.md) uses only the actual étale X-coordinates, their quadratic identity, θ comparison, the nonzero degree-nine coefficient of the fixed P and the local degree bound e_p(t)≤10. It uses neither the involution nor the parity of deg J appearing in that theorem's nonsplit application. Its calculation therefore applies here verbatim: each common local index is3,4 or9, and index4 or9 forces the leading ratio λ=(x₂+1)/(x₁+1) to equal one. A complete ten-sheet fiber has the unique partition3+3+4. The SAME original scalar satisfies κ³=λ at every common point. The index4 point makes κ³=1 and hence λ=1 at the index3 points as well; the accepted local order-three comparison with λ=1 is contradictory. Thus J is empty.

Now r=n+c=10. The exact field identity E=k(t,x₁,x₂), both actual étale degree-ten maps, disjoint infinity and original θ comparison meet [the split conic-bundle exclusion](canonical_ten_split_tensor_conic_bundle_exclusion.md): its actual normalization has genus81, whereas the conic intersection bound gives genus at most66. This excludes the last case.

Therefore every retained nonconstant split comparison has r−c≥20. The argument imports no free involution on E, no endpoint map on Γ, no presumed simultaneous Galois closure and no unmarked extraction theorem. The separate standalone geometric results retain their stronger scope without requiring this Γ carrier.
