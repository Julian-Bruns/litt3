# Proof: a residue resolution of the Frobenius pushforward

[Statement](../../Theorems/projective_connections/dormant_pushforward_resolution.md).
The five distinct-kernel construction and its cohomological reduction
were returned by Pro on 19 September 2026. The residue formulation,
removal of the separability hypothesis from the resolution, arbitrary
coefficient rank, and the four-test determinant exclusion are local
extensions. The missing stable-pullback rank bound is not claimed.

## The universal complementary operator

The [quintic calculation](genus_two_dormant_quintic.md) gives
\(r_T''=3r_T^2\) over A, including when A is nonreduced.
Differentiating gives \(r_T'''=r_T r_T'\). Consequently
\[
(D^2-r_T)(D^3+r_TD+3r_T')
=(D^3+r_TD+3r_T')(D^2-r_T)=D^5=0.
\]
The last equality is for derivations in a regular étale coordinate
in characteristic five. The rank-two kernel and complementary
operator are the [intrinsic Bol construction](dormant_bol_complex.md),
now over the finite coefficient algebra A. Equivalently, solve the
equation from its value and first derivative: the coefficients
2!, 3!, 4! are units, and the dormant identities supply compatibility
at the fifth step. This gives a locally free A-valued rank-two
kernel, not merely its reduced fibers.

Its Wronskian \(\beta_A\) is a perfect alternating pairing into
\(\omega_C\otimes A\). Finite Frobenius duality is the perfect
Cartier pairing \(P\otimes Q\to\omega_C\). In local density
frames the complementary map is characterized by
\[
\beta_A(s,\mathcal A_T h)
=4\operatorname{Car}_{\Phi}(sh\,dz).
                                                               \tag{5}
\]
This also defines it globally. At a point, expand in
\(1,z,z^2,z^3,z^4\); the normalized solution jets are
\[
a_T=(1,0,3R,S,R^2),\qquad b_T=(0,1,0,R,3S),
\quad R=r_T(q),\ S=r_T'(q).
                                                               \tag{6}
\]
Substitution into the Wronskian proves (5). The returned symbolic
checker verifies the same identity with independent coefficients.

For any monic degree-five polynomial, the coefficient-of-T-fourth
functional on its quotient algebra has perfect multiplication
pairing. For a nonzero polynomial a of degree d less than five,
\(\ell(aT^{4-d})\) is its nonzero leading coefficient. This proves
nondegeneracy without reducedness. Applying \(\ell\) to
\(\beta_A\) gives the stated perfect alternating pairing on
\(\mathcal W\).

The T-degree of \(\mathcal A_T h\) is at most three: the derivative
term is constant in T and r_T has degree three. Thus
\(\varepsilon\alpha=0\). Equation (5), followed by \(\ell\),
makes \(\alpha\) four times the adjoint of \(\varepsilon\).
It remains to prove that \(\varepsilon\) is everywhere surjective.

## Fiber surjectivity, including a nonreduced dormant scheme

Fix q on Y, a regular coordinate z, and a k-linear functional
\((l_0,\ldots,l_4)\) on the corresponding fiber of P annihilating
the image of \(\varepsilon\). Multiplying the two universal
solutions (6) by every element of A and using the perfect residue
pairing gives identities in A:
\[
l_0+3Rl_2+Sl_3+R^2l_4=0,\qquad
l_1+Rl_3+3Sl_4=0.                                            \tag{7}
\]
Write \(r_T=r_0+Th_1+T^2h_2+T^3h_3\) in the coordinate z.
As quadratic tensors, the three coefficients are
\[
h_1=(u^2+3a_4u+3a_4^2+a_3)\eta^2,\quad
h_2=(u+2a_4)\eta^2,\quad h_3=2\eta^2,\quad \eta=du/v.
                                                               \tag{8}
\]
They form a basis of \(H^0(Y,\omega_Y^2)\). This system is
basepoint-free, so R is not a scalar in A: its representative has
degree at most three, and at least one nonconstant coefficient is
nonzero at q.

If \(l_4=0\), the second equation of (7) forces \(l_1=l_3=0\),
and then the first forces \(l_0=l_2=0\). If \(l_4\ne0\),
(7) yields scalar constants a,b,c,d with
\(S=aR+b\) and \(R^2=cR+d\) in A. Since r and its first two
z-derivatives have T-degree at most three, the universal identity
\(r_T''=3r_T^2\) then implies coefficientwise
\[
h_j'(q)=a h_j(q),\qquad h_j''(q)=3c h_j(q),\qquad 1\le j\le3.
                                                               \tag{9}
\]
Here equality of polynomials of degree at most three modulo a
degree-five polynomial is actual equality. No inference from
values at reduced roots is being used.

There is always a bicanonical section vanishing to order exactly
one or two at q. At a finite nonbranch point use
\((u-u(q))\eta^2\), of order one; at a branch point the same
section has order two. At infinity use \(u\eta^2\), of order two.
Such a section contradicts (9), since 2 is invertible. Therefore
every annihilating functional is zero and \(\varepsilon\) is
surjective. Its adjoint is a subbundle injection, so (1) follows
from the ranks five, ten, five.

When \(\Psi\) is separable with leading coefficient c, residue
interpolation gives
\(\ell(a)=c\sum_i a(T_i)/\Psi'(T_i)\).
Rescale the five summands by these nonzero weights, and rescale Q
by c, to get (3). The precise scalar is unnecessary for exactness
or for the ranks of the connecting maps. In the specified
one-parameter family the returned symbolic identity
\(\operatorname{Disc}_T\Psi=-[t(t-1)(t-2)(t-3)]^2\)
proves separability at every smooth algebraic parameter.

## Cohomology and the actual five determinant sections

If S is semistable of rank r and degree zero, then
\(H^0(S\omega_Y^{-1})=H^1(S\omega_Y^2)=0\). Riemann--Roch
gives dimensions 3r for the other two groups. Projection formula
and the long exact sequence of (1) give (4).

For a degree-n finite étale q, use
\(E=q^{(1)}_*\mathcal O_{Z^{(1)}}\). Étale base change gives
\(\Phi^*E=q_*\mathcal O_Z\), which is étale-trivial and
semistable of degree zero. The inclusion of section spaces in
(4) becomes the sum of the five actual scalar Bol inclusions in
\(H^0(Z,\omega_Z^2)\). Riemann--Roch on the connected components
gives total dimension 3n.
This construction uses one actual cover and makes no simultaneous
Galois-closure assertion about a common span.

For stable rank-two E, a nonzero map \(E^\vee\to\mathcal V_i\)
cannot have rank one. Its rank-one image would be a quotient of
the slope-zero stable source, of degree at least one; its
saturation in the slope-one stable target has degree at most
zero. Thus every such map has generic rank two. If
\(D=\det E\ne\mathcal O_C\), all determinants belong to the
one-dimensional space \(H^0(\omega_C D)\). Two independent maps
would give a projective pencil and a homogeneous quadratic
determinant. Over k it has a zero, contradicting the rank-two
property. Hence each section dimension is at most one. Formula
(4) with r=2 gives the rank-one equivalence and excludes rank zero.

For any rank-two E with trivial determinant, choose a saturated
line L in E. In \(0\to L\to E\to L^{-1}\to0\), tensor by
\(\mathcal V_i\). The connecting map is a form on
\(H^0(\mathcal V_i L^{-1})\); its value on s,t is cup product
of the extension class with \(s\wedge t\). It is alternating,
so its rank is even. Serre duality and Riemann--Roch give
\[
h^0(\mathcal V_i L)-h^0(\mathcal V_i L^{-1})=2\deg L.
\]
Thus \(h^0(\mathcal V_i E)\) is even. Their sum is at most six,
so at most three tests are nonzero.

Finally work locally on a scheme carrying a universal E. The
vanishings above represent the cohomology of \(\mathcal W E\)
by the actual square matrix \(\delta\), in degrees zero and one.
In the reduced case the same complex is the direct sum of the
five individual cohomology complexes. Multiplicativity of the
determinant gives \(\det\delta=u\prod_i\sigma_i\).
At a common point each individual complex has fiber cohomology
dimension one in both degrees, so cancelling its invertible
blocks leaves the one-by-one differential \(\sigma_i\).
The rank-one block of \(\delta\) cancels similarly. Minimal free
complexes over the same local ring representing the same perfect
complex are isomorphic. Hence
\(\delta\sim\operatorname{diag}(1,\sigma_0,\ldots,\sigma_4)\),
and its two-by-two minors generate exactly the five-test ideal.

The proof supplies no rank lower bound of two when S is stable.
Ordinariness, transcendence, or an arbitrary-rank common-cover
reduction has not been used or established.

## Exact supporting checks

The [maintained checker](../../scripts/genus_two/check_bol_pushforward_identities.py)
verifies the discriminant, universal-family curvature identity,
bicanonical coefficients, and local adjoint normalization by polynomial
identities over characteristic five. It also verifies smoothness and
the stated quintic for \(v^2=u^5+u^3+u\). It ran successfully under
Sage Python on 19 September 2026. The unmodified returned script,
source hashes, execution scope, and log are retained in the external
[receipt directory](../../../litt3-computation-data/bol_pushforward_20260919/).
The proof itself, including nonreduced fibers and the cohomology
consequences, passed the [bounded audit](../../Research/audits/DORMANT_PUSHFORWARD_RESOLUTION_AUDIT_2026_09_19.md).
