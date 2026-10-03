# Proof: degree-four Mumford inverse and complete pencil

Version1, 3 October2026. See the [statement](../../Theorems/cartier_and_spin/genus_two_degree_four_mumford_pencil_gate.md)
and its [independent five-check review](../../Research/audits/OCT03_GRAM_FOUR_DZERO_DIVISOR_CHART_AND_MUMFORD_GATE_AUDIT_2026_10_03.md).
The proof is computation-free and keeps the exact divisor class and
semireduced graph hypotheses explicit.

If d=0, the polynomial H−V² has degree five and the divisor of
W−V is C+E−5P with E effective of degree one. It follows that
\[
Q^{-1}=O(C-3P)=O(2P-E)=O(\iota E).
\]
This is effective, including when E overlaps C with higher multiplicity.
The equality uses divisors, not disjointness of their supports.

If d≠0, H−V² has degree six, giving C+E−6P with E effective
affine of degree two. E is semireduced: a graph selects only one sheet
over an unramified X value; at W=V=0, the derivative of H−V² is
H′≠0, so a branch root cannot repeat. Thus E is not a complete
hyperelliptic fiber. If Q⁻¹=O(S) were effective, then
\[
E+S\in|3P|.
\]
But L(3P)=⟨1,X⟩, whose divisors are3P or P plus a complete finite
hyperelliptic fiber. Since E is finite of degree two, it would have to
be that fiber, a contradiction. This proves the effectivity equivalence.

At the conjugate graph, W+V cancels the zeros of U to their required
multiplicity. Thus h is regular away from C and P; its pole divisor
is bounded by C, also at repeated unramified points. At a simple branch
point, U has local order two and W+V order one, yielding the allowed
order-one pole. No simple-support assumption is made for unramified C.

Take ζ=X^-1/2 and W=ρζ^-5+…, ρ≠0. If d≠0,
\[
h=d\zeta^2+\rho\zeta^3+\cdots,\qquad
g=\rho\zeta+\cdots.
\]
If d=0 the corresponding leading orders are three and one. Hence
both functions are sections of O(C−P). For d=0 their ratio is X,
so they are independent. For d≠0 a dependence would force h to be
rational in X, and hence W rational in X, impossible on this smooth
quadratic curve. Riemann–Roch gives h0(O(C−P))=2: its degree is
three in genus two and the complementary line has degree minus one.
Thus h,g are the COMPLETE pencil.

For a degree-three line L=ωYQ⁻¹, a base point S is equivalent to
h0(L(−S))=2. A degree-two line in genus two has two sections exactly
when it is ωY. Therefore such a base point occurs exactly when
Q⁻¹=O(S). The preceding equivalence gives base-point-freeness for
d≠0, and the complete moving map has degree three.

When d=0, the exact divisor identity for W+V yields
\[
\operatorname{div}(h)=\iota E+3P-C.
\]
As a section of O(C−P), h has divisor ιE+2P. Since g=Xh, its
section divisor is ιE plus a hyperelliptic fiber over X=0, with the
usual divisor multiplicities. Their common fixed divisor is exactly
ιE; the remaining pencil is canonical with ratio X. This includes
overlap of E with C or the X=0 fiber.

This theorem applies to the precise graph C, not a divisor inferred
only from a norm. In the Cartier use the [exact descent theorem](canonical_ten_constant_dzero_cartier_divisor_and_tame_gate.md)
fixes Q, but its timed-out inverse-sheet calculation has no completed
pivot or chart result. Graph and semireduced exceptions therefore
remain open; the general theorem itself needs no computational evidence.
