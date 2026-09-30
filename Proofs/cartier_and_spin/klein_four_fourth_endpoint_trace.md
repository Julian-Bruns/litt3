# Proof: fourth endpoint coefficient

[Statement](../../Theorems/cartier_and_spin/klein_four_fourth_endpoint_trace.md).
The received degree40 proof is preserved in the
[complete report](../../../litt3-computation-data/degree40_reply_20260926/extracted/k4_degree40/REPORT.md).
Its exhaustive symbolic and independent arithmetic verifiers passed
locally; the [receipt](../../../litt3-computation-data/degree40_reply_20260926/local_verification.log)
records the execution. The coefficient calculation is used below
with its full arbitrary-parameter scope.

## Triangular endpoint calculation

At a canonical phase-one zero-endpoint put e=epsilon^-1 and
Z=e t^3v. The two exact identities become
\[
A(u)=\sum_{m=0}^4A_me^{4-m}t^{13-3m}Z^m,
\]
\[
(tZ'-3Z)^3P(u)^2=\widehat P(t,Z)^2(u')^3,
\quad\widehat P=\sum_{m=0}^{10}P_me^{10-m}t^{30-3m}Z^m.
\]
A'(alpha) is nonzero, so the first equation recursively determines
u from Z. Write a=ell B^4/A'(alpha) and
C=3B^3P(alpha)^2=B^20a^3. Changing z_n=[t^n]Z by h changes
the degree-n residual in the second equation by
\[
(C/B)(2n+1)h.
\]
For n=1,2,3,4 these multipliers are3,0,2,4. Thus only z2=d
can be free among these coefficients. The exact universal solution
in F25[alpha]/A with independent geometric variables d,e gives
\[
z_1=(22,7,9,23),\quad z_2=d,
\]
\[
z_3=(17,3,9,10)+4e+(23,23,17,12)d,
\quad z_4=F_0+eF_1.
\]
The accompanying u-coefficients and direct substitutions modulo t6
and t5 are in the report and
[exact series data](../../../litt3-computation-data/degree40_reply_20260926/extracted/k4_degree40/evidence/endpoint_series.json).
The resonant degree-two equation vanishes identically. Triangularity,
not merely existence of this truncated solution, proves that every
actual germ has the stated fourth coefficient.

## All phases and both endpoints

Under t_new=a t, a29=1, the actual problem has
epsilon_new=a^-4 epsilon and Z_new=a7 Z(t_new/a).
To obtain label phase xi choose a7=xi, namely a=xi25. The new
fourth coefficient is a3F0+a^-1 epsilon_new^-1 F1, which is
xi17F0+xi4 epsilon_new^-1 F1. This proves the phase formula;
no relation among the four free values d is imposed.

The zero-fiber is split and unramified of degree four. Consequently
the coefficient of t in v0=Tr(v)/4 is
(epsilon U(Q)+V(Q))/4. The proved global trace principal parts give
\[
[t]v_0=(\eta/4)(\epsilon M_3-M_{-1}).
\]
This proves the first identity. Apply the actual symmetry
(t,u,v,epsilon) -> (1/t,v,u,epsilon^-1); the poles invert, so
M_j changes to M_-j. Multiplying the resulting identity by epsilon
gives the second. This retains all poles and both actual maps.

## The complete fixed degree40 contradiction

The mean values of F0,F1 over the four roots are[12],4. Thus when
the zero labels are the four canonical types once each with phase1,
[t]v0=epsilon[12]+4. The fixed degree40 necessary moments have
epsilon=[23]zeta2, M3=1+4zeta3, M_-1=[8]. Their substitution
would give
\[
[11]+[19]\zeta^2+[21]\zeta^5=0.
\]
This is a nonzero polynomial of degree five, whereas zeta has degree
seven over F25, with minimal polynomial
(4,22,7,20,21,7,24,1). Hence no such actual data exist.

The original archive and provenance are in
[the manifest](../../../litt3-computation-data/degree40_reply_20260926/manifest.json).
All five source files have byte-identical copies under
[the source directory](../../scripts/arithmetic/pro_degree40_20260926/).
Run python3 src/verify_all.py from the retained extracted package.
The local phase and symmetric-endpoint arguments above extend the
received canonical-phase calculation. Their broader consequences
are proved separately in
[balanced exclusion](klein_four_balanced_endpoint_exclusion.md).
