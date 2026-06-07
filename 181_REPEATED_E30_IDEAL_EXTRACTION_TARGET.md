# Repeated e30 ideal extraction target

Date: 2026-06-05.

This note records the next exact algebra target behind the `G4` coverage
problem from `180_G4_DOUBLE_FIBER_TAIL_COVERAGE_TARGET.md`.

## What is already implemented

The code path in `double_fiber_x0_simple_u30_full_chain_etale_point.py`
already constructs the repeated-e30 condition after the repeated `u25` pivot
solve.  The relevant functions are:

```text
post_u25_repeated_e30_data(...)
repeated_e30_after_u25_data(...)
solve_affine_matrix_mod5(...)
```

For fixed local parameters and a fixed chart, the construction is:

```text
1. Build the repeated-u25 affine row:
     u25_affine + u25_matrix * U25 = 0.

2. Choose the chart pivots U25_PIVOTS[chart].

3. Schur-solve the three pivot variables as affine functions of the remaining
   post-u25 free variables.

4. Evaluate the repeated e=30 residual at the zero free point and at each
   coordinate free point.

5. Return a three-row affine system
     e30_base + sum e30_row[name] * y_name = 0
   in the remaining post-u25 free variables.
```

Thus repeated-e30 consistency is not a black-box predicate.  On a chart it is
an explicit affine-linear condition after inverting the u25 pivot determinant.

## Concrete audit at the rho3 survivor

Running

```text
python3 double_fiber_x0_simple_u30_e30_kernel_search.py \
  --residual-max 35 --random 0 --enumerate-prefix 1
```

at the script default survivor

```text
(2,1,2,3,4,3,2,1,1,3,0,2,0,2,4,2,1,1,2)
```

gives:

```text
free variables:
  u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,
  u3_0,u3_1,u3_2,u3_3,u2_2,u1_0,u1_1

e30_base = (3,2,4)
e30 row rank = 3
kernel dimension = 13

one solution:
  u7_3=4, u6_2=2, u6_3=1, all other displayed free variables zero.
```

The first affine solution already has nonzero next residuals:

```text
repeated e35 residual = (4,3,1)
simple e35 residual = 3
```

This matches the project picture: e30 consistency is common, but the later
layers cut the affine e30 space further.

## Exact ideal to extract

The proof target is to promote the finite evaluator above to symbolic
generators over

```text
F_5[r0,r1,r2,r3,r4,r5, post-u25 free variables]
```

or over the corresponding chart coordinate ring before quotienting by the
six-parameter local family.

For each chart, introduce variables `y_name` for the post-u25 free variables
and form:

```text
E30_chart =
  < e30_base_component + sum e30_row[name][component] * y_name
    for component = 0,1,2 >
```

where the `u25` pivot variables have been Schur-eliminated.  The open chart
condition is the product of:

```text
Delta * u5_pivot_det * u10_pivot_det * u15_pivot_det
      * u20_pivot_det * u25_pivot_det.
```

The desired exact containment target is:

```text
< low-data equations,
  simple-u30 Schur equation,
  E30_chart >
: open_chart_product^infinity
```

is contained in the union of the known killed basin ideals, or becomes unit
after adjoining the corresponding e35/e40/e45/e50 layer equations on each
remaining stratum.

## Why this is the right next step

The current finite diagnostics check only selected `F_5` points or tangent
families.  This extraction turns the post-u25 e30 condition into ordinary
polynomial algebra over `k = \bar F_5`, which is exactly what the final `G4`
proof needs.

The practical next implementation should not enumerate the 13-dimensional
kernel.  It should reuse the symbolic machinery from
`double_fiber_x0_simple_u30_symbolic_layer_certificate.py` to emit the three
e30 affine generators and the later layer generators in variables for the
kernel coordinates, then hand those generators to Sage/Singular for saturated
containment checks.
