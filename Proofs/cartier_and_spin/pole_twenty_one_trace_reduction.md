# Proof: integer phase balance suffices for the direct trace comparison

27 September2026. The [bounded supported-function theorem](marked_divisor_relation_lattice.md)
makes the two actual norms of t and t^-1 polynomials of degree seven
in their respective x-coordinates, with zeros at the four roots of A.
Their integer multiplicities m_alpha sum to seven. Each of the three
cubic sheets above alpha contains exactly m_alpha simple endpoint
branches. The compositions on the two legs are independent.

## The general integer phase theorem is sufficient

The later [unbounded phase theorem](unbounded_modular_phase_balance.md)
applies to these actual polynomial norms. Each root has common
sheet cardinality m_alpha<=7, so it has at most one fivefold
block. The two-jet field separation gives phase equality modulo
five; the index-five norm coefficient separates roots and removes
that block. The multisets agree as INTEGERS on both endpoints,
without any length-seven sum enumeration. This uses the full
actual norm polynomial and preserves both original maps; cubic
descent and a Galois closure are unnecessary.

## Scalar restriction before any cubic descent

Let H=F_(5^8)^*mu29 and choose gamma^3=epsilon. In the full-fibre norm
identity, the multiplicities are M_i=3m_i. For
g=gcd_i(m_i-m0)>0 the
[actual full-fibre lemma](comparison_root_fibre_scalar_bound.md)
therefore gives epsilon^g in H. If a root is absent, g divides seven.
Otherwise the smallest m_i is one, since their sum is seven
over four positive entries. Taking that entry as m0 gives
g dividing sum_i(m_i-1)=3. Thus in all cases epsilon^21
belongs to H, without enumerating compositions.

The permitted change t->r t,epsilon->r^-4 epsilon with r29=1 removes
the mu29 part, since29 is prime to84. Hence epsilon^21 belongs to E8.
Writing q=5^8, one has q=4 modulo21, so21 divides q^2+q+1 and
21(q-1) divides q^3-1. This proves epsilon belongs to F_(5^24).

The [direct common-source trace lemma](direct_common_source_trace.md)
now applies, because the endpoint phases balance as integers.
Its second equation is
\[
\epsilon(C_0-\eta_0Y)=E_\infty-\eta_0X,
\qquad X,Y\in K_0=\mathbf F_{5^{14}},\quad\eta_0=[22].
\]
We claim C0 does not belong to K0. In the root Fourier basis of E8/B,
B=F25, all three nonconstant projections of c(alpha_i) are nonzero.
Their exact coefficient-rank check was already made in the
[sextic scalar proof](sextic_comparison_scalar_restriction.md).
The Fourier weights are2^(li), elements of F5. Thus C0 in K0 would
force the three weighted phase sums to vanish. Every at most seven
distinct phases is independent over F5, by the complete prime-field
rank certificate. Separating each phase and Fourier-inverting shows
that its four integer root counts agree modulo five. Its cardinality
has the form4a+5b, with a,b nonnegative. The total seven cannot have
that form. This proves the claim.

The denominator C0-eta0Y is consequently nonzero. All endpoint sums
and X,Y lie in E8 K0=F_(5^56), so the displayed equation puts epsilon
in that field. Intersecting F_(5^24) with F_(5^56) gives E8. This is
a restriction on the scalar only, not on the fields of the curves.

The direct trace lemma supplies the other three equations with these
SAME X,Y. This proves the reduction without eliminating the five
non-invariant coefficients of a degree21 minimal equation.

## Evidence and scope

Phase balance uses no length-seven sum enumeration. The separate
rank-seven LINEAR independence certificate remains necessary:
its376,740 normalized subsets and rank7.log are retained in
[the phase evidence directory](../../../litt3-computation-data/prime_field_phases_20260927/).
Original sum receipts remain
[external provenance](../../../litt3-computation-data/archive_cleanup_20260930/older_phase_before_hindsight/).

The [complete pole21 exclusion](pole_twenty_one_complete_exclusion.md)
closes the necessary four-trace locus using these original-source
equations. Neither theorem extracts a tensor from an unmarked span.
