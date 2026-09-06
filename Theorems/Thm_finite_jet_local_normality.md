# A finite-jet certificate for completed-local normality

Let k be an algebraically closed field of arbitrary characteristic, and
f in z k[[z]] with f' nonzero. Put e=ord(f), delta=ord(f'),

    N=max(delta+2, 2delta-e+3),     q=N-delta.

Every g with g-f in z^N k[[z]] has a UNIQUE source automorphism
phi(z)=z+O(z^q) satisfying f(phi(z))=g(z). In particular f and g define
isomorphic extensions of the SAME field k((t)), with t mapped to f,g.

Let A_N(f) be the algebraic set of jets
psi=a_1 z+...+a_(N-1)z^(N-1), a_1 nonzero, satisfying

    f(psi(z))=f(z) modulo z^N.

The image of A_N(f)(k) under truncation modulo z^q is a finite group,
canonically isomorphic to Aut_{k((f))}(k((z))). Its cardinality is at most
e, and equals e IF AND ONLY IF k((z))/k((f)) is Galois. Counting points
of A_N itself would be wrong: its high-jet fibers need not be finite.

Likewise, fixed-base isomorphism of two separating series of orders e
and derivative orders delta is equivalent to solvability of
f(psi)=g modulo z^N. Thus the normality and identical-extension condition
in `unimodular_atlas_normality` is a finite system of polynomial equations
and nonvanishing conditions, not a condition on infinitely many coefficients.

A target change f -> h(f), h(t)=t+O(t^2), can be absorbed by such a source
change whenever 2e>=N; in particular when 3e>2delta+2. For (e,delta)=
(1000,1143),(3000,3143), one may use N=1289,3289 and q=146 in both cases.
These are safe, not optimal, cutoffs.

The determinacy bound is classical (Boubakri–Greuel–Markwig, as recalled
by Nguyen); the proof here records a controlled correction and its exact
Galois-certificate application. Major audit PASS as a dependency of the
Hermitian package, /root/hermitian_fixed_base_major_audit, 2026-09-06.
No atlas existence or common-cover exclusion follows merely from finiteness.

[Proof](../Solutions/Sol_finite_jet_local_normality.md).
