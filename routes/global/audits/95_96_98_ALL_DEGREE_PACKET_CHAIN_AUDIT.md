# Audit: abelian towers, nonabelian packets, and the full signed field

**Date:** 2026-09-04  
**Auditor:** Codex subagent
`/root/x_elliptic_quotient_maps/abelian_p_index_group_audit`  
**Audited theorem SHA-256 values:**

- file 95: `56e62e5d338e3a9da0d3ad9ac6c7fa667789d6f51a49321897590f38f004710a`;
- file 96: `e29ae0577eee7bb8226fbfeb5731468ee95f7b8ceff176bd1ea99e532b32b50c`;
- file 98: `86f034af2bdbc03d2d72992535baa2e6726320d339365f2d1350d7f09f68f9a8`.

**Certificate SHA-256:**
`113cfd95a2e457de837c498f8d21a23a2a6d705bad9c5dd6845ca8a1ed004c6b`  
**Verdict:** **PASS, conditional on the explicitly recorded arithmetic input
from file 76.**

The arithmetic assertions imported from file 76 were treated as hypotheses,
as file 95 and file 98 themselves require.  This audit did not recompute the
full Frobenius matrix from file 76.  It did rerun file 98's independent small-
prime signed-Frobenius certificate, which passed.

## Scope checked

The audit independently checked:

- the free-action etale Lefschetz character formula when
  `char(k)` divides the deck-group order;
- the rational packet dimensions and the Jacobian isotypic-factor argument;
- the tensor-product lower bound for a cyclotomic/abelian field acting on a
  matrix algebra over the target endomorphism field;
- the exact Schur-index dimension bound and its cancellation against the
  regular-representation packet dimension;
- the deductions for bounded character degree and bounded-index abelian
  subgroups;
- the two modular signed cycle types, their indicated powers, and the
  generation of the full sign kernel;
- the commutator and signed-letter-stabilizer proof that the root field has no
  nontrivial abelian subfield; and
- the reduction of an arbitrary common etale cover to its Galois closure over
  the first curve without losing etaleness over the second curve.

For the last point, if `D` is the Galois closure of `Z -> X`, then the
fundamental-group subgroup defining `D` is the normal core of the subgroup
defining `Z`.  It is contained in that subgroup, so `D -> Z` is finite etale.
Consequently `D -> Z -> Y` is finite etale as well.

The exact command

```text
sage -c "load('routes/global/98_SIGNED_FROBENIUS_CERTIFICATE.sage')"
```

passed all asserted square-free factorization degrees, verified that the
46th power switches exactly two reciprocal pairs and the 25th power switches
all 25 pairs, and verified the resulting rank-25 span over `F_2`.

## Breaking objections

None.

## Non-breaking objections and suggestions

1. In Lemma 95.3, the factors of `K tensor_Q F` are most naturally described
   as the (possibly twisted) compositum factors indexed by embeddings of
   `F intersection K`.  The stated number of factors and their common degree
   over `K` are correct; this is only a useful precision in the explanation.

2. In the proof of Theorem 96.2, the sentence saying that every complex
   constituent of (96.7) belongs to the packet is stronger than the proof
   needs.  It would be cleanest either to cite the standard freeness of the
   Tate realization over `K tensor Q_l`, or simply to choose a nonzero local
   summand of the Tate module and a constituent arising there.  The latter
   immediately supplies the existential character required by the theorem
   and avoids making the argument depend on the word "every."

3. Section 4 of file 98 could include the one-line normal-core argument above
   to make explicit why passage to the Galois closure preserves an **etale**
   map to `Y`, rather than merely a nonconstant map.  The claim itself is
   correct.

These are exposition or citation-strengthening suggestions only.  They do
not change any theorem, numerical threshold, or application in files 95,
96, or 98.
