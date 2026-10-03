# Actual global divisor sheaves and derived local frames

The terminal `Solutions.Jacobians.SmoothCurveDivisorLocalFrames` constructs the genuine valuation-bounded rational-function sheaf O(D) on an original integral scheme and proves its local triviality on an actual smooth quasi-compact curve over an algebraically closed field. Every characteristic is included. Properness is sufficient but unnecessary. The terminal assumes only the actual smooth relative-dimension-one structure morphism, integrality and quasi-compactness; it derives original closed DVR stalks and finite principal support.

The ambient rational-function sheaf is the honest skyscraper sheaf of the actual function field at the actual generic point, restricted as a module along the original structure-sheaf map. At every actual open U, O(D)(U) is the genuine submodule whose original closed-point germs satisfy v_x(f) ≤ exp(D_x). Actual restriction maps preserve these bounds; local membership and the ambient sheaf gluing prove the full sheaf condition. An empty open is included throughout.

For O(0), closed-point valuation bounds imply original stalk regularity. Every original point of an actual smooth curve is closed or generic, so these are all original stalk conditions. Original structure-sheaf gluing on the actual open then constructs a genuine section. This proves O(0) is isomorphic to the original structure-sheaf module on every open, with no supplied section-surjectivity or frame hypothesis.

For an original rational-function unit f, literal multiplication by f and f⁻¹ on the entire rational-function sheaf give O(D) ≅ O(D − div(f)). The original normalized principal coefficients prove the required bounds. At an original closed point x, a genuine original DVR uniformizer and integer powers construct f with ord_x(f)=D_x. The finite closed-point support complement of D−div(f) contains x. The generic point is not closed and lies in every such support complement. Equality of the actual divisor coefficients there gives an isomorphism on the ENTIRE restricted original open site. Composing with O(0)≅O_X proves local freeness of rank one at every original point.

The principal shift also proves O(div(f))≅O_X directly for every actual quasi-compact smooth curve. No chosen local coordinates, residue identifications, supplied chart normality, formal Laurent expansions, local frames, Cartier input, properness, or enumeration of curve points are needed in the terminal hypotheses. The proof uses structural algebra and true sheaf gluing; it has no exhaustive computation.

The construction is weaker on an arbitrary integral scheme with supplied closed DVR stalks: it still gives the genuine valuation-bounded subsheaf, but local freeness is asserted only after the original smooth-curve point strata and quasi-compact finite-support bridges are proved. No proper global pointwise tensor-sections sheaf condition, geometric Picard group, Jacobian realization, Riemann–Roch dimension theorem or classification of all line sheaves is inferred here. The affine Dedekind fractional-ideal comparison is subsequent work.

The kernel-checked terminal focused audit is [20261003T090740Z report](../../../litt3-computation-data/formalization-20261003/verification/20261003T090740Z/report.json): one terminal root, 415 transitive Litt3 theorem declarations, only Classical.choice, Quot.sound and propext, zero forbidden dependencies and zero changed sources. Earlier focused reports are 084852Z (95 declarations), 085111Z (103), 085818Z (298), and 090111Z (312), all PASS under the same axiom and source-stability checks. The terminal report contains exact hashes for every transitive local source.

Main new source chain:

- ActualSchemeRationalFunctionSheaf; ActualRationalFunctionEvaluation.
- ActualSubmodulePresheaves; ActualSubmoduleSheaves; SchemeSectionValuationBounds.
- SchemeDivisorOpenSubmodules; SchemeDivisorSheaves.
- OriginalOpenFunctionRegularity; SmoothCurveOpenRegularity.
- ZeroDivisorStructureMaps; ZeroDivisorSheafIsomorphisms; SmoothCurveDivisorSheaves.
- RationalFunctionSheafScalars; RationalFunctionSheafScalarAlgebra.
- DivisorSheafRationalMultiplication; PrincipalDivisorSheafValuations; PrincipalDivisorSheafIsomorphisms; SmoothCurvePrincipalDivisorSheaves.
- ClosedStalkRationalUniformizers; DivisorSupportOpens; DivisorSheafRestrictions; SmoothCurveDivisorLocalFrames.

Independent mathematical readback is requested separately; the audit establishes build and trust dependencies, not independent acceptance of the mathematical scope.
