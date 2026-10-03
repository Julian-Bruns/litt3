# Proof: multiplier four and the first Castelnuovo boundary

Version1,3 October2026. Pending independent review; see the [retained actual-source statement](../../Theorems/cartier_and_spin/actual_eight_spin_squared_image_genus_boundary.md).

Each t_i has divisor2h_i^{-1}(∞) on E and descends as a section of Q on C. The accepted sign theorem and free sign bound show that φ is unramified at every original infinity point. Therefore its downstairs divisor has only even coefficients, and is2Z_i for an integral effective divisor Z_i. Pullback injectivity on divisors gives φ*Z_i=h_i^{-1}(∞). The degree is a=d0/(10m); in particular this is an integer. The line equality Q=O_C(2Z_i) and Q⁸=ω_C² give degQ=2a and g(C)=4a+ONE. Individual lines O_C(Z_i) have their own sections and differ by TWO-torsion. They are not assumed to be one common original sixteen-spin line.

Let α=α(F)∈H²(G0,k*) be the actual line-linearization obstruction. The G0-action on E is free, |G0|=8d0, and degF=2d0. The accepted [invariant-line Schur theorem](../../Theorems/cartier_and_spin/actual_spin_schur_obstruction.md) implies
\[
4=\frac{8d_0}{\gcd(8d_0,2d_0)}\mid\operatorname{ord}(\alpha).
\]
The retained full positive trace gives a four-dimensional projective V4 with inverse multiplier −α, whose determinant makes4α=ZERO. Thus ordα=FOUR exactly. This argument takes place on E and G0, so it does not assume that an original spin cocycle inflates or that a sign-normalized original section remains trivial after a frame change.

The projective G0-action on W2 inherits α. Equivariant pullback identifies the descended squared orbit on C with W2, so its determinant gives FOUR|dimW2. Put r=dimW2−ONE≥THREE. Its basepoint-free series of degree2a is simple: C is its normalized image, and by construction its ratio field is k(C).

Use the characteristic-independent Castelnuovo bound for a simple series. In dimension at leastTHREE it gives
\[
4a+1\le\left\lfloor\frac{(2a-2)^2}{4}\right\rfloor=(a-1)^2.
\]
Hence a≥SIX. At a=SIX, the degree isTWELVE and the genusTWENTY-FIVE, attaining the dimension-THREE bound. Dimension at leastFOUR has a strictly smaller bound, so r=THREE. The extremal-series consequence gives dim|2Q|=EIGHT, that is h⁰(C,Q²)=NINE. These characteristic-positive statements are recorded in [Korchmáros–Torres, Section2.1, Lemmas2.1 and2.3](https://arxiv.org/pdf/math/0008202), with the positive-characteristic input of [Rathmann](https://doi.org/10.1007/BF01456986).

Now Sym²W2 has dimensionTEN, while h⁰(Q²)=NINE. Multiplication therefore supplies a nonzero quadric vanishing on the degree-TWELVE nondegenerate image in P³. There can be only ONE independent such quadric: two distinct quadrics without a common surface component have intersection degreeFOUR by Bézout, and a common plane component would force this integral nondegenerate curve into a plane. Consequently the quadric kernel is a ONE-dimensional G0-invariant space in Sym²W2.

Its multiplier is2α. A one-dimensional projective space of operators is a scalar cochain, so existence of this invariant line forces2α=ZERO in H²(G0,k*). This contradicts ordα=FOUR. Thus a=SIX is also excluded and a≥SEVEN. The asserted source-degree bounds and image degree/genus follow immediately.

No Halphen bound below its positive-characteristic degree range is used. In particular this argument does not delete larger squared images or claim that their image must lie on a quadric.
