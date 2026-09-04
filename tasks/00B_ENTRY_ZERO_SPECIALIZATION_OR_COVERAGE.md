# Task 00B: justify the entry-zero specialization or cover the full branch

## Status

Open. This is a geometric prerequisite for the retained double-fiber tower,
independent of the missing and transcript-only formal-layer calculations in
Tasks 00 and 00A.

Work over \(k=\overline{\mathbb F}_5\). Start with a profile-4 pair in the
representative entry-zero branch

\[
Q_0=P_0
\]

and with no other high-point coincidence. Read
[`162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md`](../routes/profile4/162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md)
for that reduction, then read
[`79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md`](../routes/profile4/double_fiber/79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md)
for the corrected boundary normalization.

## The gap

Put

\[
\alpha=z(P_0),\qquad c=x(Q_1),\qquad d=x(Q_\infty),
\qquad \pi=cd,\qquad \mathcal N=(1-c)(1-d).
\]

For the corner-normalized bidegree equation of file `79`, let
\(K=f(0,0)=\pi\alpha^{31}\) be its shared \(x=0\) and \(z=0\) boundary
scalar.

The boundary divisors and tangent cone determine the compatible constants in
the three norm formulas, but they do not prove

\[
\alpha^{31}=1,\qquad \mathcal N=1,\qquad \pi=-1,
\]

and therefore do not prove \(c=d=2\). In particular, the constants in the
norms cannot independently be scaled to \(1\): a defining equation has only
one overall scalar, and the limits on the branches above \(z=\infty\) retain
the factors \(-\pi\) and \(\mathcal N\).

The existing formal tower studies the specialization \(c=d=2\). Until the
present task is solved, that tower does not cover every entry-zero pair.

## Acceptable outcomes

Supply one of the following.

1. Derive \(c=d=2\) from additional, explicitly stated profile equations or
   global geometry, without reusing a norm normalization equivalent to the
   desired conclusion, and justify every further scalar normalization used
   by the tower. In particular, \(c=d=2\) alone does not imply
   \(\alpha^{31}=1\) or \(K=-1\).
2. Prove that every entry-zero pair outside \(c=d=2\) is impossible, and
   separately justify that the specialized local equation used by the tower
   follows on the remaining locus.
3. Replace the specialized tower by an argument valid for all admissible
   \((\alpha,c,d)\), with every parameter-dependent unit and exceptional
   locus retained.

A proof confined to the locus \(c=d=2\) is useful conditional progress but
does not close this task unless the complementary locus is also treated.

## Required checks

- Derive every boundary constant using one fixed normalization of the
  bidegree equation.
- Keep \(c,d,\alpha\) as elements of \(k\); do not use \(a^5=a\) for an
  unrestricted parameter.
- Distinguish equality of the values \(c=d\) from equality of the distinct
  points \(Q_1\ne Q_\infty\).
- If a coordinate change is used, state its action on all marked values and
  prove that it preserves the profile normalization.
- If later ODE or formal-layer equations provide the missing restriction,
  derive them from the displayed curve equation rather than citing an absent
  transcript.

Completion of this task supplies only the entry into, or replacement for,
the local tower. The evidence gaps in Tasks 00, 00A, 04, and 05 remain
separate.
