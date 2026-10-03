# Proof: the conceptual moving-origin cubic gate

Version3, 3 October2026. Scope unchanged. The [Version2 independent whole review](../../Research/audits/WILD140_MOVING_ORIGIN_CUBIC_AUDIT_2026_10_03.md) remains valid for its preserved computational proof; this new conceptual proof is under focused review. [Statement](../../Theorems/cartier_and_spin/wild140_moving_origin_cubic_even_part_exclusion.md).

The full ordinary [profile](canonical_wild_degree_140_ordinary_spin_reduction.md) retains the same actual source and BOTH original étale maps. It gives dG=cF³σ, with c≠0 and σ=dw/y₀, and requires seven simple zeros of F. Therefore C(F³σ)=0. Write
\[
\Phi=w^5+qw^4+s,\quad F=A+y_0B,
\quad B=w-b,\quad a=\operatorname{lc}(A)\ne0.
\]
The nonzero linear odd part has been normalized by a harmless scalar. The cubic Cartier [oper construction](genus_two_cartier_cubic_log_dormant_oper.md) gives D=∂F,E=∂D/F∈L(5P), with ∂=y₀d/dw, and a genuine dormant rank-two system. Its hypotheses include the SIMPLE finite zeros; exactness alone is not being substituted for that condition.

Put V=Φ+Φ′B/2, so D=y₀A′+V. Write E=C₂+vy₀. Comparing the highest coefficient in the even part of ∂D=EF gives v=a. Thus E is nonpolynomial. The accepted [complete oper coefficient classification](genus_two_cubic_cartier_oper_classification.md) gives
\[
C_2=\Phi''/2,\qquad a^2=q.
\]
The even and odd horizontal equations are
\[
BC_2+aA=V'=4\Phi'+3\Phi''B,
\qquad AC_2+a\Phi B=\Phi A''+\Phi'A'/2.
\]
Since1/2=3 in characteristic five, the first gives aA=4Φ′. Substitute this into the second. The terms containing Φ′Φ″ cancel, leaving
\[
B=4\Phi'''/q.
\]
For the centered moving-origin quintic, Φ′=4qw³ and Φ‴=4qw. Consequently A=aw³ and B=w, for EVERY initial shift b. Thus
\[
F=w(y_0+aw^2),\qquad a^2=q.
\]
Choose ρ with ρ⁵=−s. It is nonzero. At the point w=ρ,y₀=−aρ² the factor y₀−aρ² is a unit, while
\[
(y_0+aw^2)(y_0-aw^2)=w^5+s=(w-\rho)^5.
\]
Therefore y₀+aw², and hence F, has a zero of order five. This contradicts the required seven simple zeros. The argument is algebraic for every q,s≠0 and uses no endpoint arithmetic, invariant-ring generation or additional atlas.

The former exact-resultant proof and its original computation provenance are preserved as [Version2 proof evidence](../../../litt3-computation-data/oct03_wild140_normalized_subresultants/moving_cubic_version2_proof_evidence.md). Its saved true subresultants, original Cartier ideals, normal forms and small common-zero certificates remain in that sibling data directory. They independently established the same scope and are not replayed or needed for this conceptual proof.
