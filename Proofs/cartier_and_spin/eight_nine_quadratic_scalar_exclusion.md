# Four-phase quotients and the balanced remainders

27 September2026. Use the Fourier notation and fixed coefficient
identities of the [six/seven-label scalar proof](sextic_quadratic_scalar_exclusion.md).
For a label multiset L of cardinality eight or nine, membership
lambda*U_L+V_L in K0, with lambda in F25*, implies
\[
S_3(17)=0,\quad\lambda S_1(17)=[10]S_1(4),\quad
\lambda S_2(17)=[18]S_2(4).
\tag{1}
\]
Every at most nine distinct phases is independent over F5. The complete
normalized prime-field rank checks have1,184,040 full-rank eight-sets
and3,108,105 full-rank nine-sets, recorded by the existing independent
field-construction source in rank8.log and rank9.log. Hence S3(17)=0
forces its coefficient to vanish at each phase. An occupied phase
needs at least two labels, leaving at most four occupied phases.

The needed quotient lemma is the following exact finite statement:
for nonzero F5 coefficients c_j supported at at most four phases,
\[
\left(\sum c_j\xi^{4j}\right)/\left(\sum c_j\xi^{17j}\right)\in F25
\quad\Longrightarrow\quad\operatorname{supp}(c)=\{0\}.
\tag{2}
\]
The quotient then equals one. The denominator is nonzero by prime-field
independence. Normalize one coefficient to one. The
[dual-arithmetic enumerator](../../scripts/arithmetic/four_phase_quotient_independent.cpp)
checks29,1,624,58,464,1,520,064 weighted sums for supports1,...,4.
It independently evaluates every test in seven F25 coordinates and
fourteen F5 coordinates. The latter solves a two-column prime-field
span problem for X and beta*X rather than dividing coordinates in F25.
Every decision and quotient agrees; the only success is support{0}.
The complete receipt is four_phase_quotient_independent.log in
[the phase directory](../../../litt3-computation-data/prime_field_phases_20260927/).

If either S1 or S2 has nonzero coefficients, (1)--(2) force
lambda in{[10],[18]}. Otherwise all three nonconstant root Fourier
coefficients vanish phasewise. The four root counts then agree modulo
five at each phase; the cardinality has the form4a+5b. For eight labels
this forces a=2,b=0, so L is two complete four-root blocks. For nine
it forces a=1,b=1: L is one complete block plus a fivefold singleton,
whose contribution to all four endpoint sums is zero.

At the two endpoints, the membership scalar is epsilon and epsilon^-1.
The inverse of{[10],[18]} is{[9],[11]}, disjoint from it. Thus at least
one endpoint is balanced in the preceding sense. Since epsilon belongs
to F25, the old traces then put C and E of the other endpoint in K0.
All three nonconstant Fourier projections of the c-row are nonzero;
prime-field phase independence therefore forces the other endpoint
to have the same balanced form. Eight labels are excluded by
[the complete two-block theorem](eight_label_balanced_trace_exclusion.md).
For nine labels discard only the ZERO contributions of the fivefold
singletons in the field equations; the remaining one-block system is
excluded by the [complete balanced quartic theorem](klein_four_balanced_endpoint_exclusion.md).
No integer endpoint branch or actual divisor has been discarded.

As a separate consistency check, a complete eight-label meet-in-the-middle
test was run twice with different prime-field projections. Each run
enumerates7,940,751 four-tuples for each of24 scalars and checks every
possible complementary pair in all original coordinates. Both retain
the same10,474 normalized endpoints:435 balanced records per scalar,
plus3 extras for[10] and31 for[18]. This matches the proved classification.
Its source is [eight_f25_endpoint_mitm.cpp](../../scripts/arithmetic/eight_f25_endpoint_mitm.cpp);
its records are retained beside the balanced case certificates. This
extra check is not needed to replace the short quotient proof above.
