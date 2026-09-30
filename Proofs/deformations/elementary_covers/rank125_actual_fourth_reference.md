# Proof: the actual marked fourth-reference comparison

Version1,2026-09-14. [Statement](../../../Theorems/deformations/elementary_covers/rank125_actual_fourth_reference.md).
This combines an exact finite computation with the whole-object
construction below. The
[independent mathematical audit](../../../Research/audits/RANK125_ACTUAL_FOURTH_REFERENCE_AUDIT_2026_09_14.md)
checks source signs, tuple slots, both branches, regularity, projection
and extraction dependencies. The separate
[fresh local replay](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/local_replay_checks.json)
reconstructs both vectors, both repair tables and the two control
comparisons without a preexisting pickle or compiled binary input.

## 1. Reference, full primary and complete comparison

The preceding base and integral-chart theorems fix all input choices.
The four base/reference sources supplied with the return agree byte
for byte with their already audited originals. The other primary
sources reconstruct the original scaled characters, the six normal
representatives (kappa/u,v/u,v/u^2,v/u^3,y/u,y/u^2), the full primary M,
and its normalized Schur column a and row ell. The lower ordinary
5x5 constant block is invertible. Scalar multiplication by f has rank82,
so the full primary has rank625+82=707 and its kernel has dimension43.
No replacement cover or relabeling enters this reconstruction.

The source at H is the single exponential

    exp((5xi-25(n3+n(H))-125n4)D) mod625,

with the fixed base digits and the prescribed inverse-Frobenius source
n(H). The whole first normal cochain satisfies

    rho3(H)-rho3(0)=-A*n(H)^5.

The sign follows by expanding the source displacement at25 in the full
initial frames, and is also checked directly in all requested runs.
The full inverse-Cartier transition uses the weighted Taylor recurrence

    K0=I, K_(j+1)=5*dK_j/dz+[[0,-g],[-25*Pprev*g,0]]*K_j,

with true Witt Frobenius and actual source transport, through j=5.
Its previous potential is0 for the first flat25 comparison and R for
the fourth flat125 comparison. The j=5 coefficient is (K5/5)/24.
The upper-right entry is multiplied by z and divided by5 or25 on the
WHOLE matrix comparison, before any normal or scalar projection.

## 2. Whole first regular repairs at both branches

Triangular exact arithmetic in the original affine W_U variables splits

    A*n(H)^5=P_U,H+sum_e P_O,H,e*(W_U-chi)^e.

The six-component normal remainder is zero because H lies in the full
primary kernel. P_U,H is an actual affine polynomial in
u,kappa,y,v,W_U. Every monomial of P_O,H,e in component order
(1,kappa,y,v) has u exponent at most(-1,-2,-3,-4), respectively.
Since their leading z valuations are(0,-2,-3,-5), these coefficients
are z^2-divisible at BOTH infinity branches. W_O=S+RO is regular.

Let F_U,ref be the actual canonical first affine cochain, and define
the whole formal cochain F_O,ref=(rho3(0)-F_U,ref)/z^2. Then

    f_aff(H)=F_U,ref-P_U,H,
    f_form(H)=F_O,ref-z^-2*sum_e P_O,H,e*(S+RO)^e

are the required whole regular repairs. For the baseline Frobenius,
F_U,ref=v*sum_(h=0)^24 [r_h]u^h with field-code coefficients

    (5,61,84,15,124,53,57,81,21,62,68,124,36,
     101,115,92,79,91,55,78,73,67,26,69,118).

The [original exact certificate](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/received/rank125_fourth_reference/certificate.json)
contains every affine coefficient modulo25, retaining its signed
integral section lift, and every finite P_O coefficient. The two cases
have1347/1344 actual affine terms and806/809 formal-boundary terms.
These data are not finite-window substitutes for the displayed whole
formal expressions. Both tables were reproduced exactly in the local run.

Anchor the integral formal coefficient section at one infinity branch.
At the other use its jmath transport, including S1 -> -S1. Thus the
second integral RO1 is the negative of the first integral lift; it is
not a fresh application of the coefficient section after negation.
Every source, affine and formal-boundary monomial has even parity
under (kappa,y,W1) -> (-kappa,-y,-W1). This was checked term by term
independently. Hensel uniqueness, source transport, connection and
normalization then make the WHOLE comparison invariant. This proves
the parity used in projection without assuming the desired output.

