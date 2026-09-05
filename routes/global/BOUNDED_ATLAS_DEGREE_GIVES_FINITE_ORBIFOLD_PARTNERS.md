# Bounded atlas degree gives finitely many common-orbifold partners

**Status:** independently audited **PASS**, 2026-09-05; no breaking
objection. Auditor: `/root/x_elliptic_quotient_maps`.
[Audit record](audits/BOUNDED_ATLAS_DEGREE_GIVES_FINITE_ORBIFOLD_PARTNERS_AUDIT.md).
Author: `/root`. This is a parameterized finiteness lemma. It does not
bound the degree, nor replace a coreless correspondence by an orbifold.

## Theorem

Let `k` be an algebraically closed field, let `X/k` be a fixed smooth
projective connected curve with `g(X)>=2`, and let `B>=1` be an integer.
There are only finitely many isomorphism classes of smooth proper
**effective** Deligne--Mumford orbifold curves `S` admitting a
representable finite etale atlas

\[
                         X\longrightarrow S
\]

of degree at most `B`. Wild inertia is allowed, and the atlas need not
be Galois.

For any fixed integer `h>=2`, there are consequently only finitely many
isomorphism classes of smooth projective curves `Y/k` of genus `h` for
which such an `S` also admits a representable finite etale atlas

\[
                         Y\longrightarrow S.
\]

## Proof

The etale fundamental group of a smooth projective curve over an
algebraically closed field is topologically finitely generated. In
positive characteristic one can lift the curve to characteristic zero
and use the surjective specialization map, obtaining a quotient of the
profinite genus-`g(X)` surface group. For the specialization statement,
see [Stacks, Lemma 58.30.1](https://stacks.math.columbia.edu/tag/0C0P).
In particular, a fixed such curve has only finitely many connected
finite etale covers of any bounded degree: a degree-`d` cover is given
by a transitive continuous permutation representation into `S_d`, up
to conjugation, and there are only finitely many representations into
a fixed finite group from a topologically finitely generated group.

Take one atlas `X -> S` of degree `n<=B`. The Galois closure in the
finite-etale covering category is a connected finite etale torsor

\[
                    W\longrightarrow S
\]

under a finite transitive permutation group `G<=S_n`. It factors as

\[
                    W\longrightarrow X\longrightarrow S.
\]

The stabilizer of one letter is the deck group of `W -> X`. Hence

\[
                       \deg(W/X)\le(n-1)!\le(B-1)!.
\]

The representable finite etale cover `W -> X` is a smooth projective
curve, and Riemann--Hurwitz gives `g(W)>=2`. There are only finitely
many possibilities for this cover of the fixed `X`, by the preceding
paragraph.

For each such `W`, its geometric automorphism group is finite. The
effectiveness assumption implies that the action of `G` on `W` is
faithful: its generic stabilizer is trivial. Therefore `G` is a subgroup
of the finite group `Aut_k(W)`, and

\[
                            S\simeq[W/G].
\]

There are finitely many subgroups of `Aut_k(W)`, proving the first
assertion. This is only an overcount; not every subgroup need produce
one of the atlases originally under consideration.

Fix one of these finitely many `S`, and choose a connected curve atlas
`W -> S` as above. Its fundamental group contains `pi_1(W)` as an open
subgroup. Since a profinite group with a finitely generated open
subgroup is itself finitely generated, `pi_1(S)` is topologically
finitely generated.

Write `delta=deg(omega_S)`. Etale pullback of the canonical bundle gives

\[
              2g(X)-2=n\delta>0.
\]

If `Y -> S` is a curve atlas with `g(Y)=h`, then its degree is necessarily

\[
              \deg(Y/S)=\frac{2h-2}{\delta}
                         =\frac{(h-1)n}{g(X)-1}.
\]

This is a single positive integer, or there is no such atlas. There are
only finitely many connected finite etale covers of `S` of that degree,
because `pi_1(S)` is finitely generated. Restricting to covers that are
smooth projective curves proves the second assertion. \(\square\)

## Open-family consequence

Suppose `U` is a positive-dimensional finite-type family of pairwise
varying smooth genus-`h` curves over `k`, and a separate theorem gives the
following **uniform** bound:

> Whenever `Y` belongs to `U` and `X,Y` have a common effective orbifold
> with representable finite etale atlases, the degree of `X -> S` is at
> most `B`.

Then only finitely many isomorphism classes in `U` have such a common
orbifold. In particular, any positive-dimensional open locus in the
genus-`h` moduli space contains curves with no common effective orbifold
with `X`.

Over an algebraic closure of a finite field this argument is still valid:
a positive-dimensional finite-type open locus has infinitely many
geometric points, and we are removing a **finite** set, not a countable
union of exceptional sets.

## Exact limitation

No conclusion is made about a common finite etale cover whose two maps
have no common finite orbifold quotient. The Galois closure used in this
proof is taken **over an orbifold already assumed to exist**. It is not
a simultaneous Galois closure of an arbitrary pair of covering maps.

This lemma is intended to turn a genuine all-degree atlas bound into an
existence statement for curves without a finite common orbifold. It does
not by itself disprove Litt's common-cover conjecture.
