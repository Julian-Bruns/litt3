# Proof: a cored span has a common effective orbifold

[Statement and author-proof metadata](../Theorems/Thm_cored_orbifold_bridge.md).
Keep the actual étale span X←f—Z—g→Y and its transcendence-degree-one
field intersection inside k(Z).

## 1. The core makes the alternating étale closures finite

Since Z is hyperbolic and the span has a core,
[Krishnamoorthy, Lemma4.2](https://doi.org/10.2140/ant.2018.12.1173)
supplies a finite field extension F/k(Z) Galois over BOTH endpoint
fields. Its finite constant-field extension is unnecessary over
algebraically closed k. The corresponding curve over Z might be
ramified, so do not use it directly as a common atlas.

Instead start with L_0=k(Z) inside F and alternately take its Galois
closures over k(X) and k(Y). They stay inside F, which is normal over
each. Every step remains étale over Z: inductively the current curve
is étale over the next endpoint, and its Galois closure is a compositum
of unramified conjugates, hence unramified on smooth projective curves.

This increasing chain inside a finite extension stabilizes. Because
the closure operations alternate, the stable field is Galois over
both endpoints. Its smooth projective curve W is the required actual
finite étale refinement of Z. The finite envelope F came from the CORE;
this argument cannot be started for an arbitrary span.

## 2. The quotient retains both actual étale legs

Put A=Gal(W/X), B=Gal(W/Y) and G=⟨A,B⟩⊂Aut_k(W).
Hyperbolicity makes G finite, and S=[W/G] is a smooth proper connected
effective DM curve. Even if p divides |G|, G is a constant finite
étale group scheme; fixed points cause wild coarse ramification.

Since A,B act freely, X=[W/A] and Y=[W/B].
Subgroup inclusion gives representable finite étale surjections
X,Y→S: after base change to W they are the corresponding finite
coset covers. Finally,

    k(W)^G=k(W)^A∩k(W)^B=k(X)∩k(Y),

so the coarse field is exactly the prescribed core.
The [profinite core-tower criterion](../routes/global/21_SIMULTANEOUS_ENVELOPE_CORE_TOWER_CRITERION.md)
records the general termination obstruction and an actual counterexample
without a core. Neither a separate pair of Galois closures nor a possibly
ramified closure over the coarse curve substitutes for W.