Apply graph corrections -5*f_aff and +5*f_form to the second columns.
Recompute the first columns by negative covariant differentiation,
normalize the determinants by the residue-one inverse square root,
and differentiate again. These are actual local regular frames for
the filtered object and its prescribed grading, with the original flat
line retained. The full corrected first jet and all four entries of
inverse-Cartier horizontality pass, in addition to the regularity proof.

## 3. Exact arithmetic and certified projection

The integral local algebra is the faithful product of five scalar
factors and thirty quartic unramified factors from the integral-chart
theorem. Arithmetic uses all factors, followed by exact interpolation.
For coefficients in zeta^j*T^i with j<4,i<3, pack a Laurent coefficient
of z^h into the integer slot 35h+5j+i. Before reduction, a product has
j<=6 and i<=4, so distinct polynomial coefficients have distinct slots.
Every nonnegative slot is bounded by

    12*min(na,nb)*(modulus-1)^2 < 2^63.

The checked bound makes GMP multiplication with64-bit slots exact.
Reduction then uses T^3=-T-1 and zeta^4=Teich(2). Separate native
checks against plain Python integer convolution and polynomial reduction
pass at [mod625](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/arithmetic_mod625.json)
and [mod3125](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/arithmetic_mod3125.json),
including maximal coefficients, scalar broadcasting, truncation and
Frobenius multiplicativity. The [small checker source](../../../scripts/deformations/rank125/audit_component_arithmetic.py)
does not use packing to calculate its expected answers.

After the WHOLE division, interpolate all125 S coefficients and
translate S=W_U-chi-RO. The pole bounds of chi are(1,3,3), and each
AS exponent is at most4, so this loses at most28 z orders. Eliminate
formal boundaries in decreasing AS degree. Along every elimination
path the exponent drops telescope, giving a further total loss at
most28. Thus an unknown tail starting at150 cannot affect coefficients
below94. The six normal representatives require only exponents
through1. The baseline divided fourth cochains have precision611;
the independently supplied other-gauge/other-branch replay has957.

The normal split retains all six rows. Invert the derivative-Top
correspondence, multiply by ell, and reduce the full relation span fR.
This gives all43 prescribed scalar coordinates, not an associated
graded approximation. The jmath argument in Section2 justifies the
single-branch parity separation used by this implementation.

## 4. Finite outputs and extraction

The complete nonzero entries of the actual E4(B0) are exactly those
in the statement. Independently calculate Q from the whole primary
affine repair q_U=-P_U using

    Q=(1/2)*[n^5*(A*Dq_U-q_U*DA)].

This computes a subtracted term; it never replaces the matrix E4.
The negative carry uses the entire product modulo25 with the original
relations s_i^5=-5*c_i*s_i, c=(3,1,2), divided by5 before projection.
In degree-five coordinate order (041),(131),(140),(221),(230),(311),
(320),(410), the three resulting rows, in field codes, are

    E4: (0,46,115,0,0,59,77,0),
    Q:  (0,55,115,0,0,110,76,0),
    C:  (0,100,35,0,0,80,48,0).

Field subtraction gives (0,16,115,0,0,19,108,0)=v_minus. The
independence minor of v_minus,v_plus is[99], hence alpha=1,beta=0.
Constructing H_A from these outputs gives the listed kernel
coefficients. Its actual full matrix comparison leaves precisely
[57]E331+[17]E340. No numerical reference value enters either
comparison as a premise.

The correction block evaluates to(A0,B0c,C0,D0)=([101],[24],[35],[70]),
with determinant[58]. Its transpose-oriented solution subtracts
[81]gamma1+[97]gamma2, yielding the stated Hstar. A further actual
matrix comparison gives the zero full scalar vector there. The whole
primary and regular repair interpretation therefore supplies a genuine
compatible fourth extension, not merely vanishing of selected entries.

The local macOS reconstruction starts from the supplied source only,
builds the exact arithmetic, regenerates primary and Schur data and
canonical base, and runs B0, H_A, nu39 and Hstar. Both full vectors,
both whole repair tables, primary data and all four values agree
exactly with the original certificate. Its
[execution log](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/local_replay/reconstruction.log)
and [complete reconstructed certificate](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/local_replay/reconstructed.json)
are retained separately from the incoming evidence. The
[source-only driver](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/received/rank125_fourth_reference/run_certificate.py)
specifies the exact replay. The independent audit plus this execution
complete the verification of the scoped statement. They provide no
fifth numerator or unmarked common-cover conclusion.
