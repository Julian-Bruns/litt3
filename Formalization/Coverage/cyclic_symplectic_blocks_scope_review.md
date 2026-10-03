# Exact scope of the cyclic symplectic block formalization

Canonical source: `Theorems/deformations/section_growth/cyclic_symplectic_blocks.md`,
Version1. Status remains `partial_component`: the actual curve, bundle,
cohomology and intermediate torsor realization are not yet supplied by Lean.

The checked algebraic results hold over every coefficient field with two
invertible and every positive truncation length N, including lengths that
are not prime powers. The actual group-algebra presentation is proved for
every prime p and every exponent a≥0 in characteristic p. None of stability,
ordinariness or genus is introduced as an assumption.

`HermitianValuationStep` constructs the actual common minimum-valuation
factor, actual radical complement and constant basis lift, and actual full
Schur congruence with both rectangular inverse identities. It removes
positive rank and leaves a strictly smaller full Hermitian remainder. Its
odd valuation removes even rank. `HermitianCyclicKernel` uses this strict
rank decrease to construct the whole cyclic kernel decomposition as modules
over the actual algebra k[z]/z^N. Free length N blocks have no parity
restriction; length zero contributes the zero module when the original
matrix was not minimal.

`CyclicKernelProfile` computes actual power-action kernels on actual cyclic
quotients, with dimension min(s,j). `CyclicBlockProfile` preserves complete
module actions through genuine product-kernel equivalences. The exact
symbolic second-difference identity in `CyclicMultiplicityProfile` proves
uniqueness of every positive cyclic multiplicity. Thus `HermitianCyclicParity`
applies to every genuine full-module decomposition, and
`CanonicalCyclicParity` proves each individual odd nonfree multiplicity even.
`HermitianKernelDimension` proves that an actual odd Hermitian-kernel
dimension is at least N, without supplying parity or classification as input.

`MinimalSkewPairingData` supplies actual matrix chain maps and their actual
homotopy inverses to the conjugate dual, together with a matrix skew-symmetry
homotopy. `StrictSkewPairing` proves the strict average is a chain pairing
with a genuinely invertible mixed component. `MixedHermitianModel` then
constructs a genuinely Hermitian differential by a genuine invertible
codomain change, preserving the entire kernel module. This proves the local
matrix bridge rather than assuming existence of a Hermitian model.

`CyclicPairedSectionModel` records an actual paired minimal free complex and
an actual full-module identification of a specified section module with its
kernel. `PairedCyclicSections` proves the individual canonical parities and
odd dimension bound from those concrete data. The construction of those
data from relative cup product and Serre duality on the actual curve and
vector bundle is still a geometric obligation. This conditional component
does not constitute a full formalization of the source theorem.

`CyclicSkewPresentation` intertwines the complete actual quotient reflection
with actual cyclic inversion. `ActualCyclicRepresentation` pulls any
specified cyclic representation back to the actual truncated algebra, proves
coefficient scalar compatibility, and reconstructs the original specified
representation exactly. `CyclicDeckRepresentation` proves every full-module
identification used above is equivariant for that actual cyclic action.
The equality of all augmentation and skew-coordinate ideals is already
proved in `CyclicCoordinates`; no arbitrary representation substitutes for
the specified action.

`DeckOrderBounds` proves the Cauchy-theorem consequence for an actual finite
group once its actual p-power element orders have been bounded. The actual
intermediate torsor from a subgroup of the actual geometric deck group,
descent of the paired bundle to its quotient, and the resulting order bounds
are still geometric obligations. No statement about a simultaneous or
ordinary Galois closure is inferred.

All named solution modules build with the pinned Lean/mathlib toolchain.
Proofs are symbolic, using algebra and arithmetic normalization; no new
axiom, admitted proof, exhaustive numerical enumeration or external
certificate is used. Parent verification supplies the independent trust audit.
