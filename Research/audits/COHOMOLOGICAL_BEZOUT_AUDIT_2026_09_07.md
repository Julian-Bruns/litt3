# Cohomological Bezout audit

Verdict: PASS, bounded independent prose audit.
Auditor: `/root/cohomological_bezout_major_audit`.
Date: 2026-09-07.
Target: [cohomological Bezout theorem](../../Theorems/Thm_cohomological_bezout.md)
and its definition and proof, read in full.

No blocking mathematical objection found. This is a prose audit, not
formal verification or a rerun of the large enumeration.

- The fixed Cech splittings produce the stated polynomial blocks. On
  ker a(u), the expression to which P_M is applied is already closed,
  so an arbitrary fixed projection causes no loss of the kernel. Reduction
  of the T component leaves no boundaries because H0(T)=0.
- For every nonzero section, including repeated zeros, the two sheaf
  homology modules are torsion of length deg D. Their lack of higher
  cohomology proves the exact corank statement; no spectral-sequence
  degeneration or generic-rank assumption is hidden here.
- Length-two surjectivity excludes both two distinct zeros and double
  zeros generically on the incidence divisor. At a unique simple zero,
  the derivative in the curve direction is nonzero, so the incidence
  projection is generically separable and of degree one, also in positive
  characteristic. The pencil Chern-class calculation gives degree 2n.
  The mixed-block degree count then proves the determinant is reduced,
  rather than merely having the correct support.
- In the acyclic case the primitive is unique, hence B is canonical.
  The specified Cech convention gives K(eta_u)B(u)=I with the stated sign.
  Serre duality gives the symmetric multiplication pairing without
  dividing by two. Adjugate reconstruction and its absence of a common
  divisor follow from generic corank one on the unique resultant divisor.
- The genus-nine hypotheses give n=24 and obstruction slope -6 for
  length-two separation. The horizontal-tensor proof identifies h0(V)
  with the tangent dimension by linearizing the scheme-theoretic dormant
  equation. Thus the reduced simple points give r=0. The r=3 conclusion
  at the invariant points uses the explicit tangent-rank computation in
  [fixed_x_dormant_equations](../../Theorems/Thm_fixed_x_dormant_equations.md),
  whose proof and rank-producing script were inspected; the saved six
  residue-field certificates retain 21 pivot columns and three free
  columns. Local length eight alone would not imply tangent dimension
  three. Those existing exact computations were not rerun in this audit.

Minor exposition recommendation: explicitly cite the fixed dormant-equation
tangent-rank result next to the invariant r=3 assertion; enumeration
multiplicity alone is insufficient. No statement change is required.
The theorem supplies matrices for all strata and no common-cover or
atlas-emptiness conclusion. Both actual etale legs remain outside, and
unaffected by, this bounded lemma.
