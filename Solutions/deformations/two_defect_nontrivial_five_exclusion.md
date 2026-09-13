# Same-parameter exclusion for every actual nontrivial cyclic five-part

Version1,2026-09-10. Root application, fresh scoped audit PASS by
/root/audit_uniform_cyclic_main_application. The audit checks the
original maps, reference, markings and scope; it uses the separately
audited geometric/counterpart-count inputs without re-proving them.
[Statement](../../Theorems/deformations/two_defect_nontrivial_five_exclusion.md).

## Ordinary opposite endpoint

Suppose the actual matched span in the statement exists with r_X ordinary.
Let the actual Sylow5 order be5^a. The
[two-defect deck reduction](two_defect_deck_reduction.md) supplies
actual intermediate maps inside the given source

    Z -> T ->h Y' ->j C -> Y.

The first map is prime-to5 and preserves the two source defects.
The original h is cyclic5^a. Its base Y' has defect1 and genus3 or5.
The curve C is one of the ten known bad doubles of Y, of genus3;
j has degree1 or2 and preserves defect. The three reduced carriers
are C_(2*5^a), D_(2*5^a), C2×D_(2*5^a), with the order convention in
the statement. The small faithful image has not been substituted
for this unbounded ACTUAL Sylow order.

The bad double C has the required one zero line plus bijective Psi.
If j has degree2, normalized trace splits its pullback Psi subspace;
the remaining block has no kernel because Y' still has defect1.
Thus Y' has the exact simple-zero operator, with five or eleven
bijective dimensions. These are actual bundle/cohomology facts from
the existing bad-double and prime-to5 inputs.

The canonical ordinary Y tower lifts the actual chain of etale covers.
Its pulled-back full tuple is compatible, giving a compatible lower
reference for h through W3, as required by
[uniform cyclic descent](cyclic_power_descent.md). This uses
the full compatible pullback, not indigenous ordinariness of Y'.

Independently lift the ORIGINAL f:Z->X to the fixed canonical ordinary
X tower. The two-leg W2/FL naturality identifies its initial marking
with the Y-derived one. This gives the GIVEN full compatible upper
tower to which the descent theorems apply.

Descend it through Z->T by
[prime-to5 defect-preserving descent](defect_preserving_etale_descent.md),
through the original h by uniform cyclic descent for every a>=1, and
through the original neutral j by
defect-preserving descent again. Uniqueness and algebraization produce
the actual same-source mixed-characteristic span

    X^can <- Z^can -> C^lift.

Its source is the lift of the original Z and both maps are finite etale.
No replacement by an unrelated source, abstract common Jacobian factor,
or presumed simultaneous Galois refinement has occurred. The original
C->Y map is not asserted to lift; the genus-three endpoint already
suffices for the next step.

## One parameter bound for all exponents, not an infinite union bound

The previously audited count in
[defect-preserving descent, Sections5–6](defect_preserving_etale_descent.md) gives
at most5^24 ordinary r_X, fewer than2^80000000 genus-three
characteristic-zero common-etale-cover partners per fixed X^can, and
at most60 family parameters per special-fiber bad double.
Stable-model uniqueness passes back to special fibers, with Frobenius
stability for the parameter avoidance. Thus the total is

    5^24 * 2^80000000 * 60 < 2^80000062 < K.

This is ONE set of genus-three partners allowing ALL map degrees.
Every exponent a produces a member of that same set; there is no
separate exceptional set to sum over a. The previously selected
prime-degree t therefore excludes the entire ordinary-r_X stratum
without changing the main pair or increasing its avoidance bound.

For the explicit bad-double formulas, the projectivities of P1(F5)
fixing the omitted rational point4 form a group of order20 and act
transitively on the ten exceptional (Hasse class,bad twist) pairs.
[The exact symmetry check](../../scripts/genus_two/verify_bad_double_symmetry.py)
verifies this finite action. Transport preserves the actual normalized
quartic and intrinsic active connection: their scalar construction,
canonical marking and full filtered tuple are functorial under the
curve isomorphisms. Thus these are the same cohomological inputs on
all ten configurations, not merely a permutation of labels. The
source-defect hypotheses for each actual carrier remain explicit.

## Nonordinary opposite endpoint and exact boundary

If r_X is nonordinary, the already audited
[two-leg defect-orbit theorem](two_leg_defect_orbit_bound.md) applies
directly. The faithful projective action on ratios has order at most10,
so the actual joint normalization has Y-degree<=640 and X-degree<=80.
The same main parameter already excludes those bounded-degree partners.
It is unnecessary to lift a nonordinary X endpoint or apply the new
cyclic theorem to a two-defect base.

Together the two cases prove the statement. The remaining trivial-action
case has a two-defect base and is NOT within simple-zero cyclic descent.
Passing to a Galois closure of a non-Galois Y-leg can increase defects,
so that case is not covered. Higher defects and dormant/absent active
matches remain separate. This is a parameterized stratum exclusion,
not a solution of the original unmarked problem.

[Fresh scoped audit](../../Research/audits/UNIFORM_CYCLIC_MAIN_APPLICATION_AUDIT_2026_09_10.md).
