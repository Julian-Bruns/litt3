# Proof: modular residues, phase costs and small horizontal spaces

[Statement](../../Theorems/cartier_and_spin/actual_comparison_norm_phase_cost.md).
Use the actual norm g and counts m_(i,s,j) in the
[pole57 proof](actual_supported_norms_through_fifty_seven.md). The
[unbounded trace](unbounded_modular_phase_balance.md) fixes the sheet
differences modulo five independently of the29 phases j. If every
difference is zero, five-saturation writes g as a polynomial times
h5, with h supported and of pole<=22. The already proved classification
through28 makes g a polynomial. It remains to exclude a bad residue class.

## Complete integer coverage, with the discarded polynomial retained

At one root a residue class is a triple v in(F5)3, modulo addition
of(c,c,c). There are25 classes. For a fixed class its possible least
nonnegative triples are r(c)=v+(c,c,c) mod5, c=0,...,4. At the29
phases choose nonnegative counts l_c summing to29. Put

C_s=sum_c l_c*r_s(c),  cost=sum_s C_s,
R_s=C_s-min(C_0,C_1,C_2).

The discarded common part is exactly an integral power of x-alpha.
Every actual multiplicity vector is this residue sum plus five times
an effective divisor supported on the twelve marked points. For each
reduced R retain its MINIMUM cost over all choices of l_c and class.
This enlarges the candidate set harmlessly: it maximizes the number
of extra fivefold zeros still permitted by the pole budget.

Combine four such root profiles. For the resulting twelve-component
base divisor R and total minimum cost c, allow

b_max=floor((N-c)/5),  n_max=deg R+5*b_max,
where N=114 (or100 for the earlier retained calculation).

The norm divided by the discarded polynomial is then a nonzero h in
L(n_max O), vanishing on R, with all its remaining finite zeros in Z
and of orders divisible by five. Any profile with n_max<=28 is already
excluded. If R=0 the good-class argument above applies instead.

For fixed R, keeping only the largest b_max retains ALL lower pole
possibilities, since they are subspaces of the same L(n_max O).
Arithmetic25-Frobenius permutes marked indices by(i,s)->(i+1,s) for
i<3 and(3,s)->(0,s+1); its orbit has length12 and includes the cubic
action. Keeping one representative of each such orbit is valid for
geometric existence. No coefficient of h is restricted to that field.

The [integer profile producer](../../scripts/arithmetic/phase_packet_cost_profiles_20260929.py)
literally enumerates these25 residue classes and all compositions of29
into five counts, then combines the four roots subject to the budget.
At N=100 it produces271 single-root profiles and378 canonical global
profiles; at N=114 these numbers are592 and995. It uses integer
arithmetic only; repeated phases and fivefold multiplicities are
retained exactly.

## A linear differential equation before any support enumeration

For each profile the
[supported-logarithmic theorem](marked_supported_logarithmic_connections.md)
gives

d h = (sum_R (mult_R(base) mod5)*omega_R) h.

Construct its ordinary E-linear system in the complete monomial basis
of L(n_max O), then impose the actual integral base jets. A matrix over
E=F_(5^8) computes the whole geometric kernel by base change. It does
not enumerate E-valued candidate functions.

For the retained N=100 calculation,374 of378 kernels are zero.
The four remaining base divisors are
a single marked point with multiplicities14,19,24,29. Their data are:

| Base multiplicity | b_max | pole bound | horizontal dimension | minimum extra zero degree |
| --: | --: | --: | --: | --: |
|14|10|64|2|9|
|19|11|74|3|9|
|24|12|84|4|9|
|29|14|99|6|9|

The minimum extra zero degree is read from the least pole order in
the horizontal space, not assumed to be its maximal permitted degree.
The distinct monomial pole orders3i+10j make this an ordinary rank test.

If a k-dimensional horizontal space had a supported h, its remaining
zero divisor would have degree at least9, hence contain a degree-k
effective subdivisor on Z, for k=2,3,4,6. At a marked point the valuation
of a horizontal function is congruent to the prescribed residue modulo
five. After a base order r, vanishing of its coefficients at r,r+5,...
therefore forces successive increments by five. These coefficients
give linear functionals on the horizontal space.

For EVERY effective degree-k divisor on the twelve marked points,
the corresponding kxk matrix is invertible. The exact counts are
78,364,1365,12376, respectively, totaling14183 nonzero determinants.
Thus no horizontal function in these four spaces can have all its
extra zeros in Z. This closes every actual non-invariant profile
through100.

## Extension to114 with the same geometric test

Of the995 complete profiles,966 have zero horizontal space. The other29
have the following dimensions and counts. Every one has minimum extra
zero degree9, so the same subdivisor argument applies without a new
assumption.

| Horizontal dimension k | Number of profiles | Subdivisors per profile |
| ---: | ---: | ---: |
|1|12|12|
|2|5|78|
|3|8|364|
|4|1|1365|
|6|1|12376|
|7|1|31824|
|9|1|167960|

All216971 support determinants are nonzero. In particular the limiting
case of dimension9 and minimum block degree9 is included. The matrices
act on complete geometric section spaces; their rank is not inferred
from a search for functions with finite-field coefficients.

## Evidence and scope

The [solver](../../scripts/arithmetic/logarithmic_phase_cost_solver_20260929.py)
records the connection, constraints, kernels, base-jet minors and all
small-subdivisor determinants. The
[input profiles](../../../litt3-computation-data/conceptual_continuation_20260929/phase_cost_100.json)
and [complete summary](../../../litt3-computation-data/conceptual_continuation_20260929/log_norm_100/summary.json)
retain all378 cases, including every zero-residue boundary. Full exact
case files and code-generated checks are in that directory. The run
completed with no unresolved profile. The earlier pole73 run independently
used the same general construction on its40 profiles, all with zero
horizontal space; it is not needed for coverage through100.
The extension uses the
[pole114 profiles](../../../litt3-computation-data/conceptual_continuation_20260929/phase_cost_114.json)
and [995-case summary](../../../litt3-computation-data/conceptual_continuation_20260929/log_norm_114/summary.json).
All case headers were matched to those inputs; all statuses are excluded.
The [independent audit](../../Research/audits/LOGARITHMIC_PHASE_COST_2026_09_29.md)
checks the general coverage and geometric solver and selected pole100
arithmetic. The pole114 extension is a new complete execution of the
audited algorithm, not an independently replayed rank sweep.

This proves a statement about actual comparison norms. Arbitrary
supported functions need not satisfy the phase-cost constraint, so
their classification is not being extended to114 here. The integral
phase lift still requires root masses<=19, and the four resulting
trace equations are not known to exclude all such configurations.
