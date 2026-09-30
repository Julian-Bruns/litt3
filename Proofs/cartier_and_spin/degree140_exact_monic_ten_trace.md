# Exact coefficient queries and the next unit identity

30 September2026. Use the nine global trace polynomials and the ring R
from [the statement](../../Theorems/cartier_and_spin/degree140_exact_monic_ten_trace.md).
All original coefficients are retained in the
[external trace directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/).

The monic degree-eleven element P11 is an exact combination of these
polynomials. Divide each original row by P11 in R[mu], obtaining rows
R_i of degree at most ten. They still belong to the same ideal.
The source
[exact full-operation graph](../../scripts/arithmetic/degree140_trace_exact_dag_20260930.sage)
represents each operation on the ENTIRE polynomial. To request its
coefficient in degree k, a scale shift by s recursively requests the
parent coefficient in degree k-s. No low coefficient is discarded.
Before any degree bound is lowered, the cancelled leading coefficient
is checked to be exactly zero. The reconstruction is stored as
`trace_exact_monic11_dag.sobj`; the nine exact degree-ten coefficients
are in `trace_exact_monic11_leading.sobj`.

Remove only powers of H,q,Psi and a nonzero scalar from each leading
numerator, writing it as u_i*N_i/D_i. The source
[leading-ideal construction](../../scripts/arithmetic/degree140_trace_next_leading_ideal_20260930.sage)
retains these removed units. Its exact ideal basis is in
`trace_exact_degree10_leading_basis.sobj`.
The subsequent
[unit-lift source](../../scripts/arithmetic/degree140_trace_exact_unit_lift_20260930.sage)
finds polynomials W_i and checks in K[H,q] the identity
\[
\sum_iW_iN_i=H^6q^4.
\]
The full weights and their input numerators are retained in
`trace_exact_degree10_unit_lift.sobj`; its compact receipt is
`trace_exact_degree10_unit_lift.json`. The target is a unit of R.
Consequently
\[
P_{10}=(H^6q^4)^{-1}\sum_i W_i D_i u_i^{-1}R_i
\]
belongs to the original trace ideal and has leading coefficient one.
This proves the statement, independently of any subsequent lower-degree
extraction. The construction itself also checks that the full-operation
node for P10 has coefficient one in degree ten.

The nine-row lift took approximately626 seconds on ONE calculation core.
A separate four-row optimization attempt also found an identity, but its
weights were larger; it is not used for the continuation. No incoming
Pro verifier was replayed. The earlier fixed-cutoff arrays remain
withdrawn because later scale shifts can bring discarded terms back
into the required degree range. This exact graph was introduced to
remove precisely that failure mode.

Since each input trace vanishes at an admitted nonzero entirely ramified
critical fibre, so does P10. Neither a common-zero exclusion nor an
actual common-source construction follows from the existence of this
monic relation alone.
