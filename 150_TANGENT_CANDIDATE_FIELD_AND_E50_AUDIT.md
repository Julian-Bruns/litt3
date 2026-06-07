# Tangent candidate field and e50 audit

This note records the 2026-06-05 follow-up to the field-precision concern:
some prompts said `F_5` or merely "characteristic 5" when the intended base is

```text
k = \bar F_5.
```

All solution-locus prompts must treat variables and points as `k`-valued.  It
is legitimate for displayed coefficients and explicit test points to lie in
the prime field, but one must not simplify `x^5=x` for variables unless the
variable has explicitly been restricted to `F_5`.

## Scope of the recent counterexamples

The recent Pro counterexamples archived in `120` and `147` are not artifacts
of the field typo.  Their coordinates lie in the prime subfield, so they are
valid `k=\bar F_5` points.  They are counterexamples only to weaker local
coefficient targets:

```text
singleton low-data target: refuted by a prime-field point, but only for one
  coefficient/nonvanishing assertion.

rho3 all-zero low-data target: refuted by the point in `120`, but the full
  chain kills it at simple-u30 base residual 2.
```

Thus the mistake was not "the point disappears over `\bar F_5`"; the mistake
was that the target statement was not the full formal-branch hypothesis needed
for the common-cover strategy.

## Generalized symbolic checker

The script

```text
double_fiber_x0_simple_u30_symbolic_layer_certificate.py
```

now accepts an optional 19-coordinate point argument and an optional
`--final-exponent`.  It recomputes the post-`u25` context at that point, solves
the repeated `e30` layer, proves the `e35`, `e40`, and `e45` residual layers
are affine-linear over `k=\bar F_5` on the successive solution spaces, and then
prints the exact final residual polynomials over `F_5[a0]`.

Regression at `P129`:

```text
python3 double_fiber_x0_simple_u30_symbolic_layer_certificate.py --final-exponent 50

e35/e40/e45 ranks: 4,4,4
final line dimension: 1
e50 residuals:
  repeated_0 = 3+4*a0
  repeated_1 = 4+a0+4*a0^2
  repeated_2 = 2+3*a0+a0^2
  simple     = 2
```

So `P129` is killed over `k=\bar F_5`, not merely over tested finite
extensions.

## Tangent-neighborhood census

The new script

```text
double_fiber_x0_simple_u30_tangent_hit_census.py
```

enumerates the affine linearized Newton space around `P129`, exact-checks
rho3 all-zero hits, and profiles the full simple-`u30` base residual plus the
post-`u25` repeated-`e30` consistency.  The full `5^7` tangent space around
`P129` gave:

```text
linear_rank = 12
linear_nullity = 7
valid_rho3 = 1559
all_zero_count = 17
base_zero_count = 4
base_e30_count = 4
```

This corrects the older reading in `132`: the four base-zero hits are
repeated-`e30` consistent once the remaining post-`u25` free variables are
allowed.

The four base-zero/e30-consistent hits are `P129` plus three nearby points:

```text
P129:
  (2,1,2,3,4,3,2,1,1,3,0,2,0,2,4,2,1,1,2)

candidate 2:
  (2,1,2,1,4,1,4,3,3,1,4,3,1,4,4,2,1,2,2)

candidate 12:
  (2,1,2,3,4,3,2,1,1,1,2,0,2,1,4,2,1,3,2)

candidate 14:
  (2,1,2,0,4,0,0,4,4,2,3,1,2,3,2,2,4,3,2)
```

## Exact e50 kills for the three new candidates

Finite affine checks first showed the same pattern as `P129`: e35/e40/e45
have ranks `4,4,4`, leave a final line, and the five `F_5` points on that
line have no e50 zero.  The generalized symbolic checker upgrades this to an
exact `k=\bar F_5` obstruction.

Candidate 2:

```text
e50 residuals:
  repeated_0 = 1+2*a0
  repeated_1 = 2*a0+a0^2
  repeated_2 = 2+4*a0+3*a0^2
  simple     = 3+3*a0
```

The simple residual vanishes only at `a0=4`; then `repeated_0=4`, so there is
no common zero over `\bar F_5`.

Candidate 12:

```text
e50 residuals:
  repeated_0 = 4+3*a0
  repeated_1 = 3+a0+3*a0^2
  repeated_2 = 3+a0+4*a0^2
  simple     = 1+2*a0
```

The simple residual vanishes only at `a0=2`; then `repeated_1=2`, so there is
no common zero over `\bar F_5`.

Candidate 14:

```text
e50 residuals:
  repeated_0 = 1+3*a0
  repeated_1 = 3+2*a0^2
  repeated_2 = 4*a0+3*a0^2
  simple     = 1+a0
```

The simple residual vanishes only at `a0=4`; then `repeated_0=3`, so there is
no common zero over `\bar F_5`.

## Conclusion

The counterexamples from the recent Pro requests are genuine local
counterexamples to the weaker coefficient-only statements, not artifacts of
the `F_5` wording.  They are not common-cover counterexamples, and they do not
survive the full local continuation currently used by the project.

The tangent-neighborhood points found after `P129` are also genuine
prime-field points satisfying the early local hypotheses, but all four
base-zero/e30-consistent points in this tangent neighborhood are killed
symbolically through e50 over `k=\bar F_5`.

The remaining project obligation is therefore unchanged in kind but narrower:
prove a coverage theorem for the entire stronger rho3 all-zero plus base-zero
locus, or find a new component outside this tangent neighborhood.  The field
audit does not supply a global counterexample and does not rescue the killed
local candidates.

## Prompt-file audit

A scan of `pro_prompts/` found several old archived `fresh_*` prompts still
opening with "Work over characteristic 5" or "You are working over
characteristic 5".  These are historical prompts, not launch-ready prompts.
The active queue `08_PRO_PROMPT_QUEUE.md` now quarantines this wording and
requires future solution-locus prompts to open with:

```text
Work over k = \bar F_5.  Numerical coefficients are in F_5, but variables and
points are k-valued.  Do not use x^5=x for variables.
```

It also includes the robustness convention requested after the typo: if a
literal reading is cheap only because of an evident typo, omitted dependency,
or index slip, state the defect briefly, make the minimal repair forced by the
surrounding setup, and continue with the nontrivial intended problem.
