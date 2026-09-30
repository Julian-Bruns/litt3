# Proof: the fivefold parameter space and the remaining geometric locus

[Statement](../../Theorems/projective_connections/backup_rank_two_simultaneous_locus.md).
All moduli and bundle statements are over the algebraic closure.
The actual coefficient bundles are the five specified Bol kernels.

## The finite étale presentation and the intersection number

Let \(A=J(C)\) and \(S_0=SU_C(2,\mathcal O_C)=\mathbf P^3\).
The map
\[
\rho:S_0\times A\longrightarrow\mathcal U,
\qquad (E_0,M)\longmapsto E_0\otimes M
\]
is the base change of \([2]:A\to A\) along the determinant map.
Equivalently, it is the quotient by the free action
\((E_0,M)\mapsto(E_0\otimes\kappa,M\otimes\kappa)\) of \(A[2]\).
Thus it is finite étale of degree sixteen; \(\mathcal U\) is a
smooth projective fivefold. Let H be the hyperplane class on \(S_0\).

Each determinant section is nonzero: for a line M outside the
proper theta divisor of \(\mathcal V_i\), the bundle
\(M\oplus M\) has no such sections. Its line on the first factor
has degree two, by the rank-two determinant calculation. On the
second factor, the tested bundle \(\mathcal V_i\otimes E_0\)
has rank four and Euler characteristic zero, so the determinant
line has theta class \(4\Theta\). There is no mixed Picard class
on \(\mathbf P^3\times A\). Consequently
\[
\rho^*[\mathcal D_i]=2H+4\Theta
\quad\text{numerically}.
\tag{2}
\]
This is an ample class, so every \(\mathcal D_i\) is an effective
ample Cartier divisor. Five such divisors on a projective fivefold
have nonempty common support: at each step an ample divisor meets
every positive-dimensional projective component unless it already
contains it. This proves nonemptiness without proper intersection.

Using \(H^3=1\) and \(\Theta^2=2\), their top intersection is
\[
\mathcal D_0\cdots\mathcal D_4
=\frac1{16}\binom53 2^3 4^2\Theta^2=160.
\tag{3}
\]
If their common zero scheme is finite, the five equations have
height five in the regular local rings of \(\mathcal U\), and
form a regular sequence. Its length is therefore (3).

## Stability

A strictly semistable E has degree-zero line factors \(L_1,L_2\).
For each i, tensoring the extension by \(\mathcal V_i\) gives
cohomology with Euler characteristic zero on both factors. Hence
the section test is positive exactly when it is positive on one
of the two factors. This also proves invariance under S-equivalence.
Each line belongs to at most two of the five base theta divisors.
Two factors can account for at most four tests, not all five.
Every E in \(\mathcal Z\) is therefore stable.

## A two-torsion self-twist would come from an actual double

Suppose a stable E in \(\mathcal Z\) has \(E\simeq E\otimes\kappa\)
for a nontrivial two-torsion line. The square of this isomorphism
is a scalar because \(\operatorname{End}(E)=k\); rescale it so its
square is the identity under a chosen trivialization of \(\kappa^2\).
It gives an action of the actual étale algebra
\(\mathcal O_C\oplus\kappa\). Its trace, a section of the
nontrivial degree-zero line \(\kappa\), vanishes. Étale locally
the two eigenbundles thus both have rank one, since two is invertible.
Equivalently E is the pushforward of a line bundle L on the
corresponding connected étale double. Euler characteristics give
\(\deg L=0\). The
[simultaneous double-cover theorem](backup_double_tower_dormant.md)
excludes all five tests for this L, a contradiction.

## The first-unstable locus

For \(\det E=\mathcal O_C\), the
[first-instability correspondence](../deformations/frobenius_residue_escape.md)
gives exactly eighty stable first-destabilized classes: one for each
dormant connection and each theta characteristic. In the present
normalization these are
\(\mathcal V_j\vartheta^{-1}\kappa\), with \(\kappa\in A[2]\).
Indeed, the oper jet of \(\Phi^*\mathcal V_j\), twisted by
\(\Phi^*\vartheta^{-1}\), has canonical filtration with line
degrees one and minus one, and the sixteen two-torsion twists give
all sixteen theta characteristics. This identifies the actual
relative Frobenius rather than identifying coefficient twists.

For arbitrary degree-zero determinant choose a square root M of it
and apply that classification to \(E\otimes M^{-1}\). Degree-zero
line twists preserve instability, so the first-unstable locus is
exactly (1), absorbing the two-torsion factor into M.

