# Independent original-global scalar and trace-different review

Reviewer: Cartier/spin owner. This is a bounded mathematical readback of
the twelve requested QuotientGeometry modules, including their complete
statements and proofs. The used ParameterDifferentValuation,
WeakOriginalDifferent, ParameterHomUniqueness, ParameterFieldMapUniqueness,
WeakTameOriginalRamification/Galois and original same-source scalar APIs
were also read. The previously accepted actual scheme-chart normalization
and full original-fiber completed-field comparison are reused as settled
dependencies. No owner's Lean source was changed.

| Module under Solutions.QuotientGeometry | Reviewed SHA256 |
| --- | --- |
| CharacteristicFiveGaloisGlobal | d3c5025851ff46ab4c389fd64a34655e9e8d0f6ee7c356b72d3bf2189c28e41c |
| CompletedDVRParameterIdentification | fa8b59431ece7214731597658e89041538afb240683c8da892ca73bb4df94aad |
| WeakDifferentGalois | ff6bc50619a07df04d0bbe76aad3fe52abd5c0a294cd79e7f597193bc7fd7b7d |
| WeakDifferentRamification | b1a3489f7cc0a87f437f4f8601cf662c59015ce22d1e6282a36a6dbd110f2f0b |
| SmoothStalkDifferentialInjectivity | e9e57fa5d6294f2173cda6b0172c9cd4abc0f4139faefc0474ea490a64cdc836 |
| OriginalDVRDifferentialFrame | 26dba281961d81a381e822fdc8cbe3f843830b0aace93cd878095df474036a37 |
| SmoothCurveDifferentialFrames | 1893b73322f6bae46e36f15e16047698778fc8e374206f11a9000c62a6fe4199 |
| SmoothRationalDifferentialIdentities | 43bb1e92fe6d3dd9c9901658d7c44acbdea7cab3a70204d8748335b5cbe2ed1a |
| SmoothGlobalDifferentialIdentities | 11ebfade51e366d501f7ae1d32bc6b488d35945fa9fd85782ce57630fcd4c0c3 |
| FunctionFieldStalkSquares | e258a482ab4d611e089cd764df52b16c2e63a2e3d94ea1d65010a3f20769f490 |
| RationalPolarStalkIdentities | e317d92af08600204552e4bd3260e386ebcf06528e980f8e292909dba510923d |
| GaloisSmoothGlobalScalars | 4b617c16b535b06682997529ae3f6ac1fd78439a0d7f5262a82491cbc911cbc6 |

## Original differentials and original stalk identities

`SmoothStalkDifferentialInjectivity` proves injectivity of the genuine
fraction-field differential map from freeness of the original module of
Kaehler differentials. It derives original stalk freeness from the actual
smooth relative-dimension hypothesis, using genuine smooth charts and
formally etale localizations. The terminal integral smooth Scheme theorem
therefore assumes no differential-injectivity or frame conclusion.

`OriginalDVRDifferentialFrame` has honest generic raw hypotheses: a true
DVR, its actual fraction field, perfect positive-characteristic constants,
finite generation and transcendence degree one, and injection of original
differentials. An actual completion parameter maps its uniformizer to the
literal Laurent parameter, proving that this uniformizer is not a pth
power. The checked p-basis coordinate gives normalized field differential
one. The actual integral differential lattice supplies surjectivity of
the original coefficient-times-differential map; injectivity supplies the
full module equivalence. A differential nonzero in the original residue
fiber has a unit coefficient, since a nonunit coefficient would put it in
the maximal-ideal multiple of the original module.

`SmoothCurveDifferentialFrames` derives all these raw DVR, generation,
transcendence-degree and injectivity inputs from an actual integral smooth
curve over an algebraically closed field in prime positive characteristic.
Its completion parameters represent a genuine choice of original
uniformizer and residue-compatible completion, not a supplied frame or
target slope. The resulting frame and unit slope belong to the ORIGINAL
stalk differentials.

`SmoothRationalDifferentialIdentities` descends literal rational
differential equalities to original stalks by the proved injectivity and
actual scalar towers. `SmoothGlobalDifferentialIdentities` uses the true
global-regular intersection: an original representative exists at every
closed point. Thus its universal nonvanishing hypothesis over those
representatives is nonvacuous, and injection makes the representative
unique. The actual unit slope and original local differential identity
are conclusions, not additional local hypotheses.

