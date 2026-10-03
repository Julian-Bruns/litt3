# Full atlas projection and exact finite-algebra recovery

Version2,3October2026. Use the
[intrinsic extension data](../../Definitions/intrinsic_atlas_incidence.md):
characteristic five, stable rank-two V, det V=T M, fixed nonsplit
O->K->T, fixed j0, and prescribed tau^3=O. Put n=g-1,
A=Hom(V,M), B=Ext1(V,O), H=Ext1(V,K), each of the first two
spaces having dimension4n. No acyclicity assumption on V is made.

## Every actual atlas lies on the full rectangular-rank open

For nonzero alpha define L_alpha:A->H by p->p^*D(alpha), and let
\[
U_{\rm rk}=\{[\alpha]\in\mathbf P(B):
\operatorname{rank}L_\alpha=4n\}.
\]
At EVERY normalized intrinsic atlas, L_alpha is injective.
Thus this open retains ALL actual atlases, including H0(V)>0
and every prescribed cubic determinant character.

On U_rk form
\[
0\longrightarrow A\otimes O(-5)\xrightarrow{L}
H\otimes O\longrightarrow Q\longrightarrow0,
\qquad \operatorname{rank}Q=8n.
\]
Q is the Frobenius pullback of the corresponding linear-coefficient
quotient, with constant coefficients transported. Let Z_0 be the
zero scheme of the section s_I of Q(1) induced by I.
For each representative alpha on Z_0 the equation
I(alpha)=L_alpha(p) has a UNIQUE p. Retain the open
\[
Z=\{[\alpha]\in Z_0:\ell(p,\alpha)\ne0\}.
\]
Nonvanishing is independent of the representative, since
(alpha,p)->(t alpha,t^-4p) scales ell by t^-3.
Z is finite reduced, possibly empty, and the ENTIRE normalized
intrinsic atlas scheme is a finite étale mu_3-torsor over Z.
Projection embeds Z as a closed subscheme of P(B); all quotient
coordinates are recovered by linear algebra on the maximal-minor cover.

The ell condition is essential here; full rectangular rank alone
is not asserted to make every unnormalized extension morphism valid.
For genus nine this is projection to P31 with a rank64 quotient
bundle, including exceptional cohomology. Its rank exceeds the base
dimension without proving that its specific section has no zero.

## The older acyclic open remains a useful special case

Put V_alpha=E_alpha^D/j0(e O), and let C_alpha:H0(M)->H1(T)
be its3n-square cup matrix. The open U_theta={det C_alpha!=0}
is contained in U_rk. On U_theta every nonzero solution of
I(alpha)=L_alpha(p) already has ell!=0.
If H0(V)=0, Z lies entirely in U_theta, so its whole zero scheme
gives the older acyclic criterion. If H0(V)>0, actual atlases lie
outside U_theta but remain covered by U_rk.
No fixed square polar matrix or preferred maximal minor is substituted.

## One finite-algebra lemma supplies exact recovery in every chart

Let k be perfect and let X be a finite étale affine scheme presented by
\[
H(b)v=d(b),\qquad F(v,b)=0,\qquad c(v,b)\ne0.
\]
Assume H(b) has full column rank at EVERY geometric point of X.
Then projection to b is a closed immersion, its elimination ideal
is radical, and v and c^-1 are polynomial functions on its finite
coordinate algebra.

If J consists of verified necessary b-consequences and k[b]/J is
finite reduced, recover X on each field factor: solve H(b)v=d(b);
discard inconsistent or rank-deficient factors; then retain exactly
those unique solutions with F=0 and c!=0. Put w=c^-1 if that
inverse is included in the presentation. This is equality of finite
reduced schemes over all field extensions, not only rational points.

For a reduced atlas ideal, g^(5^e) in the ideal implies g is in it.
When extracting a displayed fifth power over a perfect field, root
its coefficients as well as dividing its monomial exponents.

In the actual [rooted compact charts](rooted_atlas_charts.md), take
b_h=s_h=0 for h<j, b_j=s_j=1, and
H_j(b)v=d_j for n(v,b)=0 and those s rows. The swapped-pencil
kernel is kv at every actual point; the s_j row kills it.
Hence H_j has rank32, and the lemma retains the ENTIRE old chart
recovery, including the three normalized lifts and admissibility inverse.
The same application works in any dimension with that actual
one-dimensional swapped-kernel hypothesis.

A necessary b-ideal may be positive-dimensional. No bounded elimination
degree, chosen pivot, finite candidate algebra or emptiness certificate
is supplied merely by this projection theorem. The intrinsic and scalar
applications do not presume an unverified identification of their bases.

[Proof](../../Proofs/atlases/theta_open_atlas_projection.md).