## The actual simultaneous point and disjointness

Use the actual symmetric triquadratic R constructed in the
[determinant-cut proof](genus_two_determinant_cuts.md), with
\(p(N)=(-\kappa_4:\kappa_3:-\kappa_2:\kappa_1)\). Its normalization is
\[
R(a,b,p(0))=(a^{\mathsf T}Hb)^2,\qquad
H=\begin{pmatrix}0&0&0&1\\0&0&-1&0\\0&1&0&0\\-1&0&0&0\end{pmatrix}.
\]
For each two-torsion line \(\tau\), let \(L_\tau\) be its actual
projective action on bundle moduli. The actual determinant satisfies
\[
R(a,b,p(\tau))=\lambda_\tau(a^{\mathsf T}HL_\tau b)^2,
\qquad\lambda_\tau\ne0.
\tag{4}
\]
The finite calibration uses 220 symmetric tensor coefficients and
sixteen unknown scalars. Its 880 equations have rank235 in236
unknowns, with a nonzero maximal minor [115]. A nonzero full-kernel
vector therefore identifies the actual section uniquely up to scale.
The translation matrices are themselves fixed by rank-fifteen
linear systems from twenty actual Mumford divisors; no arbitrary
quadric is being interpreted as a bundle.

The original package and its full locally executed verifier are
preserved in the external
[return directory](../../../litt3-computation-data/theta_exception_20260916/).
The maintained [verifier](../../scripts/genus_two/theta_exception/verify.py)
reads that directory's certificate through its data-dir argument.
Its field arithmetic, tensor calibration, divisor arithmetic and
homogeneous identities all passed. The geometric identification and
the independently checked first pullback are recorded in the
[bounded audit](../../Research/audits/THETA_EXCEPTION_RETURN_AUDIT_2026_09_16.md).

For the stated U,V,b, exact division gives
\[
V^2-f=U\bigl(4x^3+([87]+[61]\beta)x^2+
([54]+[29]\beta)x+[93]+[111]\beta\bigr),
\]
and \(G(b)=[97]+[77]\beta\ne0\). Thus the Mumford pair is an actual
line bundle, and b is a geometrically stable moduli point. It has
an actual bundle representative over the finite field: the only
descent obstruction is the scalar gerbe in its zero Brauer group.
The determinant descends as \(\omega_C\). Writing
\[
c=p(M)=([17]+[95]\beta:[71]+[116]\beta:
[105]+[61]\beta:1),
\]
the specialization of the calibrated section is
\[
R(a,b,c)=([101]+[44]\beta)\,Q(a).
\tag{5}
\]
In the quadratic monomial order
\((z_0^2,z_0z_1,z_0z_2,z_0z_3,z_1^2,z_1z_2,z_1z_3,z_2^2,z_2z_3,z_3^2)\),
the coefficient vector of Q is
\[
(1,102,59,78,17,61,16,69,110,61).
\]
Direct polynomial arithmetic gives
\[
Q(z(T))=\psi(T)([68]+[124]T+[47]T^2+[9]T^3).
\tag{6}
\]
Hence all five actual section tests are positive. The symmetric
matrix of Q has determinant [119], so this quadric is smooth.
At a stable test bundle \(V_i\), a local two-term cohomology
presentation is a square matrix whose determinant is Q. Nullity
at least two would kill all its first derivatives. Consequently
each of the five section dimensions is exactly one.

To treat the entire first-unstable locus, use the independent root
S of \(\psi\) and expand
\[
R(z(T),z(S),c)\bmod\psi(T)=\sum_{r=0}^4q_r(c)T^r
\]
over \(L=k_0[S]/(\psi)\). The five quadrics \(q_r\), multiplied by
the four c-coordinates, give a square map to the twenty cubic
monomials. Its restriction of scalars to \(k_0\) has determinant
[78], and the supplied inverse is checked by multiplication.
Thus every cubic monomial belongs to \((q_0,\ldots,q_4)\). There
is no geometric projective zero, even before restricting c to K.
Every embedding of L gives the same assertion for its conjugate
\(V_j\). These are all the families (1), including every line
twist. This proves their disjointness from \(\mathcal Z\).

## The determinant exclusion is intrinsic

Nontrivial two-torsion determinants are excluded directly. By
the Version3 [determinant-cut theorem](genus_two_determinant_cuts.md),
every semistable rank-two E with \(\det E=\kappa\ne0\) in
\(J(C)[2]\) has its actual quadric in the SAME plus eigenspace
as the \(\kappa\)-double-cover pushforwards. The fifteen certified
unique quadrics and their smooth Kummer cuts therefore exclude
these E as well. No self-twist or induced-bundle assumption is used.

