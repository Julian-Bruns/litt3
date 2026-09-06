# Ordinary genus-two partners: the remaining case is intrinsically characteristic five

**Status:** composite author proof, 2026-09-05. Author: `/root`.
The uniform orbifold bound and bounded-atlas finiteness inputs are
independently audited PASS. The core-to-orbifold and arithmetic-reduction
inputs have complete author proofs, read by the root agent; this synthesis
has not received a separate independent audit. No counterexample to Litt's
problem is asserted.

Throughout, `k = Fbar_5`. This is a parameterized auxiliary-target theorem.
It does not replace either fixed curve from file 76.

## 1. A finite exceptional set, with no bound on covering degrees

### Theorem 1

Fix any smooth projective connected curve `X/k` of genus at least two.
There is a finite set `E_X` of geometric genus-two isomorphism classes
such that, for every ordinary genus-two curve `Y` outside `E_X`, every
actual finite étale correspondence

\[
                         X\xleftarrow{f}Z\xrightarrow{g}Y
\]

has both of the following properties:

1. It is coreless:
   \[
                     k(X)\cap k(Y)=k\quad\text{inside }k(Z).
   \]
2. The entire diagram has no simultaneous smooth proper lift to any
   mixed-characteristic discrete valuation ring with both maps finite
   étale, even after permitting finite ramified extension of that ring.

The theorem allows arbitrary degrees and arbitrary non-Galois monodromy.
It assumes neither simplicity nor an endomorphism condition on `J(X)`.

### Proof

Let `E_X^orb` be the ordinary genus-two curves which have a common
effective proper Deligne–Mumford orbifold with `X`, through actual
representable finite étale maps. This is a finite set. Indeed,

\[
                  \deg(Y/S)\le 42000,
\]

by [the audited uniform genus-two theorem](ORDINARY_GENUS_TWO_UNIFORM_ORBIFOLD_DEGREE_BOUND.md),
and canonical degrees then give

\[
       \deg(X/S)=(g(X)-1)\deg(Y/S)\le42000(g(X)-1).
\]

[Bounded-atlas finiteness](../../Theorems/Thm_bounded_atlas_partner_finiteness.md)
now gives the asserted finite set. This includes wild stabilizers and
non-Galois atlases.

A cored bi-étale correspondence has such a common orbifold by
[the core-to-orbifold bridge](../../Theorems/Thm_cored_orbifold_bridge.md).
Its proof does not assume the desired simultaneous unramified envelope:
a core first supplies a finite simultaneous *field* envelope; alternating
the two étale Galois-closure operations inside it stabilizes and produces
an actual étale envelope. The quotient by its two generated deck groups
is the required orbifold. Thus `Y` outside `E_X^orb` admits no cored
correspondence with `X`.

Independently, let `E_2,5^arith` be the finite set supplied by
[the jointly-liftable coreless target theorem](FINITE_TARGET_SET_FOR_JOINTLY_LIFTABLE_CORELESS_CORRESPONDENCES.md).
This set does not depend on `X`. Its proof uses three exact ingredients:

- a coreless bi-étale diagram which lifts jointly has arithmetic
  characteristic-zero targets;
- bounded genus permits only finitely many complex arithmetic curves,
  by Borel's bounded-covolume theorem, including noncongruence groups;
- each such number-field curve has only finitely many geometric potential
  good reductions at five, by stable-reduction uniqueness. All finite
  residue-field embeddings, hence Frobenius conjugates, are included.

The root agent read the relevant primary arguments of Krishnamoorthy
(Lemma 4.14 and Corollary 4.15), Borel (§8), and
Belolipetsky–Gelander–Lubotzky–Shalev (§5.3 and Corollary 1.4).
The linked theorem records the sources and the descent details.

Set

\[
                      E_X=E_X^{\rm orb}\cup E_{2,5}^{\rm arith}.
\]

This is finite. Outside its first part any correspondence is coreless;
outside its second part a coreless correspondence cannot lift jointly.
This proves both assertions. \(\square\)

### Actual curves over finite fields, not a generic-point assertion

