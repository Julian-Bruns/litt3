# Double-fiber route

This directory studies the proposed double-fiber specialization

\[
Q_0=P_0,\qquad x(Q_1)=x(Q_\infty)=2,\qquad Q_1\ne Q_\infty,
\]

with no other high-point coincidence. File 79 shows that the retained norm
and tangent data do not prove this specialization from the general
entry-zero branch. Everything after file 79 is therefore conditional on an
additional entry-zero-to-double-fiber theorem; see
[Task 00B](../../../tasks/00B_ENTRY_ZERO_SPECIALIZATION_OR_COVERAGE.md).

## Reading paths

| Purpose | Read |
| --- | --- |
| Audit the missing reduction to the double fiber | [entry-zero norm audit](79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md) |
| Audit the formal tower | [layer-certificate guide](layer_certificates/README.md), then only the listed layer files |
| Check recorded terminal candidates | [terminal-strata guide](terminal_strata/README.md) |
| Work on H127 | [basin-127 guide](basin127/README.md) |
| Work on full tail coverage | [open-target guide](open_targets/README.md) |

## Current mathematical status

- File 79 proves the compatible norm constants and tangent leading form,
  but it does not prove \(c=d=2\). The earlier norm comparison was circular:
  the constants it set equal to \(1\) are \(-\pi\) and \(\mathcal N\).
  Task 00B isolates this new upstream gate.
- For a general nonzero tangent scalar \(a=-\pi\), the simple layers
  \(u^{10},u^{15},u^{20},u^{25}\) are instances of one proved local
  leading-response lemma. The old numerical coefficients \(3,2,3,2\)
  require the additional specialization \(\pi=-1\).
- Even \(c=d=2\) does not imply \(\alpha^{31}=1\) or \(K=-1\); it gives
  only \(K=-\alpha^{31}\). Because the source normal form is absent, this
  checkout does not establish that every later transcript is independent of
  those two quantities. A reconstruction must keep them or justify any
  further normalization.
- The repeated-layer determinant reductions are correct *conditional on*
  several scalar response identities, but those identities are retained
  only as certificate transcripts from missing programs; see
  [Task 00A](../../../tasks/00A_REPROVE_REPEATED_LAYER_IDENTITIES.md).
- There is a material break after simple \(u^{20}\): repeated \(u^{20}\)
  (note 100) is absent. Files 101 and 104 do not bridge it; see
  [Task 00](../../../tasks/00_RECOVER_REPEATED_U20.md).
- File 159 now proves directly that the displayed basin ideal \(J\) is a
  reduced five-point quotient and that its base residual selects one
  six-parameter point. It also proves \(V(J)\) is discriminant-open
  conditional on the recorded discriminant formula. The omitted
  parameter map to the 19-coordinate point called \(P129\) is still
  transcript-only. H127—the containment of the original localized
  low-data locus in \(V(J)\)—also remains open.
- All terminal-stratum derivations are certificate transcripts. Their
  displayed final one-variable systems can be checked by hand, but the
  connection to the actual local equations is not reproducible here.
- The full chart-wise tail coverage theorem remains open, and its explicit
  polynomial generators are missing.

Even if every layer, basin, and terminal gap below were repaired, this route
would exclude only the displayed double-fiber specialization until the new
entry-zero specialization gate is proved.

## Chart convention

The later determinant arguments use the priority cover

\[
D(\Delta\rho_3)
\quad\sqcup\quad
\bigl(V(\rho_3)\cap D(\Delta\rho_4)\bigr).
\]

The second piece is not an unrestricted rho4 open: it includes
\(\rho_3=0\). This equation must be included in any fallback-chart ideal.

Work throughout over \(k=\overline{\mathbb F}_5\). Prime-field searches are
diagnostics only; unrestricted variables do not satisfy \(a^5=a\).
