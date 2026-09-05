# Audit: exact 31-adic endomorphism order

**Verdict:** **PASS.**  No breaking mathematical objection found.

**Auditor and date:** `/root/audit_exact_31adic_order`, 2026-09-04.

## Checks performed

- File 40 proves that $F^3=\pi\in E=Z(\mathscr D)$.  The action of
  $\operatorname{Gal}(\overline{\mathbf F}_5/\mathbf F_{125})$
  on geometric rational endomorphisms is therefore trivial by conjugation.
  Since the integral endomorphism ring embeds in its rationalization, this
  also justifies replacing geometric endomorphisms by
  \(\mathbf F_{125}\)-endomorphisms in the integral Tate-theorem step.
- At 31, both $K/\mathbf Q$ and $E/\mathbf Q$ are totally ramified,
  with $[K_{31}:E_{31}]=3$.  File 40's rank-one rational
  $K$-Tate-module action, together with the rank count $30=[K_{31}:\mathbf
  Q_{31}]$, makes $T_{31}J$ a torsion-free rank-one module over the DVR
  \(\mathcal O_{K,31}\), hence a fractional ideal (and free of rank three
  over \(\mathcal O_{E,31}\)).
- The Honda--Tate invariants of the division algebra vanish at every finite
  place not over the characteristic 5.  Thus its completion at 31 is split;
  its action on the three-dimensional $E_{31}$-space $V_{31}J$ gives
  \(\mathscr D\otimes_EE_{31}\simeq\operatorname{End}_{E_{31}}(K_{31})\).
- Integral Tate identifies the completed endomorphism ring with the
  centralizer of $F^3$ on $T_{31}J$.  Its rational centralizer is
  \(\operatorname{End}_{E_{31}}(V)\).  Intersecting with the lattice is
  exactly \(\operatorname{End}_{\mathcal O_{E,31}}(T)\): an
  $E_{31}$-linear map preserving $T$ automatically commutes with
  $\mathcal O_{E,31}$, which already preserves $T$.  No unproved
  coefficientwise crossed-order assertion is used.
- The extension $K_{31}/E_{31}$ is tame totally ramified cyclic of degree
  three.  Hence \(\sigma(a)-a\in(1-\zeta_{31})\mathcal O_{K,31}\), so
  the divided difference
  \(\partial=(1-\zeta_{31})^{-1}(\sigma-1)\) is integral and
  \(\mathcal O_{E,31}\)-linear.  Its two nonzero coefficients in the
  direct crossed-product decomposition have valuation \(-1\), proving it
  is outside the coefficientwise crossed lattice.  The semilinear form
  $F=c\sigma$ has $c$ a unit because Frobenius is invertible on the
  31-adic Tate lattice.

**Non-breaking presentation suggestion:** In the first paragraph of the
proof of Theorem 54.1, cite file 40 explicitly when asserting that the
$\mathcal O_{K,31}$-module $T$ is torsion-free/rank one.  This follows
from the already established rational rank-one $K$-action and is not a
gap.

**Audited revision before audit-metadata insertion (SHA-256):**
`d4098b1a52d07a0f8264adbce73c66d0da49eda8219a6c0f30195e8a9ae6e8e9`.