The complement of `E_X` in the ordinary genus-two moduli locus is a
nonempty open of dimension three. Every geometric point is defined over
some finite extension of `F_5`. Thus the theorem supplies actual auxiliary
curves over `Fbar_5`, not merely a curve over a transcendental field.

Only a **finite** exceptional set was removed. There is no countable-union
avoidance argument and no assertion of a simultaneous intersection of
infinitely many nonempty opens.

## 2. Combining this with bounded families of ordinary covers

Call a finite group `Q` admissible if `5` does not divide its order and
either it has an abelian normal subgroup with cyclic quotient, or it has
odd order and nilpotency class at most two.

### Theorem 2

Suppose additionally that `X` is nonordinary, and fix an integer `N>=1`
prime to five. There is a nonempty three-dimensional open

\[
                            U_{X,N}\subset M_{2,k}
\]

such that, for every `Y` in this open, any hypothetical common finite
étale cover has all the following properties:

1. its specified two-map diagram is coreless;
2. that diagram has no simultaneous smooth proper mixed-characteristic
   lift, including after ramified extension;
3. if `G` is the group of the Galois closure of its `Y`-leg, it is
   **not** the case that `G` has a normal Sylow `5`-subgroup `P` and
   `G/P` is admissible of exponent dividing `N`;
4. its actual common source `Z` is nonordinary.

There is no bound on the order of the excluded normal `5`-subgroup.
The curve `Y` is chosen after fixing `N`; a single curve satisfying these
conditions for every `N` is not asserted.

### Proof

The [bounded Raynaud-monodromy theorem](GENUS_TWO_BOUNDED_RAYNAUD_MONODROMY_COMMON_COVER_EXCLUSION.md)
supplies a nonempty genus-two open `U_N^exp` on which every admissible
Galois étale cover of exponent dividing `N` is ordinary. Its proof uses
the exact genus-two cases of Raynaud's generic ordinarity theorems and
finite-group spreading; bounded exponent implies a finite group list in
these specified classes. Including the trivial group makes the base
curves ordinary as well.

Set `U_X,N = U_N^exp minus E_X`. Removing finitely many closed geometric
points from this nonempty three-dimensional open leaves a nonempty open.
Theorem 1 proves assertions 1 and 2.

If the group condition prohibited in assertion 3 held, write `W` for the
actual Galois closure of `Z -> Y`. Then `W/P` would be ordinary by the
choice of the open. The Galois étale `5`-power cover `W -> W/P` would
also be ordinary by Deuring–Shafarevich and Riemann–Hurwitz.

But `W -> Z -> X` is still finite étale. A nonzero Cartier-killed
holomorphic differential on the nonordinary `X` pulls back to a nonzero
Cartier-killed holomorphic differential on `W`, contradicting its
ordinarity. The same argument on `Z` proves assertion 4. At no stage is
the map to `X` replaced by a map from an unrelated curve. \(\square\)

## 3. What this does and does not resolve

The all-degree part completed here is the exclusion of every cored diagram
and every jointly liftable coreless diagram for suitable actual targets.
It isolates a genuine characteristic-five case, not merely a large-degree
case and not merely failure of one leg to be Galois.

It does **not** follow that there is no common cover. A coreless diagram
can in principle exist without a mixed-characteristic lift. Neither
ordinarity of `Y`, genus two, a lift of each individual curve, nor separate
lifting of the two covers supplies the missing joint lift.

Moreover, [Bogomolov–Tschinkel's domination theorem](UNIVERSAL_ONE_SIDED_DOMINATION_FORCES_FULL_ETALE_JACOBIAN_SPECTRUM.md)
shows that the Jacobians of finite étale covers of any genus-two `Y`
already contain every prescribed abelian variety as an isogeny factor.
Unrestricted Jacobian-factor or Newton-slope exclusion therefore cannot
close this gap: the second map's **étaleness** must enter a further argument.

The exact remaining task is to exclude an actual nonliftable coreless
bi-étale correspondence for at least one chosen pair, or to prove an
additional sufficiently strong restriction on the locus of its possible
genus-two targets. No theorem here supplies that final step.
