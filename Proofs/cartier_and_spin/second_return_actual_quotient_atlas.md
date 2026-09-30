# Proof: torsion length and an actual lifted determinant

25 September2026. All bundles are on the fixed smooth proper X. The
actual extension, its nineteen coordinates, and the whole affine and
infinity lattices are those of
[global transversality](second_return_global_transversality.md).
Write L=O(-O), E=F_abs^{2*}R_xi. The source and target extension
parameters are different variables until a fixed point is imposed.
The complete returned reconstruction is preserved in
[the report](../../../litt3-computation-data/quartic_quotient_trace_replies_20260925/extracted/nonsplit_quotient_partial/REPORT.md).

## The geometric dimension formula

Suppose Hom(E,L)=0 and phi:E->K has generic rank two. Let I be its
image and C its torsion cokernel, of length d. The established cofactor
formula gives ker phi=N=L(Z) with deg Z=d<=18. Since E surjects
onto I, Hom(I,L)=0; consequently Hom(K,L)=0 as well.

When d=0, the sequence0->L->E->K->0 yields
\[
0=\operatorname{Hom}(E,L)\longrightarrow k
\longrightarrow\operatorname{Ext}^1(K,L)
\longrightarrow\operatorname{Ext}^1(E,L).
\]
Thus V_phi is a line, and the corresponding extension is nonsplit.

When d>0, Hom(N,L)=H^0(O(-Z))=0. Applying Hom(-,L) to
0->N->E->I->0 shows that Ext^1(I,L)->Ext^1(E,L) is injective.
Apply the same functor to0->I->K->C->0. Since Ext^2 vanishes on
a smooth curve and Hom(I,L)=0, the kernel of
Ext^1(K,L)->Ext^1(I,L) is exactly Ext^1(C,L). Over a local DVR,
the resolution of R/(t^m) shows that Ext^1(R/(t^m),R) has length m.
Decomposing the finite-length module proves dim Ext^1(C,L)=d, with
all multiplicities. This proves the dimension formula.

If d=1, C=k(P). Its image in Ext^1(K,L) is the connecting image
of the quotient K->k(P) for0->L->L(P)->k(P)->0. By the supplied
description of Sigma it is a strictly semistable extension parameter.
Hence a stable parameter spanning V_phi, when this space is a line,
rules out d=1 and forces d=0.

## From extension pullback to the exact atlas

Put z_j=xi_j^25. The supplied lower-map calculation constructs
Hom(E,K) as the kernel of the80x35 matrix T(z), and Hom(E,L) as
the kernel of the43x16 matrix Q(z). These are exact regular bundle
maps, not only rational matrices. In the rank window34,16 the lower
map phi is unique up to scalar and Hom(E,L)=0.

Replace the unraised target coordinates in the top-row lifting formula
by a fresh eta. Keep the source functions u_xi^25,v_xi^25 and e^25.
After eliminating the constant116-column block of the top-row map,
there are43 residual conditions. The nineteen target basis vectors
give M_phi; the sixteen remaining free top-row coefficients give Q.
Thus
\[
A_\phi=[M_\phi\mid Q],\qquad
\ker A_\phi\longrightarrow k^{19},\quad (\eta,s)\mapsto\eta
\]
identifies the kernel with V_phi. Existence of a lift is exactly
vanishing of the pulled-back extension. Its uniqueness follows from
Hom(E,L)=0. All the affine and infinity conditions are retained in
this elimination; no branch-point denominator is inverted.

At a residual solution, recover the full3x3 matrix H:E->R_eta.
Both determinants are O_X, so det H is a global constant on X.
Choose the ordinary point P_*=([5],[14]); direct arithmetic verifies
it lies on X. The determinant at that point is linear in the unknown
top row because the two lower rows phi are fixed. This gives a linear
functional ell_phi on the35 columns. Set N_phi to be A_phi augmented
by this row.

If rank A_phi=34 and rank N_phi=35, its one-dimensional kernel has
nonzero determinant evaluation. Hence the corresponding H is globally
invertible. Its projection phi is a surjection and eta!=0: a zero
target class would split E as L plus K, contradicting Hom(E,L)=0.
Conversely a nonsplit surjection gives an isomorphism E~=R_eta;
the dimension formula gives rank A_phi=34, and its determinant is
nonzero, giving rank N_phi=35. Rank-one maps and all torsion-cokernel
maps fail the determinant test. The d=1 case explains why rank34
alone was insufficient.

The unique target class is exactly the first nineteen coordinates of
ker A_phi. It is not inferred from splitting types. The source and
target are isomorphic exactly when their nonzero extension coordinates
are proportional, by the established geometry of this family. This
proves the fixed-point criterion, without deciding it.

## Reproducible reconstruction and scope

The retained source directory contains
[the verifier](../../scripts/arithmetic/pro_quartic_quotient_trace_20260925/return/src/verify.py),
the exact Laurent arithmetic and atlas evaluator. Data remain outside
the repository. The local replay rebuilt the entire lower T and Q
systems, checked the constant eliminations, the eleven-dimensional
section space and all seven cofactor sections, then checked all665
target/free columns for each of the19 source coordinates against
Laurent reconstruction. It also checked the determinant-evaluation
recovery in every column. Thus all12635 columns were checked, in
addition to dense/sparse and nontrivial coefficient-Frobenius tests.

The geometric stability routine tests the full affine ruled surface
via its ideal in k[x,y]/(y^3-P), including geometric points outside
the coefficient field, and separately checks infinity. It uses exact
polynomial-module membership, not a list of finite-field points.
These tests and the supplied stable negative F625 example passed.

All checks are logged in
[the focused audit](../../Research/audits/QUARTIC_QUOTIENT_TRACE_REPLIES_2026_09_25.md).
No positive point of the actual quotient atlas is supplied. The bounded
exploratory searches in the original archive do not establish emptiness,
nonperiodicity, or a field-of-definition bound for stable fixed points.
