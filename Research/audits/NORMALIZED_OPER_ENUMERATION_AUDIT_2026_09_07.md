# Normalized oper algebra certificate audit

- Verdict: PASS for the exact normalized algebra isomorphism, reducedness,
  and consequent geometric counts; original common-cover problem UNSOLVED.
- Auditor: `/root/normalized_enumeration_certificate_audit`, fresh bounded agent.
- Date: 2026-09-07.
- Scope: [cubic quotient theorem](../../Theorems/Thm_fixed_x_oper_cubic_quotient.md),
  its proof, normalized generator, cyclic certificate script, actual candidate
  and certificate data, and [moment argument](../OPER_MOMENT_RECONSTRUCTION.md).
- Independent computation: [direct original-input checker](../../tests/check_oper_original_input.sage)
  verified all43 polynomials of the retained msolve input, including the
  coefficient-field quadratic, by exact modular sparse Horner evaluation.
  No candidate basis, matrix, moment claim, or hand-rewritten differential
  identity is used in that check. It also verified degree19290, separator
  a9=z, and gcd(P,P')=1, in13.84seconds. Exact source hashes are saved in
  [machine evidence](../computations/normalized_oper_original_input_audit.json).
  The main certificate has exactly the same P and coordinate polynomials.
- Mathematical check: monic division reconstructs B and lambda over arbitrary
  parameter algebras; the lambda-unit argument excludes its vanishing
  scheme-theoretically. Reversing the three displayed identities gives the
  full c4-invertible oper scheme. Global completeness at branch points and
  infinity comes from the complete affine projective-connection chart in
  the dormant-equations theorem, not from denominator clearing. The known
  normalized F25 length9645 is an inherited independent theorem dependency,
  not inferred from this candidate basis. Substitution and a9=z give a
  surjection onto F5[z]/P of dimension19290; equal dimensions give an
  isomorphism. No squarefree replacement occurs before certification.
- Counts: reduced normalized algebra has9645 geometric F25 points;
  the cubic etale cover gives28935 simple geometric opers. Adding the55
  known points of full local length8 gives28990 distinct geometric opers
  and total length29375. The earlier55 local certificates and literature
  length are retained dependencies, not independently recomputed here.
- Objections: no blocking mathematical objection. Export must preserve the
  specified F25 structure: a degree2d irreducible F5 factor, with zeta mapped
  to its recorded coordinate, defines one F25 closed point of degree d.
  All roots over an algebraic closure without imposing the fixed zeta
  embedding would double-count. Reconstruction must retain all three cube
  roots of the nonzero lambda. These counts enumerate rank-two candidates
  and establish no atlas or common-cover exclusion.
