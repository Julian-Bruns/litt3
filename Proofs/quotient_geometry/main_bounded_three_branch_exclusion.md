# Proof: tame three-puncture monodromy and the parameter orbit

[Statement](../../Theorems/quotient_geometry/main_bounded_three_branch_exclusion.md).
No numerical computation is needed.

## A finite set of source curves

Normalize three possible branch values by a target projective coordinate
to {0,1,∞}; if fewer are used, add unused marked values. A separating
tame degree-n map gives a connected degree-n étale cover of
U=P1−{0,1,∞}, tame at its compactification boundary. Conversely its
normal smooth compactification recovers the source curve and map.

The tame fundamental group of U in characteristic five is a quotient
of the free profinite group on TWO generators. This is the full tame
group, not merely its prime-to-five quotient: see SGA1, Exposé XIII,
Corollary2.12, or the explicit formulation in Harbater's
[Patching and Galois theory](https://www2.math.upenn.edu/~harbater/patch35a.pdf),
Remark5.3.3(a). In particular, non-Galois maps whose monodromy group has
five-divisible order are included. Their local inertia remains tame.

A labeled connected n-sheeted cover is specified by a transitive
continuous permutation representation into S_n. There are at most
(n!)² choices for the images of two generators. Ignoring conjugation
and transitivity only enlarges the bound. Thus there are at most
42·(42!)² geometric source-curve classes for degrees1 through42.
The finite set is stable under arithmetic F5-Frobenius, since the
branch set and the tame degree conditions are defined over F5.

## Recovering parameters without choosing an embedding of the source

Each geometric isomorphism class in the five-branch family has at most
720 parameter preimages: an isomorphism of genus-two curves preserves
their unique hyperelliptic pencil and permutes six branch points. A
permutation and the images of three distinct points determine its
projective coordinate change, so six factorial is a sufficient bound.
This is also the accepted prime-field branch-family argument.

Consequently at most C=720·42·(42!)² parameters occur, in an F5-stable
finite set. The F5-orbit of t has size [F5(t):F5]. If that size exceeds
C, no such map exists. This does not assume that the candidate map
itself is defined over F5.

The previously selected MAIN prime exceeds K>(42000!)³⁸. The elementary
inequality C<(42000!)³⁸ therefore applies without changing the endpoint.

## Application to the actual ramified spin quotient

Retain the ACTUAL maps q:T→Y and φ:T→Γ. Write K for the projective
kernel, k=|K|, H=G/K and B=Γ/H. On the tame numerical branch B=P1,
the induced actual Y→B has degree n=κ/k. Its distinguished fiber is
(2r/k)P+(r/k)(Q1+...+Qu). Away from this value, φ is unramified and q
is étale, so every other branch value of Y→B is a branch value of the
Galois cover Γ→B, with the same uniform inertia index.

At the distinguished value the inertia of Γ→B is r/k. If r/k>1,
this value is already one of its branch values. Thus a triangular
Γ→B signature makes the actual Y→B map have at most three branch
values. All local indices are prime to five on this branch. The
bounded endpoint theorem excludes it on MAIN.

If r/k=1, the distinguished value is NOT a Γ→B branch value, and
Y→B instead has an additional branch value. The finite-set argument
does not apply. Likewise a quadrilateral signature gives four values,
even when the distinguished value is one of them. No stronger scope
is asserted.
