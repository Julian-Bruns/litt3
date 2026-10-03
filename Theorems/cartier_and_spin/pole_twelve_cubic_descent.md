# Cubic descent for every actual pole-twelve comparison

Version2,3October2026. Use the fixed curve and ACTUAL same-source
finite etale comparison [normal form](new_line_comparison_normal_form.md),
with distinct embedded endpoint fields. Assume T is jointly minimal
and put n=deg h_i. If its comparison parameter has pole degree twelve, then
\[
[k(T):k(x_1,x_2)]=3.
\]
Both primitive minimal polynomials have zero cubic-character term.
This covers every covering degree12<=n<=186, all35 norm patterns,
repeated labels and arbitrary geometric scalars.

The proof now uses integer phase balance from two regular-form traces
and a local endpoint-character obstruction. The latter is reusable:
when an actual minimal equation has character term YH(t), balanced
endpoint mass at most four excludes H!=0. No first-character transport
between infinities or finite endpoint-label case analysis is needed.

The simultaneous quotient S has
\[
k(S)=k(u,v)=k(u,t)=k(v,t),\qquad
\deg t=4,\quad\deg u=\deg v=n,\quad g(S)\le3n-21.
\]
Its exact reconstruction requires P(u) noncube, r^3=P(v)/P(u),
and both u,v unramified outside the roots of P and infinity, with
indices1 or3 above those values, together with
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
\]
These data recover the original connected cubic normalization
y^3=P(u), with both actual everywhere-etale maps (u,y),(v,ry).
The parameter-map normal closure has solvable group of order
dividing1944, prime to five; it is not an etale common Galois refinement.

The later [complete exclusion](pole_twelve_complete_exclusion.md)
also closes the quartic branch. The present descent lemma remains
an input to that proof. No shared tensor is extracted from an
arbitrary unmarked common cover.

[Proof and retained evidence](../../Proofs/cartier_and_spin/pole_twelve_cubic_descent.md).