The preceding disjointness proves that every common point has
semistable first pullback. Apply the
[pushforward resolution](dormant_pushforward_resolution.md) to E:
the five section dimensions sum to at most six. If \(\det E\)
were trivial, each would be even, and five positive dimensions
would sum to at least ten. Thus \(\det E\ne\mathcal O_C\).
This replaces the former coordinate-span minor; its original
[certificate](../../../litt3-computation-data/simultaneous_dormant_theta_20260916/dormant_span_minor.json)
is retained as independent evidence, but is not needed in this proof.

## Every height is semistable, but the first loses stability

The [intrinsic residue theorem](../deformations/frobenius_residue_escape.md)
applies also to the coefficient twist C: its dormant scheme has
one degree-five residue field over \(k_0\). Over \(k_1\), an
extension of degree two, there is no rational dormant connection.
Every geometrically semistable rank-two even-degree bundle over
that field is therefore strongly semistable. This applies to E
without a determinant normalization.

For the sharper first-pullback assertion use the already audited
[Prym-quintic reconstruction](../deformations/genus_two_prym_quintics.md).
Here is a small reproducible coordinate certificate. Pack
\([a]+[b]\beta\) as the integer \(a+125b\). A Heisenberg frame for
the certified two-torsion operators is given by the columns of
\[
P=\begin{pmatrix}
1&12200&2818&8737\\
1210&11843&12281&10312\\
95&6857&7273&7832\\
5367&2716&5873&13189
\end{pmatrix}.
\]
Conjugation takes the two diagonal involutions and their two paired
shifts to the standard Heisenberg matrices. Direct substitution
takes G to the Hudson equation with coefficients
\(([14],[15],[17],1)\). Therefore the established actual quintics V
give absolute pullback in this frame as \(x\mapsto V(x^{[5]})\).
The [source script](../../scripts/genus_two/theta_exception/frobenius_probe.py)
and [exact receipt](../../../litt3-computation-data/theta_exception_20260916/frobenius_probe.json)
verify
\[
x_0=(1,2126,1931,1371),\qquad
[Px_0]=b,\qquad
[V(x_0^{[5]})]=(1,7655,13000,10948)=x_1.
\tag{7}
\]
The output is nonzero, \(G(Px_0)\ne0\), and \(G(Px_1)=0\).
These first-step equalities were independently checked. The map
in the original coordinates was also checked to vanish on all five
original dormant points; its pullback of the target Kummer equation
has the correct coefficient twist. Thus (7) uses the actual map,
not an unlabelled projective model.

It follows that the absolute first pullback of \(W_b\) is strictly
semistable. Factoring absolute Frobenius through the relative map
and the coefficient-field isomorphism gives the same stability
assertion for the specified \(\Phi:Y\to C\). Tensoring by its
degree-zero pullback of M gives strict semistability for E as well.
No splitting assertion follows from a Kummer moduli point.

Finally suppose stable E were trivialized by a finite étale cover.
Take an actual connected Galois closure of this one cover.
Descent of its trivial bundle is a representation by constant
matrices. Stability forces that representation to be irreducible.
Conversely, a degree-zero subbundle of a trivial bundle on a
projective connected curve is constant: its Grassmannian map has
degree zero against the Plücker ample class. A positive-degree
subbundle is impossible. Thus an irreducible representation gives
a stable associated bundle. Frobenius raises its constant matrices
to fifth powers and preserves irreducibility. Every pullback of a
stable étale-trivial bundle is consequently stable. Equation (7)
contradicts that conclusion, proving the claimed nontrivializability.

The longer orbit recorded by the exploratory script is unnecessary
here. The global conclusion needs the following separate calculation.

## The complete finite locus enters the first boundary

Let \(\mathcal Y\subset S\times K\) be the five-test scheme obtained
by expanding \(R(z(T),b,c)\) modulo \(\psi(T)\). Write its five
bihomogeneous equations as \(F_0,\ldots,F_4\). On the chart
\(b_3=c_3=1\), use the polynomial ring
\[
k_0[b_0,b_1,b_2,c_0,c_1,c_2],\qquad
I=(F_0,\ldots,F_4,G(c)).
\tag{8}
\]
The actual quintic map in the original frame has the form
\(z\mapsto Q(z)^{[5]}\). Its exact pullback factorization is
\[
G^{[1/5]}(Q(z))=u\,G(z)H_8(z)^2,\qquad u\ne0.
\tag{9}
\]
Both Q and \(H_8\) have coefficients in \(k_0\). On stable
points in the map's domain, \(H_8=0\) is precisely the first
strict-semistability condition. Equation (9), with its coefficient
twist, is included in the same exact Frobenius receipt as (7).

