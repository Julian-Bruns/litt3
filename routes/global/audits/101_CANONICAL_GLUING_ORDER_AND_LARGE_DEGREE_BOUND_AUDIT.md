# Audit: canonical gluing order and large-degree bound

**Date:** 2026-09-04  
**Auditor:** Codex subagent
`/root/x_elliptic_quotient_maps/abelian_p_index_group_audit`  
**Audited theorem SHA-256:**
`da1f04bb18f8cf01aaf7f7113514b1cb23fabac2ceb5b5b1116ccf2b3fddc196`  
**Verdict:** **PASS.**

## Scope checked

The audit independently checked:

- the identification of the differential ratio as a canonical
  trivialization of the pullback of
  `pr_X^* omega_X tensor pr_Y^* omega_Y^(-1)`;
- torsion of the resulting generalized-Jacobian point over
  `algebraic closure(F_p)` and the equivalence between its order and descent
  of the specified normalized trivialization;
- the see-saw decomposition of `O(C)` under
  `Hom(J(X),J(Y))=0`, including the two fiber degrees;
- the restriction-sequence and Kunneth argument giving both inequalities in
  (101.4), and the Riemann--Hurwitz and ceiling consequences;
- the completed local ring of a two-branch image singularity;
- the exact descent condition for the differential-ratio powers;
- all three local-order cases, including tangencies in which the
  characteristic divides the intersection multiplicity; and
- the passage from the local orders to their global least common multiple.

Only Proposition 100.1 was used from file 100.  Its primitive joint-image
reduction supplies the same normalization with both maps still finite etale,
which is exactly what file 101 requires.

## Breaking objections

None.

## Key checks

For two branches `y=u(x)` and `y=v(x)`, put `w=u-v` and
`m=ord_x(w)`.  In the ambient frame `dx tensor dy^(-1)`, the normalized
differential-ratio values are `u'` and `v'`; membership in the completed
local ring is therefore exactly

```text
(u')^n - (v')^n in w k[[x]].
```

If `m>=2` and the characteristic divides `m`, then
`w=x^m a(x)` gives `w'=x^m a'(x)`, so order one already descends.  If the
characteristic does not divide `m`, then `ord(w')=m-1`, and for
`n=p^a b`, `p` not dividing `b`,

```text
ord((u')^n-(v')^n)=p^a(m-1).
```

This reaches `m` exactly when `p` divides `n`, proving that the local order
is exactly `p`.  The node calculation similarly gives the exact order of the
tangent ratio.

As a non-authoritative sanity check, these descent predictions were tested
with truncated exact power series in characteristics 2, 3, 5, and 7, for
all contact orders from 2 through 20 and powers through `2p+1`; every case
passed.

The global lcm step is sound because the quotient measuring descent from the
normalization is supported at the finitely many singular points, completion
is faithfully flat, and a descended section whose value is a unit on every
normalized branch is itself a local unit.  Since the normalization is
connected and projective, any other normalized trivialization differs by one
global scalar, which does not alter any local divisibility condition.

## Non-breaking suggestions

1. In the see-saw paragraph, one could mention explicitly that the canonical
   principal polarizations identify the possible cross term with a
   homomorphism between the two Jacobians.  The current argument already has
   the needed content.

2. In the global lcm paragraph, the one-line support/completion explanation
   above would make especially transparent why no additional global gluing
   constraint survives after all local tests pass.

These are exposition suggestions only; no mathematical correction is
needed.
