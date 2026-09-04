# Dependency ledger for the partial-progress note

Date: 2026-06-05.

This ledger records exactly what the package proves, what is conditional, and
what remains open.  It is deliberately conservative.

## A. Global common-cover route

| Label | Statement | Status | Evidence |
| --- | --- | --- | --- |
| GLOB-1 | \(Y:y^{31}=x(x-1)\) has genus 15 and \(Y\to S=\mathbb P^1(31,31,31)\) is finite etale as a stack atlas. | proved in archive | `14_PROOF_LIFT_THROUGH_Y.md` |
| GLOB-2 | \(\deg K_{\mathbb P^1(2,3,62)}=14/93\), so no genus-three curve maps finite etale to \(S_0\). | proved in archive | `10_PROOF_SELF_CORRESPONDENCE.md` |
| GLOB-3 | If \(\operatorname{Comm}_{alg}(S)=S_3\), then \(Y\) has no common finite etale cover with any genus-three curve. | conditional theorem | `10_PROOF_SELF_CORRESPONDENCE.md` and `partial_progress_note.tex` |
| GLOB-4 | \(\operatorname{Comm}_{alg}(\mathbb P^1_{\bar F_5}(31,31,31))=S_3\). | open | global finite-envelope/self-correspondence bottleneck |

The common-cover counterexample is complete only after GLOB-4, or after a
different direct bridge replaces it.

## B. Displayed degree-35 curve problem

| Label | Statement | Status | Evidence |
| --- | --- | --- | --- |
| D35-1 | High-point quotient: if \(Q_j=P_i\), then \(\deg(\Omega_j(r)/\Omega_i(x))\le 6-M_{ij}\). | proved in archive | `162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md` |
| D35-2 | The coincidences \(Q_\infty=P_0\), \(Q_1=P_1\), and \(Q_0=P_\infty\) are impossible. | proved in archive | `162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md` |
| D35-3 | The remaining high-point cases are entry-0, entry-1, and no-highpoint. | reduction | `167_SHORTEST_REDUCTION_AUDIT_GATES.md` |
| D35-4 | The entry-0 edge \(Q_\infty=P_\infty\) is equivalent to \(Q_0=P_0\) by simultaneous inversion \(x\mapsto 1/x,\ r\mapsto 1/r\). | proved in note | `partial_progress_note.tex` |
| D35-5 | Entry-1 case is impossible. | open | current notes give compatible trace/ODE checks only |
| D35-6 | No-highpoint case is impossible. | open | residual `(4,4)` target isolated in `170_NO_HIGHPOINT_RESIDUAL_GATE.md` |
| D35-7 | In the no-other-highpoint \(Q_0=P_0\) representative, the norm constants and corrected \(x=0\) tangent cone force \(c=d=2\). | proved in note | `partial_progress_note.tex` |
| D35-8 | The paired entry-0 edge \(Q_0=P_0,\ Q_\infty=P_\infty\) is impossible by a bidegree \((5,5)\) genus drop. | proved in note | `partial_progress_note.tex` |
| D35-9 | Modulo the entry-1 theorem D35-5, every \(Q_0=P_0\) entry-0 case reduces to the no-other-highpoint representative, hence to D35-7. | proved in note | `partial_progress_note.tex` |

Thus the displayed degree-35 problem is not solved by the current package.

## C. Corrected entry-0 double-fiber branch

| Label | Statement | Status | Evidence |
| --- | --- | --- | --- |
| DF-1 | Repeated/simple tower reaches the simple-\(u30\) frontier on rho3/rho4 charts. | proved in archive, chart-local | `81`, `83`, `86`, `92`, `93`, `96`, `97`, `100`, `101`, `104` notes |
| DF-2 | \(P129\) is killed by symbolic \(e35,e40,e45,e50\) layers. | proved in archive | `145_SYMBOLIC_FINAL_LINE_SIMPLE_E50_CERTIFICATE.md`, `148_SYMBOLIC_P129_LAYER_CERTIFICATE.md` |
| DF-3 | The three \(P129\) tangent companions and the unique rho4 base-zero hit are killed through \(e50\). | proved in archive | `150_TANGENT_CANDIDATE_FIELD_AND_E50_AUDIT.md`, `156_RHO4_ALLZERO_POINT_AND_E50_KILL.md`, `160_E50_FINAL_LINE_SINGULAR_CHECKS.md` |
| DF-4 | Basin-127 displayed quotient \(J\) is radical length 5, disjoint from \(\Delta=0\), and base residual cuts it to \(P129\). | proved for displayed quotient | `159_BASIN127_CAS_SETUP_AND_DISPLAYED_BASIS_CHECK.md` |
| H127 | The original basin-127 low-data ideal saturated by \(\Delta\) times the rho3 pivot equals the displayed quotient \(J\). | open, currently computational | Sage/Singular certificate script and cache |
| G4 | The killed \(P129\), rho4, and basin-127 neighborhoods cover the whole tail-exhausted simple-\(u30\) base-zero/e30 locus. | open | exact ideal target in `180` and `181` |

If H127 and G4 are proved, then the corrected \(Q_0=P_0,\ c=d=2\)
double-fiber branch is eliminated.

## D. Current strongest conditional theorem

The archive currently proves the following conditional statement.

```text
H127 + G4 + D35-5 + D35-6
  => displayed genus-11 degree-35 divisor problem has no solution.
```

The common-cover counterexample still requires either:

```text
GLOB-4,
```

or a new theorem directly connecting displayed degree-35 nonexistence to the
full common-cover problem.

## E. Sage handoff status

At the time this package was made, the basin cache still reported:

```text
last_index = 6
max_index = 9
```

The reduced `--max-tail-degree 2` run should only be started after
`last_index >= 7`, as described in `STANDALONE_SAGE_COMMANDS.md`.
