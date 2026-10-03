# Proof: exact traces of the original square-root line

The changed global map, calibration, and exact traces passed an
[independent focused audit](../../Research/audits/ACTUAL_CHARACTER_SQUARE_TRACE_AUDIT_2026_10_02.md).

All selected divisors and normal-form functions are the ORIGINAL
ones in the universal actual character theorem. Put C=Y^(1), and
transport source divisors to T^(1) when used as bundle divisors.
Write tau=dlog ell=2sx eta0, so beta=-tau. The intrinsic global
frame of F*E has canonical connection
\[
\nabla K1=-3tau K1,\qquad
\nabla K2=2s eta0 K1-4tau K2.
\]
The first identity is in the intrinsic complement theorem; the
second is a four-coefficient rational identity, checked in the tiny
[connection source](../../scripts/oct02_reciprocal_complement_connection.sage).

## The original negative root line

Direct differentiation of chi=phi/u gives
dchi=qeta+chi*qbeta. This uses dphi=df=u*qeta/2 and
-dlog(u phi)=qbeta, with precisely the original normalization.
Its divisor is E_sel-5G; E_sel and G are disjoint, and chi is
separating. For eta=a eta0+b beta, set chi0=(chi+b)/a. Then
dchi0=qeta0+chi0*qbeta. The coefficient a is nonzero: at infinity
eta is a nonzero multiple of eta0; at a finite Weierstrass r it
is a nonzero multiple of (x-r)eta0, with r nonzero.

The vector (-2s chi0)K1+K2 is a horizontal line for the above
connection: its ratio r satisfies dr+tau*r=-2s eta0.
Cartier descent gives a saturated line L_chi in qE. In the global
Frobenius frame its ratio has pole divisor5G, so projection to the
canonical quotient A-fourth has zero divisor G. Thus
L_chi=qA^4(-G), of degree minus n. The exact admissible contact
identity is O(2G)=O(2H)qA^3. Since A has order five,
\[
L_chi^2=qA^8(-2G)=qA^3(-2G)=O(-2H)=h^*lambda_X.
\]
This equality alone does not identify its image in B; the next
global calculation does so.

## A global horizontal quadratic map and its calibration

N=N_eta=(JQ_eta)/ell is a GLOBAL augmentation section of F*B.
Its evaluation is eta. Products N-squared and N-cubed are taken
in the global augmentation ideal, not in an asserted algebra
structure on B. The canonical connection on a representative has
\[
\nabla N=-tau N-eta,
\qquad eta=a eta0-b tau.
\]
The last term is a scalar, so it is discarded in F*B for N itself.
It MUST be retained before differentiating its products:
\[
\nabla N^j=-j tau N^j-j eta N^{j-1}\quad(j=2,3).
\]
These formulas follow directly from N=ell^-1*(Q_second-Q_first)
in the augmentation quotient. They make the three displayed map
formulas match the connection on Sym^2(F*E). For example the mixed
source has connection2s eta0 K1-squared-7tau K1K2; substituting
the three images and eta=a eta0-btau gives exactly its target
derivative. The two other source derivatives are
-6tau K1-squared and4s eta0 K1K2-8tau K2-squared.
Thus the map is global and horizontal, and descends by Cartier
to j_eta:Sym^2E->B. Its coefficient matrix in N,N-squared,N-cubed
is triangular with nonzero diagonal, as a and s are nonzero.
The map is generically injective.

For calibration, first put Q0=Q_O and
r0=s^2x^2-sV=-2s Q0/ell. Generic vectors
v0=r0 K1+K2 and v1=ell^-1 K1 both have scalar connection -4tau.
Write Q_eta=aQ0-bell, and C0=a0^5/a; the original normal form is
ell*chi0=Q0+C0. Thus L_chi has generic vector
v0-2s C0 v1. Expanding the displayed j on its square gives
\[
j_eta((v0-2s C0 v1)^2)
=ell^{-3}J((Q_eta+a0^5)^3).
\]
This is a polynomial identity in the augmentation ideal. The
original phi equals a fifth-power scalar L times
(Q_eta+a0^5)^3. On Frobenius pullbacks its augmentation jet is
therefore L*ell-cubed times the displayed image. This factor
need not be a Frobenius constant: ell-cubed accounts for the
chosen character-frame connections. The two generic Frobenius
subspaces agree, and both are horizontal; faithful Cartier
descent identifies their original embedded lines. The saturated
image is the original canonical lambda_X line. The domain L_chi-squared
already has the same degree and line class as that line; therefore
the map has no extra line zero and identifies the embedded lines.
This is stronger than a class-only squaring argument.
The tiny [polynomial verifier](../../scripts/oct02_reciprocal_square_trace_map.sage)
checks all three connection identities and this calibration with
independent formal variables; its
[exact receipt](../../../litt3-computation-data/oct02_reciprocal_twisted_cartier/square_trace_map.json)
records four successful checks in0.018 seconds, one core, Sage10.9.

The span of N,N-squared,N-cubed is the orthogonal hyperplane
A_eta-perp generically. Locally at the double adjunction zero
use Q=z^3, t=z^5. Its regular hyperplane frame is
(Q,Q-squared/t,Q-cubed/t), while the image frame is
(Q,Q-squared,Q-cubed). Hence the defect is(1,1), supported at W.
Away from W the primitive starts in order one and there is no
defect. This is the local primitive calculation of the settled
[quadratic trace map](positive_rank_three_quadratic_trace.md),
used without its former orbit premise. Since Sym^2E has degree
zero and j is injective, its UNSATURATED image has degree zero;
the hyperplane saturation has degree two.

## Exact rank-two trace

The finite-etale direct image q_*L_chi is semistable of slope
-1/8. This remains valid when q is not Galois: pull back along
the ACTUAL normal closure of T/Y, where it splits into line
pullbacks of the same degree. Semistability descends along that
finite etale cover. A rank r image J in E consequently has
degree at least ceil(-r/8), hence at least zero for r=1,2.
E is strongly semistable of degree zero, so J is saturated of
degree zero. Its only degree-zero line subbundle is A-cubed:
a different one would map nontrivially to A-fourth, be isomorphic
to it, and split the known nonsplit extension. But the original
L_chi maps nontrivially to A-fourth, with divisor G. Therefore
J cannot have rank one. It is exactly E, as an image sheaf.

## Exact rank-three square trace

Pass to the normal closure W of T/Y only. Pullback of the exact
root trace says that all Galois-orbit root lines generate qE in
EVERY fiber. They cannot have only two distinct generic directions:
then two saturated orbit lines, each of negative degree, would
already surject onto the degree-zero rank-two bundle, contradicting
their determinant degrees. Thus there are at least three generic
directions. Their squares on the nonsingular Veronese conic span
Sym^2E generically. By the calibrated map, the canonical lambda
orbit trace therefore has rank three and lies in j_eta(Sym^2E).

The original q_*h^*lambda_X is semistable of slope -1/4 by the
same etale splitting argument. Its rank-three image has degree
at least ceil(-3/4)=0. It is contained in the rank-three degree-zero
image of j. Equal ranks and the degree inequality force equality
of the UNSATURATED image sheaves. This proves the assertion on
the original Y, not merely after refinement. Both original maps
are retained; the one-leg normal closure supplies only an orbit
proof and is never asserted to be Galois over X.

The conic and its two-character unipotent coefficient still depend
on the marked actual Y character. A single canonical lambda_X
line has not been proved to recover them intrinsically on X.
