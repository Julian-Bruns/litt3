# Proof: actual cofactors, modifications and the exact return atlas

Version2,3October2026. On the fixed X put
L=O(-O), E=F_abs^{2*}R_xi and z_j=xi_j^25. The full extension
and both integral lattices are those of
[rank-three geometry](rank_three_extension_return_geometry.md).
Every nonzero R_xi is semistable of degree zero and its maximum
line degree is minus one. The [later sharp K bound](small_shift_line_twist_vanishing.md)
is minus four. It gives Hom(L,K)=Hom(K,L)=0 and stability of K.

The fixed positive section s_*=(a_*,b_*)=(A_*(x),yB_*(x)) is the
one in [the positive presentation](explicit_degree_one_etale_sections.md),
normalized by the x^44 y coefficient of b_* being one. Its B row
is exactly the original filtration row. Thus
\[
0\to O(8O)\xrightarrow{s_*}F^{2*}K
 \xrightarrow{\psi}O(17O)\to0,\qquad
\psi(a,b)=a_*b-b_*a
\]
is an actual exact sequence. Pulling back along E->F^2*K defines B_xi:
\[
0\to O(-25O)\to B_\xi\to O(8O)\to0,\qquad
0\to B_\xi\to E\to O(17O)\to0.
\]
These sequences retain the actual extension, not its associated graded.

## The complete section space and global transversality

The actual Laurent conditions on a section L->E with coordinates
(n,a,b) are
\[
v_O(n-Ua-Vb)\ge24,\quad v_O(a-e^{25}b)\ge124,\quad
v_O(b)\ge-151.
\]
Polynomial parts uniquely recover a,n from b; there are no free
summands in the two negative spaces. The complete space
W=H^0(F^2*K(O)) has dimension11. Its free b coordinates are
\[
(47,0),(48,0),(49,0),(50,0),(41,1),\ldots,(47,1),
\]
where (i,j) means x^i y^j. It has character dimensions4,7,0.
The 132x143 constant constraint matrix has rank132; the resulting
32x11 matrix satisfies
\[
S(z)=\sum_{j=0}^{18}z_jS_j,\qquad
\ker S(\xi^{25})=\operatorname{Hom}(L,E).
\]

A section of B_xi(O) projects nontrivially to O(9O), so has lower
pair s_*(lambda0+lambda1 x+lambda2 x^2+lambda3 x^3).
Let C_* be its 11x4 coordinate matrix in W. The obstruction
S(z)C_*lambda separates by the three cubic characters:
\[
M_A(\lambda)z_A=0,\qquad M_B(\lambda)z_B=0,\qquad
A=\{0,6,7\},\quad B=\{1,2,3,4,5,8,9,10,11,12\}.
\]
The remaining indices C={13,...,18} define the pure-v P5.
M_A has size11x3 and M_B size14x10. All cross-character blocks
are identically zero. The character-zero block involving z_C is
not needed to force z_A=z_B=0.

Their transposed cokernels over k[lambda0,...,lambda3] have zero
degree2 and degree8 pieces, certified by full ranks30/30 and
1650/1650 in matrices30x44 and1650x1680. If a module generated
in degree zero has zero degree d, every lambda_i^d times every
generator is a relation. Evaluation on any projective chart
therefore makes the relation columns span the target, over every
field extension. Both M's have full column rank at every nonzero
lambda. Hence a lift forces z_A=z_B=0, proving
\[
\operatorname{Hom}(L,B_\xi)=0\quad\text{outside }P_C.
\]
This global assertion uses constant module certificates, not a scan
of parameters or selected coordinate faces.

## The fixed degree-eighteen subsystem

The determinant map J:W->H^0(O(18O)), J(a,b)=a_*b-b_*a,
has kernel s_*H^0(O(9O)), of dimension4, and image V18 of dimension7:
\[
V_{18}=\langle v_0,v_1,v_2,v_3,y,xy,x^2y\rangle,
\]
where the ascending polynomial rows of v0,...,v3 are
\[
(1,0,0,0,17,2,1),\ (0,1,0,0,22,21,22),\
(0,0,1,0,13,18,23),\ (0,0,0,1,16,1,15).
\]
All entries are F25 codes and all coefficients range over k.
The original exact determinant computation verifies the complete
image and all high-degree cancellations.

For an actual stable second return H:E~=R_xi, compose with R_xi->K.
Its kernel is the nowhere-zero inclusion w:L->E. The
[pure-v theorem](pure_v_geometric_rank_window.md) places the source
outside P_C, so psi(w)=delta is nonzero and belongs to V18.
Restricting the quotient to B_xi gives
\[
0\to B_\xi\to K\to O_{D_\delta}(17O)\to0,\qquad
D_\delta=\operatorname{div}(\delta)+18O.
\]
Indeed B_xi meets w(L) trivially and its quotient is
O(17O)/delta L. D_delta has degree18 and may be nonreduced
or contain O. This modification is necessary, not sufficient.

## One cofactor divisor controls every actual quotient

Write an actual map phi:E->K in rational rows as
\[
\phi=\begin{pmatrix}a&q&r\\ f&g&h\end{pmatrix},\qquad
w_\phi=(qh-rg,\ rf-ah,\ ag-qf)^t.
\]
Exterior powers put w_phi in H^0(E(O)), and phi w_phi=0.
Its lower pair has W coordinates beta; beta=0 exactly when
phi has generic rank at most one, since a remaining first
coordinate would lie in H^0(O(-24O))=0. On the actual incidence,
\[
S(z)\beta=0,\qquad
\delta_\phi=J\beta
=a_*(ag-qf)-b_*(rf-ah)\in V_{18}.
\]
This is the determinant of the two phi rows and (0,-b_*,a_*).
Outside P_C, delta_phi=0 exactly when phi has generic rank one:
otherwise w_phi would be a nonzero section of B_xi(O).

