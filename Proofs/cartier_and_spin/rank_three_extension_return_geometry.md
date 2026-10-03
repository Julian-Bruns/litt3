# Proof: the extension locus and a certified false-positive family

The returned [full report](../../../litt3-computation-data/coreless_primitive_returns_20260923/rank3_progress_bundle/source/rank3_progress_report.tex),
[matrix data](../../../litt3-computation-data/coreless_primitive_returns_20260923/rank3_progress_bundle/certificates/),
and [successful complete replay](../../../litt3-computation-data/coreless_primitive_returns_20260923/runs/rank3_replay.log)
are retained. The [source programs](../../scripts/arithmetic/pro_coreless_20260923/rank3/certificates/)
reconstruct the matrices from the actual e, not just graded lines.
Their internal finite-field elimination is exact; no independent-agent
audit is claimed.

## The sharp line gap and the unique quotient

The later
[sharp line-degree theorem](small_shift_line_twist_vanishing.md)
gives maximum line degree minus four in K and
\(H^0(K(3O)\otimes L)=0\) for every geometric Pic0 line L.

In an extension \(0\to N=T(-O)\to R\to K\to0\), any saturated
line other than N maps nontrivially to K. Its saturation there
has degree at least that of the original line, hence every other
line has degree at most minus four. Thus N is the unique maximal
line. The sharp vanishing also gives
\[
h^0(R\otimes M(O))=
\begin{cases}1&M=T^{-1},\\0&\text{otherwise},\end{cases}
\qquad
\operatorname{Hom}(R,K)=\operatorname{End}(K)=k.
\]
The first identity follows from the extension sequence and vanishing
of \(K(O)\otimes M\); the second uses \(\operatorname{Hom}(N,K)=0\)
and stability of K. No shifted symmetric-power calculation is
needed for these extension conclusions.

For a general stable degree-zero rank-three E, every nonzero image
in K is a quotient of positive degree. A rank-one image is
incompatible with stability of K; a rank-two image of positive
degree is all of K. Its kernel has degree-1, so the preceding
argument gives uniqueness of the quotient. If also E^vee tensor M
mapped to K, the composite K^vee->E tensor M^-1->K tensor M^-1
would have rank at least one at every point. Quadratic all-twist
vanishing forces it to be alternating. Its2x2 alternating matrix
would therefore give a nowhere-zero section of det K tensor M^-1,
of degree one, impossible.

## The unstable boundary is a known ruled surface

For a nonzero extension, a saturated rank-two nonnegative-degree
subbundle S must inject into K. Degree one would split the extension;
the only remaining case is degree zero and
S=ker(K->k(P)). Such S is stable, since all its lines are negative,
and Hom(S,N)=0. Its lift exists for exactly the projective point
coming from the one-dimensional Ext^1(k(P),N) in W_T. For its
nonzero class the lift is saturated, with quotient N(P). Hence no
positive-degree destabilization occurs and these are precisely the
strictly semistable bundles.

Serre duality identifies W_T with the dual of H^0(K(17O) tensor T^-1).
Put \(A_T=K(17O)\otimes T^{-1}\). Its degree is35. For every
effective divisor D of degree d<=5, Serre duality gives
\[
H^1(A_T(-D))^\vee
=H^0(K\otimes T(D-2O))=0.
\]
Indeed \(T(D-dO)\) has degree zero and d-2<=3, so the sharp
all-twist theorem applies after multiplication by an effective
multiple of O. Thus h0(A_T)=19 and
\[
H^0(A_T)\longrightarrow H^0(A_T|_D)
\quad\text{is onto, of rank }2d.
\]
This includes fat base points. The d=2 case separates length-two
schemes on the ruled surface, proving the closed embedding and
tautological degree35. At d distinct base points, their fiber lines
span a projective (2d-1)-space. This is interpolation on the base;
it does not assert that O(1) separates three points in one fiber.

## Strict returns have an extra quotient condition

A strict return imposes T^q=T, q=5^r. Transport its degree-1 kernel
into F_abs^{r*}R; it differs from T^q(-qO). Wedging and using
determinants gives the necessary section in F_abs^{r*}K tensor
T^-1(O). Lifting it to R is controlled by the actual extension
class, and uniqueness of the maximal line requires kernel dimension
one in the displayed connecting map. For r>=3 the source dimension
is q-14 and the target is q+7; its required rank is q-15. Mere
nonvanishing of the source has no force there.

For T=O,r=1, multiplication by e^5 gives a32x23 full-column-rank
matrix for H^0(F_abs^*K(O)). Its character minors are[22],[5],[17].
This excludes that exact first-return case, not other determinants.
For r=2, the section matrix is132x143 of rank132, giving11 sections.
In the rational extension frames
\[
n_V=n_U-u a_U-v b_U,\quad a_V=a_U-e b_U,\quad b_V=b_U,
\]
take u-basis yx^-1,y^2x^-5,...,y^2x^-1 and v-basis
x^-2,x^-1,yx^-5,...,yx^-1,y^2x^-6,...,y^2x^-1, the latter
modulo the two classes e,xe. They give the19 extension coordinates.
For a section with bottom b_U and top a_U=(e^25 b_U)_+, its cup
is [u^25 a_U+v^25 b_U] in H^1(O(-24O)). The resulting tensor
has shape32x11x19 and raw uint8 SHA256
3b0db6b0a70a32d965569f12c87772dd383f08d821cb4b38d417a45f6f4b463e.
The parameters themselves are raised to25; a finite-field sample
does not impose the geometric equations.

