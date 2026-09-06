# Canonical marked quotient: major stress test

Date: 2026-09-06. Auditor: `/root/canonical_marked_quotient_major_stress_test`.
Verdict: **PASS**, taking the established prime-to-characteristic contact
bounds as proved. No counterexample or broken inference found.

Scope: `Solutions/Sol_canonical_marked_quotient.md`
and `Solutions/Sol_finite_correspondence_groupoid.md`,
including the arbitrary-weight extension, all exact and scalar-preserving
correspondences, refinements, powers, and the finite-field marked version.
The contact/root statements and the general atlas bound were checked for
applicability; old audit files were not opened.

## Main checks

* If p divides d, the logarithmic Frobenius connection is frame-independent
  and regular even at D. Horizontal sections have unique actual p-th
  tensor roots, regular by their valuations. The nonhorizontal case gives
  a separating function t with dt/t=eta and degree at most d(2g-2).
  All normalized exact self-images embed as distinct components of its
  reduced fiber product. The argument also handles two endpoints and
  simultaneous horizontal extraction.
* After reduction to weight prime to p, the stated two-endpoint root
  bound supplies bounded degrees over either fixed endpoint. Finite
  etale covers of bounded degree and the zero tangent spaces of maps
  to the other hyperbolic endpoint give the required cross-endpoint
  finiteness. The simple-form constant is 4p/(p-4).
* Normalization really resolves joint-image branch collisions in the
  finite groupoid. Each composition domain is normal and dominant over
  its integral joint image, so its lift to that image's normalization
  exists uniquely on the whole domain. The same argument applies to
  associativity and inverse identities. No generic-only composition or
  assumed simultaneous Galois closure enters the construction.
* Effectivity ensures distinct generic arrows and identifies every
  effective atlas relation with the normalization of its reduced joint
  image. Descent, the two-object quotient, and the whole-relation root
  torsor bound therefore apply as claimed, including disconnected torsors.
* An exact beta-preserving automorphism of the quotient yields only
  arrows already in the exact relation and hence is the identity.
  Automorphism finiteness follows from the finite set of degree-n covers
  and finiteness of Aut(C). Thus multiplier injection, cyclicity, and
  prime-to-p order are valid.
* For powers, equality of the r-th powers of the tensor pullbacks forces
  their ratio to be a constant root of unity, also when p divides r.
  This gives exactly G[r]. Connected finite etale endpoint refinements
  are covered by the actual two-endpoint span argument. The later Galois
  envelope and degree (n-1)! follow in the finite-etale covering category.

## Nonbreaking clarification suggestions

1. In the main theorem, “classified by G” should explicitly mean a
   partition indexed by G, whose individual members are components of
   the corresponding twisted fiber products; it need not mean one
   jointly minimal image per group element.
2. One can justify the use of “generically trivial automorphism is
   trivial” by taking the closure of the generic 2-isomorphism in its
   finite Isom space over the normal orbifold. The finite birational
   closure is the base, so the 2-isomorphism extends uniquely. This also
   makes the descent argument for multiplier injection fully explicit.

Neither suggestion changes any mathematical conclusion.
