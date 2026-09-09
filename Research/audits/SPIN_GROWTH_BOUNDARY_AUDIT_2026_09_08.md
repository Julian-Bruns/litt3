# Spin growth and ordinary boundary audit

Verdict: PASS (independent bounded prose audit; no Lean verification).
Auditor: /root/audit_spin_growth_boundary.
Date: 2026-09-08.
Scope: Version1 of alternating_spin_growth and ordinary_dihedral_spin_growth,
including both corresponding solution files. Consulted the canonical
spin_cartier_root_normal_form and spin_primitive_matching_defect records and
dependencies; checked the latter proof only for the needed initial-section
implication. No broader dependency audit or common-cover exclusion is claimed.

Objections: None requiring a mathematical correction.

- Alternating growth: the union is Galois over each embedded endpoint by
  cofinal normal stages. Each finite stage still has both actual etale maps.
  The rational product spaces are stable under the appropriate Galois group;
  equality of successive section spaces supplies stability under both.
  Their two finite matrix images generate a finite group specifically over
  bar(F_p), so the invariant-field argument is valid. Reducedness prevents
  a nonzero section's m-th power divided by h from being constant. The
  primitive exact sequence supplies r_0>=1 without assuming endpoint
  primitives exist in the general effective-spin case. Strictness starts
  at n=1, exactly as stated.
- Global generation at stage2: the fixed divisor on an etale Galois cover
  descends as an integral effective divisor. A nonzero descended divisor
  would consume at least the entire degree of the pulled-back degree-one
  line and leave at most one section. Since r_2>=2, it cannot occur.
- Boundary tower: the disjoint branch sets give a connected biquadratic
  T_0 and a free diagonal involution, including at infinity. Verschiebung
  is etale with cyclic geometric kernel for this ordinary elliptic curve;
  its odd-degree extension is disjoint from the quadratic extension.
  Negation lifts with r sent to -r, fixes y, and conjugates translations
  by inversion. Counting automorphisms proves normality over the single
  prescribed endpoint. Relative Frobenius twists cause no semilinear
  identification problem; E and the chosen origin are already over F_5.
- Ordinarity and exact count: the elliptic Hasse coefficient is 3 and the
  genus-two determinant is 3(t+1)^4, nonzero under t^5-t!=0. The three
  tame character summands of T_0 are Cartier-stable, and the etale
  p-group Deuring--Shafarevich formula propagates ordinarity. The divisor
  identity f_0^*W_i=q_0^*P_i has multiplicity one at both points.
  O_Y(2W_i)=omega_Y, and the double-cover pushforward splits into degrees
  0 and -2N. Projection formula therefore gives N+0 sections exactly,
  with N=5^n. The elliptic degree-N line is generated for n>=1.

Limits: These statements give necessary two-leg growth and a one-leg
boundary family. They provide neither a second endpoint for the boundary
tower nor an exclusion of any unknown common cover. The infinite union
of section spaces is not a finite-dimensional representation. No heavy
computation was performed.
