# Audit: fixed-weight norms and commuting canonical-ring realization

Date: 2026-09-05. Auditor: independent agent
`fixed_weight_norm_encoding_check`. Verdict: **PASS**.

Audited the complete
[proof note](../FIXED_WEIGHT_NORMS_AND_COMMUTING_CANONICAL_RING_REALIZATION.md),
with the definitions of its linked pluricanonical trace construction.
This is a mathematical proof audit; no historical novelty or common-cover
nonexistence claim is certified.

## Checks

1. **Polynomial and target line.** If `L = omega_Y^m`, the determinant
   of multiplication by a section of `g^*L` lies canonically in
   `Hom(det E, det(E tensor L)) = L^b`. Thus no choice of trivialization
   of `det E`, extra scalar normalization, or invertible cover degree is
   needed. Applied to the universal input section, this gives an actual
   homogeneous polynomial with coefficients in `H^0(Y,L^b)`.
   `Sym^b(V^vee)` is the correct space of polynomial functions; no
   factorial or divided multilinear polarization is involved. Field
   extension and passage to the geometric generic fiber preserve this
   construction.

2. **Separation of branches.** Normalization is an isomorphism outside
   finitely many points of each integral image. Distinct image curves
   also intersect in finitely many points. Their projections to `Y`
   are finite sets, avoided by its geometric generic point. Consequently
   the distinct sheets of all distinct minimal images have distinct
   `X` coordinates there. Finite etaleness ensures their generic fibers
   are reduced; no geometric inseparability multiplicity is being
   mistaken for a cycle coefficient.

3. **Reconstruction and characteristic-p exponents.** The stated degree
   estimate makes `omega_X^3` very ample, including genus two. Every
   sheet functional is nonzero and its projective class is the
   tricanonical evaluation point, since the differential comparison is
   invertible. Unique factorization over the algebraic closure of
   `k(Y)` therefore recovers all the distinct points and their ordinary
   integer exponents. A polynomial such as `L^p` still has factor
   exponent `p`, although its derivatives vanish. The reduced separable
   generic fibers descend to their image components, and taking closures
   recovers the cycle. Changing the target fiber basis rescales the
   polynomial and cannot change this reconstruction. No extraction of
   coefficients by differentiation or assumption that `k(Y)` is perfect
   occurs. The zero cycle is represented separately by degree zero and
   the constant polynomial one.

4. **Refinement and composition.** On an etale refinement of degree `e`,
   the endpoint differential comparisons pull back from the minimal
   span; norm transitivity gives its norm to the power `e`, also when
   `p` divides `e`. On a fiber product, splitting the two successive
   covers gives the same product over pairs in either order. The
   inner result has weight `mb`, so applying the outer norm at weight
   `mb` gives exactly weight `mbd`. Disconnected components and repeated
   cycle components give the stated integer multiplicities. For general
   effective cycles this argument uses their total right degrees.

5. **Commuting operators and recurrences.** Multiplication in `g_*O_C`
   proves the twisted matrix identities, with tensor twists understood
   in each composition. Compatible local trivializations by powers of
   a basis of `omega_Y` identify these with ordinary commuting matrices.
   Trace and determinant give precisely the stated operators. Etale
   splitting diagonalizes them without asserting global splitting or
   semisimplicity of monodromy representations. Formula (9) follows in
   formal power series because `Q_s(0)=1`; Cayley--Hamilton gives the
   homogeneous recurrence beyond the initial terms. Neither argument
   divides by an integer.

6. **Generic separability and scope.** For the joint-minimal span used
   in Section 5, distinct projective evaluation functionals are in
   particular distinct linear functionals. Their differences and the
   individual functionals define proper hyperplanes. A generic linear
   combination avoids their union, so its eigenvalues are distinct and
   nonzero, independently of divisibility of `b` by the characteristic.
   This statement does not assert separability for a repeated positive
   cycle or a refinement with repeated eigenvalues. Multiplying `Q_s`
   by a normalized `p`-th-power factor indeed leaves its logarithmic
   derivative unchanged. The note correctly keeps this trace loss
   separate from recovery using norm factor exponents.

No mathematical repair is required. The reconstruction is faithful for
the actual effective integral bi-etale cycles specified in the note;
it provides neither a bound on their degrees nor an obstruction to the
existence of a common etale cover.
