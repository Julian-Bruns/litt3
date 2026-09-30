# Proof: the zero-leading rank-125 fourth-lift slice

[Statement](../../../Theorems/deformations/elementary_covers/rank125_fourth_low_slice.md).
Use the complete actual comparison \(E_4\) and scalar conventions of
[the quadratic-channel proof](fourth_hodge_quadratic_channel.md).

## 1. The entire fourth-lift slice

The complete actual W4 comparison gives, for EVERY
H in K8=K intersect J8,

    E4(H)=Q_actual(H)-[f_hat*H_hat/5] in the ENTIRE R/(f).

Indeed every remaining regular additive deck-equivariant map preserves
J8 subset(f), even with mixed coefficient transports. The constant
is zero. A single odd-log carry lowers degree by4, so only q2H8 and
q2H9 survive below J8. The quadratic filtration puts Q(K8) in J7 and
makes its class depend only on H8. Thus

    E4(H)=q8(H8)-C(q2H8)-C(q2H9),

with output degrees7,6,7 respectively. No formal A3 coordinate is
substituted for the original deck generators in C or q8.

The exact finite calculation now settles q8 on the required locus.
Reconstruct the full25-vector K8 basis from f. The degree-six carry
has rank6, with19-dimensional kernel. Applying the ACTUAL residue
quadratic to all190 symmetric pairs of this kernel gives zero in
R/(f). Thus any zero of E4 must first satisfy the degree-six carry,
and then its quadratic term is already zero. The full carry has
rank10. Its kernel therefore has dimension15 and is exactly the
geometric fourth-lift locus inside K8. The higher H>=10 are invisible.

These are coefficient identities, not a finite-field search or a
linearization at the origin. The two-dimensional image of q8 on
unrestricted K8 was retained; it is NOT declared identically zero.
Vanishing of the full obstruction permits a terminal primary repair
of the normal H1 class and a WHOLE regular boundary primitive. The
given uniqueness then glues the prescribed compatible tuple. This
proves sufficiency as well as necessity on K8, only at W4.

## 2. Eliminate leading degrees six and seven

Every source used below is an ACTUAL full kernel vector: row-reduce
the kernel of multiplication by the reconstructed f, then group its
rows by leading degree. Q is evaluated on these completed vectors,
not on homogeneous polynomials which might fail fH=0. The induced
low equations are independent of omitted higher kernel completions.

For H in K intersect J7, regular additive errors start in J7 and
carry terms from H>=8 start in J6. Also Q(K7,K8) subset J6. Thus the
full E4 modulo(f)+J6 depends on only the eight leading H7 parameters.
The eight actual degree-five equations generate the maximal ideal
of these eight parameters. In addition to a Groebner check, independent
finite coefficient elimination finds and verifies identities

    x_i = sum_j p_ij(x) E_(5,j)(x),    deg p_ij <= 2,

for all eight i. This forces H7=0 on every geometric solution.

Next let H in K intersect J6. The equations modulo(f)+J5 depend on
only its six H6 parameters and eight H7 parameters: Q(K6,K8) subset
J5, higher carries start in J6, and regular errors preserve J6.
There are14 nonzero equations (five in degree3, nine in degree4).
In the recorded RREF coordinates x0,...,x5 for H6, exact ideal
identities successively give

    x5²=0; x4²=0; x3²=0; x2²=0; x1=0; x0²=0,

where each assertion is modulo the previously vanishing coordinates.
The polynomial multipliers have respective degree bounds3,2,1,1,0,0.
Singular proposes the first large identity; a separate Python
polynomial multiplication verifies every coefficient of all six
identities over F125. This is a radical/geometric argument, not an
assertion that the obstruction scheme is reduced. It forces H6=0;
the preceding eight-equation calculation then forces H7=0.

The equations, actual completed kernel columns and exact identity
coefficients are retained in
[leading67 equations](../../../../litt3-computation-data/rank125_reference_20260914/computations/rank125_leading67_equations.json),
[six radical identities](../../../../litt3-computation-data/rank125_reference_20260914/computations/rank125_leading6_radical_certificate.json),
[leading7 equations](../../../../litt3-computation-data/rank125_reference_20260914/computations/rank125_leading7_equations.json),
and [eight ideal identities](../../../../litt3-computation-data/rank125_reference_20260914/computations/rank125_leading7_ideal_certificate.json).
Their generators and verifiers are
[the actual low-locus generator](../../../scripts/deformations/rank125/probe_rank125_low_locus.py),
[leading6 verifier](../../../scripts/deformations/rank125/certify_leading6_elimination.py),
and [leading7 verifier](../../../scripts/deformations/rank125/certify_leading7_elimination.py).

For perspective, the sole nonzero degree-one equation on all of K is
[78]a0²+[47]a1²+[96]a1*a2+[56]a2², in the four pivot coefficients
of H5 listed in the statement. Its rank is two: [96]=2*[47]*[34],
[56]=[47]*[34]² and -[78]/[47]=[50]=2t². Thus it splits over k into
the two planes a1+[34]a2=plus-or-minus zeta²*t*a0. Neither plane is
defined individually over k0; this is one reason a finite-field
search would not suffice. The origin in the four H5 coefficients is
settled by the preceding elimination. The later
[fourth-escape theorem](rank125_fourth_escape.md) proves existence of
nonzero points in the intersection of the two planes.

## 3. Exact evidence and scope

The completed \(K_8\) basis, carry ranks and 190 zero quadratic
coefficients are checked in the
[corrected checker](../../../scripts/deformations/rank125/audit_high_kernel_return.py).
The low-degree equations and independent polynomial ideal identities
are linked in Section 2. They prove a geometric-point equality,
without claiming that the original Frobenius-parameter scheme is
reduced. The nonzero-leading locus beyond its necessary quadratic
equation is handled only in the separate fourth-escape theorem.
