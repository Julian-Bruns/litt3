# Focused audit: two-leg defect orbit bound

Verdict: PASS. Auditor: /root/audit_two_leg_defect_orbit.
Date: 2026-09-10. Scope: Version 1 of
[the statement](../../Theorems/Thm_two_leg_defect_orbit_bound.md) and
[its proof](../../Solutions/Sol_two_leg_defect_orbit_bound.md), Sections 1–5.
No blocking mathematical objections. This is a prose audit, not Lean
verification. The established two-defect deck reduction and effective
bounded-atlas counting ingredients were inputs, not freshly re-audited.

Checks:

- A constant nonzero ratio supplies a global quadratic q proportional
  to the given tangent with q²=s. The cited exact factorization gives
  B(q)=0 and dDelta(q)=-q^5, a contradiction. The pole bound is valid
  for total function-field degree, including inseparability.
- The tangent-bundle construction retains the full root torsor and
  its natural etale pullback. Consequently its section representation
  is the actual deck representation on regular tangent quadratics.
  The audited explicit matrices J and diagonal sign subgroups show
  that C10 and C2×D10 contain scalar -I; squaring kills this scalar.
  The three orbit bounds are therefore 5, 10, and 10 respectively.
- With the original embedded fields A,B inside k(Z), separability of
  k(Z)/B gives [B(a):B]=b. The compositum bound
  [AB:B(a)]≤[A:k(a)] needs neither linear disjointness nor separability
  of A/k(a). Both induced maps from the joint normalization are etale
  by the intermediate-cover property. Hurwitz supplies the other
  degree bound. No normality of AB/B or bound on [k(Z):AB] is used.
- Closing only R→Y gives an actual etale V→X and
  deg(V/X)≤n!/8≤D, |Gal(V/Y)|≤n!≤D, and g(V)≤G0.
  The inherited cover and automorphism counts bound the quotient
  curves by D(D!)^18 3^(4G0²L), below the unchanged K0. The subgroup
  generator bound and the prime-degree Frobenius-orbit argument apply
  without a cored hypothesis. No simultaneous Galois closure is
  introduced.
- In the prime-to-five branch, self-duality restricts every scalar to
  ±I, so the ratio action factors through the actual projective image.
  The arithmetic 64·5249=335936≤335999 proves the stated threshold
  5250. [Faber, Theorem C](https://arxiv.org/pdf/1112.1999), checked
  directly, supplies the prime-to-characteristic PGL2 classification;
  A5 is absent in characteristic five and A4,S4 fall below the bound.

The exclusion is precisely the stated nonordinary-X, source-defect-two,
nontrivial-five-action stratum of the selected pair. Ordinary X and
unbounded cyclic/dihedral projective images remain outside that
exclusion. No common-cover solution or cyclic-five Witt descent follows.
