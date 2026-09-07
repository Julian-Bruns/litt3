# A finite matrix-pencil criterion retaining every quotient direction

Fix the data of `direct_wronskian_atlas`. Let E=P48 (dimension56),
let P128 have the nine gap monomials and t,...,t127 (dimension136),
and set D=-rho32 delta:E->P32. For U in S_U define k-linear maps
N_U:E^[5]->P128 and R_U:E^[5]->E by

    N_U(eta^[5])=rho128(U eta^5),
    R_U(eta^[5])=rho48(kappa^5 rem(U eta^5)-U(D eta)^5).      (1)

Here E^[5] denotes the coefficientwise Frobenius-twisted coordinate
space in the displayed basis; (D eta)^5 uses the fifth powers of the
matrix coefficients of D too. The entries of N_U and R_U are LINEAR
in U's32 coordinates. Their sizes are136x56 and56x56.

There is an untwisted atlas inducing the fixed oper if and only if there
are U in S_U and eta in E with pole U in {111,112} such that, putting

    T=-aff(U eta^5),

one has

    N_U eta^[5]=0,
    U delta T-T delta U=1,
    R_U eta^[5]=eta.                                        (2)

There are no T variables, auxiliary frames, local inverse series or
extension variables left. On the first equation T automatically belongs
to S_T, and its Wronskian with U is a CONSTANT; its value at one affine
point therefore suffices for the middle equation. This is a finite
polynomial system over the fixed oper's coefficient field, interpreted
geometric-pointwise for the atlas equivalence. No inverse Frobenius of
variable coefficients is used in (2).

For an admissible quotient direction U, N_U has rank EXACTLY55.
On its one-dimensional kernel the Wronskian functional is nonzero.
In fact rank N_U<=55 for every U, by density of admissible sections.

Write N_U^[1/5] for the matrix obtained by the unique entrywise fifth
root at a geometric point. For an admissible U define

    B_U = [N_U; N_U^[1/5] R_U],               size272x56.    (3)

Some nonzero scaling of this direction gives an atlas if and only if
rank B_U=55 and R_U does not kill ker N_U. Otherwise rank B_U=56,
or its kernel line is killed by R_U, and the whole direction is excluded.
Using U=sum u_i^5 U_i makes (3) polynomial: its blocks have degrees5
and6 in the u_i. Both infinity charts and all nongeneric admissible
directions remain included. This is NOT a proof that every direction
is excluded.

Status: author proof, not separately audited. Exact five-sample tests
verify (1)--(2), rank55, and reconstruction against the independently
implemented direct test; samples are not global exclusions.
[Proof](../Solutions/Sol_wronskian_matrix_pencil.md).
