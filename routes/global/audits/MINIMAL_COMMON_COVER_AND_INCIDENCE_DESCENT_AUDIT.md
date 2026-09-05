# Audit: minimal common covers and rational incidence descent

**Verdict:** **PASS.**  No breaking mathematical objection was found.

**Auditor and date:** /root/x_elliptic_quotient_maps/m9_incidence_profiles,
2026-09-04.

## Scope checked

The audit checked:

- the product-image birationality of a minimal common etale cover;
- descent of the exterior-product incidence section and fpqc descent of
  integrality;
- the normalization of the fiber product and preservation of the generic
  degree \(d\);
- etaleness of both intermediate maps and separability via Kahler
  differentials;
- impossibility of descending the given \(Y\)-map through the incidence
  quotient when \(d>1\); and
- exclusion of a purely inseparable/Frobenius factor in an actual
  bi-etale incidence family, including when the characteristic divides
  \(d\); and
- the equivalence \(r\mid\ell\Longleftrightarrow d\mid n\) and the strict
  degree drop produced by a hypothetical etale map \(Z_0\to Y\).

All were found correct.

## Breaking objections

None.

## Non-breaking suggestions and objections

- Declare the factor curve \(B\) smooth, projective, and integral before
  using finite flatness.
- Make explicit that the integral generic algebra of
  \(Z_0\times_B Y\), together with finite flatness, rules out vertical or
  embedded extra components before passing to the common normalization.

Both clarifications were incorporated before the revision hashed below.
The later Corollary D.2a was separately rechecked by the same auditor;
the identity \(\psi_*\psi^*=[d]\) and wild Riemann--Hurwitz make its
argument characteristic-independent.

## Audited revision hash

d8162a176acb2b550a30833c5bc706400dcd437a91e48f8ae1bee1f79f1c6f15
