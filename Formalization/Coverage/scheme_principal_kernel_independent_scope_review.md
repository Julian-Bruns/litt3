# Independent actual-scheme principal-kernel review

Reviewer: Cartier/spin owner. This is a bounded mathematical readback of
five root-owned solution modules and their used geometric/algebraic APIs;
it is not a replacement for their transitive Lean axiom audit.
All five complete source files were read, together with the actual
Dedekind-chart/support proofs, constant-field compatibility, principal
divisor definition, normalized DVR integer-ring bridge, and the used
Mathlib universal-closed/global-integrality and sheaf-gluing theorems.
No root Lean file was modified.

Reviewed hashes:

| Module under Solutions.SharedTensors | SHA256 |
| --- | --- |
| SmoothCurveFiniteSupport | 66462582e208b986ddea25e85792f08067bbb74345304a76dce46b0f4a78ca0c |
| SmoothCurvePointStrata | 2e9aca5f31fdbdf2ea66542fca23e26d54d06d764c4e626ca506fd1523c0efc0 |
| IntegralSchemeGlobalFunctions | df806ac04a91a6f28a8f4c20ae18f5c29c2d83bcafcad6ae04b9ad9caef7547f |
| ProperSchemeGlobalConstants | 6d7d1f4aac953e9a87e053b12f3caf4ed075e03f9e976731d449db8f44a59298 |
| SmoothCurvePrincipalKernel | f8a77c113f9bd84c6f089c20a5b075410a1a1ce05bdd7701e9cf40b1ecd725cc |

`SmoothCurveFiniteSupport` constructs finite support of each original
rational principal divisor from true compactness and smooth relative
dimension one, over an algebraically closed field on an integral Scheme.
It chooses an actual finite affine subcover of the original Scheme,
derives the original chart rings are Dedekind, and proves they are not
fields using their actual maximal localizations being DVRs. The imported
support proof represents the rational unit by an actual chart numerator
and denominator and uses their finitely many Dedekind prime factors.
Quasi-compactness of the actual structure morphism suffices; the proper
specialization is a consequence. No finite chart list, finite valuation
support, chart normality or DVR hypothesis is supplied by the caller.

`SmoothCurvePointStrata` proves every original point is either closed or
the original generic point, using actual Dedekind affine charts and the
Jacobson topology derived from the smooth finite-type structure. The zero
prime case transports the genuine chart generic point through the open
immersion. Every other prime is maximal and its closedness transfers to
the original Scheme by the Jacobson open-embedding theorem. The regularity
wrapper treats the generic stalk literally as the function field; it does
not silently discard other points or substitute geometric points.

`IntegralSchemeGlobalFunctions` proves, for ANY integral Scheme, that a
rational function lies in every actual structure-sheaf stalk iff it is the
image of an actual global structure-sheaf section. Germ representatives
produce local sections. Equality in the original generic-point function
field proves compatibility by injectivity on nonempty open overlaps;
empty overlaps are handled using the terminal empty-open section ring.
Actual Scheme sheaf gluing constructs the global section. Restriction and
section/stalk/function-field scalar towers identify its literal generic
image. No smoothness, properness, finite presentation, global section
existence or all-stalk-to-global premise is assumed.

`ProperSchemeGlobalConstants` uses the actual structure map to an
algebraically closed field and its Mathlib `UniversallyClosed` property.
The actual global-section hom is integral by the affine-target universal
closedness theorem, and its target is a domain because the Scheme is
integral. Algebraic closedness therefore makes this hom bijective. The
rational-function wrapper combines the preceding actual sheaf gluing with
literal chart/generic compatibility. Smoothness and finite type are absent
from this wrapper's explicit hypotheses; algebraic closedness and genuine
universal closedness are essential stated inputs. It does not merely
assume that global regular functions are constants.

`SmoothCurvePrincipalKernel` applies these results to the ORIGINAL proper
smooth integral Scheme over an algebraically closed field. Actual smooth
geometry supplies all closed-point DVRs; properness supplies finite
principal support, so `schemeDivisorSystem X` is the genuine original
valuation system. Zero principal divisor gives exact zero integer order
at every original closed point. The normalized signed logarithm and
nonzero unit value imply valuation one, and the checked height-one DVR
integer-ring bridge gives an actual original stalk representative.
The closed/generic dichotomy yields regularity at every point, actual
sheaf gluing yields a global section, and actual universal closedness
forces an actual constant. Its nonzero value gives a literal constant
unit whose actual field pullback equals the original rational unit.
Neither a principal-kernel-constants premise nor an independently chosen
divisor system or constant-field embedding occurs.

The final literal theorem proves zero principal divisor implies a pulled
back constant unit. It does not separately state the reverse implication,
a degree/product formula, the full Picard/sheaf identification, or any
common-cover conclusion. The chain is mathematically sound at its exact
quantified scope; no circular target hypothesis or missing local/global
construction was found in this readback. A changed hash requires rereading
the affected proof. Build and axiom evidence remain the root audit's duty.
