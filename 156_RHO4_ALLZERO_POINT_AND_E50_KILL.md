# Rho4 all-zero point and e50 kill

This note records the completed rho4 fallback audit on 2026-06-05.

## Automation status

Per user instruction, Chrome/Pro monitoring was deactivated after the run
finished.  The guarded watcher status was:

```text
label: simple_u30_etale_rho4_allzero_standalone
url: https://chatgpt.com/c/6a22c6f9-62cc-8325-87ab-0604f7f54510
finished: 2026-06-05T16:21:24+0200
```

No further Pro calls should be assumed available for the project.  The
remaining work is local math, with optional tightly bounded Codex-thread
delegation for small auxiliary checks.

## Pro output

The rho4 prompt returned an explicit prime-field point in the prompt's
19-variable order:

```text
P_rho4 =
(0,3,2,2,3,2,1,4,4,2,2,2,1,1,2,4,2,2,4).
```

It claimed:

```text
alpha,beta,gamma,Delta = (4,2,3,4),
U = Col(1,33)=0,
M = Col(0,34)=S,
H = Col(3,30)=2S+4S^2,
Row(a,b)=0 for all 19 tail labels.
```

Thus all fallback `C4(R)` vanish in the rho4 chart.  Local verification
confirms the point exactly:

```text
python3 double_fiber_x0_simple_u30_low_formula_gf25_verify.py \
  '0 3 2 2 3 2 1 4 4 2 2 2 1 1 2 4 2 2 4'

True
('rho4', {... all sixteen non-pivot coefficients are 0 ...},
 {'delta': 4, 'phi': (1,2,2,4)})
```

This refutes the rho4 coefficient-only all-zero obstruction.  It is not a
common-cover counterexample.

## Full-chain continuation of the Pro point

The full-chain checker kills this exact point at the simple-`u30` base
equation:

```text
python3 double_fiber_x0_simple_u30_full_chain_etale_point.py --linear-data \
  '0 3 2 2 3 2 1 4 4 2 2 2 1 1 2 4 2 2 4'
```

Key output:

```text
chart = rho4_i00_m00_p
u5/u10/u15/u20/u25 pivot determinants = 2,3,1,3,2
raw_simple_u30_base = 4
raw_simple_u30_row = 0 on all U25 tail variables
schur_post_base = 4
schur_post_coeffs = 0 on all non-pivot variables
```

So the point is killed before the later repeated layers.

## Tangent basin around the rho4 point

The rho4 low-data Jacobian at `P_rho4` has:

```text
equation count = 20
variable count = 19
rank = 12
homogeneous tangent nullity = 7
```

Exact enumeration of the full `5^7` affine tangent basin found six exact
rho4 all-zero coefficient hits.  Their simple-`u30` base residuals were:

```text
4, 3, 1, 2, 3, 0
```

The unique base-zero hit was

```text
P_rho4_base0 =
(0,3,2,2,3,2,1,4,4,4,0,2,0,2,2,1,3,2,1).
```

It verifies as rho4 all-zero with `delta=4`, `phi=(4,3,2,1)`, and full-chain
simple-`u30` base residual zero.

## Later-layer kill of the base-zero rho4 hit

For `P_rho4_base0`, the post-`u25` repeated `e30` affine system is
consistent:

```text
post_u25_repeated_e30.base = (2,2,0)
row_rank = 3
one_solution: u7_3 = 4, all other displayed free variables = 0
```

The generalized symbolic layer checker then gives:

```text
python3 double_fiber_x0_simple_u30_symbolic_layer_certificate.py \
  --final-exponent 50 \
  '0 3 2 2 3 2 1 4 4 4 0 2 0 2 2 1 3 2 1'
```

Layer summary:

```text
e35: rank 4, new dimension 9
e40: rank 4, new dimension 5
e45: rank 4, new dimension 1
```

On the final line, the `e50` residual polynomials are:

```text
repeated_0 = 4*a0 + 3*a0^2
repeated_1 = 4 + 2*a0 + 3*a0^2
repeated_2 = 4 + a0^2
simple     = 2 + a0
```

The simple residual forces `a0=3`; then `repeated_0=4`, so there is no common
zero over `k=\bar F_5`.

Therefore the unique base-zero/e30-consistent rho4 tangent-basin hit is killed
symbolically at `e50`, just like the rho3 P129-family hits.

## New local helper

Added:

```text
double_fiber_x0_simple_u30_high_nullity_hunt.py
```

This scout ranks near-miss basins by tangent nullity without enumerating their
affine spaces.  The first loose run was stopped because the support threshold
was too permissive; future runs should use a smaller threshold or much smaller
`--max-near`.

## Interpretation

The finite picture is now stronger but still not a global proof:

```text
1. rho3 coefficient-only all-zero is refuted and killed later.
2. rho4 coefficient-only all-zero is also refuted and killed later.
3. In the explored rho4 tangent basin, the only base-zero hit is killed at e50.
4. The remaining obligation is still a coverage theorem for the full stronger
   all-zero plus base-zero/e30 locus, or a new component outside the checked
   tangent basins.
```

