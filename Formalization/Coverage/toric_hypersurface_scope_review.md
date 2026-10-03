# Actual toric hypersurface quotient: complete calculation

Canonical source: `frobenius_truncated_hypersurfaces`, Version 1,
statement SHA256 `21d69d2df228f7ddb710cdbe03485f55ad0538e92ae8bd43f15589e4ce36f00b`,
human proof SHA256 `9553c138536962078745d7dbe8745c18409efc4b77b0fcbe8c6894da4639ed38`.
Both current files were read. This chain completely proves the actual
toric normal-equation quotient basis, dimension, floor/remainder formula
and every stated p=5 specialization. It does not itself construct a
relative formal Morse change from an arbitrary original hypersurface.

## Exact actual quotient and basis

For every nontrivial commutative coefficient ring K, Q>0, R>0, R<=Q
and s>0, the ORIGINAL quotient
K[[x,y,z]]/(xy-z^s,x^Q,y^Q,z^R)
has a constructed finite K-basis. Its unchanged monomial representatives are
z^c for 0<=c<R, and x^a z^c and y^a z^c for 1<=a<Q and
0<=c<min(R,s(Q-a)). The polynomial quotient has the same actual basis.
No characteristic, reducedness, algebraic closure or supplied independence
or rank is needed. The basis construction itself works over every
commutative K, including the zero ring; nontriviality is needed for finrank.

`toricHypersurfaceBasis` constructs the actual original polynomial quotient
basis, and `toric_hypersurface_basis_original_class` identifies each vector
with its exact original quotient monomial class.
`toricHypersurfaceFiniteBasis` reindexes it by the shared constant string
and two finite axis strings. `toricHypersurfaceSeriesPolynomialEquiv`
constructs a genuine coefficient algebra equivalence retaining the literal
original toric equation and all three original power relations.
`toricHypersurfaceSeriesBasis` transports the finite basis to the actual
original multivariate formal-series quotient.

The complete projection argument proves independence rather than assuming
a standard-monomial or semigroup-basis conclusion.

- Each original x^a y^b z^c monomial is normalized to the unchanged axis
  exponents (a-b,b-a,c+s min(a,b)). The actual xy=z^s quotient relation
  proves equality of its ORIGINAL class with that normalized class.
- The explicit coefficient-linear projection sends each surviving normal
  monomial to its own distinct single coordinate and every removed one
  to zero. The normalized exponents of a multiple of xy and z^s agree.
  Surviving normalization forces each original exponent below its actual
  cutoff, so the three power generators and all their monomial multiples
  project to zero. Polynomial induction handles arbitrary coefficients
  and arbitrary polynomial multiples. Ideal-span induction then kills
  the ENTIRE original four-generator ideal.
- Every removed normal monomial vanishes in the SAME actual quotient.
  Besides the direct power cutoffs, x^a z^(s(Q-a))=0 and its y analogue
  follow by multiplying the original x^Q or y^Q relation by the opposite
  power and using xy=z^s. The whole extra cutoff is derived.
- The section sends each distinct surviving coordinate back to its
  original monomial class. Section after projection is the original
  quotient map; projection after section is the identity on every
  coordinate. Thus the two actual maps are inverse linear equivalences,
  giving the claimed genuine basis and exact kernel, over any K.
- The finite index equivalence handles one shared z string and precisely
  two nonzero axis strings. R<=Q and s>0 prove that the constant string
  has the full length R. Reversing the finite axis index gives the
  displayed summation. The Q=R=1 boundary is included.

## Complete exact lengths

`toric_hypersurface_series_length_sum` proves
L_s(Q,R)=R+2 sum_(j=1)^(Q-1) min(R,sj).
Its Lean range sum also includes j=0, whose contribution is proved zero.
The polynomial and series finrank theorems use the equivalent finite-index
sum. No finite list of exponents or coefficients is enumerated.

For s>=2, `toric_hypersurface_series_length_floor` proves
L_s(Q,R)=2QR-sm^2-r(2m+1), m=R/s, r=R%s.
The arithmetic proves m<Q and uses the literal division equation
R=sm+r with 0<=r<s. It splits the sum into the linear and constant
parts, proves the doubled triangular sum by uniform induction and
proves the exact addition identity before natural subtraction.
The r=0 boundary is included.

`toric_hypersurface_series_length_remainder_one` proves
L_s(Q,R)=2QR-(R^2+s-1)/s whenever R%s=1. The correction numerator
is proved an exact multiple of s, so no rounded quotient is substituted.
`toric_hypersurface_series_length_five_two` and its `five_four` analogue
prove the canonical formulas for every R=5^n and every Q>=R, including n=0.
The residues 5^n modulo 2 and 4 are derived by the uniform power/modulus
identity. No bounded power enumeration is used. The balanced theorems
`toric_hypersurface_series_balanced_length_five_two` and `five_four`
give (3Q^2-1)/2 and (7Q^2-3)/4 for every Q=5^n. All these toric quotient
calculations work in every characteristic, not only characteristic five.