## A stable, saturated false positive

In the pure-v P5 write v=y^2 sum_{j=0}^5 z_j x^{-6+j}. Its cup
matrix decomposes into a14x4 block, a7x7 block C(z), and zero rows.
At z_*=(1,0,[18],0,0,0), the full rank is10 and its kernel vector is
(0,0,0,0,4,2,17,3,8,6,1). A10x10 minor has determinant[22].
The polynomial det C is homogeneous of degree seven; on
(1,0,t,0,0,0) its ascending row is(22,0,17,14,14,22,9,19).
It is squarefree. Its full degree is retained on this line, so a
repeated homogeneous factor of the full determinant would give a
repeated nonconstant factor on the line. Hence the septic is reduced.
Its gradient at z_* is(6,6,3,9,23,17), so it is smooth there.

Stability is checked against the exact surface Sigma_O. The zero
u-coordinates force the quotient to kill the O(-5O) direction.
The two sections y,xy^2 in the relevant bottom image then force
the possible support to be a finite cubic branch point. In the
reduced branch-evaluation coordinates its fourth coordinate is
w_3(r)=r^2+[3]r^6+[23]r^7. The actual extension has that
coordinate zero, whereas gcd(P,w_3)=1. The certificate supplies
U P+V w_3=1, so R_* is stable over the whole algebraic closure.

Reconstruct the unique lifted section of F_abs^{2*}R_*(O):
b_U=y b(x), a_U=(e^25 b_U)_+, n_U=(v_*^25 b_U)_+.
Their polynomial degrees are47,192,117 respectively. The exact
Bezout identity between n_U and a_U rules out a finite common
zero, and their regular-frame infinity orders are(0,2,0).
The section is therefore nowhere zero, giving a genuine saturated
O(-O) subline of F_abs^{2*}R_* and a rank-two degree-one quotient.

The quotient is not K. For Hom(F_abs^{2*}R_*,K), six rational
matrix entries have source/target pole bounds
((20,120,-155),(31,131,-144)). Eliminating polynomial parts
leaves270 free coefficients and315 forbidden coefficients.
The independently reconstructed transition equations give a315x270
matrix of full rank, with selected maximal minor[1]. Thus this
Hom space is zero. Any strict second return would compose with
R_*->K to give a nonzero such map, a contradiction.

Stability, rank exactly10, the nowhere-zero lift and this nonzero
Hom minor are open conditions on the reduced septic near z_*.
They therefore hold on a nonempty four-dimensional locally closed
family. This proves the failure of the preliminary tests on a
family, without deciding any higher return for its members.

## A limit on symmetric-invariant exclusions

The symmetric filtration gives chi(Sym^m K tensor L)=
(m+1)(m-16)/2. Complete all-twist vanishing is impossible for
m>=17. On the other hand, for q=5^s>=25 the natural SL3(F_q)
module is irreducible and primitive: its order-five transvections
generate it, and cannot act nontrivially on three permuted lines.
The group has no nontrivial k-valued character for the same reason.
An invariant homogeneous polynomial of degree0<m<q is fixed by
every k-valued root subgroup, since a degree<=m polynomial in
the subgroup parameter vanishes at all q values. It is then
SL3(k)-invariant and must be zero. The dual satisfies the same
claim. Thus this method alone cannot exclude every possible modular
rank-three type. No actual representation of pi_1(X), or map to K,
has been supplied for those abstract examples.

## Complete quotient obstruction and pencil exclusion

The [new report](../../../litt3-computation-data/reconstruction_returns_trace_20260924/originals/strict_return/strict_return/REPORT.md)
and [unchanged source](../../scripts/arithmetic/pro_reconstruction_20260924/strict_return/)
give all formulas. The full reconstruction was replayed locally;
every retained array and stability section agreed.

Put E=e^25, U=u^25 and V=v^25. Restricting a morphism
F_abs^{2*}R to O(-25O) gives a section of K(25O). Write it
(a,f), with f in H0(O(31O)), a=(ef)_++alpha and
alpha in H0(O(20O)); this gives 35 parameters. Add g_0 in
H0(O(131O)) and q_0 in H0(O(120O)), giving 235 more.
With p=a-ef and w=(Uf)_-, set
\[
c=eg_0+ew-Ua,\quad b_*=E(g_0+w)+Vf,\quad h=-(b_*)_+,\quad
a_*=-eh+E(q_0-c_-)+Vp.
\]
The residual conditions are the forbidden negative coefficients
of b_* for O(-144O) and a_* for O(-155O): 315 equations.
The fixed 235-column block A has full rank, proving
Hom(F_abs^{2*}K,K)=0. Its left annihilator L has rank 80.
If B_i are the remaining 315-by-35 blocks, T_i=LB_i gives
the exact Hom formula. Coefficients xi_i are raised to 25.

