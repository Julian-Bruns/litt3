# One regular form detects the actual genus-nine endpoint map

Version3,22September2026. Let k=F5bar and let X:y^3=P(x) be the
fixed genus-nine curve. For ACTUAL finite etale maps pi:T->W and
h:T->X of smooth proper connected curves, one has
\[
\boxed{\quad
h^*H^0(X,\omega_X)\cap\pi^*H^0(W,\omega_W)\ne0
\quad\Longrightarrow\quad h=h_0\pi
\quad}
\tag{1}
\]
for an actual finite etale map h0:W->X. No Galois, degree, ordinariness,
marking, or no-clump assumption is needed. In particular, distinct
embedded X-fields on one etale source have DISJOINT pulled-back
regular nine-spaces. This includes their exact three-spaces V_X.

The new exact case uses the
[one-form orbifold exclusion](../quotient_geometry/local_actions/fixed_x_one_form_atlases.md).
Its last degree160 case is excluded over the entire algebraic closure
by a necessary local Galois invariant and an independently verified
polynomial identity. A source-refinement or generic cohomological
identification does not replace the two actual maps in(1).

## Retained intrinsic two-form reconstruction

Use a^2=a+3, the code [n0+5n1]=n0+n1 a, and ascending coefficients
\[
P=(11,22,18,5,19,20,15,16,9,22,1).
\]
The Cartier kernel has basis omega_i=h_i dx/y^2, where
\[
h_0=[24]+2x+x^2,\quad h_1=[5]+[16]x+x^3,\quad
h_2=[5]+[20]x+[8]x^4+x^5.
\]
For exact regular forms omega=dA,eta, the operations
beta(omega,eta)=C(A eta) and tau=C beta are well-defined, regular,
alternating and compatible with etale pullback. Absolute Cartier
retains its inverse-Frobenius scalar action. For EVERY independent pair,
\[
k(X)=k\left(\eta/\omega,\tau(\omega,\eta)/\omega\right).
\tag{2}
\]
The double-Cartier matrix in the pair order01,02,12 and the basis
(1,x,x^2)dx/y is
\[
\begin{pmatrix}[5]&[8]&[5]\\[21]&[6]&[22]\\[12]&[9]&[5]\end{pmatrix},
\qquad\det=[13]\ne0.
\]
Unlike(2), the one-form conclusion(1) is an etale map-recognition
theorem; it does not assert rational reconstruction from one form.

## Global orbit and finite-deck consequences

On a source W, span the pullbacks from ALL actual etale maps W->X,
using respectively V_X, the ordinary six-space U_X, or the full
regular nine-space. Under any etale refinement W'->W, every nonzero
jump of these field-saturated global spaces has dimension at least
3,6,or9, respectively. These are global k-spaces, not coherent fibers.

Let W->Y be the first Y-Galois closure of an actual jointly minimal
coreless span with fixed X, and let G=Gal(W/Y). Write E_ex,E_ord,E_all
for the corresponding deck spans. Then
\[
\boxed{\dim E_{\rm ex}\ge6,\qquad
\dim E_{\rm ord}\ge12,\qquad\dim E_{\rm all}\ge18.}
\tag{3}
\]
The action on E_ex is faithful, with projective kernel central cyclic
of order dividing three. The action on E_ord is projectively faithful
and has a canonical F5-form given by Cartier-fixed vectors. For every
nonidentity sigma in G,
\[
\boxed{\operatorname{rank}(\sigma-1\mid E_{\rm ex})\ge3,\qquad
\operatorname{rank}(\sigma-1\mid E_{\rm ord})\ge6,\qquad
\operatorname{rank}(\sigma-1\mid E_{\rm all})\ge9.}
\tag{4}
\]
For any subgroup H<=G, its invariant intersection with a conjugate
original three-, six-, or nine-space is either zero or that entire
space. No later orbit bound or finite closure is asserted.

The earlier numerical p-rank jump already followed from Rosati
saturation. The new content is integral differential disjointness,
including exact forms, and its modular finite-deck consequences.
Neither original common-cover problem is solved by this result.

[Proof](../../Proofs/cartier_and_spin/two_form_map_descent.md).
