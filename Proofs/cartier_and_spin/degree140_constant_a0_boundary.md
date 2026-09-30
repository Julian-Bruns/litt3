# Proof: all seven constant a0 boundary roots

[Statement](../../Theorems/cartier_and_spin/degree140_constant_a0_boundary.md).
The full coefficient construction and incoming executed checks are in
Sections19–20 of the
[retained report](../../../litt3-computation-data/finite_loci_v4_replies_20260926/extracted/constant_a0_boundary/constant140/REPORT.md).
This proof records the exact algebraic coverage and independent replay.

## Three factors, all geometric roots

In the prescribed K-code,
\[
a_0=245794(q+372885)p_0p_1,
\]
where
\[
p_0=q^3+63559q^2+262411q+219733,
\qquad p_1=q^3+188479q^2+229183q+288706.
\]
These are pairwise coprime and separable; both cubics are irreducible
over K. The linear root is115265, with cube root w=196636. Each cubic
is treated in its full field E_i=K[q]/p_i, retaining all three
embeddings into the algebraic closure. H and the scale remain
indeterminates over these fields. They are not restricted to their
finite rational points.

At each factor, q,a1(q),q-1,q-15383 are nonzero. Thus Psi=a1H,
and H!=0 is exactly the remaining leading-coefficient condition.
For the cubic factors use the compact norm W directly, without
adjoining or selecting a cube root of q. Its reversed polynomial
A(T)=T^140 W(T^-1) has leading coefficient
\[
L=c_Wq^{42}a_1(q)^3H^{12},
\qquad c_W=2\epsilon^{24}/299619^6.
\]
The linear factor uses the invertibly rescaled original coordinates.

## Three tails and fixed-degree resultants

Every square requires the three coefficients C71,C72,C73 of
C=A^63 modulo T^125 to vanish. This follows scheme-theoretically:
if A=L b^2 and b(0)=1, then b^125=1 modulo T^125, so C=L^63 b.
A square polynomial of degree140 has b of degree70.

The exact support computation permits division by H powers only:
\[
f_{71}=C_{71}/H^{549},\quad
f_{72}=C_{72}/H^{548},\quad
f_{73}=C_{73}/H^{545}.
\]
The respective (H,scale) degrees are(313,47),(316,47),(320,48),
with8366,8581,8797 terms. The bound deg_H W<=36 precedes its
37-node reconstruction. The tail bounds precede their321-by49
interpolation. Full grid roundtrips and additional evaluations are
retained. This is exact polynomial reconstruction under proved degree
bounds, not a search for points in a finite field.

Compute the fixed-degree Sylvester determinants
\[
r_0=\operatorname{Res}_{47,47}(f_{71},f_{72}),\qquad
r_1=\operatorname{Res}_{47,48}(f_{71},f_{73}).
\]
The weighted support bounds give H degrees at most19928,20256.
Reconstruction uses20257 distinct nodes, and evaluates the full
Sylvester determinant at scale-degree drops. The actual degrees are
19315,19622, with H orders2024,2087, in all three factor algebras.
For a=r0/H^2024 and b=r1/H^2087 the complete retained multipliers
satisfy
\[
ua+vb=1.
\]
This is a coefficient identity, not just an asserted gcd or sampled
evaluation. The resultant adjugate puts r0 in(f71,f72) and r1 in
(f71,f73), without inverting a leading scale coefficient. The displayed
identity therefore places1 in the necessary tail ideal after inverting
H only. Each factor's complete geometric square scheme is empty.

## Nilpotents and the global localization

Let B be the original localized coefficient ring and I its full square
ideal. Chinese remaindering over the three coprime factors gives
B/(I,a0)=0. Consequently1=i+ua0 for some i in I,u in B. Thus a0
is already a unit in B/I; the map B/I to(B/I)[a0^-1] is an
isomorphism. This retains the full scheme structure.

## Evidence and local checks

All specialized inputs, tails, resultants and Bezout multipliers are
retained under the report's `decision/evidence/` directory. The incoming
fresh-extraction replay regenerated every essential data file exactly.
Locally, the format/support/factorization verifier passed, and the
independent GMP implementations replayed all34826 K coefficients for
the linear factor and all34826 cubic-extension coefficients for each
cubic factor. The latter are104478 K coefficients per factor. The
independent arithmetic uses direct tower reduction and carry-free
integer polynomial multiplication, not the generator's field tables.

The local command receipts and full identity outputs are in
[verification_constant](../../../litt3-computation-data/finite_loci_v4_replies_20260926/verification_constant/).
This focused local check does not claim a fresh local rerun of the
incoming full interpolation pipeline. Source copies and provenance
are indexed in the
[integration audit](../../Research/audits/FINITE_LOCI_V4_REPLIES_2026_09_26.md).
