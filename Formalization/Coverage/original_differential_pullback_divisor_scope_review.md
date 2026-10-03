# Original differential order and divisor transport

Scope review, 3 October 2026. The three new CartierAndSpin files prove
actual rational differential order and divisor transport, building on the
accepted original differential divisor/frame chain. This is a review of
the new implications and their hypotheses; it does not replace an
independent mathematical readback.

`DVRDifferentialOrderPullbacks.lean` has two exact results. The nonzero
pullback theorem applies to any formally-etale commutative coefficient
square with two fields and a genuine original rank-one coordinate. It
requires neither DVRs nor finite type. The order theorem applies to
actual local formally-etale, essentially finite-type maps of DVRs with
their original fraction fields. Its target integral frame is arbitrary.
Actual universal differential base change constructs a compatible frame;
the already proved original integral-unit frame change removes that
frame choice. The proved original unramified valuation law then gives
the entire integer order, with the established positive-zero convention.

`SmoothEtaleDifferentialDivisors.lean` first derives original rational
pullback injectivity and nonvanishing for finite-etale surjective scheme
maps over any field, requiring only that the target structure morphism
is a smooth curve. Its original rank-one coordinate comes directly from
the actual smooth generic differential rank, without a perfectness or
transcendence-degree premise. The full order theorem concerns two smooth
integral curves over an algebraically closed field, in every
characteristic, at every original closed source point. The actual stalk
square, formally-etale algebra, local map and DVRs are derived from the
actual morphism. No assumed differential or valuation compatibility is
used. A nonzero-proof parameter in the order theorem is only the proof
needed to form a nonzero differential's order; pullback nonvanishing is
separately derived in the same file.

With both spaces compact, the original differential divisors have finite
support by the accepted original finite zero/pole results. Extensionality
and the entire original order equality prove
`div(f*omega) = schemeDivisorPullback f (div(omega))`. The divisor theorem
constructs its own pullback nonzero proof. Properness, canonical degree,
Riemann–Roch and genus are absent from its hypotheses and conclusions.

`SmoothEtaleSpanDifferentialDivisors.lean` retains the actual
`FiniteEtaleSpan`, both morphisms and the same source, and proves both
original divisor pullback identities. It derives source smoothness from
the left original map and uses the literal over-base equality for the
right. Source and endpoint compactness are explicit. It neither replaces
the maps by function-field labels nor decides existence of a common cover.

Focused `verify.py` run passed: 862 transitive Litt3 declarations,
build and audit return code zero, only `Classical.choice`, `Quot.sound`
and `propext`, zero forbidden dependencies or changed sources. Evidence:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T120858Z/report.json`.

| File | SHA256 |
| --- | --- |
| `Solutions/CartierAndSpin/DVRDifferentialOrderPullbacks.lean` | `6d874f8f6cdd206c8e13591a85031663c397998c9b1009ff7c4335ce7da5e7eb` |
| `Solutions/CartierAndSpin/SmoothEtaleDifferentialDivisors.lean` | `85a1edb6aca6cde8e43cdcb3c7ae144b19963af3c234292f4fb2385269e2354d` |
| `Solutions/CartierAndSpin/SmoothEtaleSpanDifferentialDivisors.lean` | `ae7f600578f8ab6c10a2a2ea786ea1d3246880c7de829befcbc6e3bdca4dd22d` |

The original canonical sheaf/divisor identification and categorical
differential pullback isomorphism are separate work. Canonical degree,
Riemann–Roch and the unmarked common-cover problem remain unresolved by
these declarations.
