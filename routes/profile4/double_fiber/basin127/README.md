# Basin-127 route

This is a component calculation inside the proposed \(c=d=2\) formal
tower. File 79 does not prove that the general entry-zero branch enters this
specialization.

For H127:

1. Read [file 159](159_BASIN127_CAS_SETUP_AND_DISPLAYED_BASIS_CHECK.md).
   It gives a self-contained decomposition of the displayed ideal \(J\); this part no
   longer depends on an absent CAS. Its discriminant-open calculation uses
   the explicitly recorded local-model formula, whose derivation is absent.
2. Read [file 179](179_BASIN127_TAIL_DEPTH_REDUCTION.md) only when optimizing
   an exact reconstruction. Its depth rule is retained, while its low-degree pivot
   values are explicitly transcript-only.
3. Use [Task 04](../../../../tasks/04_BASIN127_CONTAINMENT.md) for the
   intended target, subject to the ideal-direction correction in file 159.

The open statement is

\[
J_k\subseteq
\sqrt{\,I_{127}:(\Delta\mu_3)^\infty\,},
\]

equivalently
\(V(I_{127})\cap D(\Delta\mu_3)\subseteq V(J_k)\).
The generators of \(I_{127}\) and the pivot \(\mu_3\) are absent.

Reproving that \(J\) has five points, or that its base residual selects
\(r_{129}\), does not prove H127. Moreover, the parameter map identifying
\(r_{129}\) with the 19-coordinate terminal point called \(P129\), and that
point's later terminal kill, are certificate-transcript.
