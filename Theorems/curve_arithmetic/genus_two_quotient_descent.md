# Effective descent of actual genus-two étale quotients

Version2,3October2026. Let k be algebraically closed of odd
characteristic and let C/k be smooth, projective and connected of genus
G>=2. Count finite étale maps C->Y with g(Y)=2 up to an isomorphism of
the target commuting with the map; equivalently, count their actual
embedded quotient fields in k(C).

The number of these quotients is at most
\[
N_G:=\binom{2G+3}{3}6^{2G}.
\]
The bound follows from a reduced zero-dimensional open subset of an
explicit affine polynomial system. It counts actual maps, including
degrees divisible by the characteristic, and requires no Jacobian
simplicity or joint-minimality hypothesis.

There is also an intrinsic recovery statement, valid for ANY finite
etale quotient u:C->Y with g(Y)>=2, in ANY characteristic. The
integral endomorphism \(T_u=u^*\operatorname{Nm}_u\) of J(C)
determines the actual subfield u*k(Y) inside k(C).
If C is defined over a finite
field E, u descends over E up to target isomorphism if and only if
T_u is defined over E. Purely inseparable maps can occur in the
auxiliary reconstruction; the original quotient remains étale.

Put \(R_G=G(2G-1)\) and
\(\mathcal M(R)=\operatorname{lcm}_{\varphi(j)\le R}j\).
For a fixed model of C over E, the Frobenius orbit length of EVERY
actual hyperbolic etale quotient field divides \(\mathcal M(R_G)\).
In particular all these quotients descend simultaneously over the
degree-\(\mathcal M(R_G)\) extension of E. This uses the actual
Rosati-symmetric norm endomorphism, not just a Jacobian isogeny factor.

For the family C_t: v^2=u(u-1)(u-2)(u-3)(u-t) in characteristic five,
the number of ordered triples (a,b,t) obtained from actual étale maps
C->C_t by pulling back (du/v,u du/v) is at most
\[
(2G+1)6^{2G}.
\]
In particular this bounds the number of parameters t occurring from
the fixed source.

For the arithmetic assertion take k=overline(F_q). Let X/F_q be smooth,
projective, geometrically connected of genus h>=2, with q odd. If an
actual span X_k<-Z->Y has both maps finite étale,
g(Y)=2 and n=deg(Z/X), then the ORIGINAL span descends, up to target
isomorphism, to F_(q^(ae)) for integers
\[
a\le n(n!)^{2h-1},\qquad e\le N_G,\qquad
e\mid\mathcal M(R_G),\qquad G=1+n(h-1).
\]
The first leg is defined over F_(q^a) with degree n unchanged. The
coefficient-Frobenius-q orbit of [Y] consequently has length dividing
ae. No common refinement, lift, Hom-vanishing or restriction on n
is needed.

If the coefficient-Frobenius-q orbit of [Y] has PRIME length ell,
then the sharper necessary condition is
\[
\ell\le\max\{n(n!)^{2h-1},\;G(2G-1)+1\}.
\]

For the project's fixed h=9 curve over F25, put B=335999, D=B!,
G_star=1+8D, L_star=(B+1)^2 and
\[
K=D(D!)^{18}3^{4G_{\rm star}^2L_{\rm star}}
(42000!)^{2G_{\rm star}+L_{\rm star}}.
\]
The selected main partner has prime Frobenius-25 moduli orbit ell>K.
Every actual common-cover witness for that partner must satisfy
\[
\boxed{n(n!)^{17}\ge\ell,\qquad n>D^2=(335999!)^2.}
\]
This is a lower bound on every possible witness, not an upper bound
or an exclusion in arbitrary degree. Both common-cover problems
remain open.

[Proof](../../Proofs/curve_arithmetic/genus_two_quotient_descent.md).
