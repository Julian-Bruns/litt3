# Audit: normed hyperelliptic branch pencil

**Verdict:** **PASS WITH ONE MINOR CORRECTION.**  The correction is
non-structural and affects no displayed identity or theorem.

**Auditor and date:** `/root/norm_polarization_refinement`, 2026-09-04.

**Objection:** Immediately after (44.27), the phrase “Its divisor is the norm
of (44.12)” is off by a factor of two if “it” denotes the displayed product.
Equation (44.12) is \(\operatorname{div}(z)\), whereas the divisor in (44.27)
is

\[
  2p_*a^*\operatorname{div}(z)
    =2\left(\sum_{\alpha^{31}=1}D_\alpha-31D_\infty\right).
\]

Equivalently, it is the pushforward of \(\operatorname{div}(z^2)\).  The
displayed equation (44.27) itself is correct, so the theorem file is left
unchanged except for its audit metadata.

**Non-breaking suggestions:**

- In Proposition 44.3, one may explicitly say that the projection center is
  disjoint from the Veronese curve because \(P(\alpha)\) is never the zero
  section.  This gives \(\nu^*\mathcal O(1)=\mathcal O(7)\), although the
  image can have lower degree.
- The base-point-free proof could spell out cancellation of the prescribed
  pole by the local trivialization of \(\mathcal O(2D_\infty)\).
- The orbit proof could cite Corollary 38.4 directly; its existing
  seventh-iterate sign argument is nevertheless valid.

The audit checked Propositions 44.1--44.3 line by line, including all norm,
canonical, and torsion exponents; the two-torsion interpretation; orbit and
minimal-polynomial arguments; coefficient pole bounds; base-point freeness;
and the projected-Veronese statement.

**Audited revision:** SHA-256
`25f0ad73f218f7f66f12d6092697a99c7994586de133358f46609c6114efa0f2`.
The later audit-metadata change does not alter the mathematics.
