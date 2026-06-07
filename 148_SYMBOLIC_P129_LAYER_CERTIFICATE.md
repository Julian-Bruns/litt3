# Symbolic P129 layer certificate

This note records the local symbolic proof that the current `P129` survivor
does not extend through the post-`e30` layers.

## New script

Added:

```text
double_fiber_x0_simple_u30_symbolic_layer_certificate.py
```

It mirrors the finite-extension layered solver, but replaces the current
layer variables by sparse polynomials over `F_5`.  For each of the layers
`e35`, `e40`, and `e45` it:

1. writes the current solution space as `base + sum a_i*b_i`;
2. rebuilds the repeated-`u25` pivot solve symbolically;
3. solves the simple `u25` branch symbolically and computes `u2_0`;
4. rebuilds `F0,...,F35`;
5. solves the repeated and simple branches symbolically through the target
   exponent;
6. extracts the four residual coordinates
   `(repeated_0,repeated_1,repeated_2,simple)`;
7. asserts that every coordinate is affine-linear in the current parameters;
8. solves the displayed affine layer and passes the resulting kernel to the
   next layer.

Any hidden Frobenius term such as `a_i^5`, or any ordinary nonlinear product,
would make `linear_data()` fail.  The script also asserts that the branch
recursion pivot systems it solves have constant matrices.

## Verification

Compile:

```text
python3 -m py_compile \
  double_fiber_x0_simple_u30_symbolic_layer_certificate.py \
  double_fiber_x0_simple_u30_symbolic_final_line_simple_e50.py
```

passed.

Layer certificate:

```text
python3 double_fiber_x0_simple_u30_symbolic_layer_certificate.py
```

Output:

```text
e35:
  u2_0_degree = 1
  lower_repeated_count = 0
  lower_simple_count = 0
  base = (4,3,1,3)
  rank = 4
  new_dimension = 9

e40:
  u2_0_degree = 1
  lower_repeated_count = 0
  lower_simple_count = 0
  base = (1,0,4,4)
  rank = 4
  new_dimension = 5

e45:
  u2_0_degree = 1
  lower_repeated_count = 0
  lower_simple_count = 0
  base = (0,1,4,2)
  rank = 4
  new_dimension = 1
```

The final line in the 16 non-pivot post-`u25` free variables is

```text
base =
(0,3,1,1,1,0,3,3,1,3,1,3,4,0,4,0)

direction =
(2,0,3,1,4,4,0,1,0,2,1,4,4,1,0,0)
```

with variable order

```text
u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,
u3_0,u3_1,u3_2,u3_3,u2_2,u1_0,u1_1.
```

This is exactly the final line used in `145`.

Final-line simple obstruction:

```text
python3 double_fiber_x0_simple_u30_symbolic_final_line_simple_e50.py
```

Output:

```text
u2_0(a) = 3a
lower_nonzero_count_before_50: 0
simple_e50(a) = 2
simple_e50_coefficients: [2]
```

## Layer matrices in the script basis

The symbolic script uses the `nullspace_mod5` bases inherited from the
current verifier, so its matrices are not the same basis as the GF125 note
`146`, though the base values/ranks/final line agree.

For `e35`, columns are:

```text
(0,4,1,4)
(4,4,0,0)
(0,1,4,1)
(0,3,4,2)
(3,0,2,4)
(2,1,1,1)
(3,3,0,1)
(2,4,3,1)
(3,4,0,0)
(0,0,3,4)
(1,0,1,4)
(4,1,1,1)
(3,2,3,0)
```

For `e40`, columns are:

```text
(3,1,0,2)
(4,4,0,2)
(2,4,0,1)
(0,3,2,4)
(2,2,4,2)
(4,1,4,2)
(0,3,1,0)
(3,4,4,2)
(1,1,4,1)
```

For `e45`, columns are:

```text
(2,2,3,4)
(0,2,1,4)
(2,4,4,3)
(1,0,2,0)
(0,2,3,2)
```

Each matrix has rank `4` over `F_5`, hence over `k=\bar F_5` in the same
basis.

## Conclusion

At `P129`, after imposing repeated `e30`, the residual layers `e35`, `e40`,
and `e45` are affine-linear over `k=\bar F_5` on the successive solution
spaces, with ranks `4,4,4`.  They leave exactly the final line certified in
`145`, and on that line the simple `e50` residual is the constant `2`.

Therefore `P129` is not a formal local branch through `e50`.

This resolves the current local survivor.  It is still a local obstruction
inside the direct double-fiber search, not by itself a global proof of the
common-cover theorem or a global counterexample.
