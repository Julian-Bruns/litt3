# Bounded audit: spin probes retain both actual endpoint fields

Verdict: PASS.
Auditor: /root/audit_spin_probe_reduction.
Date: 2026-09-08.
Scope: version1 of
[the statement](../../Theorems/Thm_spin_probe_common_cover_reduction.md)
and [its proof](../../Solutions/Sol_spin_probe_common_cover_reduction.md).
Independent prose audit, not Lean verification. No large computation.

The audited eight-step spin-series reduction was accepted as an input.
The relevant Cartier field-recovery proof and the source-effectivity
argument in spin_primitive_matching_defect were checked directly. The
new ID was not yet registered when queried; stated dependencies were
retrieved through the canonical CLI. This is an administrative timing
point, not a mathematical objection.

No mathematical objections:

- The square-compatible difference of two spin lines defines a mu_2
  torsor. Pulling back the two endpoint torsors and taking a connected
  component gives a finite etale refinement of degree at most4 with
  compatible square trivializations. Both actual endpoint embeddings
  and their field intersection are preserved.
- For the superelliptic model, tame ramification and the unique point
  at infinity give div(dx/y^(a-1))=(2g-2)O. The numerical hypothesis
  makes e and xe regular. Their descending products recover x, and
  dx/theta=y^(a-1), followed by F(x)/(dx/theta)=y, recovers the full
  embedded endpoint field. Separability makes these differential
  identities valid and nonzero.
- The other probe squares to the specified eta. Cartier naturality
  puts its independent Cartier image downstairs. The two genus-two
  forms recover the hyperelliptic coordinate and then its quadratic
  generator using one differential. Thus both endpoint maps factor
  through the same S, and the intermediate maps are finite etale.
- Tensor descent gives the intrinsic common spin L_S and h_S. The
  actual coreless span implies H0(S,L_S) is nonzero. Completeness for
  M provides a matching section downstairs. The resulting rational
  isomorphism L_S to M pulls back to the fixed global isomorphism;
  injectivity on divisors under finite surjective pullback makes it
  global. Compatibility of squares is likewise detected by pullback.
  This correctly eliminates possible two-torsion killed upstairs.
- Base-point-freeness descends from the complete section space, and
  its ratio field is k(S), proving birationality of the complete
  spin series on S.

For the characteristic-five example only the effective spin at infinity
is needed: eta=du/v, and the coefficient of u^9 in F(u)^2 is
-2(t+1), nonzero when t^5-t is nonzero. Thus Cartier(eta) has a nonzero
u*eta component. No unrelated small-torsion or family exclusion claim
is certified by this audit.

The conclusion is a structural reduction for the specified spin-Cartier
profile. It neither excludes the resulting common span nor addresses
the other weights or the no-clump alternative. No revision requested.
