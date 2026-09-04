# Task 06: verify the final conditional assembly

## Status

This is an assembly task, not a way to bypass an open theorem or an evidence
gap. Do not begin until Tasks 00, 00A, 00B, and 01--05, including the terminal
identities named in Task 05, have self-contained proofs.

Work over \(k=\overline{\mathbb F}_5\), and put

\[
S=\mathbb P^1_k(31,31,31),\qquad
S_0=[S/S_3]\simeq\mathbb P^1_k(2,3,62).
\]

## Hypotheses to audit

Assume that the completed proof package establishes:

1. **Profile extraction:** every non-visible connected representable finite
   étale self-correspondence of \(S\) produces the profile-4 pair with
   incidence matrix
   \[
   \begin{pmatrix}0&1&3\\1&2&1\\3&1&0\end{pmatrix}.
   \]
2. **Entry-one exclusion:** no such pair has an entry-one high-point
   coincidence, including every lower-degree specialization.
3. **No-highpoint exclusion:** no such pair has all six high points distinct.
4. **Entry-zero coverage and exclusion:** every remaining entry-zero pair is
   either excluded before the formal tower or is proved to enter a stated
   local model covered by it. That tower is self-contained through repeated
   \(u25\), the basin and coverage theorems are proved, and the terminal
   later-layer equations are derived and have empty localized loci.

Hypothesis 4 includes Task 00B, the missing repeated-\(u20\) step, and the
other transcript-only response identities. Tasks 04 and 05 alone do not
supply it.

## Proved branch reduction

File `routes/profile4/162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md` proves:

- a coincidence \(Q_j=P_i\) gives a quotient of degree at most
  \(6-M_{ij}\);
- residue counts exclude
  \(Q_\infty=P_0\), \(Q_1=P_1\), and \(Q_0=P_\infty\);
- simultaneous inversion identifies the two entry-zero cells; and
- the paired entry-zero case
  \(Q_0=P_0,\ Q_\infty=P_\infty\) is impossible.

Consequently, after Hypotheses 2 and 3, every remaining pair has exactly one
entry-zero coincidence, represented by \(Q_0=P_0\). The corrected file
`routes/profile4/double_fiber/79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md`
computes its compatible norm constants and tangent leading form, but it does
not prove \(x(Q_1)=x(Q_\infty)=2\). Hypothesis 4 must cover the whole last
branch; checking only that specialized locus is insufficient. Once it does,
no profile-4 pair exists. Hypothesis 1 then implies that every connected
finite étale self-correspondence \(u,v:T\to S\) is visible:

\[
\pi_0u\simeq\pi_0v.
\]

This proves the repository's shorthand assertion
\(\operatorname{Comm}_{\mathrm{alg},k}(S)=S_3\).

## Common-cover consequence

File `routes/global/10_PROOF_SELF_CORRESPONDENCE.md` contains the
self-contained descent proof; verify, rather than omit, its essential
cocycle step.

Let \(Y\) be the smooth projective curve

\[
y^{31}=x(x-1).
\]

File `routes/global/14_PROOF_LIFT_THROUGH_Y.md` proves that \(g(Y)=15\) and
that \(Y\to S\) is a representable finite étale \(\mu_{31}\)-torsor.
If \(Z\) were a connected common finite étale cover of \(Y\) and a smooth
proper connected curve \(X\), put \(R=Z\times_XZ\). Visibility supplies a
2-isomorphism on every connected component of \(R\) between the two pullbacks
of \(Z\to S\to S_0\).

These isomorphisms are unique because \(S_0\) has trivial generic inertia and
the maps are dominant. Uniqueness forces the cocycle on
\(Z\times_XZ\times_XZ\). Effective finite-étale descent therefore gives a
representable finite étale map \(X\to S_0\).

Since

\[
\deg K_{S_0}
=-2+\left(1-\frac12\right)+\left(1-\frac13\right)
  +\left(1-\frac1{62}\right)
=\frac{14}{93},
\]

a degree-\(d\) finite étale map from a genus-\(g\) curve would satisfy

\[
2g-2=d\,\frac{14}{93},
\qquad d=\frac{93(g-1)}7.
\]

Thus \(7\mid(g-1)\). In particular \(g=3\) is impossible. Under Hypotheses
1--4, \(Y\) has no common finite étale cover with any genus-\(3\) curve. A
disconnected cover would have a connected component still covering both
connected curves, so this gives the intended negative answer to Problem 3.
