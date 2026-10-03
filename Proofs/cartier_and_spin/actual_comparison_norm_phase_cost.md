# Integer residue profiles before geometric support tests

[Statement](../../Theorems/cartier_and_spin/actual_comparison_norm_phase_cost.md).
Let g be either actual endpoint norm in the same-source comparison
normal form. Write m_(i,s,j) for its nonnegative sheet/phase counts.
Their sums over j are the marked zero multiplicities, and their total
is the pole degree. The
[unbounded trace](unbounded_modular_phase_balance.md) makes the sheet
differences modulo five independent of the29 phases j.

## Complete integer coverage

At one root a residue class is v in(F5)^3 modulo the diagonal.
There are25 classes. Its possible least nonnegative triples are
r(c)=v+(c,c,c) modulo five, c=0,...,4. For all29 phases choose
nonnegative integers l_c summing to29. Put
\[
C_s=\sum_c l_c r_s(c),\qquad
cost=\sum_s C_s,\qquad R_s=C_s-\min(C_0,C_1,C_2).
\]
Every actual multiplicity triple is C plus five times a nonnegative
integer triple. Removing min(C_s) from each sheet divides by an actual
complete-fibre polynomial. It leaves the reduced base divisor R and
fivefold supported zeros. No hypothetical function or root extraction
is introduced by that division.

For each reduced R retain its MINIMUM cost over all classes and l_c.
Combining four roots gives a twelve-point base divisor R with total
minimum cost c. A pole budget N then permits
\[
b_{max}=\lfloor(N-c)/5\rfloor,\qquad
n_{max}=deg R+5b_{max}.
\]
Discard profiles with c>N. Any actual norm after the displayed division
has pole at most n_max, prescribed base jets R, and remaining finite
zeros supported in Z of orders divisible by five. Minimum cost may
enlarge this candidate space, which is harmless for necessary tests.
Keeping only the largest b_max for a fixed R retains every lower pole
possibility.

The zero class is included. When its total sheet residues agree
modulo five, the [root-extraction theorem](marked_support_five_saturation.md)
can reject a noninvariant function below its sharp conditional threshold.
Beyond that threshold it must remain in the candidate list.
Frobenius orbits of the profiles may be used because the marking is
preserved; no finite-field restriction is put on the unknown function.

## Smaller geometric section spaces

The [supported logarithmic identity](marked_supported_logarithmic_connections.md)
makes every candidate horizontal for
\[
dh=\left(\sum_{S\in Z}(mult_S(R)\bmod5)\omega_S\right)h.
\]
Build its ordinary linear system in the full basis of L(n_max O)
and append the actual integral base jets. Scalar extension computes
the entire geometric kernel. A horizontal section may still have
fivefold zeros away from Z; horizontality is only necessary.

Let the horizontal kernel have dimension k. Its least possible
nonzero pole is found by imposing successive top-coefficient zeros.
If every nonzero section has at least k remaining fivefold zero blocks,
enumerate all degree-k marked subdivisors of those blocks. At a marked
point horizontality makes the valuation congruent to the prescribed
residue modulo five. Coefficients at r,r+5,... therefore give successive
linear conditions for additional blocks after the base order r.
If every corresponding k-by-k matrix is nonsingular, no supported
section remains. Otherwise retain the rank-defect kernel and apply
the complete geometric recursion in
[the general support method](supported_norm_geometric_methods.md).
A rank defect alone asserts neither existence nor nonexistence.

The integer producer
[phase_packet_cost_profiles_20260929.py](../../scripts/arithmetic/phase_packet_cost_profiles_20260929.py)
and geometric solver
[logarithmic_phase_cost_solver_20260929.py](../../scripts/arithmetic/logarithmic_phase_cost_solver_20260929.py)
implement these reusable constructions. The existing solver reports
unresolved_small_zero_count or unresolved_rank_defects when its short
test does not decide a profile; the general recursion is a mathematical
completion method, not a claim that this source executes it.

The [original focused audit](../../Research/audits/LOGARITHMIC_PHASE_COST_2026_09_29.md)
records the method and its historical executions at100 and114.
Those fixed-budget searches and certificates are superseded by the
exact marked and actual congruence lattices. Their results are not
inputs to the all-budget profile construction, and no replay is needed.

Integer phase equality still requires the separate per-root mass
hypothesis from the unbounded phase theorem. None of these necessary
linear systems realizes a norm divisor by both actual maps.
