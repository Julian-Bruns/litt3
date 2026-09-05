# Audit: nonabelian deck-rigidity boundary

**Date:** 2026-09-04  
**Auditor:** Codex subagent
"/root/x_elliptic_quotient_maps/abelian_p_index_group_audit"  
**Current theorem SHA-256:**  
"0d3cae087966ffffdd32b55ca1531a90a3bea56c83442e4885d39f342357676a"  
**Certificate SHA-256:**  
"a6a7de971d53ae81d865b8688bb66f259990b95da5beb36faf3c3f5fbde158a2"  
**Verdict:** **PASS, with minor citation and exposition repairs applied.**

The auditor checked the immediately preceding mathematical revision.  The
current hash differs only by the auditor-requested clarifications recorded
below and the audit link/status metadata; no theorem or calculation was
changed.

## Scope checked

The audit independently checked:

- the passage from Jain's complex Hurwitz-monodromy theorem to tame
  characteristic five through auxiliary \(G\ltimes W\)-Hurwitz spaces;
- Romagny--Wewers' good-reduction result and compatibility of the
  connected-component calculation;
- the reduction from the rank-two permutation module to full symplectic
  monodromy on the quotient Jacobian;
- applicability of the symplectic lifting theorem and Chai--Oort's
  absolutely-simple-fiber theorem;
- the automorphism-rigidity argument using primitivity,
  Castelnuovo--Severi, and a generic branch configuration;
- all \(\operatorname{PSL}_2(8)\) group, genus, character, and generation
  calculations; and
- the \(\operatorname{PSL}_2(7)/D_8\) comparison.

The exact Sage/HAP certificate was rerun and passed.  Its optional
"polymake", "neato", and display-path warnings do not affect any invoked
calculation.

## Breaking objections

None.

## Non-breaking suggestions, now applied

The auditor requested three precision changes:

1. state the passage to colored fixed-conjugacy-class Hurwitz unions over a
   cyclotomic base and the compatibility of the auxiliary finite-etale maps
   under good reduction;
2. cite Chai--Oort by the arXiv numbering, Lemma 2 and Proposition 4; and
3. describe the two degree-three characters of
   \(\operatorname{PSL}_2(7)\) as complex Galois-conjugate characters, not
   separate rational irreducibles.

All three changes are present in the current theorem file.
