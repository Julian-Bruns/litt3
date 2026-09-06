# One finite étale cover destroys every ordinary nilpotent datum on a fixed curve

Date: 2026-09-05. Author: /root.
Audit: PASS, /root/all_ordinary_data_killed_finite_cover_audit, 2026-09-05.
[Scoped audit and non-breaking qualifications](audits/ALL_ORDINARY_DATA_KILLED_ON_ONE_FINITE_ETALE_2_COVER_AUDIT_2026_09_05.md).

Here “ordinary” always means Mochizuki's ordinariness for nilpotent
indigenous projective bundles, not the different ordinary-dormant-oper
condition. All curves and indigenous bundles are unmarked.

## Theorem

Over an algebraically closed field of characteristic five let

    X: y² = x⁵ − x,    η = dx/y.

There is a connected finite étale Galois cover V → X with a 2-group as
Galois group such that the pullback of every ordinary nilpotent indigenous
PGL2 bundle on X is nonordinary on V. These pullbacks remain nonordinary
on every further connected finite étale cover of V.

More precisely, X has seventy such ordinary objects. Each of ten of
them becomes nonordinary on a degree-two étale cover; each of the other
sixty becomes nonordinary on a degree-four étale cover.

This does not assert that V has no ordinary indigenous bundles of its
own. It proves neither that V fails to lift, nor that two curves lack
a common étale cover.

## 1. The finite pool and its two orbits

The [complete unmarked quartic pool](GENUS_TWO_HYPERELLIPTIC_INDIGENOUS_INVARIANCE_AND_COMPLETE_UNMARKED_QUARTIC_POOL.md)
consists of seventy tensors A satisfying

    C_3(A⁴) = A,       div(A) = 2D,    D reduced.

Ten are squares of quadratic differentials, and sixty are nonsquares.
All seventy corresponding indigenous projective bundles are ordinary.
The construction is intrinsic: their square Hasse invariant is −A.
Thus distinct normalized tensors give distinct projective objects.

For completeness, ordinary nilpotent indigenous objects are exhausted
by this pool, not merely included in it. A dormant object has zero
p-curvature and zero square Hasse invariant, so the induced Frobenius
on H¹(X,T_X) is zero; it is not ordinary in the convention used here.
An ordinary nilpotent object is admissible by Mochizuki II, Proposition
3.2. For an unmarked admissible active object, the Bouw–Wewers
deformation-data classification has no spikes and has local signature
1 at ordinary points and 3/2 at supersingular points. Its normalized
quartic consequently has divisor 2D with D reduced. Conversely these
quartics give the unmarked admissible objects.

These implications and the operator convention are recorded in the
[inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md)
and the [primary-source identification](CARTIER_EIGENFORMS_AS_MULTIPLICATIVE_DEFORMATION_DATA.md).
In particular ordinariness is equivalent to invertibility of

    T_A: H⁰(X,ω_X²) → H⁰(X,ω_X²),    q ↦ C_1(Aq).

This is a semilinear operator. It commutes with étale pullback.

The sixty nonsquares form one automorphism orbit, as proved in the
complete-pool note. The ten squares also form one orbit: they correspond
to the ten unordered conjugate pairs in P¹(F₂₅) outside P¹(F₅).
The affine subgroup x ↦ ax+b, with a in F₅* and b in F₅, is already
transitive on the twenty non-F₅ points. Every PGL₂(F₅) transformation
of the six branch points lifts to X over the algebraic closure.
Naturality and uniqueness of normalization identify the transformed
quartics, without a remaining scalar choice.

## 2. A degree-two witness for the square orbit

Take the normalized quadratic

    q₀ = 2(1+x+2x²)η²

and its square

    A = q₀² = (x⁴+x³+3x+4)η⁴.

Its quadratic polynomial has nonsquare discriminant 3 in F₅, so its
zero divisor is reduced. The quadratic certificate proves its
normalization and ordinariness.

Let

    T: v² = u⁸−1,    x=u²,    y=uv,    ρ=du/v.

The map T → X is connected and étale: it adjoins a square root of x,
whose divisor is 2P₀−2P∞; its associated nontrivial 2-torsion class
is represented by the branch pair {0,∞}. Here g(T)=3 and η pulls
back to 2ρ. The pulled-back quartic is

    A_T = (u⁸+u⁶+3u²+4)ρ⁴.

