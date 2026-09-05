# Focused checks: bounded cored degree and coreless iteration

**Verdict:** PASS for the cored-degree, finiteness, iteration, and
monodromy statements in Sections 1--6; no breaking objection.

**Auditors and date:** `/root/canonical_trace_algebra` (cored degree and
bounded-image finiteness), `/root/x_elliptic_quotient_maps` (iteration,
minimalization, and monodromy), 2026-09-05.
`/root/gluing_cohomology_rigidity` independently checked the iteration
argument and the bounded prior-art comparison on the same date.

**Theorem:**
[bounded orbifold quotients and coreless correspondences](../BOUNDED_ORBIFOLD_QUOTIENTS_FORCE_INFINITELY_MANY_CORELESS_CORRESPONDENCES.md).

This record preserves delivered audit summaries and proof checks, not
private scratch reasoning. The subsequently appended Section 7 is an
author corollary and is not included in these independent checks.
The earlier ordinary-genus-two atlas bound has a separate linked audit;
its long local classification was not re-audited here.

## Checked statements

- In the actual simultaneous etale Galois refinement `W`, minimality
  identifies the original source with `W/(A cap D)`, with its specified
  endpoint maps. Its degree over `X` is at most `[G:D]=deg(Y/S)`.
  Wild stack stabilizers do not change the coset argument.
- Bounded-degree covers of the two fixed projective curves form finite
  lists. Identifications of any two sources are finite because their
  genus is at least two. This avoids counting stack automorphisms.
- Odd paths in the two-colored generic graph yield actual components of
  fiber products, etale over both endpoints. Minimalization remains an
  intermediate etale cover on both legs.
- A fixed minimal image accounts for at most its degree over `X` red
  endpoint embeddings above a fixed generic `X` embedding. Infinite
  generic dynamics therefore gives infinitely many images, not merely
  growing nonminimal sources. Subtracting finitely many cored images
  leaves infinitely many coreless ones.
- Both leg monodromies remain in the subgroup/quotient/product/extension
  closure of the initial two monodromy groups. This preserves fixed
  prime support and solvability but not exponent.

## Nonbreaking suggestions and boundaries

The first auditor suggested the two-finite-cover-lists proof in place
of the valid but less elementary bounded-degree Hom-scheme argument;
the suggestion was adopted.

The iteration checker emphasized counting endpoint images, not paths
or source genera, and keeping the graph two-colored even for identical
endpoints. Both points are explicit in the proof.

The literature check found no later solution of the restricted case;
this is not a priority or current-open-status certification. The general
Question 3.21 is not answered by the conditional parameterized theorem.

## Recorded consolidated revision

Before this audit link was added, the consolidated theorem (including
the separately marked author corollary in Section 7) had SHA-256

`ec88d499d4f3994756d0ae4ecd581ac26138f9cd57979644eafd4b55a8c07b43`.

The hash identifies the recorded consolidation, not a claim that every
auditor read every later editorial addition. Any change to a checked
mathematical statement requires reconsidering its scope.
