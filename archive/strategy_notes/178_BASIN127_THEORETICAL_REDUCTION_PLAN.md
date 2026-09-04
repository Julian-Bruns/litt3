# Basin 127 theoretical search-space reductions

Date: 2026-06-05.

This note records ways to replace the current long Sage certificate by a
smaller mathematical certificate.  The running script is proving a strong
scheme-level statement:

```text
saturate(<19 low-data equations>, Delta*u1_pivot) = J_displayed.
```

For the common-cover contradiction, the needed statement is weaker:

```text
V(low-data equations) cap D(Delta*u1_pivot)
    is contained in V(J_displayed),
```

followed by the already identified base-residual cut

```text
J_displayed + (r3+r4^2) = P129,
```

and then the separate e50/base equation excluding P129.  Nilpotent structure
and exact equality of saturated ideals are not needed for that route.

## 1. Work modulo the displayed quotient first

The displayed basis is

```text
r2 - 2,
r5 - 2,
r0 + 2*r1 - 2*r3 + 2*r4^2 + r4 + 1,
r1^2 - r3 - 2*r4 - 1,
r1*r3 + 2*r1 - 2*r3 - r4^2 + 2*r4,
r1*r4 - r1 + 2*r4^2 - 2,
r3^2 + r3 - 2,
r3*r4 - r3 - r4 + 1,
r4^3 - 2*r4^2 - r4 + 2.
```

The quotient is reduced of length 5, and `Delta` is nonzero on it.  Therefore
one side of the desired certificate can be checked by doing the shared
recurrence in the five-dimensional quotient `R/J_displayed`, or simply at the
five displayed points.  This avoids constructing huge degree-12 rational
functions in the full six-variable fraction field.

This proves that the displayed points satisfy the low-data equations.  It does
not by itself prove that there are no further points, but it cheaply verifies
one inclusion and catches mistakes before expensive saturation.

## 2. Replace full ideal equality by a generator-derivation certificate

Instead of producing all 19 low-data polynomials and saturating them, it should
be enough to derive the nine displayed generators from selected equations after
localizing at `Delta*u1_pivot`.  Concretely, seek equations or combinations
whose localized consequences are

```text
r2 = 2,
r5 = 2,
r4^3 - 2*r4^2 - r4 + 2 = 0,
r3^2 + r3 - 2 = 0,
r3*r4 - r3 - r4 + 1 = 0,
r1*r4 - r1 + 2*r4^2 - 2 = 0,
r1*r3 + 2*r1 - 2*r3 - r4^2 + 2*r4 = 0,
r1^2 - r3 - 2*r4 - 1 = 0,
r0 + 2*r1 - 2*r3 + 2*r4^2 + r4 + 1 = 0.
```

This is a point-containment certificate.  It can be checked by producing
explicit multipliers

```text
(Delta*u1_pivot)^N * g_i in <selected low-data equations>
```

for each displayed generator `g_i`, rather than computing the full saturated
Groebner basis.

## 3. Split by the forced `r4` cubic

The displayed quotient forces

```text
r4^3 - 2*r4^2 - r4 + 2 = (r4-1)(r4-2)(r4+1).
```

Thus the no-extra-points part can be split into three small charts:

```text
r4 = 1,   r4 = 2,   r4 = -1.
```

On `r4=2` and `r4=-1`, the relation

```text
r3*r4 - r3 - r4 + 1 = 0
```

immediately gives `r3=1`.  The remaining equations then solve `r1` and `r0`
linearly/quadratically.  The only nontrivial fiber is `r4=1`, where the same
relation degenerates and the residual equations split the three remaining
points.  This three-chart proof should be much cheaper than a global
six-variable lexicographic saturation.

## 4. Use the `w6` checkpoint before asking for tail data

The current expensive stage is computing the shared repeated column recurrence
through `w9`.  But the p-closed/ODE residual

```text
ode_constant_residual_a(w)
```

uses only `w1,...,w6`.  The run has already completed `w6`.  Therefore all
three `phi_i` equations can already be extracted in principle.

The tail equations require `t_inv`, hence the script currently calls
`branch_t_inv_a(..., max_degree=9)` and asks for `w7,w8,w9`.  A smaller route is
to first test how much of the displayed generator set follows from the three
`phi_i` equations plus the lowest-degree tail equations.  If this already
forces `r4` into the three displayed strata, the remaining tail search can be
done case-by-case and may not need full global `w9` expressions.

## 5. Practical replacement if the run is too slow

If the current process is cancelled later, a faster certificate script should:

1. Load the `w6`/`w7` recurrence checkpoint rather than restart.
2. Extract and save the three `phi_i` equations immediately.
3. Reduce all recurrence arithmetic modulo `J_displayed` for the easy inclusion.
4. Search for a small subset of equations proving the displayed generator
   consequences after localization.
5. If global saturation is still needed, split it by
   `(r4-1)`, `(r4-2)`, and `(r4+1)` before invoking Groebner.

This would turn the current "prove exact saturated ideal equality" task into a
shorter radical-containment and three-chart exclusion proof, which is closer to
what the global argument actually needs.
