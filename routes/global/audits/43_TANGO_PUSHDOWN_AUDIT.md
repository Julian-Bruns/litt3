# Composite audit of file 43: Tango-line pushdown

- **Verdict:** COMPOSITE PASS on the current claims.
- **Coordinator/author:** `/root/tango_line_c7_descent`.
- **Independent checking tasks:**
  `/root/tango_line_c7_descent/explicit_bx_segre` and
  `/root/tango_line_c7_descent/rank4_cartier_escape`.
- **Audited revision:** SHA-256
  `090718f648a0628a07428a5d1386e5be185bb8679d4f659fa2d9c32a4334d97a`.
- **Date:** 2026-09-04.

This was a split audit rather than one end-to-end reread: the two helpers
independently attacked the two principal escape branches and checked the
shared numerical backbone.

## Checks performed

The explicit-(B_X) task checked the pushdown splitting on the hyperelliptic
base, the possible ranks and degrees, the local residual-divisor criterion,
and the displayed function

\[
 u=((t+3)v+3t+2)/t^2.
\]

It recomputed \(\operatorname{div}(du)\) and confirmed that an actual
rank-three degree-four survivor has surjective first Frobenius projection.

The rank-four task checked the generic trace-coordinate formula, the
nondegenerate cyclic Kummer/Vandermonde model, the Cartier Pfaffian, and the
determinant calculation.  It also checked the four exact power lines on
(Y), their degrees and residual divisors, the determinant defect
(36P_1), and the global pull-push surjection onto (B_X^1).

## Correction caught during the audit

An exploratory claim that the degree-(5M) lines were absolutely maximal
Tango lines on (V) was false: the universal upper bound is

\[
 \left\lfloor\frac{28M}{5}\right\rfloor
   =5M+\left\lfloor\frac{3M}{5}\right\rfloor.
\]

The current file does not make the false claim and explicitly records that
the lines lie below the absolute bound.  The helpers found no remaining
substantive issue.  Their countermodels justify the file's negative
conclusion only at the stated formal level; they do not model both global
31-divisor identities, a limitation which file 43 states explicitly.
