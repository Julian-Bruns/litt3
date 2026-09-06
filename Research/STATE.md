# Continue here — idle solver wait; read the post-enumeration roadmap

Last updated: 2026-09-06, 21:17 CEST. Litt3 is UNSOLVED.

## Latest instruction — do not lose this after compaction

The user asked for a precise explanation of what remains AFTER the29375
count, then to stop active work and resume automatically on solver exit.
The explanation is saved in AFTER_ENUMERATION.md and linked from README.
Read that roadmap before claiming enumeration completes the proof.
No new solver was adopted. Do not restart from the reported "degree8":
that is a stage, not a checkpoint of intermediate polynomials.

## One active heavy computation, unchanged

SolverPID9991; detached supervisorPID9989, started19:27:38CEST.
Executable /tmp/litt3-msolve-lowmem.bQGL6w/msolve-0.10.1/msolve
Arguments -t10 -l2 -m250 -v2 -g2
Input Research/computations/normalized_oper_msolve.in
Output Research/computations/normalized_oper_msolve.gb
Durable status Research/computations/normalized_oper_run.json
Durable log Research/computations/normalized_oper_solver.log

This is14 variables overF25, encoded15 overF5 with zeta²+4zeta+2.
Expected F25 length9645; F5 length19290. NOT Weil restriction.
Input SHA256 c378d97ee11e2f1e306402a47a90cca586316734df3475d0099d3eabe2253f2a.
Last observed stage: degree8, with growing sparse matrices and many pending
consistency checks. These pairs are NOT candidate roots or covers.
No reliable completion ETA or degree-only resumption is available.
The ten CPU cores are enabled; symbolic phases and some reductions are serial.

The earlier PID90081 disappeared with EMPTY output, cause unestablished.
The current supervisor blocks in wait() and records final returncode and
output bytes. Neither exit0 nor a nonempty output alone proves completeness.
The validated source patches and their exact limited test scope are in
Research/computations/msolve_lowmem/README.md. Keep the temporary build alive.

## Completion watcher and live display

One-shot watcherPID56616 is rearmed on THIS run and exact chat
01a06bb7-7c2a-7eb1-971c-2b890a7e0bf7. It waits in macOS kqueue, with
no model calls while waiting. On supervisor/solver exit it sends a macOS
notification and invokes codex exec resume once for this exact session.
State: Research/computations/normalized_oper_completion_watch.json.
Logs: normalized_oper_completion_watch.log, normalized_oper_resume.jsonl.
Final resumed reply: normalized_oper_resume_reply.md.
A failed resume generates another notification. Do not start another watcher
or a competing root writer while this one is armed.

Terminal runs scripts/watch_normalized_solver.py; closing it stops neither
solver nor watcher. The1.50% bar is VERIFIED multiplicity440/29375, not runtime.
German decimal-comma parsing was fixed and display verified live.
No active subagents or side calculations. Hourly model reminder cancelled
during the user-requested idle wait; rearm when mathematical work resumes.

## Exact wake-up action

1. Read actual run JSON/log/output and determine success or failure.
2. On success run:
     sage scripts/export_oper_basis.sage --normalized
   It checkpoints field conversion and exact Groebner basis, checks original
   equations and length9645. Then implement the still-missing radical/
   closed-point extraction, cubic reconstruction and local multiplicities.
3. On failure inspect saved evidence, preserve output, and do not start
   repeated blind retries or an unaudited replacement.
4. Read AFTER_ENUMERATION.md for the scientific next steps. The next
   existence test has56 residual equations on ALL quotient choices;
   it is NOT solved by enumeration or the existing16 rank samples.

## Enumeration already completed

Invariant A=C=0 has55 distinct geometric points, each full local length8,
Hilbert function(1,3,3,1), exact truncated lengths4,7,8,8. Full contribution440.
All55 tuples are exported in invariant_oper_solutions.json; its short README
gives conventions. Bulk local certificates are reference-only.
The c4=0 slice has length330, radical55, local slice length6 (NOT full8).
Remaining full length28935 = 3*9645. On c4!=0 set t=c4, Lambda=t³,
C=t*Chat,A=t²*Ahat. Lambda is a UNIT of the normalized algebra, proved
using rank5 C-block minors at all six closed invariant points.
The cubic is etale and retains local multiplicities. Other distinct-root
counts remain UNKNOWN; only55 total points contradicts these length proofs.

## Latest proved tools — statements first, proofs only as needed

- finite_algebra_completion_certificates: AUDITED exact known-length
  Groebner stopping, Frobenius reduced-subalgebra extraction and point
  completeness. Derived G subset I plus leading colengthD can stop all
  remaining S-pairs. No such current intermediate certificate is available.
  Three25-power iterations suffice after algebra construction; exact
  consecutive-rank stability may stop sooner. Retain A for multiplicities.
- dormant_first_integral_charts: explicit FIELD solution of r''=3r²
  via c=(r')²-2r³=D⁴r. A partial-fraction argument proves D⁴r!=0 for
  EVERY squarefree monic degree-ten trigonal potential chart, not merely
  the fixed F. Its fixed-X affine first-integral map is18x24, rank17,
  with exact nonzero minor and affine witness. New bounded coefficient
  data: gamma=(G0+G1*y+G2*y²)/F, degrees<=8,5,2.
  Field classification is NOT yet a smaller global scheme presentation.
  Script dormant_first_integral.sage passes125 rational identity examples.
- semilinear_hermitian_lift v2: AUDITED general differential retraction,
  including nontrivial tau³=O. Exactly one extension candidate for fixed
  V,pi,j;7(g-1) residual coordinates. No rank assumption.
- scalar_hermitian_reconstruction v3: fixed geometric oper, untwistedPSU,
  all ten identification parameters and40 extension variables eliminated.
  lambda*=-rho32(delta eta);
  rho48(kappa^5(T0+eta^5 U0)-eta-U0 lambda*^5)=0.
  Global quotient regularity still essential. Full theorem author proof;
  frames and elimination separately audited, not whole normalization.

A new Sage10.9 issue was isolated: a rational derivative can be represented
as0/den with incorrect truthiness/nonzero comparison. Use numerator-based
zero tests. Fresh audit found no concrete prior polynomial/Laurent certificate
affected. See scoped audit metadata, not its body, unless investigating.

## Unadopted optimization and cleanup

A12-coordinate exact triangular probe gave42 equations/maxdegree22/242362
terms, versus current14/maxdegree16/39368. No speed improvement demonstrated.
Do not silently switch to it. Short derivation is in
TRIANGULAR_COORDINATE_PROBE.md; trial source/expanded checkpoint were retired
recoverably to /Users/julian/.Trash/litt3-retired-solvers.2a0Fl7/.
All older full-system, inverse-variable and auxiliary solvers remain retired.
Do not assume any killed process's in-memory basis was checkpointed.

GPU review: AppleM5/10GPUcores/Metal4; current msolve is compiledC exact
sparseF4/OpenMP with no Metal backend. NVIDIA-CUDA alternatives are not
drop-in Apple replacements. No demonstrated speedup warranted restarting.

## Absolute proof boundary

Large cored cases are [H/PSU3(5)] and [H/PGU3(5)]; none is excluded for X.
Untwisted scalar computation does not handle all3^18 torsion lines.
Smaller cored atlas degrees<=2240 and the entire coreless branch remain.
Coreless common canonical ring may be k; a nonconstant generator is not
known to exist. Preserve BOTH actual etale maps from the SAME source;
never assume a simultaneous Galois refinement without a proved core.
