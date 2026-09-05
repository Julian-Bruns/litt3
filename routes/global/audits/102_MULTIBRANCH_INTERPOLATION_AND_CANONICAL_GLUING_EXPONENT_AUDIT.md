# Audit: multibranch interpolation and canonical gluing exponent

**Date:** 2026-09-05  
**Auditor:** Codex subagent
`/root/x_elliptic_quotient_maps/abelian_p_index_group_audit`  
**Audited theorem SHA-256:**
`3b37daabba447d721b960059fd968e53fbd7ffca7336e1d81adbb9cfd59580c6`  
**Verdict:** **PASS.**

## Scope checked

The audit independently checked:

- every step of the scaled residue-cluster induction in Lemma 102.1;
- the integral Chinese-remainder interpolation across distinct residue
  clusters and the final coefficient-denominator bound;
- the description of the multibranch completed local ring by integral
  interpolation at the branch graphs;
- the derivative-power valuation estimate for every pair of branches,
  including transverse pairs and characteristic-divisible contacts;
- the choice of the common tangent-ratio exponent and the power
  `q >= 2(r-1)`;
- descent and invertibility of the resulting local differential section;
- simultaneous application at all singular points with at most `R` branches;
  and
- the exact prime-to-characteristic part of the global gluing order and all
  ensuing degree bounds.

## Breaking objections

None.

## Key proof checks

In Lemma 102.1, scaling by the minimum pair distance `d` leaves integral
nodes and values and preserves the same pairwise inequality.  Reduction
modulo the uniformizer produces at least two nonempty node clusters, so every
cluster has strictly fewer than `r` nodes.  The inductively obtained cluster
interpolants may be imposed modulo their monic vanishing polynomials: cross-
cluster root differences are units, hence all cross-cluster resultants are
units and the corresponding ideals are comaximal.  Monic division after CRT
keeps the combined polynomial integral and of degree below `r`.

In the final rescaling, a degree-`j` term loses at most `j d` powers of the
uniformizer.  Since `j <= r-1 <= L`, the prefactor of valuation `L d`
cancels every possible denominator.  Thus the displayed induction proves
the full DVR statement, including nested clusters.

For a branch pair of contact `m`, after the prime-to-`p` exponent `e` has
equalized slope residues, the Frobenius power `q` multiplies the relevant
valuation by `q`.  Transverse pairs therefore give at least `q`; higher
contacts give at least `q(m-1)`.  The elementary inequality

```text
2(r-1)(m-1) >= (r-1)m  for m >= 2
```

supplies Lemma 102.1 with `L=r-1` for all pairs simultaneously.  If `p`
divides every higher contact, differentiation instead gives valuation at
least `m`, yielding the stated sharper exponent.

Finally, local descent forces equality of all branch residues, so every
tangent ratio has exponent dividing the global gluing order.  Hence `e`
divides `t(C)`; together with `t(C) | e q_R` and the fact that `q_R` is a
`p`-power, this proves that the prime-to-`p` part is exactly `e`.

As a non-authoritative sanity check, an exhaustive exact `Z_p` interpolation
test checked all admissible value tuples for 4 nodes modulo 8 at `p=2`
(4,368 cases) and 3 nodes modulo 9 at `p=3` (24,084 cases).  Every
interpolating polynomial had integral coefficients at the relevant prime.

## Non-breaking suggestions

The CRT paragraph could explicitly say that the combined polynomial is
chosen congruent to each cluster interpolant modulo that cluster's vanishing
polynomial.  This is already the evident CRT construction and does not alter
the proof.
