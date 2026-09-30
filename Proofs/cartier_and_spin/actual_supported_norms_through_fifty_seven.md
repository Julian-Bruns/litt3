# Proof: complete phase packets reduce the norm problem

[Statement](../../Theorems/cartier_and_spin/actual_supported_norms_through_fifty_seven.md).
The comparison norm g under h1 has its sole pole delta*O and zeros
only at the twelve marked points. Its zero multiplicity at sheet s
above alpha_i is sum_j m_(i,s,j), where j runs over all29 phases and
the counts are nonnegative integers. Their total is delta. Apply the
same argument to the reciprocal norm under h2.

The [unbounded modular phase theorem](unbounded_modular_phase_balance.md)
says that at each root the differences of the three counts modulo five
are independent of j. Call a root good if these differences vanish,
bad otherwise. For a bad root, each of the29 phases has positive
total count; it costs at least29. Since delta<58, at most one root
is bad. At that root the minimum of the sums of the five residue
triples with the specified differences is at most one. Otherwise
the29 phases alone would cost at least58. The minimum is nonzero,
so it is one: after permuting cubic sheets its unique minimum triple
is(1,0,0).

If no root is bad, the total sheet counts agree modulo five. The
[five-saturation theorem](marked_support_five_saturation.md) writes
g as a polynomial times the fifth power of a supported function with
pole at most11. The established supported classification through28
therefore makes g a polynomial in x.

## The only bad-root normal form

For each phase at the bad root, choose c_j in{0,1,2,3,4}. Its residue
triple is the reduction of(1+c_j,c_j,c_j). The five possibilities are
(1,0,0),(2,1,1),(3,2,2),(4,3,3),(0,4,4).
Write ell for the number of phases with c_j=4. Restore the removed
multiples of five as nonnegative counts. At every good root the
residue triple is common on the sheets and can be accounted for by
a nonnegative power of x-alpha_i.

Let a be the sum of all these common exponents, and b the total of
the fivefold counts. Let R be the exceptional sheet point. The exact
zero divisor is

(29-5ell)R + sum_i a_i*x^*(alpha_i) + 5D,

where D is effective of degree b on the twelve marked points,
a=sum_i a_i, and a>=4ell. Therefore

delta=29+3a-5ell+5b >=29+7ell+5b.

It follows that0<=ell<=4. In particular29-5ell>0, so dividing g by
product_i(x-alpha_i)^(a_i) produces an ACTUAL regular affine function
whose divisor is

(29-5ell)R+5D-(29-5ell+5b)O.

No fifth-root extraction or hypothetical covering curve is used in
this step. This function cannot be a polynomial in x: its sheet
counts at R's cubic fibre differ modulo five, since29-5ell=4 mod5.
The bounded supported theorem excludes it if its pole is<=28.
The complete remaining list of(a0,b), a0=29-5ell, is

(29,0..5), (24,1..4), (19,2).

The case(29,0) is included in the base-jet exclusion for(29,1).
These leave exactly the ten tests below. Nothing is assumed about
the degree of either h_i beyond actual etaleness.

## Ten small exact geometric systems

Arithmetic Frobenius and the cubic automorphism act transitively on
the twelve marked points, so fix R=(alpha_0,rho_0). For each pair
(a0,b), use the complete monomial basis x^i y^j,0<=j<=2,
3i+10j<=a0+5b. First impose the a0 jets at R and compute its kernel.
For EVERY degree-b effective divisor D supported on the twelve
points, impose its additional5D jets on that kernel. At R those
additional jets start after the a0 already imposed jets. The results are:

| a0 | b | pole | dimension after base jets | remaining systems | outcome |
| --: | --: | --: | --: | --: | :-- |
|29|1|34|0|0|excluded|
|29|2|39|2|78|excluded|
|29|3|44|7|364|excluded|
|29|4|49|12|1365|excluded|
|29|5|54|17|4368|excluded|
|24|1|29|0|0|excluded|
|24|2|34|2|78|excluded|
|24|3|39|7|364|excluded|
|24|4|44|12|1365|excluded|
|19|2|29|2|78|excluded|

All systems have full column rank, over the full algebraic closure.
For the first line the29x26 base matrix itself has rank26; in the
producer's field encoding its selected determinant is352090.
Thus its subspace L(29O) also has no required section.

The [producer](../../scripts/arithmetic/actual_norm_phase_saturation_tests_20260929.py)
uses the established exact cubic jets, with a common rho0 character
scaling that keeps all matrices over F_(5^8). It records every divisor,
kernel, row selection and nonzero determinant. The
[summary](../../../litt3-computation-data/conceptual_continuation_20260929/phase_saturated_norms/summary.json)
and separate exact files are retained externally. This is a new small
collection of geometric linear systems, not a rerun of the large
degree<=28 certificate or an enumeration of coefficients.

The [focused independent audit](../../Research/audits/ACTUAL_NORMS_FIFTY_SEVEN_2026_09_29.md)
passes the reduction, five-saturation and complete family coverage.
Its independent cubic-power jets reproduce the29x26 base minor352090.
The8060 residual systems and24 divisors covered by zero base kernels
give8084 exact divisor cases in total; the successful older search
was not replayed.

Their exclusion proves norm invariance. Since delta=3m<=57, every root
mass is at most19. The audited integer lift now proves integer phase
balance. The four equations of the direct-source trace theorem apply.
They remain additional restrictions, not an exclusion of all m<=19.
