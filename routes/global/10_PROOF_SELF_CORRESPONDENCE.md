# Self-correspondences and the conditional common-cover theorem

This file fixes the global notation, states the exact open visibility
assertion, and proves its conditional consequence for the common-cover
problem. It also isolates the still-open passage from an arbitrary
self-correspondence to a finite over-orbifold.

Throughout, `k=\bar F_5`.

## DEF-S-TRIANGLE-STACK — `S`, its symmetric quotient, and `S_0`

**Status: `proved-text`, using the cyclic-atlas calculation in
[file `14`](14_PROOF_LIFT_THROUGH_Y.md).**

Let

`S=P^1_k(31,31,31)`

be the root-stack orbifold with stacky points at `0`, `1`, and `infinity`.
Equivalently, file `14` proves

`S=[Y/mu_31]`, where `Y: y^31=x(x-1)`.

The permutations of the three marked points give an action of `S_3` on
`S`. Define

`S_0=[S/S_3]`, with quotient map `pi_0:S -> S_0`.

Then

`S_0 ≃ P^1_k(2,3,62)`,

and `pi_0` is a representable finite étale `S_3`-torsor of degree `6`.

To check the signature, take the quotient of the coarse `P^1` by the group
permuting `{0,1,infinity}`. Besides the orbit of those three points, there
is one orbit with stabilizer `C_2` and one with stabilizer `C_3`. At a marked
point, the source inertia `mu_31` combines with its order-`2` stabilizer to
give inertia of order `62`. This inertia is cyclic because it is tame and
acts faithfully on a one-dimensional formal disc. Thus the three target
orders are `2`, `3`, and `62`. The quotient map to `[S/S_3]` is an
`S_3`-torsor by the definition of a quotient stack; `S_3` is finite étale in
characteristic `5`.

In particular, `S_0` has trivial generic inertia. This fact is used in the
descent proof below.

## DEF-FINITE-ETALE-SELF-CORRESPONDENCE

**Status: definition.**

A finite étale self-correspondence of `S` consists of a connected smooth
proper Deligne–Mumford curve `C` and two representable finite étale maps

`u,v:C -> S`.

Neither map is assumed Galois. Representability is part of the definition.

## DEF-ALG-COMMENSURATOR — the open visibility assertion

**Status: `open`.**

The notation

`Comm_alg,k(S)=S_3`

is shorthand in this repository for the following assertion; it is not a
separately constructed commensurator group:

> For every connected finite étale self-correspondence `u,v:C -> S`, there
> is a 2-isomorphism `pi_0 u ~= pi_0 v`.

Equivalently, `(u,v):C -> S x S` lifts to the 2-fiber product

`S x_{S_0} S`.

Since `pi_0` is the `S_3`-torsor above,

`S x_{S_0} S ≃ S_3 x S`,

where the right side is the disjoint union of six copies of `S`.

Consequently, connectedness of `C` makes the assertion equivalent to the
existence of one constant `sigma in S_3` such that

`v ~= sigma u`.

This assertion is also the item formerly duplicated as
`BOTTLENECK-ALG-COMM-S31`. Nothing in files `11`–`13` currently proves it.

## LEM-CANONICAL-DEGREE-S0

**Status: `proved-text`.**

The orbifold canonical degree of `S_0=P^1_k(2,3,62)` is

`deg K_{S_0}`

`=-2+(1-1/2)+(1-1/3)+(1-1/62)`

`=14/93`.

This is consistent with the étale degree-`6` quotient, since
`6(14/93)=28/31=deg K_S`.

More generally, if a smooth projective curve of genus `g>=2` has a finite
étale map of degree `d` to `S_0`, then

`2g-2=d(14/93)`, so `d=93(g-1)/7`.

Thus `g` must be congruent to `1` modulo `7`. In particular, no genus-`3`
curve admits such a map: its degree would have to satisfy

`4=deg K_X=d(14/93)`,

so `d=186/7`, not an integer.

## PROP-CONDITIONAL-COMMON-COVER

**Status: `conditional-proof`, conditional only on the open visibility
assertion.**

Assume `Comm_alg,k(S)=S_3` in the precise sense above. If a smooth
projective connected curve `X/k` of genus at least `2` has a common finite
étale cover with `Y:y^31=x(x-1)`, then

