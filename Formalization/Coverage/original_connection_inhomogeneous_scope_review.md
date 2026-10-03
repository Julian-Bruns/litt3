# Original scalar-root gauges and inhomogeneous differential equations

Five new modules build and pass the two-root [focused audit487](../../../litt3-computation-data/formalization-20261003/verification/20261003T112717Z/report.json). The roots are OneVariableScalarRootGauge and OneVariableIntrinsicInhomogeneous. The audit checks all 487 transitive Litt3 declarations, only Classical.choice, Quot.sound, propext, with zero forbidden dependencies and zero captured source changes. All 83 current captured hashes, including the five new files, match the report. Independent mathematical acceptance remains separate. No canonical whole-source promotion is made.

## Original scalar-root normal form

OriginalConnectionScalarRootGauge works for any actual derivation D of a field K over an arbitrary commutative ring R, in any prime characteristic p, with an actual full single p-basis and D(t)=1. Let c=D^(p−1)(f)+f^p. If a belongs to the **literal Frobenius-image subfield Kp** and a^p=−c, the theorem constructs an actual original field unit u and proves, for **every x∈K**, the whole original connection identity
L_f(u*x)=u*(D(x)+a*x).
It derives D(a)=0 from actual pth-power membership, proves the positive derivative iterates of −a vanish, and compares the exact curvature of f with that of −a. The earlier genuine original-field unit-gauge construction then produces u. Characteristic two is retained without an odd-prime sign shortcut. K need not be perfect; finite dimension over R, an intertwining unit, a matrix normal form and a scalar-extension solution are not assumed. This realizes the scalar-root branch of the actual commutant classification by multiplication in the **original** field.

OneVariableScalarRootGauge derives the full p-basis when K is actually finitely generated of transcendence degree one over perfect characteristic-p constants k. The original derivation base R may differ from k; no scalar-tower compatibility or finite degree over R is inserted. The original normalized derivation and entire connection functions are retained.

## Whole inhomogeneous field equation

ConnectionInhomogeneousSolvability first starts with an actual original field unit u satisfying D(u)=f*u. It proves the precise full-field criterion
∃v∈K, L_f(v)=g iff rationalCartierCoefficient_b(g/u)=0.
The forward implication gauges v to v/u and proves its derivative is g/u, then uses actual Cartier annihilation of every derivative. The reverse implication constructs an original primitive w with D(w)=g/u from the full actual p-basis expansion and sets v=u*w. The primitive theorem is not restricted to a polynomial or a truncated matrix space. The companion result constructs u from **zero actual curvature**, obtaining the criterion simultaneously for every g; no gauge, cokernel functional or primitive is supplied.

This generic result uses a full actual p-basis and normalized genuine derivation over any commutative coefficient ring. It asserts original-field solvability, with no regularity, pole bound or H0 conclusion. Its zero-Cartier condition uses the true coefficient extraction from the literal Frobenius-image field; it is not an opaque predicate assigned to solvability.

## Actual universal differential equation

IntrinsicConnectionInhomogeneous transports that criterion to the **true universal differential module** Ω_(K/k), an actual normalized rank-one universal coordinate, and an actual intrinsic Cartier operator C. For every actual Cartier-fixed ω it constructs an original field unit u with the literal original differential identity
d(u)=u*ω.
For **every original rational differential η** it proves
∃v∈K, d(v)−v*ω=η iff C(u^(-1)*η)=0.
The section equation is an equality in the actual Ω module. The proof verifies the entire coordinate equality with the original connection, derives the scalar primitive criterion, and converts the zero coefficient back through the actual intrinsic Cartier coordinate formula and coordinate injectivity. Neither the differential identity, primitive, Cartier test nor unit is a hypothesis. The generic full-p-basis/coordinate inputs are explicit and K need not be perfect.

OneVariableIntrinsicInhomogeneous removes all p-basis, coordinate and Cartier-existence inputs for a genuine perfect-constant one-variable field, using actual finite generation and transcendence degree one. Its only form-specific input is that the **constructed actual intrinsic Cartier** fixes ω. The output and all η-quantification are entirely coordinate-free original universal differential equalities; all gauges and solutions live in K. No accepted literature interface is needed for Cartier existence or the logarithmic/inhomogeneous conclusion.

## Exact pins and boundary

The five current hashes in audit487 are:

| Solution module | SHA256 |
| --- | --- |
| OriginalConnectionScalarRootGauge | c6dc2ddcb5655b919588e7dcb12d6423f75355a3c2555476c0d135aec66c9fa1 |
| OneVariableScalarRootGauge | 829dfacd2e9f552d2e6dae6d51f9c8f71a262d673451156ff2957aaf49efc709 |
| ConnectionInhomogeneousSolvability | 886e233fbaaaaa93f8b571392b6ad48383fcbb7d1b8d1f798c328d698575956e |
| IntrinsicConnectionInhomogeneous | cfbb190af0382e4ca8bb0c16c38e29d1efa6d7fa9bb761a7d84e48468d035b0a |
| OneVariableIntrinsicInhomogeneous | 927f6ebcae6290cc302bf310d84f7a1ae3f98d6da68845801087903607de5515 |

These are symbolic uniform-prime proofs. No sample matrix, oracle or finite numerical certificate is used. They do not assert solvability by regular global functions, regularity of the constructed unit, a divisor bound for a primitive, global H0 bijectivity, cohomological Cartier duality or a common-cover decision. Those extra geometric restrictions require separate proofs.