`FunctionFieldStalkSquares` establishes the pullback square for EVERY
original stalk element by specialization naturality. `RationalPolarStalkIdentities`
then descends the actual global polar equation to original stalks through
that square and fraction-field injection. The supplied germs are honest
restrictions of the stated rational functions; no local polar relation is
assumed.

## Whole completed maps and global Galois scalar

`CompletedDVRParameterIdentification` identifies the WHOLE completed ring
map associated with a local original DVR map. Localness gives constant
term zero of the actual parameter image. A finite-truncation proof shows
that any power-series homomorphism with this image is genuine substitution:
the full infinite remainder is a high parameter power and cannot affect
the coefficient being checked. No continuity hypothesis, polynomial-only
agreement or fixed finite jet is substituted for the full map. The
fraction-ring extension then identifies the entire Laurent map.

`GaloisSmoothGlobalScalars` keeps the actual same-source commutative
diagram. Its hypotheses include a finite etale surjective first leg, a
finite second leg with genuine unramified original stalk maps on the
selected fiber, and an ACTUAL Galois quotient field extension G/B. This
last hypothesis is an explicit marked source condition; it is not a
presumed simultaneous Galois closure of the two source legs. The original
smooth curves, global polar relation and global differential relation
produce the actual local polar and differential identities, unit slopes,
and completed parameter identifications. The settled full-fiber
comparison yields equal local scalar for any pair of original points in
the stated fiber. No target scalar equality, local identity, unit slope or
completed isomorphism is supplied by the caller.

`CharacteristicFiveGaloisGlobal` specializes p=5, h=4 and m=7. Its finite
arithmetic checks establish only these fixed numerical hypotheses. The
scalar equality is then translated to the literal original-fiber equation
G1(R)^2 S1(R)^5 = G2(R)^2 S2(R)^5, where S1 and S2 are actual original
sigma/dF unit slopes. The scalar exponent is 5-7=-2 and m/h=3 in the
characteristic-five constant field. Nonzero factors come from actual
units and the stated nonzero constant. No extra fiber normalization or
enumerative geometric computation enters this implication.

## Genuine trace-defined different and full ramification

The different statements concern an actual parameter substitution
b=X^(p*h)*c, with c a genuine unit power series, h positive and dividing
p-1, and the corresponding actual finite separable Laurent extension.
Their input is the literal Mathlib trace-defined `differentIdeal` equal
to the ideal generated by X^(p*h+p-2). It is not an opaque definition of
the desired derivative order, root model, group or filtration.

The used `ParameterDifferentValuation` constructs the full completed
power basis, integral closure, actual fraction-field tower and degree.
The actual trace different is the ideal of the minimal-polynomial
derivative; the actual defining parameter relation identifies it with
the ideal of b'. Consequently the supplied different equality forces
nonzero b' with exact Laurent order p*h+p-2.

`WeakOriginalDifferent` extracts an actual tame hth root psi of b^-1 and
derives orders psi=-p and psi'=-2 using the genuine Laurent derivation.
Its normal form retains the ENTIRE regular power-series tail.
`WeakDifferentGalois` identifies the literal original full-field
substitution extension with the irreducible weak pole-polynomial model,
then proves that this actual extension is Galois. No weak root or Galois
conclusion is an input.

`WeakDifferentRamification` transports the normalized affine semidirect
action through compatible full ring/field coordinate maps. It gives an
actual group isomorphism with the full group of fixed-embedding
automorphisms, preservation of every Laurent order, and the original
all-integral lower ramification filtration: G0 is the full group, G1 has
order p, and every Gn for n at least two is trivial. The filtration is
defined on ALL integral elements; a single parameter test is proved
equivalent rather than presumed. Whole infinite regular tails and all
negative Laurent orders remain covered.

## Scope and verdict

The implications are mathematically sound at their literal scope. No
circular target premise or missing local/global construction was found.
The different-to-Galois theorem concerns the actual completed parameter
extension; an additional original-scheme-to-trace-different formula is
not asserted by it. The global scalar theorem assumes the stated marked
Galois quotient diagram and actual rational functions/differential; it
does not produce those data, assume both arbitrary legs are globally
etale, or solve the unmarked common-cover problem.

The owner's transitive audit at
`../litt3-computation-data/formalization-20261003/verification/20261003T063227Z/report.json`
reports 1,331 checked declarations, only Classical.choice, Quot.sound and
propext, zero forbidden dependencies and zero source changes. This card
records the independent mathematical readback, not a redundant rebuild.
A changed reviewed hash requires rereading the affected implication.
