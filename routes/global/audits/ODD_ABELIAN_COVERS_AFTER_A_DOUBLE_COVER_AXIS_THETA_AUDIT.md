# Audit: odd abelian covers after an étale double cover

Date: 2026-09-05.
Auditor: `/root/gluing_cohomology_rigidity`.
Verdict: **PASS**, with no breaking objections.

Target: [Odd abelian covers after a double cover have proper axis theta](../ODD_ABELIAN_COVERS_AFTER_A_DOUBLE_COVER_HAVE_PROPER_AXIS_THETA.md).

## Scope

The auditor read the complete new note, independently checked the
broadening in §§4–5, and reconfirmed the opposite-component argument
of §3 previously checked during author discussion. The previously
checked Prym polarization and compulsory theta contribution, Raynaud
symmetry and properness, and p-group refinement support invariance
are inputs, not newly audited primary foundations.

## Checks

1. The quotient isogeny \(P\to J(U^{(1)})/A\) has kernel
   \(P[2]\). For every odd integer \(n\) prime to five it induces
   an isomorphism on geometric \(n\)-torsion. Consequently a class
   \(\gamma\) of such order has a unique representative
   \(\alpha\in P[n]\) modulo \(A\). Neither anti-invariance nor
   a lift of the involution to the abelian cover is required.

2. If a prime-to-five \(\alpha\in P\) has a bad translate and
   \(2\alpha\notin A\), symmetry supplies two distinct divisor
   components. Their restrictions are the disjoint reduced
   degree-four divisors \(\alpha+P[2]\) and \(-\alpha+P[2]\).
   They exhaust degree eight but miss the compulsory contribution:
   nonzero five-torsion in the ordinary case, or the origin in the
   supersingular case. Restriction of the effective residual divisor
   is legitimate because \(P\) is not contained in theta. Thus
   \(\alpha\in P[4]\); the already proper zero translate excludes
   \(P[2]\), leaving only exact order four. No odd class is bad.

3. For each finite abelian cover, the character decomposition has
   finitely many summands, each generically zero on the same base
   Jacobian. Its irreducibility makes the intersection of the good
   opens nonempty. This is a per-cover conclusion with unrestricted
   degree and prime support, not a claim that one open works for
   infinitely many covers simultaneously. All line classes and
   pullbacks are correctly placed on the scalar Frobenius twists.

4. Étale pullback injects the required section spaces for every
   actual intermediate source. The cited p-group filtration lemma
   applies to the bundle on the existing source, so an actual
   Galois five-group refinement preserves its vanishing locus.
   Neither a trace splitting nor descent of a second map is used.

5. In the stated Galois-closure formulation, the subgroup of index
   two in \(G/R\) is automatically normal. Its quotient gives the
   actual étale double \(U/Y\); the remaining cover of \(U\) is
   abelian of odd prime-to-five degree. The cover by \(R\) is the
   actual Galois five-group refinement. Thus arbitrary conjugation
   action on the odd abelian subgroup is permitted. The second-leg
   conclusion uses the good slice on the original source and does
   not reconstruct or replace that source.

## Boundaries and snapshot

The fourth-order cases remain possible exceptions. The theorem does
not cover unrestricted monodromy, prove a common-cover exclusion,
or assert compatibility of generic choices across infinitely many
covers. These boundaries are correctly stated in the target note.

Reviewed SHA-256, before any later status/link edits:

`9a636261b37a5612b283d141c7cf633af2dfb354265bc5bcf4d26c1b76fa32e6`.

No theorem text was edited in this audit.
