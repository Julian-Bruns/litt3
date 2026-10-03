# Independent review: actual divisor-sheaf principal kernel

The root reviewer read all eight sources in the generator-to-principal-kernel
chain, independently of their author. Their exact SHA256 values match
`../../../litt3-computation-data/formalization-20261003/verification/20261003T093903Z/report.json`:

- `DivisorSheafTrivialSectionGenerators`: `3d7c6727ccb009758cff0f704b6353d3a12061e5ea7a0c8530a3979eca3a171a`.
- `DivisorSheafGlobalGenerators`: `6d419ccf4ab7134fded7668f6611dbb51b0e71ef1f4de364b973337048aac4f9`.
- `FractionalIdealUnitGenerators`: `d7fd981210f35dc14460d9cc19ceb3252702ff012b10e962821e10bb3a8e9028`.
- `AffineDivisorTrivialGenerators`: `b27389133515c97cb14f0c945bd7c15d3a715c3afb372d6f1f2e8ba4724cba0e`.
- `AffineDivisorTrivialOrders`: `85b03f3911c8b3c18ab8d15f68c256db6c1f5c6385b4d9a121fac763901248fd`.
- `SmoothCurveTrivialDivisorOrders`: `f02e04502535abfc02b75a032b3d55164a278e27360c5bb90f7de2646e293f25`.
- `SmoothCurveDivisorSheafPrincipalKernel`: `da4bdca1955288c2d4628e003d6dce42b9b4a9dd8f0ae3df1f9c44bd0f3fc29f`.
- `SmoothCurveDivisorClassSheaves`: `e8ad7876299fa261a0399e9a180ceeee3247b91b40b5c07b60aecb855840e452`.

A genuine sheaf trivialization supplies the inverse image of the ORIGINAL
unit section. Original restriction naturality gives one nonzero rational
function with the same original value on every nonempty open. The actual
affine-section / fractional-ideal equivalence preserves that value and
the original scalar action. Thus the actual ideal generator is this same
global function. Literal Dedekind factorization gives its order -D at
every original closed point. Its inverse has divisor D. Quasi-compactness
is needed for finite principal support, not for the pointwise order theorem.
The reverse implication is genuine rational multiplication with the
already checked O(D) sign convention.

The terminal equivalence holds on any actual integral quasi-compact smooth
relative-dimension-one scheme over an algebraically closed field in ANY
characteristic. Properness, local generators, valuation compatibility,
principal-divisor equality and Picard identification are not premises.
The class wrappers identify zero and integer torsion of the ORIGINAL
divisor-class quotient with genuine triviality of O(D) and O(ND).
They do not claim a tensor-power comparison from global sections.

The statements, constructions and scopes are accepted. The focused audit
passed 550 transitive Litt3 theorem declarations with only
`Classical.choice`, `Quot.sound` and `propext`, zero forbidden dependencies
and zero changed sources. No independent build replay was needed. The
classification of ALL invertible sheaves, global tensor coherence,
geometric Picard/Jacobian and proper cohomology remain separate gaps.