## Source boundary and review

The chain's quotient calculation is complete. The archived source's
unequal-power nondegenerate-plane clause additionally requires the actual
relative source normalization and absorption of the residual unit from
its original residual-order hypothesis. That source foundation is separate
from the present basis and dimension. Balanced actual formal type with an
actual invertible change and unit can instead be transported using already
proved Frobenius ideal invariance; root owns that source-facing consequence.
The full archived source's current status is determined by all its clauses,
not promoted merely because this literal quotient calculation is complete.

Root independently read the eleven basis/quotient/series files in full,
then the four new arithmetic/closed-length files, and accepted their exact
scopes. The accepted readback checked all floor and residue boundaries,
natural subtraction, arbitrary coefficients and powers one. Settled
series/polynomial transport foundations were reused, not numerically replayed.

## Frozen evidence

Focused basis/series report
`../../../litt3-computation-data/formalization-20261003/verification/20261003T185751Z/report.json`
built the actual series endpoint and audited 165 transitive Litt3 theorem
declarations, standard three axioms only, zero forbidden dependencies and
zero changed sources. Owner independently rehashed all 25 captured sources,
zero mismatches. Its SHA256 is
`ac0e364a13c804ceb16d415270a65ecfd00a6c7d8cfb1dad7621569f9acfa5c4`.

Final whole toric calculation report
`../../../litt3-computation-data/formalization-20261003/verification/20261003T190632Z/report.json`
built `Solutions.Deformations.ToricHypersurfaceFiveLengths` and audited
206 transitive Litt3 theorem declarations, only `Classical.choice`,
`Quot.sound`, `propext`, zero forbidden dependencies and zero changed sources.
Owner independently rehashed all 29 captured sources, zero mismatches.
Report SHA256:
`1ec995dd4d519df37e401426e47097462681e02cae65e646711bb5a01a1ec9a0`.
The following fifteen source pins are relative to `Formalization/`.

| Source | SHA256 |
| --- | --- |
| `Definitions/Deformations/ToricHypersurfaceAlgebra.lean` | `7345983caed460e6ef931ddd025b5671a49e49bffdba92d4ff0a945fb8e50760` |
| `Definitions/Deformations/ToricHypersurfaceSeriesAlgebra.lean` | `bc12bc552209f5c675d2c85459040c6a6e3d0fccf002240c54f4466165f0e3f0` |
| `Solutions/Deformations/ToricHypersurfaceBasis.lean` | `5a98ceddec975f400e81432acd9a09314363242e45e6dbb07c62d0808ff394cc` |
| `Solutions/Deformations/ToricHypersurfaceClosedLengths.lean` | `d34e5c393b3649e5f9132a527c53032b5fcdedc31854e76b42d3978677f3eba5` |
| `Solutions/Deformations/ToricHypersurfaceDimensions.lean` | `8b5abe94584842299ad7b78b591564dbe1f1c6d3444cb126e7a3ecfed0140f51` |
| `Solutions/Deformations/ToricHypersurfaceFiveArithmetic.lean` | `00e0e02d709311c5de655365d4652171f91a6b698c33278612938735ec956d6d` |
| `Solutions/Deformations/ToricHypersurfaceFiveLengths.lean` | `6c49704e3267a8d00f69bfe8d67d0bf17000116bb7f95bc63c3cccf6c4b49444` |
| `Solutions/Deformations/ToricHypersurfaceIndex.lean` | `02ea9df70f96a00a9859a63d0c68367e53763299e2dafa393e1653074ed67278` |
| `Solutions/Deformations/ToricHypersurfaceLengthArithmetic.lean` | `d8ca955f684de43c76f01ded7fe7f4797619debb6a76ca746134fa8b0a93d8f6` |
| `Solutions/Deformations/ToricHypersurfaceNormalization.lean` | `5918e58e45f8f27d628c2c0fadb2c9159225ffbba3c32518464ac4ff4d9d4b05` |
| `Solutions/Deformations/ToricHypersurfaceOriginalClasses.lean` | `3f2c3c1845f3e67fda7e72ec2729a4f5000a9ba2e9a89ab0b067f66f04f2c4a4` |
| `Solutions/Deformations/ToricHypersurfaceProjection.lean` | `582a196d91adc558e559301107b725bdb28649d58d88689721ab8123a572ff89` |
| `Solutions/Deformations/ToricHypersurfaceProjectionKernel.lean` | `5d86eff22a2114539c03fe6c28084b78d75f3f20f2d084be6865bb8606a0ff08` |
| `Solutions/Deformations/ToricHypersurfaceQuotientRelations.lean` | `700ab279e0c24a0e23d5c91ff2a9c0283004975215f89242ffb89f8142f51ad5` |
| `Solutions/Deformations/ToricHypersurfaceSeriesDimensions.lean` | `ab4fac6d782ed98e74ba47c6d448c58c72248a72b59a4b3b1340e9da7498f37b` |
