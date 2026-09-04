# Symbolic final-line simple e50 certificate

This note upgrades the parameter observation from
`144_E50_PARAMETER_CONSTANT_SIMPLE_OBSTRUCTION.md` to an exact one-variable
calculation over `F_5[a]`.

## New script

Added:

```text
double_fiber_x0_simple_u30_symbolic_final_line_simple_e50.py
```

It works in the polynomial ring `F_5[a]` on the final post-e45 line

```text
free = base + a*v
```

from `137`/`144`, solves the simple branch symbolically, solves `u2_0(a)`
from the simple `u25` equation, and computes the simple ODE residual through
e50.

Compile:

```text
python3 -m py_compile \
  double_fiber_x0_simple_u30_symbolic_final_line_simple_e50.py
```

passed.

## Output

Command:

```text
python3 double_fiber_x0_simple_u30_symbolic_final_line_simple_e50.py
```

The symbolic final free line is:

```text
u7_3  = 2a
u6_2  = 3
u6_3  = 1+3a
u5_1  = 1+a
u5_2  = 1+4a
u4_0  = 4a
u4_1  = 3
u4_2  = 3+a
u4_3  = 1
u3_0  = 3+2a
u3_1  = 1+a
u3_2  = 3+4a
u3_3  = 4+4a
u2_2  = a
u1_0  = 4
u1_1  = 0
```

The repeated-`u25` pivot variables on this line are:

```text
u5_3 = 1
u0_0 = a
u2_1 = 3+3a
```

The simple `u25` solve gives:

```text
u2_0(a) = 3a
```

After building the full post-`u25` system with this `u2_0(a)`, the simple
branch has:

```text
lower_nonzero_count_before_50: 0
simple_e50(a) = 2
```

as an identity in `F_5[a]`.

## Meaning

This proves that **if** the e35/e40/e45 Frobenius-linear conditions reduce the
post-e30 local solution scheme to this final line over `k=\bar F_5`, then the
`129` survivor cannot extend: the simple e50 residual is the nonzero constant
`2`.

The remaining local proof obligation is therefore narrower:

```text
prove over k=\bar F_5 that the e35/e40/e45 solution scheme after e30 is
exactly the line displayed above.
```

Equivalently, extract/prove the Frobenius-linear e35/e40/e45 rank/codimension
certificate symbolically.  The e50 obstruction on the final line is now
certified.