For generic rank two, let Z be the common zero divisor of w_phi.
Smith normal form over each actual local DVR gives
\[
d=\operatorname{length}(\operatorname{coker}\phi)=\deg Z,\qquad
\ker\phi=L(Z).
\]
Thus phi is surjective exactly when Z=0, including its infinity
fiber. Every line in E either maps nontrivially to O(17O), or lies
in B_xi, whose filtration bounds its degree by8. Thus every such
line has degree at most17, and d-1<=17 proves d<=18 for ALL xi.
Outside P_C the sharper divisor inclusion is Z<=D_(delta_phi).
When delta_phi is nonzero, B_xi->K is injective with length18
cokernel; that cokernel need not be cyclic when phi is not surjective.

The original recovery tensors provide beta and the seven V18
coefficients as polynomials of degree one in z and two in the
35 lower-map coordinates. Their exact unsymmetrized tensors have
shapes11x19x35x35 and7x19x35x35, with both off-diagonal orders
included. This is an actual sheaf statement only after imposing
the full lower-map residual equations.

## Nonsurjective maps exclude every positive projective period

If phi has generic rank one, its line image has degree at most
minus four by the sharp K bound. Its rank-two kernel in E has
positive degree. A projective period F^r*R_xi~=R_xi tensor M
has deg M=0; pulling that kernel to a multiple of r would
destabilize the semistable R_xi tensor a degree-zero line.

If phi has generic rank two and is not surjective, d>=1.
Its saturated kernel L(Z) has degree d-1>=0. Pulling it to
a multiple of any projective period would give a nonnegative
line in R_xi tensor a degree-zero line, contradicting its
maximum line degree minus one. This includes d=1; positivity
alone would have missed that case.

Therefore a positive projective period requires EVERY nonzero
actual map F^2*R_xi->K to be a surjection. The assertion is
conditional on such a map existing; it does not exclude points
with zero Hom at this particular Frobenius height.

## The later Ext-kernel criterion gives the exact quotient atlas

Assume Hom(E,L)=0 and phi has generic rank two. Put I=im(phi),
C=coker(phi) and
\[
V_\phi=\ker(\phi^*:\operatorname{Ext}^1(K,L)
                         \to\operatorname{Ext}^1(E,L)).
\]
For d=0, applying Hom(-,L) to0->L->E->K->0 makes V_phi a
line, since Hom(E,L)=0. The extension is nonsplit.
For d>0, Hom(L(Z),L)=H^0(O(-Z))=0, so
Ext^1(I,L)->Ext^1(E,L) is injective. Also Hom(I,L)=0 because
E surjects onto I. The sequence0->I->K->C->0 therefore identifies
V_phi with Ext^1(C,L), whose dimension is d: a local resolution
of each DVR module R/(t^m) contributes length m. Thus
\[
\dim V_\phi=1\ (d=0),\qquad \dim V_\phi=d\ (d>0).
\]
At d=1 its projective class is the connecting class of a quotient
K->k(P), hence belongs to the strictly semistable surface Sigma.
A stable target spanning a one-dimensional V_phi consequently
forces surjectivity.

The full lower-map matrices identify Hom(E,K)=ker T(z) and
Hom(E,L)=ker Q(z). On the window rank T=34, rank Q=16,
phi is unique up to scalar and Hom(E,L)=0. Introduce a fresh
target extension eta. Eliminating the116 constant top-row
columns gives the verified43x35 matrix
\[
A_\phi=[M_\phi\mid Q],\qquad
\ker A_\phi\xrightarrow{(\eta,s)\mapsto\eta}V_\phi.
\]
The nineteen eta coordinates and sixteen free top coordinates
retain the affine and infinity lattices. A lift is unique because
Hom(E,L)=0.

Its full3x3 determinant is a global constant. Evaluation at the
ordinary point ([5],[14]) gives one linear row in the top variables;
augment A_phi by that row to obtain N_phi of size44x35. Then
\[
\phi\text{ is a nonsplit surjection}
\quad\Longleftrightarrow\quad
\operatorname{rank}A_\phi=34,\quad\operatorname{rank}N_\phi=35.
\]
The forward implication uses the one-dimensional V_phi; the
reverse gives an invertible lift E~=R_eta. A zero eta would split
E and contradict Hom(E,L)=0. The first nineteen kernel coordinates
are the actual target class. Stable strict second return is exactly
eta proportional to xi with xi outside Sigma. No fixed point has
been constructed or excluded.

## Evidence and replacements

The original [global filtration evidence](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/return19_global_obstruction/)
and [exact quotient evidence](../../../litt3-computation-data/quartic_quotient_trace_replies_20260925/extracted/nonsplit_quotient_partial/)
retain the module minors, whole section/recovery/cofactor tensors,
portable arrays and executed checks. The
[global verifier](../../scripts/arithmetic/pro_structural_norm_replies_20260924/return/src/verify.py)
and [atlas verifier](../../scripts/arithmetic/pro_quartic_quotient_trace_20260925/return/src/verify.py)
remain necessary. All12635 target/free atlas columns were originally
checked, with full lattice and determinant recovery.

The later fixed positive presentation replaces the preliminary
positive-line census. The retained filtration producer constructs
that same explicit row directly; no kernel enumeration remains.
The unused K-to-K(12O) exploratory algorithm is deleted, and its
failed approach is recorded in [the failed-route index](../../Research/FAILED_ROUTES.md).
Original sources and evidence hashes remain in
[external provenance](../../../litt3-computation-data/second_return_before_hindsight/provenance.json).
No settled module or return certificate was replayed.
