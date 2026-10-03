# Proof: both elliptic Weierstrass-Q normal forms are impossible

Version1,3 October2026. Independently accepted in the [elliptic Weierstrass audit](../../Research/audits/Q0_FOUR_ELLIPTIC_WEIERSTRASS_AUDIT_2026_10_03.md). There is no candidate sweep or new polynomial computation.

Use the TWO complete [elliptic normal forms](actual_q0_tensor_degree_four_elliptic_hyperelliptic_form.md) and normalize D=ONE by a common affine scale of the centered Xi. This preserves the [selected branch Sidon property](../curve_arithmetic/fixed_x_branch_strong_sidon.md). Suppose Q is Weierstrass.

## Proportional odd numerators: the existing polynomial contradiction still applies

In the proportional case A=(z−a)L, L=l1z+l0, and b=b1(z−e), e∉{0,a}. Put Y=by, so the same actual functions become
\[
X_1=L/z+Y/[z^2(z-a)],\qquad X_2=L/\kappa+\kappa Y/(z-a),
\]
\[
Y^2=az(z-a)S,\qquad S=(z-a)L^2+1-z^3,\qquad\kappa^2=1/a.
\]
The polynomial S may have the double root e, since this is a singular affine model of the smooth elliptic B. This edge is not discarded. Nevertheless S has degree THREE and S(0)S(a)≠0: the original cubic model is smooth at R1,Q, and b is nonzero there. In particular l1²−1≠0 and a³≠1. Sidon excludes l0=ZERO or l1=ZERO, because these give a constant even part of X1 or X2.

The derivation δ=Y d/dz is b times the original y d/dz. Its two derivative norms remain rational squares, since Norm(b)=b². Thus the same explicit equations as in the genus-two Weierstrass proof hold:
\[
H1^2=T1^2-(l0^2/a)M,\quad H2^2=T2^2-a l1^2M,
\]
\[
M=z(z-a)^3S,\quad T2=2aS+3z(z-a)S',\quad T1=T2+3(z-a)S.
\]
The entire polynomial contradiction there requires only deg S=THREE, S(0)S(a)≠0 and l0l1≠0; it does NOT require distinct roots of S. To check coverage explicitly, the factors H−T,H+T have degrees THREE and FOUR; at a the value T is nonzero, so (z−a)³ belongs entirely to one factor. If on the degree-THREE side, it fills that side. If on the degree-FOUR side, its extra linear root is any root of zS, including a repeated root of S. The remaining factor is still exactly zS/(z−r); division S=(z−r)V and the identity V+zV'=3(l1²−1)(z−a)² remain valid with repeated roots. No partition relies on squarefreeness.

Consequently the second norm square leaves precisely the same TWO cases: l1²=TWO,l1l0=2a,S=(z−a)³+1−a³; or l1²=FOUR,l1l0=2a,a³=TWO,S=3z³+2a²z+FOUR. The first norm square contradicts both by the coefficient and a-derivative comparisons already displayed in that proof. Thus the proportional elliptic case is excluded, including its genuine double-factor edge.

## Coprime odd numerators: two cubic square factors give incompatible jets

In the coprime case L=ℓ(z−a), and
\[
y^2=\Phi=(z-a)J,\qquad J=\gamma z(z-e),\quad\gamma=\ell^2+1\ne0,
\]
with e∉{0,a}. Write b=vz+w,c=z+u. The actual functions are
\[
X_1=\ell+\ell u/z+b y/[z^2(z-a)],\qquad
X_2=\ell(vz+w)+c y/(z-a).
\]
Sidon gives ℓuv≠0; the simple Q-pole gives b(a)c(a)≠0.

For δ=y d/dz, the cleared derivative norms are necessary squares
\[
H1^2=T1^2-\ell^2u^2(z-a)^2\Phi,\qquad
H2^2=T2^2-\ell^2v^2(z-a)^2\Phi,
\]
where
\[
T1=b'\Phi+b\Phi'/2-b\Phi(2/z+1/(z-a)),
\quad T2=c'\Phi+c\Phi'/2-c\Phi/(z-a).
\]
Both Ti are polynomials of degree THREE with nonzero leading coefficients, and Ti(a)=−p_i(a)J(a)/2≠0, for p1=b,p2=c. Each product (Hi−Ti)(Hi+Ti) has degree FIVE, and the two factors have degrees TWO and THREE after choosing the leading sign. The entire multiplicity THREE of z−a must be in the degree-THREE factor. Thus the degree-TWO factor is a multiple of J. It follows that BOTH Ti lie in the pencil spanned by J and (z−a)³. This includes both square-root signs; no finite ramification or lower-degree stratum has been omitted, since ℓuv and the two actual pole coefficients are nonzero.

Put bA=b(a),cA=c(a)=a+u and d=v/bA−1/cA. Since Φ=(z−a)J, direct expansion gives
\[
T1=-bJ/2+(z-a)\bigl[b'J+bJ'/2-2bJ/z\bigr],
\]
\[
T2=-cJ/2+(z-a)\bigl[c'J+cJ'/2\bigr].
\]
The normalized difference T1/bA−T2/cA has zero constant J coefficient at a, so the pencil condition makes it divisible by (z−a)³. Divide by (z−a) and γ. Its exact quadratic expression is
\[
I=(z-e)(dz/2-2)
 +(z-a)\bigl[d(2z-e)/2-2(v/bA)(z-e)\bigr].
\]
The equations I(a)=I'(a)=ZERO give
\[
d=4/a,\qquad e(u-a)=a^2-2au.
\]
For the second relation, use v/bA=d+1/cA. No division by u or a−u is needed in these equations.

The individual pencil condition for T2 also gives T2'(a)/T2(a)=J'(a)/J(a). From the displayed expansion T2'(a)=J(a)/2, hence
\[
-1/(a+u)=1/a+1/(a-e),\qquad
e(2a+u)=a(3a+2u).
\]
Eliminate e from the last two equations. Multiply the first by2a+u and the second by u−a; their difference reduces to
\[
4au(a+u)=0.
\]
But a,u,cA=a+u are all nonzero. This is a contradiction. In particular no division by a−u or2a+u has silently removed an edge.

Thus BOTH normal-form cases are excluded when the common simple pole is Weierstrass. The elliptic NON-Weierstrass-Q stratum remains explicit; no Y-cover has been constructed or substituted.
