# A canonical pencil gives two alternating atlas matrices without field inverses

Let C be a smooth projective curve of genus g>=2 over an algebraically
closed field. Put n=g-1. Let V be a rank-two bundle with det V=omega and
H0(V)=0. Choose a basepoint-free pencil s0,s1 in H0(omega). Then

    H0(V omega^2) = s0 H0(V omega) + s1 H0(V omega)           (1)

is a DIRECT sum of two spaces of dimension4n. In this basis the determinant
extension pencil is a pair of alternating4n by4n matrices:

    A_s(eta)(u,v) = <eta, s det(u,v)>,
    eta in H1(omega^-3), u,v in H0(V omega), s=s0,s1.

This assertion is characteristic-independent; it needs no stability beyond
the stated acyclicity. The pencil equations are A_0(eta)u=A_1(eta)u=0.

For the fixed characteristic-five curve, let V=W(8O) for ANY acyclic
dormant oper. Take s0=theta and s1=x^2*y*theta. In scalar Frobenius
coordinates (1) reads

    S_40 = S_U direct-sum (x^2*y)^5 S_U.                    (2)

There is the following exact97-equation atlas presentation with no
oper-dependent inverses or horizontal-kernel calculations. Let M be the
104 by56 matrix of Q:L64->L112. Choose32 columns I and32 rows J such that
G=M[J,I] is invertible. Let h_i be the chosen L64 monomials, S the fixed
56 by56 residue pairing, and put

    U=M[:,I]v,      B=S^-T M[J,:]^T,      eta=Bb.

Use the ORIGINAL raw136-row N and56-row R maps. The exact equations are

    Res_O(h_i U eta^5 theta)=0,                   i=1,...,32,
    Res_O((x^2*y)^5 h_i U eta^5 theta)=0,          i=1,...,32,
    Res_O(h_i R_U eta^[5] theta)=(G^T b)_i,        i=1,...,32,
    b^T G v=2.                                               (3)

Each residue in the R line means the residue of its canonical principal-
part representative. The first two lines are alternating matrices acting
on v. Equations (3) define the same finite reduced scheme as the compact
atlas system, including all its geometric points and normalization.
All their coefficients have degree at most6 in the24 ORIGINAL oper
coefficients. The residue operators and S^-T are fixed over F25. Choosing
I,J is a genuine rank condition; a minor cannot be presumed invertible.

There is a UNIFORM choice of rows J on the whole acyclic locus: take the
coefficients of the affine monomials with pole orders

    36,37,41,42,...,111,112.

Projection to these32 coordinates is an isomorphism on S_U for every
acyclic oper. Only the independence of the selected Q columns remains
to be checked. In particular the high-row orbit0011 frame does not
require an oper-dependent row-basis calculation.

Without acyclicity, keep all136 raw N equations. Together with the same
32 projected R equations and normalization this is an exact169-equation
inverse-free presentation for every oper. The two-copy reduction (2) must
not be applied to the55 exceptional opers with h0(V)=3.

For (3), write A_0(b), A_1(b) for its two alternating matrices. The17
coefficients of

    Pf(X A_0(b)+Y A_1(b))                                   (4)

are pure-b polynomial consequences of the normalized system. They have
degree16 in b^[5]; their coefficientwise fifth roots give necessary
degree16 equations in b at geometric points. These equations are NOT
proved sufficient, finite, or empty, and they do not remove the known
invalid quotient families of the unnormalized N equations.

Status: author proof,2026-09-07; no independent audit claimed. The complete
first-oper tensor verifies (2) and every alternating coefficient exactly.
This is a representation and a necessary obstruction, not an atlas
exclusion or a solution of the unmarked common-cover problem.
[Proof](../Solutions/Sol_acyclic_alternating_atlas.md).
