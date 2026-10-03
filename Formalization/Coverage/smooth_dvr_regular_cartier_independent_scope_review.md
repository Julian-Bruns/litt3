# Independent smooth-stalk and regular-Cartier scope review

Reviewed by the Cartier/spin owner, 3 October2026. This is a bounded
mathematical readback, separate from the root's upcoming build/axiom audit.
No reviewed module was edited and no settled numerical checks were rerun.

The seven requested terminal modules were read in full:
`SmoothLocalCotangent`, `SmoothLocalizationDVR`,
`SmoothSchemeLocalCharts`, `SmoothCurveDVRStalks`,
`SmoothCurveCompletions`, `DVRRegularDifferentials`, and
`DVRCartierDifferentials`, all in `Solutions.SharedTensors`.
The specific conormal-sequence and DVR TFAE lemmas in Mathlib were read,
as were the coefficient-residue, completion-regularity, intrinsic-Cartier,
regular-lattice and p-basis derivative-transport imports needed to assess
the new implications. No substantive scope defect was found.

The local cotangent equivalence is the literal m/m² module and actual
residue tensor of Ω(k,R). Surjectivity of k→κ gives a coefficient-field
isomorphism; it supplies vanishing H¹(k,κ) and Ω(k,κ), respectively proving
injectivity and surjectivity in the actual conormal sequence. Extension
of scalars through the surjective residue map yields the correct κ-linear
equivalence. Rank-one actual Ω over a Noetherian local domain then gives
cotangent dimension one and the genuine DVR by Mathlib's exact TFAE.
The field case is excluded by that exact criterion, not silently treated
as a DVR.

The localization theorem constructs Noetherianity from the standard
smooth finite-type chart, formal étaleness of its arbitrary localization,
formal smoothness over k, and the actual Ω base-change equivalence.
Rank and freeness are derived from true relative dimension one; local
finite presentation or DVR structure are not input. Domain and rational
residue hypotheses are explicit at this algebraic level.

The scheme theorem obtains a true standard smooth affine chart from
`IsSmoothOfRelativeDimension 1 sX`. The base affine open is all of Spec k
because it contains the image of the selected point. Every coefficient
map is induced by the original structure morphism. A closed source point
gives a maximal chart ideal; actual finite-type residue arithmetic over
algebraically closed k and the original coefficient-preserving stalk
equivalence construct residue surjectivity. The actual integral scheme
supplies the stalk domain. The resulting DVR family ranges only over
actual closed points, and preserves the actual stalk and function field.
Properness is unnecessary for these local conclusions. This part works
in arbitrary characteristic and does not assume a common cover or closure.

Completion parameters contain only an actual irreducible uniformizer
and the actual residue-coefficient surjectivity; both are constructed for
the smooth closed stalk. An entire completion isomorphism is not a field
of that structure. The imported completion embedding and its normalized
valuation compatibility are constructed. The reverse regularity test
descends from full completed power-series membership to the original
DVR using its genuine valuation integer-ring criterion and uniqueness
of its height-one place. Thus original regularity is not replaced by
completed regularity.

`DVRRegularDifferentials` identifies the image of the literal map
Ω(k,R)→Ω(k,K), not an assumed free lattice. The derivative of an original
regular function is proved to have original regular coefficient by the
full p-basis transport to the constructed Laurent field and the true
power-series derivative. The forward image implication uses the actual
generation of Ω(k,R) by universal differentials; the reverse implication
constructs r·d(parameter) inside the original Ω(k,R). Its coordinate
equivalence and normalization are explicit at this intermediate level.

`DVRCartierDifferentials` constructs that normalized coordinate through
the previously checked intrinsic-Cartier coefficient theorem, applies
the actual coefficient-extraction formula to the entire completed power
series, descends regularity back to R, and uses the genuine image
equivalence in both directions. Its conclusion is preservation of the
original universal-differential image. Cartier regularity is not assumed.

The differential/Cartier portion explicitly requires prime positive
characteristic, perfect base field and the original function field's
finite generation and transcendence degree one. It makes no characteristic
zero assertion about algebraic Ω of an infinite Laurent series field.
The underlying smooth-stalk/DVR construction is broader and remains valid
in arbitrary characteristic. These distinct scopes are represented correctly.

This review accepts the new mathematical implications within those exact
hypotheses. It does not certify the upcoming trust audit, complete unrelated
global sheaf/gluing arguments, or solve the unmarked common-cover problem.
