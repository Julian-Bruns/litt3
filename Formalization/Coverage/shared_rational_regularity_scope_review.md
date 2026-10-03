# Actual shared rational differential regularity

This is a proved component of `saturated_divisor_relations`, not completion of that full canonical source and not a solution of the unmarked common-cover problem. The implementation preserves both actual finite etale surjective maps from their SAME original smooth integral source.

## Exact terminal scope

`Solutions.CartierAndSpin.SharedRationalDifferentialRegularity.actual_no_clump_shared_rational_differentials_regular` assumes an algebraically closed field of arbitrary characteristic, integral endpoint schemes with actual smooth relative-dimension-one proper structure morphisms, an actual `FiniteEtaleSpan`, an integral original source, the literal base-field triangle relating BOTH original maps, and `IsEmpty s.fiberClump`. It proves that the actual intersection of the two rational universal-differential images lies in the original source's closed-stalk regular differential intersection.

Every geometric bridge used in this implication is proved. There is no input asserting finite pole support, polar-support pullback equality, rank-one stalk coordinates, DVR stalks, valuation preservation, differential regularity or a global-section identification. Endpoint function-field generation and transcendence degree are derived from the original smooth schemes. Neither a field-intersection condition, genus bound, primitive generator, chosen simultaneous closure, characteristic-p condition nor marked reference choice is needed.

## Proved chain

| Module | Actual conclusion and scope |
| --- | --- |
| `Definitions.CartierAndSpin.SchemeDifferentialPoles` | Literal original closed points outside the image of their original universal differential stalk module. |
| `Solutions.CartierAndSpin.RationalDifferentialFinitePoles` | Every actual rational one-form on a quasi-compact smooth integral curve over an algebraically closed field has finite actual poles, in any characteristic. An actual normalized separating parameter writes it as `f dg`; two proved finite original principal-divisor supports contain its poles. Regular germs of `f` and `g` explicitly give an original stalk representative of `f dg`. |
| `Solutions.CartierAndSpin.SmoothStalkDifferentialCoordinates` | The entire original smooth stalk differential module has its actual relative rank, in any dimension and characteristic. In dimension one, an actual rank-one coordinate is constructed from genuine stalk freeness and rank. |
| `Solutions.CartierAndSpin.EtaleStalkDifferentials` | Genuine smoothness gives formal smoothness of every original stalk map. Together with actual etale formal unramifiedness this gives full original formally etale stalk algebras, without falsely requiring stalk finite presentation. |
| `Solutions.CartierAndSpin.FormallyEtaleDifferentialCoordinates` | Full universal modules base change through true formally etale algebras over arbitrary commutative rings. The coordinate formula, original-image criterion and compatibility through an actual coefficient square are conclusions. |
| `Solutions.CartierAndSpin.UnramifiedDifferentialLattices` | True local unramified essential-finite-type DVR maps reflect membership in the original coefficient ring and in the original universal differential lattice. Actual valuation compatibility is derived. No completed lattice replaces either original module. |
| `Solutions.CartierAndSpin.SmoothEtaleDifferentialRegularity` | Any actual finite etale surjective map of original smooth integral curves reflects and preserves rational differential regularity at every original closed source point. All rings, towers, frames, DVRs and compatibility are constructed. |
| `Solutions.CartierAndSpin.SmoothEtaleDifferentialPoleSets` | The literal pole set of the actual differential pullback equals the inverse image of the endpoint's literal pole set. This equality is proved, not assumed. |
| `Solutions.CartierAndSpin.SharedRationalDifferentialRegularity` | A genuine pole of a shared actual one-form constructs a nonempty actual finite clump from the two endpoint pole sets, whose same-source preimages are proved equal. Literal no-clump then forces all shared forms regular. |

The zero form is retained in the finite-pole theorem and has empty pole set. No numerical enumeration, prime-specific check, sampled matrix certificate or project-result axiom is used.

## Verification and boundaries

Focused audit of the terminal root: `../litt3-computation-data/formalization-20261003/verification/20261003T083338Z/report.json`. It built one root and audited 832 transitive Litt3 theorem declarations. Only `Classical.choice`, `Quot.sound` and `propext` occur; forbidden dependencies and changed sources are both zero.

`Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialRegularity` proves global original closed-stalk reflection using actual surjectivity on closed points, derived from the smooth source's Jacobson property. `SharedEndpointDifferentialRegularity` then proves regularity of BOTH endpoint representatives themselves in the no-clump case. `SharedGlobalDifferentialSections` proves that the shared rational intersection is exactly the shared rational images of ACTUAL endpoint global differential SHEAF sections and that every such form has an ACTUAL same-source global section. It uses the genuine `SchemeDifferentialClosedRecovery` theorem, whose independent mathematical review is in `original_differential_global_recovery_independent_scope_review.md`.

Focused audit of this enlarged H0 terminal root: `../litt3-computation-data/formalization-20261003/verification/20261003T083933Z/report.json`. It built one root and audited 895 transitive Litt3 theorem declarations, with only the same three standard logical axioms, zero forbidden dependencies and zero changed sources. This later evidence includes the three new wrappers; the earlier 832-declaration snapshot remains intact.

The canonical source additionally treats the finite-clump case using uniqueness and positive canonical degree, global invariant line bundles, Picard and group-scheme identifications, full torsion finiteness, and exact canonical-ratio height. Those claims are not asserted by this component. The true no-clump regularity gap is removed; the finite-clump and full canonical scope remain explicit.
