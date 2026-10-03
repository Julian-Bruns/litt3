# Proof: intrinsic character plane and finite-local complement

Version2,2 October2026. Reuse the
[universal two-character theorem](../../Theorems/cartier_and_spin/actual_two_map_twisted_cartier_characters.md)
and the [original positive X plane](../../Theorems/cartier_and_spin/positive_cartier_plane_orbits.md).
The new complement and projection statements are author checked.

## Plane and pairing

Local trivialization of A makes the two differential representatives
a common unit times $\eta_0,x\eta_0$. The canonical pencil has
vanishing sequences $(0,1)$ at ordinary points and $(0,2)$ at the
six Weierstrass points. Their local primitive fiber classes consequently
have independent leading orders $(1,2)$ or $(1,3)$, all below five.
Thus $A\oplus A\to B_Y$ is fiberwise injective and saturated.
Frobenius evaluation is onto, with kernel $\omega_Y^{-1}$, and the
second-fundamental divisor is exactly the six reduced Weierstrass points.

For $D_Q=d/dQ_O$, differentiation gives
\[
D_Q\ell=2sx,\quad D_Q^2\ell=2sV/\ell,\quad
D_Q^3\ell=s(F'-4sxV)/\ell^2,\quad D_Q^4\ell=3s^2/h^5.
\]
Indeed the numerator of the last derivative is
$s((F''+s^2x^2)V-4sF-sxF')=3s^2h$.
The fourth Q_O p-basis coefficient is therefore $2s^2/h^5$.
For the Cartier pairing $C(f\,dg-g\,df)$,
\[
\langle[Q_O],[\ell]\rangle
=3(2s^2/h^5)^{1/5}dQ_O^{(1)}\ne0.
\]
A different standard nonzero scalar normalization is immaterial.
The raw differential has divisor $10R_s-8O_C$; subtracting the
divisor $8R_s-8O_C$ of $A^2$ gives restricted-pairing divisor $2R_s$.

Since N is a subbundle, $B_Y\to N^\vee\otimes\omega_C$ is onto.
Its kernel E has degree zero and determinant $A^2$.
The determinant divisor of $N\oplus E\to B_Y$ is twice the
restricted-pairing divisor, hence $4R_s$.

## Two explicit global sections trivialize the complement

Identify $F^*B_Y$ with the augmentation ideal of the fifth infinitesimal
diagonal. In a separating coordinate x write its local parameter
$\epsilon=x_{second}-x_{first}$, with $\epsilon^5=0$.
For a regular differential $\omega=gdx$, its formal primitive jet
\[
J_\omega=\sum_{j=1}^4\frac{\partial_x^{j-1}g}{j!}\epsilon^j
\]
is coordinate-independent and global. Indeed its augmentation is zero
and $d_{second}J_\omega=\omega_{second}$ modulo
$I^4\Omega_{second}$, an invariant ideal. In any regular local
coordinate the map
$d_{second}:I\to\Omega_{second}/I^4\Omega_{second}$ sends
$\epsilon^j$ to $j\epsilon^{j-1}d\epsilon$ for $1\le j\le4$
and is an isomorphism. These two conditions therefore specify a unique
jet, so local formulas agree on overlaps and remain regular in branch
and infinity coordinates. Put $J=J_{\eta_0}$ and
$J_x=J_{x\eta_0}$. The top jet
$T_4=(x/V^3)\epsilon^4$ is the global four-differential
$x(dx)^4/V^3$: its orders at each finite branch point and at infinity
are respectively $4-3=1$ and $-2-12+15=1$, and it has no other poles.
Define
\[
K_1=J_x+3sJ_x^2+s^2J_x^3+4s^3J_x^4,
\]
\[
K_2=J+3sJJ_x+s^2JJ_x^2+4s^3JJ_x^3+s^2T_4.
\]
These are global sections of $F^*B_Y$. The flat N representatives
have coefficients $n_j=\partial_x^jQ/(j!\ell)$ for Q_O and Q_x.
For jets $a=\sum a_i\epsilon^i$, $b=\sum b_i\epsilon^i$,
the pairing is the scalar factor of $(dx)^5$ given by
$\sum_{i=1}^4(5-2i)a_i b_{5-i}$.
Direct substitution gives orthogonality of both K sections to both
N sections. Their first/second coefficient minor is
\[
(K_1)_1(K_2)_2-(K_1)_2(K_2)_1=-1/(2V^2)=2/F\ne0.
\]
Thus they are generically independent for EVERY smooth parameter.
The map $O_Y^2\to F^*E$ has a nonzero determinant between degree-zero
line bundles. Its zero divisor has degree zero, so it is everywhere
an isomorphism. No completeness or generic rank calculation is needed
for this implication.

The [exact short jet source](../../scripts/oct02_reciprocal_complement_global_jets.sage)
verifies these FOUR orthogonality identities, the exact minor and K1's
character identity. Its
[certificate](../../../litt3-computation-data/oct02_reciprocal_twisted_cartier/complement_global_jets.json)
also records a complete 17-section calculation (rank15), useful discovery
evidence but unnecessary to the proof. The changed direct checks ran
in 0.76 seconds, one core, Sage10.9. The
[universal polynomial verifier](../../scripts/oct02_reciprocal_twisted_cartier.sage)
checks the fourth-derivative identity independently by its two coefficients.

Evaluation of E is onto: locally the symplectic dual of evaluation
in the primitive basis $[t],\ldots,[t^4]$ is $[t^4]$. N contains
no such fiber vector, so its orthogonal complement cannot have zero
evaluation. Orthogonality gives its evaluation-kernel primitive order2
at an ordinary point and order3 at a Weierstrass point. This proves
the same second-fundamental divisor and kernel as for N.

## The unique nonsplit finite-local extension

The formal exponential identifies K1 with the canonical embedding of
$A^3$: its normalized primitive is
$(\exp(6sJ_x)-1)/(6s)$, truncated modulo $\epsilon^5$.
Equivalently its canonical connection is $-3d\log\ell$.
That line is saturated, because its nonzero Cartier-fixed logarithmic
form has only simple zeros. The determinant gives quotient $A^4$.

To exclude splitting, use the two inverse-character sections
$[Q_{-s,O}],[h_{-s}^2]$ spanning $\operatorname{Hom}(A^4,B_Y)$.
Their product with ell differs from one by a fifth-power scalar,
since $\ell h_{-s}^2=(x^5-S)^4$.
Pairing these sections with $[Q_x]=[\ell/(2s)]$, and removing that
common nonzero fifth-power factor, gives regular forms whose
coefficients BEFORE the Cartier fifth roots are respectively
\[
(3s^3,2s),\qquad (0,-2S^2)
\]
in the basis $\eta_0,x\eta_0$. Their determinant is nonzero.
Hence no nonzero map $A^4\to B_Y$ lands in E, so the extension is
nonsplit. Its Ext space is $H^1(A^{-1})$, of dimension one.
The exceptional twisted-Cartier vanishing says Frobenius kills this
entire space, consistent with the explicit trivialization above.

A nonzero Frobenius-killed extension remains nonsplit under etale
pullback. Lift its class to the twisted height-one additive torsor
sequence for $A^{-1}\xrightarrow{F}F^*A^{-1}=O$. If the pulled-back
extension split, its torsor class would differ from zero by a connecting
class of a constant; adjusting the original lift by that SAME constant
makes the pulled-back torsor trivial. Constants on both smooth connected
proper curves are k. A nontrivial finite-local torsor cannot become
trivial under separable field extension: its generic splitting requires
a purely inseparable fifth root. A generically trivial such torsor
extends trivially over the normal curve. The adjustment would therefore
make the original extension class zero, a contradiction.

## Original source noninclusion and projection loss

For infinity eta, the nonzero fourth coefficient above persists.
For finite eta, $Q_\eta=\lambda(Q_x-rQ_O)$ and $r\ne0$; pairing
with ell is a nonzero scalar multiple of the same pairing. Thus its
fourth coefficient also stays nonzero after the ORIGINAL separable q.
But the source normal form makes P the span of a linear Q class and
a cubic Q class. This proves the universal second-embedding noninclusion.

Over the generic point, project P to the symplectic plane qN along qE.
P is Lagrangian and contains its shared A line, so the projection lands
in that A line. Consequently $K=P\cap qE$ has rank one and P splits
generically as A plus K. The projection has poles only at qR_s, of
order at most two. Saturating K gives
$0\to A\oplus K\to P\to\text{torsion}_\tau\to0$,
with $0\le\tau\le2qR_s$ and degree formula $\deg K=7n-\deg\tau$.

If K were the canonical qA^3 subline, P would be the pullback of the
saturated Y plane spanned by the two original A and A^3 embeddings.
Its degree would be divisible by $\deg q=8n$, contradicting $\deg P=7n$.
Thus K maps nontrivially to qA^4, with effective divisor D. It cannot
have degree zero, because that would split the pulled-back nonsplit
extension. Therefore D is nonempty. Taking determinants and using
$\det P=O(7H)$ gives $\tau-D\sim7H$ and all asserted bounds.

## Moving-branch contact and the original residual divisor

At P_s put $x=x_0$, with $x_0^5=S$ and
$V_0=s(x_0^4-1)/x_0^2$. N and E have the same fiber there.
Their first/second primitive coefficient map is an isomorphism,
and those two coefficients give
$K_1=(S N_0-N_x)/(x_0^4-1)$. Hence A-cubed coincides with the
moving-branch A embedding and with no other double-zero A embedding.
Away from R_s, N and E are complementary, so there can be no other
defect in the span of these two characters.

For the moving branch their first/second jet wedge is $Z/V^3$, where
$Z=-SV/2+2sx^2(x-S)$. Its exact norm is
\[
N_{k(Y)/k(x)}Z=S(x-S)(x^5-S).
\]
The pole is six at O. At x0 only P_s is a zero, of order five; at
the branch point W_S it has order one. Thus
$\operatorname{div}Z=5P_s+W_S-6O$, proving the torsion relation.
The coordinate x is unramified at P_s and V is a unit, so the wedge
has order exactly five. Its Frobenius descent therefore has defect
exactly one at R_s. The universal polynomial verifier checks this norm.

At a source qR_s point choose P frames (a,p), with a its shared
A embedding. Set $f=\langle a,\ell\rangle$ and
$g=\langle p,\ell\rangle$. Then ord f=2, K is the saturation
of $fp-ga$, and loss is $\max(2-\operatorname{ord}g,0)$.
If the point lies in hR_X, it lies in selected E_sel, because qP_s
cannot lie in Delta=qW_eta. The P evaluation-kernel primitive has
order3 there (the original simple second-fundamental zero), whereas
the N kernel has order2. Their pairing is a unit, so g is a unit
and the loss is two.

In the moving chart, at loss two the K frame agrees with minus a up
to order two. The A and A-cubed embeddings meet to order one. That
first difference lies inside E, since the projection of a outside E
vanishes to order two. Therefore K to A-fourth has zero order EXACTLY
one. At loss one its fiber is still a=A-cubed, so the quotient has
zero order at least one. At loss zero its fiber is independent of a
and the quotient is nonzero.

Let a,b count loss-two and loss-one points. The degree identity gives
$\deg D=2a+b-7n$, while the forced zeros give $\deg D\ge a+b$.
Thus $a\ge7n$. Let C0,C1 be the reduced loss-zero and loss-one
divisors, B=C0+C1, and $D'=D-qR_s+C0$. This is effective.

All following divisor classes are transported to $T^{(1)}$.
The original source identities give $2E_{sel}\sim10H$ and
$E_{sel}+\Delta\sim13H$. In the moving chart Delta=qW_S,
so $2qO\sim2\Delta\sim16H$. The universal norm gives
$5qR_s+\Delta\sim6qO$, whereas the original SAME logarithmic
character gives $4(qR_s-qO)\sim E_{sel}-G-4H$.
Subtracting gives $qR_s-7H\sim G$ exactly. The determinant identity
now implies $D'\sim G-B$, with degree $n-\deg B$. The following
exact contact computation strengthens this class equality: the
constructed representative $D'+B$ is the original G itself.

## Exact positive-plane contact in all six charts

The universal explicit primitive formulas in the character theorem,
and the derivative identities in the
[degree-one endpoint construction](backup_lagrangian_degree_one_census.md),
give $\Pi_\eta=\operatorname{Sat}([Q_\eta],[Q_\eta^2/2])$.
Its determinant is $O(2(R_s-O)+W_\eta)$ and its canonical line
is the original $A_\eta$. This uses only the explicit construction,
not a universal assertion about the entire backup plane census.

Put $D_s=R_s-O$. The rational Q section in A has divisor $4D_s$,
and its wedge with $Q^2/2$ has divisor $12D_s+W_\eta$.
These are exact rational-frame identities: at R_s the derivative
order20 gives primitive orders21 and42 after subtracting fifth-power
parts, hence B orders4 and8. At W the primitive orders3 and6 give
B orders0 and1. At an ordinary point they give0 and0. At infinity
the two B orders are(-4,-7) if W=O, and(-4,-8) otherwise.
The wedge is unchanged by subtracting a fifth-power constant.
Therefore the rational quotient section $Q^2/2$ in $\Pi_\eta/A$
has divisor exactly $8D_s+W_\eta$.

On the ORIGINAL source write the normal form as
$\phi=L(Q+C)^3$, $L=(A_0/B_0)^5$, $C=a_0^5$.
The Q-fourth coefficient in
$\phi\,d(Q^2/2)-(Q^2/2)d\phi$ is $2L$, so Cartier gives
\[
\langle[\phi],[Q^2/2]\rangle=2(A_0/B_0)dQ^{(1)}.
\]
The coefficient C cancels. The normal-form divisors give
$\operatorname{div}(A_0/B_0)=2G-2H-12qD_s$ and
$\operatorname{div}(dQ^{(1)})=20qD_s+2\Delta$.
Thus the raw pairing divisor is $2G-2H+8qD_s+2\Delta$.
The settled [admissible reconstruction](admissible_line_reconstruction.md)
gives the rational phi section divisor $-2H+\Delta+G$ in P/A.
The other rational quotient section has divisor $8qD_s+\Delta$.
Subtracting these two frame divisors proves that the quotient
pairing has zero divisor EXACTLY G, all six charts. It cannot
vanish identically, since the two saturated planes have degrees7n
and8n. The original maps and source translation are retained.

For the moving chart, $\Pi_\eta$ is also
$\operatorname{Sat}(A_\eta+A^3)$: projection of its quadratic
primitive to E is the canonical A-cubed line. This can be seen
directly from the formal primitive jets: with
$N_\eta=N_x-SN_0$, the pairing of $N_\eta^2$ with K1 is zero.
Expanding its coefficient gives
$3s^2x^5+r(3x^5+2s^2)+2r^2$, which vanishes identically
at $r=S=-s^2$. The two planes agree generically, and their
saturations consequently agree. Their target saturation defect is
the already proved single R_s.

The restricted symplectic pairing on E has divisor $2R_s$.
Indeed the Pfaffian of the pairing on $N\oplus E$ is the product
of the two restricted pairings. Its divisor is the determinant
divisor $4R_s$ of the generically invertible inclusion in B.
Subtracting the already proved N pairing divisor $2R_s$ gives
the E pairing divisor exactly.
The quotient pairing of K with A-cubed has divisor D. Passing
from K to P/A divides its rational scalar by the source contact
divisor tau. Passing from A-cubed to $\Pi_\eta/A$ divides by the
target saturation divisor R_s. Therefore the exact positive-plane
contact just proved has divisor $D+2qR_s-\tau-qR_s$.
It follows that $G=D+qR_s-\tau$ exactly. Since
$\tau=2qR_s-2C0-C1$, this says
$G=D-qR_s+2C0+C1=D'+B$. All loss-deficit points therefore
lie in the original G, without a dimension hypothesis on |G|.
