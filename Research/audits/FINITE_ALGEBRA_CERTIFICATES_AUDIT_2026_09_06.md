# Finite-algebra certificate audit — reference only

- Verdict: PASS, with the precision corrections below incorporated.
- Auditor: /root/finite_algebra_certificate_audit, GPT-6 Astra medium.
- Date: 2026-09-06.
- Scope: known-length leading-monomial/border stopping; exact Frobenius
  stable image and nilradical; weighted point completeness; local Nakayama.
- Not audited here: the external fixed-X length theorem, current solver
  implementation, or a claim that its current basis meets the criterion.

Non-breaking suggestions and corrections: dimension-based Frobenius
iteration counts are sufficient, not necessary; with the F25 structure the
F5 encoding needs at most six fifth-power iterations, not the coarser seven.
Preserve original algebra for multiplicities. Do not assume a finite-field
product is monogenic. Derived membership has the opposite direction from
reducing input generators to zero. All these qualifications are now explicit.

Audit bodies are not routine research context; open only for concrete doubt.
