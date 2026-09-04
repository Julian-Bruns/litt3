# Task 05: prove double-fiber tail coverage and terminal emptiness

## Status

Open. The retained transcripts do not prove this theorem.

This task may be attacked as a conditional local-algebra problem at the
post-\(u25\) frontier, but it can imply the entry-zero exclusion only after
all of the following requirements are supplied:

1. Task 00B, a proof that the specialized tower covers every surviving
   entry-zero pair, or a replacement covering the full branch;
2. Task 00, the missing repeated-\(u20\) transition;
3. Task 00A, exact proofs of the transcript-only response identities in files
   `81`, `92`, `96`, and `104`;
4. Task 04, the basin-127 containment; and
5. derivations of the terminal equations recorded in files `148`, `150`,
   and `156`.

File `79` gives the tangent leading scalar \(a=-cd\ne0\). Under the full
local normal-form and variable-occurrence hypotheses displayed in file `85`,
the simple-layer response calculations in files `86`, `93`, `97`, and `101`
remain valid with coefficients multiplied by \(a^{-1}\). This does not prove
that the retained specialized tower applies to the original entry-zero
branch. The `101` calculation is also disconnected from the incoming tower
until Task 00 is complete.

## Geometric setup

Work over \(k=\overline{\mathbb F}_5\). For this conditional local target,
assume the specialized branch

\[
Q_0=P_0,\qquad x(Q_1)=x(Q_\infty)=2,\qquad Q_1\ne Q_\infty,
\]

with no other high-point coincidence. File
`routes/profile4/double_fiber/79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md` does
not prove this specialization: it proves only the compatible boundary/norm
constants and tangent leading form. Task 00B must justify this input, exclude
the complementary locus, or replace the specialized analysis. Moreover,
\(c=d=2\) alone does not imply \(\alpha^{31}=1\) or that the shared boundary
scalar \(K=f(0,0)\) equals \(-1\); any use of those constants in a
reconstructed local equation must be independently justified.

Assume for purposes of the local target that the formal tower has genuinely
reached the post-\(u25\) variables. The remaining frontier consists of the
repeated low-data equations, the non-pivot tail-exhausted simple-\(u30\)
equations, the simple-\(u30\) base residual, and the three repeated-\(e30\)
equations.

## Correct chart cover

The priority charts are the disjoint locally closed pieces

\[
\mathcal C_3=D(\Delta\rho_3),\qquad
\mathcal C_4=V(\rho_3)\cap D(\Delta\rho_4),
\]

with every later pivot used as a denominator also inverted. The fallback
chart is not all of \(D(\rho_4)\); its ideal must include \(\rho_3=0\).

On each chart, display:

- the ambient polynomial ring and variable order;
- every low-data, non-pivot, base, and repeated-\(e30\) generator after the
  relevant Schur solve;
- the saturation product, including \(\Delta\) and every active pivot; and
- explicit ideals for every claimed terminal stratum.

If \(F_3,F_4\) are the full generator lists and \(g_3,g_4\) the saturation
products, the chart ideals have the form

\[
I_3=(F_3):g_3^\infty,\qquad
I_4=(F_4+\langle\rho_3\rangle):g_4^\infty.
\]

File `181` isolates the missing repeated-\(e30\) extraction needed to make
these ideals explicit.

## Exact theorem

For each chart \(c\in\{3,4\}\), find explicit terminal-stratum ideals
\(K_{c,1},\ldots,K_{c,m_c}\) and prove

\[
V(I_c)\subseteq\bigcup_jV(K_{c,j}).
\]

Equivalently, over the algebraically closed field \(k\), prove the correctly
directed containment

\[
\bigcap_jK_{c,j}\subseteq\sqrt{I_c}.
\]

Then derive the actual later-layer ideals \(L_{c,j}\), containing every
required \(e35,e40,e45,e50\) equation, and prove

\[
(I_c+K_{c,j}+L_{c,j}):g_c^\infty=(1)
\]

for every stratum. This second step must verify the extraction of the
terminal equations; checking only the one-variable polynomials printed in an
old transcript is not enough.

If either coverage or terminal emptiness is false, an explicit geometric
point satisfying the fully reconstructed localized equations is a valid
resolution of the task: record it as a counterexample to the proposed route
rather than discarding it as a failed certificate.

The basin-127 stratum may use Task 04 as an explicit hypothesis. File `159`
proves that the displayed quotient \(J\) is reduced of length \(5\) and that
its base residual leaves one six-coordinate point. It does not prove H127,
does not supply the missing affine parameterization identifying that point
with the 19-coordinate \(P129\) of the terminal transcript, and does not
prove the later \(e50\) extraction.

## What does not suffice

- Enumerating \(\mathbb F_5\)-points does not cover \(k\)-points.
- Killing sampled tangent points does not cover a chart or component.
- Coefficient-only emptiness is weaker than the full base and repeated-\(e30\)
  frontier.
- Clearing a pivot denominator without saturating introduces spurious points.
- Proving H127 closes only the basin component, not the full coverage theorem.
- Later layers do not repair the missing repeated-\(u20\) transition.

The detailed ideal-theoretic target and the exact containment directions are
recorded in
`routes/profile4/double_fiber/open_targets/180_G4_DOUBLE_FIBER_TAIL_COVERAGE_TARGET.md`.
