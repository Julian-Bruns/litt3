# Audit of Sage 10.9 custom-GF(25) dense matrix arithmetic in the Hoshi certificates

**Verdict: BACKEND BUG CONFIRMED; THE CURRENT HOSHI CERTIFICATES SURVIVE.**

**Auditor:** `/root/x_elliptic_quotient_maps`  
**Date:** 2026-09-05  
**Environment:** SageMath 10.9, invoked through `sage -python`.

This is a software/certificate audit, not a theorem audit.  Sage's optimized
`Matrix_gfpn_dense` operations are mathematically inconsistent for the tested
noncanonical presentations of `GF(25)`.  In particular, optimized rank,
kernel, solve, and matrix--matrix multiplication must not be used with the
presentation

```python
k = GF(25, 'r', modulus=[2,0,1])       # r^2 = 3
```

The Hoshi certificates currently relied on in this route do not inherit a
false conclusion from this bug: the one certificate using this field for
linear algebra already implements every operation by scalar arithmetic, and
the remaining extension-field reconstruction matrices were independently
rechecked below.

## Minimal deterministic reproduction

The following two-by-two example already contradicts itself:

```python
from sage.all import *
k = GF(25, 'r', modulus=[2,0,1]); r = k.gen()
M = matrix(k, [[r,1],[3,r]])

assert r**2 == 3
assert M.det() == 0
print(M.rank(), M.right_kernel().dimension())
```

Sage 10.9 prints rank `2` and kernel dimension `0`, even though the scalar
determinant is `r^2-3=0` and the true rank is one.  Constructing the same
entries with either

```python
matrix(k, [[r,1],[3,r]], implementation='generic')
matrix(k, [[r,1],[3,r]], sparse=True)
```

gives rank one and kernel dimension one.

The reported four-by-eleven example was reproduced exactly.  Direct scalar
matrix-vector multiplication gives `z*M == c`, but the optimized dense
backend reports

```text
rank(M) = 4
rank(M.stack(matrix(k,[c]))) = 5
M.solve_left(c): ValueError: matrix equation has no solutions
```

Scalar Gaussian elimination gives ranks `4,4` and solution `z`.  Restriction
of scalars gives an independent check: expanding each GF(25) row and its
`r`-multiple over GF(5) produces ranks `8,8`, before and after adjoining
`c`.  The correct scalar RREF of the five-row stack has four pivots and a
zero last row.

## Tested scope and diagnosis boundary

- In 300 deterministic random tests with a row deliberately appended as a
  known linear combination, the presentation `x^2+2` gave a wrong optimized
  stack rank in 281 cases and a failed optimized solve in 282 of 300
  full-row-rank cases.
- The failure is not explained merely by the generator `r` having order
  eight.  Primitive but noncanonical defining polynomials `x^2+x+2` and
  `x^2+2*x+3` also failed in 100 of 100 analogous tests.
- The Sage-default presentation `x^2+4*x+2` passed the supplied example and
  all 300 random dependent-stack tests.  Three hundred random low-rank
  factorizations also agreed with scalar elimination for this presentation.
- On the custom Givaro field, matrices constructed directly from scalar
  entries with `implementation='generic'` or `sparse=True` agreed with scalar
  elimination.  This does not repair a matrix product that was already
  computed by the faulty optimized dense backend.
- In 100 random tests, optimized vector--matrix multiplication happened to
  agree with scalar multiplication, while optimized matrix--matrix
  multiplication failed all 100 tests.  This is a measured boundary, not a
  guarantee that every vector--matrix operation is safe.
- A `pari_ffelt` field plus explicitly generic matrices gave correct ranks,
  but `solve_left(vector)` attempted to create an optimized dense right-hand
  side and raised an internal `AttributeError`.  Merely switching the field
  implementation is therefore not a reliable drop-in repair in Sage 10.9.

These experiments strongly localize the defect to conversion used by the
optimized dense extension-field matrix backend when the field presentation
is not Sage's canonical one.  They do not identify or prove the underlying
library-level cause, and make no claim about other Sage releases.

## Scope of the existing Hoshi certificates

Checked revisions:

- `HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE.py`:
  `9a08f27bab65ca6f30673ca609ef47613a10fc36b808dea31f401184c4c35bf1`;
- `HOSHI_GENUS2_UNRAMIFIED_PRYM_FILTER_CERTIFICATE.py`:
  `d3f3184c05e85b99ddb42e1b33dab0af24aa5510f539242f51442c73211979ee`;
- `HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL_CERTIFICATE.py`:
  `a25deb4b50e933d4a01f8b38118661ed30d958a133073a1753008e6c87e778ef`;
- `HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE.py`:
  `ec9d8c12d9f85734852c7ec062b7c7827cfed99112e88a38abeaa78df28848b3`;
- `HOSHI_GENUS6_REFLECTION_CERTIFICATE.py`:
  `80f86c4916658276bbcc511065f2a9d9118a0a303e86c4a4484ad1e3fd1cc8fd`;
- `HOSHI_GENUS6_F5_KUMMER_P_RANK_CERTIFICATE.sage`:
  `40dd838a2498de06fe725d776a37f532d211af237f91be85e9dd78dbf1370a42`.

Findings:

1. The single-twist p-rank certificate explicitly calls no Sage matrix
   constructor or matrix algorithm.  Its constraints, nullspace, coordinate
   reconstruction, semilinear products, and ranks all use scalar GF(25)
   operations.  It reran successfully and returned stable ranks
   `[4,4,4,4,4,4]`.
2. The genus-two unramified-Prym filter uses only scalar and polynomial
   arithmetic over the custom GF(25).  It reran successfully and has no
   exposure to the faulty matrix backend.
3. The genus-two quotient-model certificate does form two optimized
   extension-field matrices, but over GF(625) with defining polynomial
   `x^4+4*x^2+4*x+2`, which is the Sage 10.9 default polynomial.  More
   importantly, both claims were recomputed from their scalar entries:
   `M1` has scalar rank 7 and its claimed one-dimensional kernel is exact;
   `M2` has scalar rank 19 and its claimed one-dimensional kernel is exact.
   Each claimed vector annihilates every row by direct scalar arithmetic.
4. The other matrix calls found in the Hoshi certificates are over the prime
   field GF(5), not a custom extension-field presentation.

**Breaking objections to the present Hoshi conclusions:** none after the
scalar rechecks.

**Non-breaking but mandatory implementation warning:** future certificates
must avoid optimized `Matrix_gfpn_dense` arithmetic over explicitly chosen
noncanonical finite-field moduli.  Prefer auditable scalar elimination, or
force a generic matrix implementation and independently check defining
relations coefficient by coefficient.
