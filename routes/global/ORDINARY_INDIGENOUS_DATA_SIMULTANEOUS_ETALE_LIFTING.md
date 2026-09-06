# Ordinary indigenous data: conditional simultaneous étale lifting

Date: 2026-09-05. Author: `/root/deformation_data_etale_compatibility_sources`.
Status: exact primary-source compatibility theorem and a two-leg corollary;
ordinariness is an additional hypothesis, not established for our eigenforms.

Repository relationship: this is a fresh primary-source check of the
conditional mechanism already recorded in
[file 33](33_MOCHIZUKI_CANONICAL_LIFTING_LIMIT.md), especially its
Theorem 33.6 and Corollary 33.7, not a newly discovered lifting theorem.
The later [characteristic-five destruction theorem](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md)
shows why choosing among a finite endpoint pool cannot supply the
missing hypothesis in general. Lifting is not the active main route.

## Exact source and proof checked

Mochizuki, [*A Theory of Ordinary p-adic Curves*](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf),
Chapter III, Definition 2.9 and Theorem 2.10, PDF pp.111–112:
a finite log étale covering taking marked points to marked points respects
canonical modular Frobenius and canonical indigenous bundles **provided
the pulled-back special-fiber indigenous bundle is ordinary**. The base
in the stated theorem is log étale over the ordinary nilcurve stack,
formally smooth over Z_p, with normal-crossings log structure.

The proof inducts modulo p^i. Renormalized Frobenius and Lemma 2.6 identify
underlying bundles one level farther; their indigenous structures identify
the classifying maps. Lemma 2.5 then identifies the connections.

Chapter III, Theorem 3.2 gives unique canonical Witt-vector liftings of
nilpotent ordinary curve/bundle pairs. Corollary 3.4, PDF p.114, characterizes
a smooth pointed canonical pair by ordinary reduction and an MF-nabla
structure. Its proof uses the same uniqueness lemmas. Chapter II,
Definition 3.1 defines ordinariness by invertibility of the induced
Frobenius on H^1 of the logarithmic tangent bundle; Proposition 3.2 says
ordinary implies admissible.

## Two-leg consequence (deduction, preserving the specified source)

Let k be perfect of characteristic 5. Suppose the actual finite étale
maps f:Z→X and g:Z→Y have compatible reduced markings

    D_Z = f^*D_X = g^*D_Y,

and ordinary nilpotent indigenous bundles P_X,P_Y,P_Z, in Mochizuki's
pointed-curve sense, together with

    f^*P_X ≅ P_Z ≅ g^*P_Y.

Then there is a simultaneous finite étale lifting over W(k)

    X_can ← Z_can → Y_can

of these actual two maps, compatible with the canonical indigenous
bundles. In particular this is a characteristic-zero lifting restriction
on the original correspondence, not just separate existence of endpoint
lifts.

To see the same-source assertion directly, lift f over X_can by formal
étale invariance, and algebraize the resulting finite cover. Its
indigenous bundle is the pullback of the canonical bundle on X_can.
Étale pullback preserves the MF-nabla structure. Ordinary reduction and
Corollary 3.4 therefore identify this lifted source pair with the
canonical lift of (Z,P_Z). Carry out the same construction for g over
Y_can. Uniqueness identifies both source pairs with that same Z_can,
with the prescribed special-fiber identification. No extension of one
arbitrarily chosen curve lift across both maps is being asserted.

## What remains extra in the eigenform problem

The equality of normalized eigenforms supplies deformation data; applying
this corollary requires their indigenous counterparts to satisfy the
pointed-curve conventions above and to be ordinary on **all three**
curves. In particular active nilpotent does not supply the stated
ordinariness hypothesis. Markings cannot simply be enlarged while
assuming the bundle remains indigenous in the required sense.

Ordinariness cannot be omitted by a general étale-pullback principle:
Hoshi, [*Nilpotent Admissible Indigenous Bundles via Cartier Operators in
Characteristic Three*](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1811revised.pdf),
Theorem C / Corollary 5.4, proves that every ordinary nilpotent indigenous
bundle on a smooth proper genus-at-least-two curve in characteristic 3
becomes nonordinary on some connected finite étale cover. The proof
trivializes its Hasse defect, dominates a nonordinary curve cover, and
uses the Cartier criterion equating bundle ordinariness with ordinary
Jacobian in that trivial-defect case. This is a warning against a general
claim, not a characteristic-5 counterexample.

The theorem does not itself prove a common core, classify the lifted
correspondence, or rule out the present span. A further characteristic-zero
obstruction or an independent ordinariness criterion is required.
