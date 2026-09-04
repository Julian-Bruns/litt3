# Task 04: prove the basin-127 saturation containment

## Status

Open. File `159` now gives a handwritten proof of every assertion below
about the displayed ideal \(J\). The original basin equations and
saturation element are absent, so the containment target cannot yet be
entered into a CAS from this checkout.

Work over \(k=\overline{\mathbb F}_5\), but the concrete algebra below is over
\(\mathbb F_5\).  This prompt is a local algebra problem arising in the
specialized double-fiber model. It may be attacked conditionally without the
global geometry, but Task 00B must still prove that this model covers every
surviving entry-zero pair before H127 can contribute to an exclusion.

Let
\[
  R=\mathbb F_5[r_0,r_1,r_2,r_3,r_4,r_5]
\]
with lexicographic order.  The displayed expected quotient is the ideal
\[
\begin{aligned}
J=\langle&
r_2-2,\ r_5-2,\\
&r_0+2r_1-2r_3+2r_4^2+r_4+1,\\
&r_1^2-r_3-2r_4-1,\\
&r_1r_3+2r_1-2r_3-r_4^2+2r_4,\\
&r_1r_4-r_1+2r_4^2-2,\\
&r_3^2+r_3-2,\\
&r_3r_4-r_3-r_4+1,\\
&r_4^3-2r_4^2-r_4+2
\rangle.
\end{aligned}
\]
It is already proved that \(J\) is radical of length \(5\), with points
\[
\begin{gathered}
(0,0,2,1,4,2),\quad
(0,1,2,3,1,2),\quad
(3,4,2,1,2,2),\\
(4,2,2,1,1,2),\quad
(4,4,2,3,1,2).
\end{gathered}
\]
It is also already proved that adding the base residual
\[
  B_{127}=r_3+r_4^2
\]
cuts \(J\) to one point:
\[
  r_{129}=(3,4,2,1,2,2).
\]
The missing basin parameterization is needed to identify this six-coordinate
point with the 19-coordinate point called
\(P129\) in the terminal transcripts. The displayed terminal \(e50\)
residual has no zero, but both that identification and the residual's
derivation from the local equations are certificate-transcript. Task 04
concerns the basin containment, not those separate terminal verifications.

The open local algebra theorem is the following.

**Theorem.** Let \(I_{127}\subset R\) be the basin-127 low-data ideal obtained
from the simple-\(u30\) corrected double-fiber local equations, and let
\[
  s_{127}
\]
be the product of the étale discriminant and the relevant \(\rho_3\) chart
pivot.
Prove
\[
  V_k(I_{127})\cap D(s_{127})\subseteq V_k(J),
\]
where all ideals are extended to \(k=\overline{\mathbb F}_5\). Equivalently,
prove the correctly directed radical containment
\[
  J\,k[r_0,\ldots,r_5]\subseteq
  \sqrt{\,I_{127}k[r_0,\ldots,r_5]:s_{127}^{\infty}\,}.
\]
The stronger scheme-theoretic statement
\[
  I_{127}:s_{127}^{\infty}=J
\]
is also acceptable.

You must make the theorem fully explicit: define \(I_{127}\) and \(s_{127}\)
from the local equations, not by referring to code or an archive.  A valid
solution may be a handwritten Groebner/saturation certificate, a compact
verifiable Singular/Sage transcript with all input polynomials displayed, or
a conceptual proof explaining why the low-data equations force exactly \(J\)
on \(D(s_{127})\).

If the containment is false, a displayed point of
\(V(I_{127})\cap D(s_{127})\setminus V(J)\), verified against the recovered
generators, is an equally valid outcome and must be recorded as a failure of
H127.

Do not stop at verifying that \(J\) has five points; that is proved in file
`159`. The missing step is to show that every geometric point of the
original localized low-data scheme satisfies \(J\). Pointwise checks only on
\(\mathbb F_5\) do not prove this over \(k\).
