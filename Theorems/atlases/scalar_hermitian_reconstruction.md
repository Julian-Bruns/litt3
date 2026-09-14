# Explicit scalar reconstruction, with normalized identification

Version4. Use `scalar_hermitian_data` and fix a geometric dormant oper r. There
are explicitly computable rational matrices H in SL2(Acal) and G with
det G=t^-16, representing its fixed rank-two descent V, and bounded
linear spaces

    Pi={p in L(59)^2 : t^32 pG in Rcal^2},              dim Pi=32,
    Sigma={s in L(76)^2 : t^33 G^-1 s in Rcal^2},      dim Sigma=66.

Here p is a row and s a column. Their construction, including all
regularity tests and Laurent bounds, is given in the proof.

An untwisted PSU Hermitian atlas inducing this r exists if and only if,
on one of the two charts j=1,2, there exist p in Pi and s in Sigma such that

    ps=1,       p_O=t^32 pG,       p_O,j(0)!=0,                  (1)

and the following explicit equations hold. Set

    S=[p2,s1; -p1,s2],     s_O=e_j/p_O,j,
    eta=t^32 (s2,-s1) G s_O,
    J_0=(H S^[5])^T,
    v=J_0^-1 e2,
    Z_0=J_0^-1(-kappa^5, eta^5 kappa^5)^T-(0,eta)^T.

For the fixed basis ell_1,...,ell_40 of P_32, define

    M[:,nu]=Q(v ell_nu^5),       gamma=Q(Z_0),
    M=[M_1;M_2],               gamma=(gamma_1,gamma_2).

Define the extension cochain, rather than searching for it, by

    lambda_*=-rho_32(delta eta).                              (2)

The entire remaining test is the following 56 scalar equations:

    M_2 lambda_*^[5]=gamma_2.                                (3)

Equivalently, putting

    U_0=f1 p2^5-f2 p1^5,     T_0=f1 s1^5+f2 s2^5,

the test is

    rho_48(kappa^5(T_0+eta^5 U_0)-eta-U_0 lambda_*^5)=0.       (4)

Before eliminating lambda, the test is

    lambda + M_1 lambda^[5]=gamma_1,
    M_2 lambda^[5]=gamma_2.                                  (5)

An invertible, fixed linear change of the 96 target coordinates changes
its first40 equations into lambda+rho_32(delta eta)=0. Thus (2)--(4)
are scheme-theoretically equivalent to (5) on the scalar charts for this
fixed geometric oper.

All powers on coefficients are genuine fifth powers. Inverse constants
are encoded by inverse variables. Thus this is a finite polynomial test.
It constructs an actual everywhere-etale atlas, not just a rational form.

No parameters for j are needed: allowing all identifications
j=j_0[a,b;0,a], a!=0, b in L(16), gives EXACTLY the same existence
test after varying p,s,lambda. The ten apparent identification parameters
are removed by explicit changes of presentation.

For every valid quotient, M_1=Dbar M_2 and rank M=rank M_2=31.
The uniform equality follows from the Frobenius injectivity in
[the intrinsic criterion](semilinear_hermitian_lift.md); its differential
retraction gives the intrinsic explanation for eliminating lambda.
The lower block is

    v=(-delta U_0,U_0)^T,
    U_0=f1 p2^5-f2 p1^5 in L(112),
    (M_2)[:,nu]=rho_48(U_0 ell_nu^5),

where f1,f2 are the first row of H. The surjective quotients form a
nonempty open subset of Pi for every fixed oper.

The frame construction and differential elimination retain their independent
audits. Bounded checks on2026-09-14 cover the shear removal and universal
rank31 assertion; the full reconstruction retains author-proof status.
[Proof](../../Proofs/atlases/scalar_hermitian_reconstruction.md) ·
[Frame audit](../../Research/audits/PRO_SCALAR_FRAME_CHECK_2026_09_06.md) ·
[Differential audit](../../Research/audits/HERMITIAN_DIFFERENTIAL_ELIMINATION_AUDIT_2026_09_06.md).
