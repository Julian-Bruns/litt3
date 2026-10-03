# Proof: the Weierstrass-Q degree-four genus-two branch is impossible

Version1,3 October2026. Independently accepted in the [whole genus-two audit](../../Research/audits/Q0_FOUR_GENUS_TWO_WHOLE_AUDIT_2026_10_03.md). The argument is exact polynomial factorization, with no new numerical or elimination calculation.

## Exact normalized model and two necessary polynomial squares

Use the [genus-two hyperelliptic normal form](actual_q0_tensor_degree_four_genus_two_hyperelliptic_form.md). Center q0(X)=X²+D and scale both centered Xi, y and A by √D. For the present necessary local argument this sets D=ONE. The selected branch polynomial changes by that affine scale, which preserves its [strong Sidon property](../curve_arithmetic/fixed_x_branch_strong_sidon.md).

Suppose Q is Weierstrass. Then A(a)=0, so A=(z−a)L with L=l1z+l0. The model and functions become
\[
\Phi=az(z-a)S,\quad S=(z-a)L^2+1-z^3,\qquad
X_1=L/z+y/[z^2(z-a)],\quad X_2=L/\kappa+\kappa y/(z-a),\quad\kappa^2=1/a.
\]
Here a≠0,a³≠1; S has degree THREE with leading coefficient s=l1²−1≠0, and its three roots are distinct and different from ZERO and a. If l0=0, the invariant part of X1 is constant; if l1=0, the invariant part of X2 is constant. The Sidon symmetry exclusion forbids either. Hence l0l1≠0.

Set σ=dz/y and δ=y d/dz. The actual ramification indices ONE or THREE imply that div(dx_i) is even, including its poles. Also div(σ)=2R2 is even. Therefore Norm(δXi) has even divisor on the z-line and is a rational square. Direct differentiation gives necessary polynomial squares
\[
H_1^2=T_1^2-(l0^2/a)M,\qquad H_2^2=T_2^2-a l1^2M,
\]
where
\[
M=z(z-a)^3S,\quad
T_2=2aS+3z(z-a)S',\quad T_1=T_2+3(z-a)S.
\]
Indeed δX1=−l0y/z²+aT1/[z²(z−a)] and δX2=l1y/κ+κ aT2/(z−a). Their norms differ from these two displayed polynomial squares only by nonzero constants and square denominators. Since the constant field is algebraically closed, each Hi can be chosen polynomial.

The leading coefficients of T1,T2 are2s,4s. Each Hi has degree FOUR. Choose its sign so H_i−T_i has degree THREE and H_i+T_i has degree FOUR: their product is a nonzero constant times M, of degree SEVEN. At z=a both Ti have value2aS(a)≠0. Thus all THREE copies of the factor z−a occur on exactly ONE side. Since zS is squarefree, there are precisely TWO factorization possibilities: the degree-THREE side is a multiple of (z−a)³; or the degree-FOUR side is a multiple of (z−a)³(z−r), with r a root of zS. No other partition is omitted.

## The second square leaves only two explicit cases

For H2, the first factorization possibility is impossible. In that case its degree-FOUR side is a multiple h zS. Evaluating T2=(G−F)/2 at a forces h=FOUR, so the leading coefficient of T2 would be2s, whereas it is4s, with s≠0.

Hence write
\[
H_2+T_2=k(z-a)^3(z-r),\qquad
H_2-T_2=h\,zS/(z-r).
\]
Leading coefficients and evaluation at a give k=3s,h=a−r. The product condition is
\[
(a-r)s=3a l1^2.
\]
If r=ZERO, coefficient comparison gives l1²=TWO and S'=3(z−a)². Indeed the displayed factor identity reduces to z(z−a)S'=3z(z−a)³. Comparing the z² and z coefficients of S then gives l1l0=2a. Thus
\[
l1^2=2,\qquad l0l1=2a,\qquad S=(z-a)^3+1-a^3.
\]

If r is a root of S, put S=(z−r)V. The same factor identity reduces to
\[
V+zV'=3s(z-a)^2,
\quad\text{hence}\quad V=s(z^2+2az+3a^2).
\]
Using (a−r)s=3a l1² and comparing the next TWO coefficients of S gives
\[
l1l0=2a,\qquad l0^2=3a^2(1-l1^2).
\]
Writing t=l1², these give t²−t+3=0, so t is TWO or FOUR. The value TWO would make r=ZERO, impossible since S(0)≠0 in this subcase. Therefore t=FOUR,r=2a. Evaluation at a gives a³=TWO, and
\[
l1^2=4,\qquad l0l1=2a,\qquad a^3=2,\qquad S=3z^3+2a^2z+4.
\]
These TWO cases cover every possible second square.

## Neither case allows the first square

In the first case, l0²/a=2a and s=ONE. If (z−a)³ is on the degree-THREE side of the first square, evaluating at a and matching the product makes its alleged T1 equal2zS−a(z−a)³. Subtracting this from the actual T1 gives (z−a)(1−a³), nonzero. If instead the factor is on the degree-FOUR side, its extra root must be r=−a, from leading coefficients and the product. Its degree-THREE side is F=2a zS/(z+a). At a, S'=ZERO and F'/F=1/(2a), so the alleged T1' is S(a). The actual T1' is3S(a), and S(a)≠0. This is again a contradiction.

In the second case, l0²/a=a and s=THREE. If (z−a)³ is on the degree-THREE side, the alleged T1 is2zS+2a(z−a)³. Its difference from the actual T1 is
\[
(z-a)\bigl(3az^2+2a^2z\bigr),
\]
which is nonzero. In the degree-FOUR alternative the extra root is again−a, but S(−a)=FOUR, so it is not a root of zS. This alternative is impossible as well.

Thus the two necessary derivative-norm squares cannot coexist for a smooth Weierstrass-Q genus-two branch with nonconstant invariant parts. The constant cases were excluded by the fixed branch Sidon property. The WHOLE Weierstrass-Q stratum is excluded, retaining the actual two-X étale antecedent and leaving the non-Weierstrass and elliptic strata explicit.