The quadratic differential vρ² is nonzero and regular. At finite
branch points ρ is a unit and v vanishes; at the two points at
infinity ρ has order 2 and v has pole order 4. Directly,

    T_(A_T)(vρ²)
      = ρ C((u⁸+u⁶+3u²+4)du)
      = 0.

Indeed none of the exponents 8,6,2,0 is 4 modulo 5. The first equality
uses the local formula C_1(Fρ⁶)=ρ C(Fρ) and vρ=du.
Thus A becomes nonordinary on T. Composing this map with suitable
automorphisms of X supplies a degree-two witness for every square
member of the pool.

## 3. A degree-four witness for the nonsquare orbit

Choose t with t²=2 and use the ordinary normalized nonsquare

    A₀ = (tx+3x²+3tx³)η⁴.

The [explicit degree-four failure certificate](ORDINARY_NONSQUARE_INDIGENOUS_DATUM_FAILS_ON_ETALE_DEGREE_FOUR_COVER.md)
proves that the smooth projective normalization of

    Y: v²=u⁸−1,     z²=(u−1)(u−3t)

has a connected étale degree-four map to X given by

    x = u²/(2u²+1),       y = uv/(2u²+1)³.

This is a tower of two étale double covers followed by an automorphism
of X. The second cover is étale because {1,3t} is a nontrivial even
subset of the eight branch points of T; its defining square class
has even valuations everywhere. The genus of Y is five.

On Y the nonzero regular quadratic

    (v/z)(u+2+4t)(du/v)²

belongs to the kernel of T_(A₀|Y). The exact scalar certificate computes
the relevant block, before inverse Frobenius, as

    [3+2t  3+4t]
    [1+2t  2+2t],

with kernel vector (2+4t,1). The other blocks are invertible; the
whole quadratic kernel has dimension one. Only existence of this
kernel is needed here. Automorphism transitivity supplies a witness
for each of the sixty nonsquares.

## 4. Finite-family destruction lemma

The following elementary mechanism is not particular to X or to
seventy data.

Let C be a smooth connected projective curve, and let A₁,...,A_r be
quartics on C in characteristic five. Suppose that for every i there
is a connected finite étale cover C_i → C and a nonzero quadratic
q_i on C_i such that

    T_(A_i|C_i)(q_i) = 0.

Then a connected component V of the fiber product of the C_i over C
is a finite étale cover of C on which every pulled-back operator has
a nonzero kernel.

To prove this, its projection V → C_i is finite étale and nonempty.
Its image is open and closed in connected C_i and is therefore all
of C_i. Pullback of a nonzero differential along a separable
surjective map is injective, and Cartier commutes with étale
pullback. Thus q_i pulls back to a nonzero kernel vector on V.
Exactly the same argument proves persistence on every further
connected étale cover of V.

If the Galois closures of all C_i → C have groups in a class closed
under finite products and subgroups, V may instead be chosen as the
connected Galois cover corresponding to their compositum. Its group
is a subgroup of the product of the closure groups and belongs to
that class.

In our examples every degree-two witness is Galois with group C₂.
Every degree-four witness is a tower of two double covers, so its
Galois-closure group embeds in the imprimitive wreath product
C₂ wr C₂, a group of order eight. Hence all the closures have
2-groups as groups. Applying the lemma to all seventy witnesses
proves the theorem.

## 5. Strategic scope

This is a characteristic-five obstruction to a specific proposed
method: a finite supply of ordinary nilpotent data on an endpoint
does not ensure that at least one stays ordinary on every étale
source. On this fixed endpoint, one cover simultaneously destroys
the whole supply.

The theorem does not settle whether an unknown minimal common source
has a compatible ordinary datum, nor whether either proposed Litt
endpoint has the same behavior. Conditional simultaneous lifting
requires an ordinary common datum on the actual source; that
hypothesis cannot simply be removed by choosing among a finite
endpoint list.

There is no conflict with preservation for Galois 5-group closures
in the [simple-monodromy-factor theorem](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md).
The witnesses here have 2-group monodromy.
