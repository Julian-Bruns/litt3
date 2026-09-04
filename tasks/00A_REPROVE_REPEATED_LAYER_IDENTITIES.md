# Prerequisite: reprove the transcript-only repeated-layer identities

## Status

Open evidence prerequisite. The determinant arguments in files `83`, `92`,
`96`, and `104` are correct conditional linear algebra, but their decisive
response identities were produced by missing programs. Finite
\(\mathbb F_5\)-scans do not prove identities over
\(k=\overline{\mathbb F}_5\).

This task is independent of the completely missing repeated-\(u20\) note 100
except at the point where file `104` is attached to the full tower. Both
Task 00 and this task are required. Task 00B is a further independent
geometric prerequisite: these identities cannot establish that the
specialized tower covers every entry-zero pair.

## Exact objective

Turn the following computational premises into proved mathematics:

1. In file `81`, derive the closed raw-response formula and prove
   \[
   \operatorname{coeff}_{s^2}(I/p)=4,\qquad M/p-L/p=s.
   \]
2. In file `92`, prove the Schur-corrected repeated-\(u10\) response and the
   scalar identities
   \[
   \operatorname{coeff}_{s^2}(L/p)=0,\qquad
   \operatorname{coeff}_{s^2}(F)=2,\qquad G=L/p+3s.
   \]
3. In file `96`, prove the repeated-\(u15\) response formula and
   \[
   \operatorname{coeff}_{s^2}(u15_3/p)=4.
   \]
4. In file `104`, prove the repeated-\(u25\) Schur-corrected response and
   \[
   \operatorname{coeff}_{s^2}(u5_3/p)=4.
   \]

A single general recurrence theorem covering several layers is preferred if
the displayed hypotheses genuinely support it. Otherwise give direct proofs
or exact executable certificates with all local equations, variable orders,
denominators, and saturation opens included.

If a recorded identity is false after the local equations are reconstructed,
give an exact countercalculation and mark the affected determinant step as
failed; do not alter the input model merely to reproduce the transcript.

## Required safeguards

- Use the étale cubic algebra and determinant normalization in file `80`.
  A common column \(p\in A^\times\) contributes
  \(N_{A/k}(p)\), not \(p^3\) viewed as a scalar in \(k\).
- Separate a polynomial identity from its use on
  \(D(\Delta\rho_3)\) and
  \(V(\rho_3)\cap D(\Delta\rho_4)\).
- Prove uniform identities in the old parameters. Sampling only
  prime-field points is a regression test, not a proof.
- State exactly which local normal-form equations are assumed. If an
  equation needed to derive the response is missing, isolate it as an input
  rather than reconstructing it by analogy.
- File `104` cannot be used downstream until Task 00 independently supplies
  the repeated-\(u20\) transition.

## Minimal reading

Read the layer-certificate README, then files `80` and `81`. Load `83`,
`92`, `96`, and `104` only for the identity being proved; the simple-layer
files are not needed except to verify a stated Schur correction.