The [affine source](../../scripts/genus_two/theta_exception/simultaneous_locus_probe.py)
reconstructs (8) directly from the calibrated tensor and performs
exact arithmetic over \(k_0\). Its completed Sage/Singular
calculation gives
\[
\dim k_0[b,c]/I=1280,\qquad H_8(b_0,b_1,b_2,1)\in I.
\tag{10}
\]
Here dimension means vector-space dimension. The degree-reverse-lexicographic
Gröbner basis has656 elements; its leading ideal contains
\[
b_0^8,\ b_1^8,\ b_2^8,\ c_0^8,\ c_1^4,\ c_2^9.
\]
The complete original equations, basis, zero octic remainder,
quotient dimension and source hash are preserved in the external
[exact computation](../../../litt3-computation-data/theta_exception_20260916/simultaneous_locus_probe.json).
This is a computer-assisted step using the standard exact
Gröbner-basis implementation, not a geometric-point search.
The separate attempt to extract shorter multiplication-only
certificates was interrupted and is not used as verification.

To globalize, lift a point of \(\mathcal Y\) to \((b,M)\) in
\(S\times A\), so \(E=W_b\otimes M\in\mathcal Z\).
The known nontrivial determinant implies \(M\notin A[2]\).
Two distinct translates of the standard genus-two theta curve
by two-torsion meet only in two-torsion points. Indeed, for
\(\tau=\mathcal O(W_i-W_j)\), the two points
\(\mathcal O(W_i-O)\) and \(\mathcal O(W_j-O)\) exhaust the
intersection of \(\Theta\) and \(\Theta+\tau\), whose degree is two.
It follows that at least fifteen diagonal two-torsion translates
of \((b,M)\) have \(c_3\ne0\).

The fourth rows of any fifteen of the sixteen certified translation
matrices span all four linear forms. This finite check is ordinary
rank computation over \(k_0\); all sixteen ranks are four.
Hence at least one of those same translations also has \(b_3\ne0\).
The sixteen translates of the chart in (8) cover the support of
\(\mathcal Y\). Equation (10) proves global finiteness. It also
proves the boundary assertion globally: the test is invariant under
degree-zero line twists, because
\[
F^*(W_b\otimes\tau)=F^*W_b\otimes F^*\tau.
\]
The earlier disjointness from the entire first-unstable locus
ensures that the rational map is defined at every point in question.
No literal untwisted invariance of the polynomial \(H_8\) is assumed.

The length comparison must use \(S\times A\), rather than a
presumed map from \(S\times K\) to \(\mathcal U\): replacing M
by its inverse may change E. The two pulled-back five-test schemes
agree scheme-theoretically. Near their support the first map to
\(\mathcal U\) is finite étale of degree sixteen, and the second
map to \(S\times K\) is finite étale of degree two. Consequently
\[
16\operatorname{length}(\mathcal Z)
=2\operatorname{length}(\mathcal Y).
\tag{11}
\]
Global finiteness makes the five equations on the smooth fivefold
\(\mathcal U\) a regular sequence. Equation (3) therefore gives
length160, and (11) gives length1280 upstairs. This agrees with
the full affine length in (10); in particular this chart omits
no point of \(\mathcal Y\).

This gives a further determinant exclusion without new numerical
work. Since \(j^*(c_3=0)=2\Theta\), a determinant in \([2]\Theta\)
would admit a square root M in Theta. Its presentation \(E=W_bM\)
would then give a point of the common scheme with c3=0, which the
length comparison has excluded. Thus \(\det E\notin[2]\Theta\).
For nontrivial D, the unique effective divisor of \(\omega_C D\)
is a double point exactly when \(D=\mathcal O_C(2p-2O)\).
Consequently every common determinant divisor is reduced. Its
two points cannot both be Weierstrass, by the two-torsion exclusion.

The geometric globalization and the finite-monodromy implication
were independently reviewed in the return audit. The affine
arithmetic is the executed exact computation (10), not an
independent second Gröbner replay. At the explicit point, the
Jacobian of the six equations (8) has rank six; this separately
proves reducedness there. Reducedness elsewhere is not needed.
All points of \(\mathcal Z\) are stable before Frobenius and
strictly semistable afterward, so the finite-monodromy argument
above excludes étale trivialization for every one of them.
