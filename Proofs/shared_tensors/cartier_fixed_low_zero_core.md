# Proof: low-zero Cartier-fixed forms and positive-genus cores

[Statement and audit metadata](../../Theorems/shared_tensors/cartier_fixed_low_zero_core.md).
The core is an explicit hypothesis of the main lemma. The final
simple-root consequence uses the separately audited
[canonical marked quotient](../quotient_geometry/canonical_marked_quotient.md).

## Low zeros make the core positive-genus

Use the [cored orbifold bridge](../quotient_geometry/cored_orbifold_bridge.md) to obtain
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

## Orthogonal Jacobians and the remaining boundary

Normalize a common nonzero Cartier eigenvalue to1. In characteristic
p≥5, simple zeros have order1<p−2. The canonical marked quotient
theorem supplies a core; the preceding low-zero argument makes its
genus positive. The actual maps X,Y→C give a
common positive-dimensional isogeny factor of JX,JY, contradicting
Hom(JX,JY)=0. A rational core alone would not give that contradiction.

The absence of a coreless simple-root tensor of any weight is the
separate canonical-quotient result. The
[fixed-X atlas theorem](../quotient_geometry/local_actions/fixed_x_orbifold_bound.md)
also records the complete exclusion of shared regular one-forms
in its coreless case. No invariant tensor is supplied by this argument;
other zero patterns and cored configurations need additional input.
