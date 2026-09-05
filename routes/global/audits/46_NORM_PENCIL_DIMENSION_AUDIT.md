# Audit: norm-polynomial system cannot be a pencil

**Verdict:** **PASS.**  No breaking objection.

**Auditor and date:** `/root/norm_pencil_dimension_audit`, 2026-09-04.

**Non-breaking suggestions:**

- Say explicitly that normalization of the possibly singular raw fiber
  product is harmless because the specialized norm form counts the seven
  etale sheets with multiplicity.
- The degree of the final lift can alternatively be written directly as
  \([k(Y):k(Y_{\mathcal B})]=14/2=7\).
- Note explicitly that the local case \(r_b=7\) forces \(7\mid M\).
- For possible reuse: when \(|\mathcal B|=8\), Riemann--Hurwitz for \(R\)
  shows that no \(r_b=7\) fiber occurs and all twelve units of its different
  are exhausted over \(\mathcal B\).  When \(|\mathcal B|=6\), at most one
  \(r_b=7\) fiber can occur.

The audit checked the integral spectral divisor, exact degrees of \(f\) and
\(R\), strict-henselian multiplicities even at collisions and infinity, the
common ramification index and the \(r_b=7\) case, Riemann--Hurwitz with the
different, the parity pullback, the characteristic-five double-cover lift,
and the absolute-simplicity contradiction.

**Audited revision:** SHA-256
`614d8e7f7998008a7969b884e2f954ed395528622540a1cd034de8ede730e8da`.
The later audit-metadata change does not alter the mathematics.
