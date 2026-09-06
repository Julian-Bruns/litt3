# Custom GF(25) matrix arithmetic: independent current-frontier audit

**Verdict:** optimized matrix defect independently reproduced; no breaking
objection to the current quartic certificate or other scoped frontier claims.

**Date:** 2026-09-05. **Auditor:** `/root/finite_field_matrix_backend_audit`.
**Scope:** fresh reproduction of the reported genus-five Cartier discrepancy,
followed by a bounded scan of the recent certificates named below. This is a
software/certificate audit, not a reopening of old proofs. No old file changed.

Environment: `/usr/local/bin/sage`, Sage 10.9, Python 3.14, installed matrix
module under `/var/tmp/sage-10.9-current/local/lib/python3.14/site-packages/`.
The prior [Hoshi audit](HOSHI_SAGE10_9_CUSTOM_GF25_MATRIX_BACKEND_AUDIT.md)
already documented related failures for other custom presentations. The
present audit independently tests the new presentation and current certificate.

## Isolated reproduction and diagnosis

In a fresh `sage -python` process:

```python
from sage.all import *
k = GF(25, 't', modulus=[3,0,1]); t = k.gen()
A = matrix(k, [[t]])
print(t*t, (A*A)[0,0])
```

Output: `2 t + 3`. Thus even a one-by-one product is inconsistent with the
displayed field entries. This excludes transposition, Cartier convention,
and matrix-input ordering as explanations. Generic multiplication gives `2`.

The complete [executable reproducer](GF25_T_SQUARED_TWO_MATRIX_BACKEND_REPRODUCER_2026_09_05.py)
tests all 625 ordered scalar pairs. Every optimized one-by-one product agrees
with this incorrect operation: reinterpret each polynomial-coordinate integer
in Sage's default GF(25), multiply there, then copy the resulting coordinates
back. The default modulus is `x^2+4*x+2`, where the generator squares to itself
plus 3. Exactly 400 of these 625 products disagree with the supplied custom
field multiplication. Generic products agree with scalar arithmetic in all
625 cases. This establishes the observable wrong-modulus conversion behavior;
it does not identify the precise responsible source line or upstream library.

For the reported five-by-five matrix

```text
[2t 0 2 0 0]
[0  0 0 1 0]
[3  0 t 0 1]
[0  2 0 0 0]
[0  0 1 0 2t]
```

the optimized determinant is `t+1`; generic and scalar Leibniz determinants
both give `2t`. For `M` times its entrywise fifth power, the top-left entry is
`t+4` optimized and `3` both generically and by direct scalar dot product.
This is a reproducible Sage 10.9 backend defect, not merely a disagreement
between two unverified implementations. No statement is made about other
Sage releases or every extension field.

Additional trap independently reproduced: `apply_map` on a generic matrix
returns `Matrix_gfpn_dense` in this environment. Explicitly rebuilding the
Frobenius matrix with `implementation='generic'` is necessary here.

## Current frontier exposure

The current final Python block of
`SUPERSPECIAL_GENUS_TWO_QUARTIC_DEGREE_FOUR_CERTIFICATE.md` already constructs
generic matrices, checks every product entry against scalar multiplication,
and checks the determinant by the Leibniz formula. I executed that exact block
successfully from the Markdown. It returns p-ranks `1,1,5,7`, and both faithful
Cartier blocks are invertible (determinants `t` and `4t`). The audited file
SHA-256 is `1e44a9b1a3149d022b8b2181687678cccbc409dab164f1a5ec2d6bb12999c696`.

The bounded scan additionally checked:

- `SUPERSPECIAL_GENUS_TWO_QUADRATIC_CARTIER_EIGENFORMS_CERTIFICATE.md`,
  `EXPLICIT_GENUS5_CUBICAL_COVER_CERTIFICATE.sage`, and
  `EXPLICIT_ORDINARY_GENUS_TWO_DOUBLE_WITH_FROBENIUS_CYCLIC_PRYM_TWO_TORSION_CERTIFICATE.sage`:
  relevant Cartier matrix operations are over the prime field GF(5).
- `HOSHI_GENUS6_TWIST_PACKET_CARTIER_CERTIFICATE.py`: custom GF(25), but
  elimination and semilinear products explicitly use scalar lists and sums.
- `EXPLICIT_C3_CUBIC_DIAMOND_WEIL_CERTIFICATE.sage`: custom GF(25) scalar
  point counts and polynomial arithmetic; no finite-extension matrix operations.
- `SEVENTH_ROOT_BRANCH_PARTITIONS_ORDINARY_PAIR_FACTORS_CERTIFICATE.py`:
  custom GF(5^6), but the relevant one- and two-dimensional determinants
  explicitly use scalar formulas, including an inverse-Frobenius consistency check.
- `EXPLICIT_GENUS9_ENDOMORPHISM_FIELD_ABELIAN_PART_CERTIFICATE.sage`,
  `FIXED_Y_LOW_DEGREE_TORSION_FROBENIUS_CERTIFICATE.py`,
  `NONWEAK_TWO_POINT_FIRST_BREAK_FINITE_FILTER_CERTIFICATE.py`, and
  `ORDINARY_ATLAS_WITH_NONWEAK_MIXED_INERTIA_CERTIFICATE.py`: no relevant
  custom-extension dense matrix operation found by the bounded source scan.

These source exposure checks are not full independent mathematical audits of
each certificate. Earlier Hoshi reconstruction matrices remain covered by the
separate audit linked above; their whole audit was not repeated here.

**Breaking objections:** none to the scoped current conclusions after the
quartic block rerun. **Implementation objection:** an optimized product over
this custom GF(25) presentation is invalid evidence, even if later converted
to a generic matrix. Construct generic operands from original scalar entries
and verify the necessary scalar identities. No old proof required editing.
