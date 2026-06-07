# Basin-127 CAS setup and displayed-basis check

This note records the local CAS follow-up after `154`/`155`.

## CAS setup

Two CAS paths are now available locally:

```text
SymPy 1.14.0
  installed into /private/tmp/common_cover_pydeps

Singular 4.4.1p5_2
  installed by Homebrew, together with flint and ntl
```

The purpose is to avoid expanding the project's hand-written polynomial
algebra for Groebner and saturation checks.

## New files

```text
double_fiber_x0_simple_u30_basin127_sympy_certificate.py
double_fiber_x0_simple_u30_basin127_displayed_basis.sing
```

The SymPy script has a fast default mode and an experimental
`--reconstruct-low-polys` mode.  The default mode verifies the displayed
basin-127 quotient and the base-residual cut.  The reconstruction mode starts
to rebuild the full six-parameter low-data recurrence, but the naive SymPy
rational-function branch solve is too slow: it reached the first symbolic
repeated solve, `index 3`, and made no further progress in the short local
trial.  This is not treated as a certificate.

The Singular script verifies the same displayed-basis quotient calculation
using a real Groebner backend.

## SymPy displayed-basis check

Command:

```text
python3 double_fiber_x0_simple_u30_basin127_sympy_certificate.py
```

Key output:

```text
displayed_basis_zero_dimensional: True

displayed_basis_plus_base_residual_groebner:
  r0 + 2
  r1 + 1
  r2 - 2
  r3 - 1
  r4 - 2
  r5 - 2

base_cut_is_p129: True
```

Thus, conditional on the displayed basis being the saturated low-data ideal,
the quotient residual `r3+r4^2` cuts the basin to the single point

```text
r = (3,4,2,1,2,2).
```

## Singular displayed-basis check

Command:

```text
Singular -q double_fiber_x0_simple_u30_basin127_displayed_basis.sing
```

Key output:

```text
std(J):
G[1]=r5-2
G[2]=r4^3-2*r4^2-r4+2
G[3]=r3*r4-r3-r4+1
G[4]=r3^2+r3-2
G[5]=r2-2
G[6]=r1*r4-r1+2*r4^2-2
G[7]=r1*r3+2*r1-2*r3-r4^2+2*r4
G[8]=r1^2-r3-2*r4-1
G[9]=r0+2*r1-2*r3+2*r4^2+r4+1

std(J + (r3+r4^2)):
Gbase[1]=r5-2
Gbase[2]=r4-2
Gbase[3]=r3+r4^2
Gbase[4]=r2-2
Gbase[5]=r1-2*r3+2*r4^3+r4^2-2
Gbase[6]=r0+2*r1-2*r3+2*r4^2+r4+1

base cut equals P129 ideal:
_[1]=0
...
_[6]=0
_[1]=0
...
_[6]=0

dimension J:
0

vector-space dimension R/J:
5

radical(J) equals J:
all mutual reductions are zero

dimension Jbase:
0
```

The mutual reductions against the P129 maximal ideal prove that the Singular
standard basis for `J+(r3+r4^2)` defines the same ideal as

```text
r0+2, r1+1, r2-2, r3-1, r4-2, r5-2.
```

The same Singular script now also checks the etale discriminant factor on the
displayed quotient.  On the `127` affine family,

```text
alpha = beta = r5-r2,
gamma = -r0 - 2*r1 - r2 + 2*r3 - 2*r4 - 2*r5 + 1.
```

The displayed basis forces `alpha=beta=0`, so `Delta=2*gamma^2` on the
quotient.  Singular gives:

```text
normal form of gamma mod J:
2*r4^2-r4+1

normal form of Delta mod J:
-r4^2-2*r4+1

std(J + (Delta)):
_[1]=1
```

Thus `J` is a reduced length-`5` quotient, and every point of the displayed
quotient lies in the declared `Delta != 0` etale locus.

## Tangent warning

A quick Zariski tangent check of the 19 low-data equations restricted to the
six-dimensional `127` affine family gave restricted ranks

```text
r=(0,0,2,1,4,2): rank 5, tangent dimension 1
r=(0,1,2,3,1,2): rank 5, tangent dimension 1
r=(3,4,2,1,2,2): rank 5, tangent dimension 1
r=(4,2,2,1,1,2): rank 5, tangent dimension 1
r=(4,4,2,3,1,2): rank 4, tangent dimension 2
```

So first-order tangent rank is not enough to certify the basin.  The
low-data equations have Frobenius/nonlinear structure that is invisible to a
pure tangent argument, and the Groebner/saturation certificate remains the
right kind of evidence.

## Current status

The `127` basin is stronger than before:

```text
1. The displayed nine-generator basis is verified by the hand-written checker,
   SymPy, and Singular; Singular also verifies it is radical of length `5`.
2. SymPy and Singular independently verify that the displayed basis plus the
   quotient base residual cuts exactly to P129.
3. Singular verifies that the displayed basis is disjoint from `Delta=0`.
4. P129 is already killed by the symbolic e50 certificate.
```

The remaining local audit gap is unchanged but sharper:

```text
Need a local CAS certificate that the original six-parameter low-data
recurrence ideal, saturated by Delta times the rho3 pivot, equals the
displayed basis.
```

The new CAS setup should make that possible once the low-data polynomials are
generated efficiently or the complete Sage/Singular script is recovered.
