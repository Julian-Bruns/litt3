# Simultaneous numerators and primitive involution secants

Version1, 25 September2026. Retain ALL actual hypotheses of
[Klein-four pole shortening](klein_four_pole_shortening.md), with
K=k(t), L=k(S), and the two specified endpoint identities. No Galois
action on the cubic reconstruction is assumed.

For every nonidentity involution sigma in Gal(L/K), the function
\[
\rho_\sigma=\frac{v-\sigma(v)}{u-\sigma(u)}
\]
generates the quadratic field L^{<sigma>} over K. This holds in every
endpoint degree under the stated hypotheses. In particular, the
fully coalesced endpoint-label case does not permit a rational secant.

Let e=s+j be the number of common-pole parameter values, let q_i count
triple-pole fibers whose inertia is the kernel of character i, and
put c_i=j-q_i and h_i=g_i+1. Then the actual character numerators obey
\[
u_i=\frac{U_i z_i}{E C_i},\quad
v_i=\frac{V_i z_i}{t^3 E C_i},\quad
\deg U_i,\deg V_i\le\ell_i=3+e+c_i-h_i,
\quad 0\ne V_i-\epsilon t^7U_i\in E k[t],
\]
where E is squarefree of degree e and divides t^{29}-1, and C_i has
degree c_i. Moreover, every pair of these numerator vectors is
independent over K:
\[
U_iV_j-U_jV_i\ne0\qquad(i\ne j).
\]
Writing b(e)=min(10,3+ceil(e/2)), the following uniform bounds hold:
\[
g(S)\le 3b(e)+2j-3-2\mathbf1_{\{e\text{ odd},\ e\le13\}},
\qquad g(S)\le\min(n+1,85).
\]
In particular, g(S)<=n for odd n. Equality g(S)=n+1 is possible
numerically only for n=26,28,...,54, with e=14, one common-pole point
in each simple-pole fiber, and no fiber with two triple poles.
In 14<=n<=182, the connected cubic reconstruction has at least88
branch points. These are necessary bounds, not geometric witnesses.

Neither endpoint is a quadratic polynomial or a fractional-linear
function of the other over K. Consequently each admits the unique
genuine degree-(2,1) rational representation
\[
v=a u+b+\frac{c}{u-d},\quad
u=\widetilde a v+\widetilde b+\frac{\widetilde c}{v-\widetilde d},
\quad ac\widetilde a\widetilde c\ne0,\quad
a\widetilde a\ne1,
\]
with coefficients in K. Actual nonlinear endpoint compatibility is
still open; no degree14..182 is completely excluded here.

[Proof and exact evidence](../../Proofs/cartier_and_spin/klein_four_simultaneous_quotients.md).
