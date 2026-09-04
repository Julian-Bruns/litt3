# Rho4 candidate transcript and \(e50\) ending

## Referee status

**certificate-transcript**.  The local evaluators, tangent enumeration, and
symbolic layer checker cited in the original note are absent.  The displayed
final one-variable system has no common zero over
\(k=\overline{\mathbb F}_5\), but its derivation from the double-fiber
equations is not independently verified here.

## Coefficient-zero point

The recorded rho4 coefficient-only survivor is

\[
P_{\rho4}=
(0,3,2,2,3,2,1,4,4,2,2,2,1,1,2,4,2,2,4).
\]

The 19 coordinate names and their order are not retained, so this tuple is
only regression data for a future reconstruction.

The missing evaluator reported

\[
(\alpha,\beta,\gamma,\Delta)=(4,2,3,4)
\]

and vanishing of all sixteen non-pivot coefficient residuals.  The full-chain
transcript then reported a nonzero simple-\(u30\) base residual \(4\),
independent of the remaining tail variables.  Conditional on that
calculation, this point dies at the base equation.  Its existence shows that
coefficient-only emptiness is the wrong target.

## Recorded tangent-basin point

Enumeration of a seven-dimensional affine tangent space over
\(\mathbb F_5\) reportedly found six coefficient-zero points.  Their base
residuals were \(4,3,1,2,3,0\); the unique base-zero point was

\[
P_{\rho4,0}=
(0,3,2,2,3,2,1,4,4,4,0,2,0,2,2,1,3,2,1).
\]

The repeated-\(e30\) transcript reports a consistent rank-\(3\) affine
system at this point.  The later symbolic transcript reports ranks
\(4,4,4\) at \(e35,e40,e45\), followed by the one-variable \(e50\)
system

\[
\begin{aligned}
R_0(a)&=4a+3a^2,\\
R_1(a)&=4+2a+3a^2,\\
R_2(a)&=4+a^2,\\
S(a)&=2+a.
\end{aligned}
\tag{156.1}
\]

The simple equation in (156.1) forces \(a=3\), at which
\(R_0(3)=4\).  Therefore the displayed system has no common zero over
\(k\).

## Scope

The exact last substitution proves only a fact about (156.1).  The absent
programs are still needed to certify that (156.1) is the actual terminal
system and that the finite tangent census is correct.  Even then, it covers
only the explored tangent family, not the full rho4 locally closed chart.
The full use of this terminal obstruction also presupposes the missing
repeated-\(u^{20}\) layer.