`g(X) ≡ 1 (mod 7)`.

In particular, no genus-`3` curve has such a common cover.

### A uniqueness observation

Let `T` be a separated Deligne–Mumford curve with trivial generic inertia,
and let `a,b:D -> T` be dominant maps from a connected smooth curve. There
is at most one 2-isomorphism `a ~= b`.

Indeed, two such isomorphisms differ by an automorphism of `a`. At the
generic point this automorphism lies in the generic inertia of `T`, hence is
the identity. The isomorphism sheaf is separated over the reduced curve
`D`, so equality on the dense generic point implies equality everywhere.

### Proof of the proposition

If the common cover is disconnected, any nonempty connected component still
maps surjectively to both connected curves: its image is nonempty, open, and
closed. We may therefore suppose there are finite étale maps

`p:Z -> X` and `a:Z -> Y`,

with `Z` connected. Put

`b:Z -> Y -> S`, and put `q=pi_0 b:Z -> S_0`.

Both `b` and `q` are representable finite étale. Consider the finite étale
equivalence relation

`R=Z x_X Z`

with projections `p_1,p_2:R -> Z`. On each connected component `R_alpha`,
the two maps

`b p_1,b p_2:R_alpha -> S`

form a finite étale self-correspondence. (Each projection from a nonempty
component is surjective because `Z` is connected.) Visibility therefore
gives a 2-isomorphism

`q p_1 ~= q p_2`

on every component. These componentwise isomorphisms form one isomorphism
on `R`.

They are unique by the observation above: the maps in question are
dominant, and `S_0` has trivial generic inertia. On
`Z x_X Z x_X Z`, the two sides of the descent cocycle are consequently the
same, because both are isomorphisms between the same pair of dominant maps.
The restriction along the diagonal is likewise the identity, since the
identity isomorphism is the unique automorphism there.
Thus `q` carries an effective étale descent datum and descends to a map

`h:X -> S_0`.

Representability and étaleness descend along the finite étale cover `p`.
Since `X` is proper and `S_0` is separated, `h` is proper; a proper étale
morphism is finite étale. It has positive degree because `q=h p` is
surjective. Hence `h` is representable finite étale. The canonical-degree
lemma now forces `g(X)` to be congruent to `1` modulo `7`; for `g(X)=3` it
gives the contradiction `deg(h)=186/7`.

The uniqueness argument is the essential point: mere existence of unrelated
isomorphisms on the components of `R` would not, by itself, be a descent
datum.

## PROP-CORRESPONDENCE-TO-OVER-ORBIFOLD — the open envelope bridge

**Status: `open`; no general finite-envelope theorem is available.**

The proposed bridge starts with `u,v:C -> S` and seeks a connected finite
étale cover `W -> C` for which both maps `W -> S` are Galois. If such a
simultaneous refinement exists, let `A` and `B` be the two deck groups.
Then the rest of the quotient construction is valid:

1. Since `W -> S` is finite étale and
   `deg K_S=-2+3(1-1/31)=28/31>0`, the curve `W` has genus at least `2`;
   hence `Aut_k(W)` is finite.
2. The subgroup `H=<A,B>` of `Aut_k(W)` is therefore finite.
3. `O=[W/H]` is a smooth proper connected orbifold curve.
4. The maps `[W/A] -> [W/H]` and `[W/B] -> [W/H]` are representable finite
   étale, and the two source stacks identify with `S` through the two given
   Galois covers.

Thus a simultaneous Galois refinement really would produce a common finite
over-orbifold. If a strong over-orbifold theorem additionally supplied a
single map `O -> S_0` compatible with both presentations of `S`, pulling
back to `W` and using the uniqueness observation would yield
`pi_0u ~= pi_0v` after descent to `C`.

What is missing is precisely what this conditional construction assumes:

- no proof produces a finite `W` simultaneously Galois for the two maps;
- separate Galois closures over the two copies of `S` do not imply one; and
- file `11` does not prove the required strong, presentation-compatible
  factorization `O -> S_0`.

Accordingly, this section is a description of the open gate, not a
proposition that may be cited. The conditional common-cover proposition
above does **not** depend on this envelope construction; it depends directly
on the stated visibility assertion.