On the pencil u=0, v=s y^2x^-6+t y^2x^-4 the tensor is
s^25 T_13+t^25 T_15. Put z=(t/s)^25 on s!=0. Its three
blocks have sizes 27-by-8, 30-by-12 and 23-by-15. Two retained
maximal-minor polynomials per block have Bezout combination one.
T_15 has full rank at infinity. Thus no geometric pencil point
has a nonzero quotient map, irrespective of stability.

## Stable strict returns form a finite reduced locus

The full 3-by-3 transition yields 474 residual equations in 402
morphism coefficients. After they hold, the determinant is a global
function on proper connected X, hence constant. Testing it at the
actual point ([5],[14]) and normalizing it to one gives a sufficient
return system on each extension chart; the stability surface must
also be excluded. The supplied symbolic generator has not been
executed or solved. It is not an emptiness certificate.

In a first-order deformation xi+epsilon dot(xi), the coefficient
25th powers are constant. A deformed return makes R_xi a constant
first-order deformation. Its O(-O) inclusion is unique up to a
unit because H0(K(O))=0; the quotient to K is unique up to a
unit because Hom(O(-O),K)=0 and End(K)=k. The projective
extension tangent vector is therefore zero. This uses the scheme
of the specified absolute-Frobenius equations, including coefficient
25th powers.

Every infinitesimal automorphism of stable R is scalar.
Determinant-one normalization kills it because 3 is invertible.
The finite-type normalized return scheme consequently has zero
tangent space at all stable points and reduced zero-dimensional
local rings there. Its stable locus is finite. There are three
normalized isomorphisms per stable class; forgetting them gives
the stated finite reduced set of extension classes. No cardinality
or emptiness conclusion follows from this argument.

## Nonempty quotient incidence with no strict period

The [new certificate](../../../litt3-computation-data/rational_rankdrop_20260924/originals/rankdrop/rank_drop/REPORT.md)
constructs an actual rank-one map, and both its independent Laurent
verifier and complete tensor reconstruction passed locally. Set u=0,
v=y^2 x^-6 D with D=(24,2,10,11,1), and write e=y^2x^-10 C,
C=(11,24,1,7,2,1,7,16,16,2). Put H=(12,9,20,3,4,18,22,19,2).
The small [polynomial certificate](../../../litt3-computation-data/rational_rankdrop_20260924/originals/rankdrop/rank_drop/certificates/polynomial_identity.json)
gives explicit N,J of degrees36,33 and the exact identity
\[
P^3(C^5H+x^{20}D^5)=N+x^{50}J.
\]
Coefficient Frobenius is included. Equivalently
e^5H+v^5=yx^-50 N+yJ. The row maps
\[
\psi_U=(1,H,-yJ),\qquad\psi_V=(1,H,yx^{-50}N)
\]
therefore define F_abs^*R -> O(-O). Their infinity pole weights
are (0,24,-32), within the allowed (4,24,-31). The first entry
is a unit away from O; the second has the maximal allowed weight
24 and is a unit in the regular infinity frames. Thus psi is
surjective. One more Frobenius pullback, followed by the actual
inclusion O(-5O)->K, gives the requested rank-one map.

The reconstructed 80-by-35 matrix has rank33, with kernel spanned
by inputs (f,alpha)=(y,0) and (0,1). Both reconstructed maps factor
through the same quotient row; their columns into K are
((ey)_+,y) and (1,0). Every nonzero combination has generic rank
one. Thus this entire Hom space fails to surject onto K.

The full geometric fiber over (f,alpha)=(0,1) is the projective
line of extension coordinates with final six entries spanned by
D_1=(24,2,10,11,1,0) and D_2=(14,5,13,12,0,1). The exact
80-by-19 transposed matrix has rank17. The two auxiliary solutions
have g_0=0, and their q_0 polynomials are fifth powers H_i^5.
The focused [continuation script](../../scripts/arithmetic/rank_drop_pencil_first_pullback.py)
checks both first-pullback maps directly, with
H_1=(12,9,20,3,4,18,22,19,2) and H_2 obtained by taking fifth
roots of the retained q_0 coefficients. Both satisfy the infinity
bounds (4,24,-31).

For xi=s xi_1+t xi_2 over the algebraic closure, the first-pullback
transition uses s^5,t^5. Combining H_i and the last row entries
with precisely those coefficients gives a nonzero map
F_abs^*R_xi -> O(-O), whose first affine entry is one. At a
special parameter the map may have an infinity zero; its image
is still a line bundle of degree at most -1. Therefore F_abs^*R_xi
has a negative-degree line quotient for EVERY pencil member.

All subsequent pullbacks have negative-degree line quotients too.
If some positive Frobenius power returned to the original semistable
R_xi, this would contradict its semistability. This strengthens the
reported no-second-return conclusion to no strict positive period
on the whole geometric pencil. It does not classify the other
components of the quotient incidence or settle the full return locus.
