# Proof: shared simple-root tensors and positive-genus cores

[Statement and audit metadata](../Theorems/Thm_shared_tensor_core.md).
The all-weight assertion uses the separately audited
[canonical marked quotient](Sol_canonical_marked_quotient.md);
the positive-genus argument has its own retained audit.

## 1. A shared reduced canonical marking supplies the core

The canonical-quotient theorem identifies the two endpoint quotients
and makes their normalized joint image a component of X×_S Y.
The coarse field k(S) therefore embeds in BOTH endpoint fields
inside k(Z), proving that their intersection has transcendence degree1.
This works for every weight d, with wild inertia and non-Galois legs.
No Jacobian hypothesis or covering-degree bound is needed.

## 2. Low zeros of a Cartier-fixed form make that core positive-genus

Use the [cored orbifold bridge](Sol_cored_orbifold_bridge.md) to obtain
a finite étale W→Z Galois over both endpoints. Put
A=Gal(W/X), B=Gal(W/Y), G=⟨A,B⟩ and C=W/G.
The shared form α_W is G-invariant and descends to a rational form β
on C, whose function field is the core. Separability makes pullback
injective and compatible with Cartier, hence Cartier(β)=β.

Cartier strictly decreases every pole order greater than1: in a local
Laurent expansion only exponents congruent to−1 modulo p survive,
and z^(pn−1)dz maps to z^(n−1)dz. Thus β has at most simple poles.

At a supposed pole, the pullback order is δ−e, where e is inertia
order and δ the different. Tame inertia gives−1, contradicting
regularity. Wild inertia gives

    δ≥(|I_0|−1)+(|I_1|−1)≥e+p−2,
    ord(α_W)=δ−e≥p−2,

contradicting the strict zero-order hypothesis. This remains valid
with a nontrivial tame complement; δ−e≥e−2 is NOT assumed.
The étale W→Z preserves all zero orders. Therefore β is a nonzero
regular form on C and g(C)≥1.

## 3. Orthogonal Jacobians and the remaining boundary

Normalize a common nonzero Cartier eigenvalue to1. In characteristic
p≥5, simple zeros have order1<p−2. Section1 supplies a core and
Section2 makes its genus positive. The actual maps X,Y→C give a
common positive-dimensional isogeny factor of JX,JY, contradicting
Hom(JX,JY)=0. A rational core alone would not give that contradiction.

In particular a coreless span cannot preserve a simple-root tensor
of any weight. The [fixed-X atlas theorem](Sol_fixed_x_orbifold_bound.md)
also records the complete exclusion of shared regular one-forms
in its coreless case. No invariant tensor is supplied by this argument;
other zero patterns and cored configurations need additional input.
