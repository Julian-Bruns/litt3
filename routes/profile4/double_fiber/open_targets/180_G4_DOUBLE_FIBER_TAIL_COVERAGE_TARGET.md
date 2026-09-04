# Double-fiber tail-coverage target

## Status and prerequisites

**open**.  This is a conditional local target, not a theorem established in
the repository.

Before it can imply the entry-zero exclusion, the following independent
gaps must also be closed:

1. prove that the general entry-zero branch actually has \(c=d=2\), and
   audit or supply any further \(\alpha^{31}\) or \(K\) normalization used
   by the formal tower;
2. recover or reprove the missing repeated-\(u^{20}\) layer (note 100);
3. independently prove the transcript-only repeated-layer response
   identities; and
4. prove H127 and recover the coordinate map needed to attach its surviving
   six-parameter point to the terminal data.

[File 79](../79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md) proves only corrected
norm constants and tangent-cone compatibility. Its former reduction to
\(c=d=2\) was circular and has been removed.

## Geometric target

Work over \(k=\overline{\mathbb F}_5\). Conditional on the double-fiber
specialization \(c=d=2\), consider points that satisfy all of the following:

- the repeated low-data equations;
- all non-pivot, tail-exhausted simple-\(u30\) equations;
- the simple-\(u30\) base residual;
- the three repeated-\(e30\) equations, with the remaining post-\(u25\)
  variables retained; and
- the discriminant and applicable pivot nonvanishing conditions.

Prove that every such \(k\)-point lies in one of finitely many explicitly
defined terminal strata, and prove that the appropriate
\(e35,e40,e45,e50\) equations have no common point on each stratum.

Coefficient-only emptiness is not the target: the transcripts in files 150
and 156 record prime-field counterexamples to that weaker statement.

## Correct chart decomposition

The two minors \(\rho_3,\rho_4\) are intended to cover the clean repeated
branch.  Later formulas use a priority charting convention, so the disjoint
locally closed pieces are

\[
\mathcal C_3=D(\Delta\rho_3),\qquad
\mathcal C_4=V(\rho_3)\cap D(\Delta\rho_4),
\tag{180.1}
\]

with any additional nonzero layer pivots included in the two products.
Treating the fallback as all of \(D(\rho_4)\) without either imposing
\(\rho_3=0\) or separately handling the overlap does not match the
determinant proofs in files 92, 96, and 104.

## Ideal-theoretic formulation

The full polynomial lists are absent, so the notation below specifies the
logical form of the required certificate rather than an executable ideal.
Let \(A\) be a polynomial ring containing every low-data variable and every
remaining post-\(u25\) variable.  Let \(F_3,F_4\subset A\) denote the full
lists of low-data, non-pivot simple-\(u30\), base, and repeated-\(e30\)
generators after the appropriate Schur eliminations.  Let \(g_3,g_4\) be the
products of \(\Delta\) and all pivots inverted on their charts.  Define

\[
I_3=(F_3):g_3^\infty,\qquad
I_4=(F_4+(\rho_3)):g_4^\infty.
\tag{180.2}
\]

The extra equation \(\rho_3=0\) in \(I_4\) implements the fallback piece in
(180.1).

Suppose \(K_{c,1},\ldots,K_{c,m_c}\subset A\) are explicit ideals for the
claimed terminal strata on chart \(c\in\{3,4\}\).  Set-theoretic coverage is

\[
V(I_c)\subseteq\bigcup_jV(K_{c,j}),
\]

which, over the algebraically closed field \(k\), is equivalent to

\[
\bigcap_jK_{c,j}\subseteq\sqrt{I_c}.
\tag{180.3}
\]

This is the correct direction of ideal containment.  A scheme-theoretic
version may replace the radical inclusion by a specified closed-union
scheme and an ordinary ideal inclusion.

For each stratum, let \(L_{c,j}\) be the later-layer ideal containing all
required \(e35,e40,e45,e50\) equations.  The terminal emptiness check is

\[
(I_c+K_{c,j}+L_{c,j}):g_c^\infty=(1).
\tag{180.4}
\]

Equations (180.2)--(180.4), with every generator displayed, constitute a
complete tail-coverage certificate.

## What is currently known

- File 159 proves that the *displayed* basin-127 ideal \(J\) is a reduced
  five-point quotient and that its base residual cuts it to one
  six-parameter point \(r_{129}\).  The omitted parameter map to the
  19-coordinate terminal point \(P129\) is transcript-only.
- Containment of the original localized basin-127 equations in \(V(J)\) is
  H127 and remains open.
- Files 148, 150, and 156 record terminal residuals for \(P129\), three
  nearby rho3 points, and one rho4 point.  Their final one-variable systems
  visibly have no common zero, but their extraction from the local equations
  is certificate-transcript.
- All finite tangent and near-miss searches range only over specified
  \(\mathbb F_5\)-sets.  They do not prove (180.3) over \(k\).

## Missing data before computation

The checkout does not contain the polynomials \(F_c\), the products \(g_c\),
or explicit ideals \(K_{c,j},L_{c,j}\).  Consequently (180.2) cannot yet be
entered into a CAS from retained files.  File 181 isolates the first
extraction step.  Any future saturation output must display its input
generators; sampled points or a bare transcript are not a proof of coverage.
