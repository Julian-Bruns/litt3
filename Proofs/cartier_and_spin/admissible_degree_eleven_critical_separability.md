# A three-term source-kernel obstruction to inseparable critical degree eleven

1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_eleven_critical_separability.md).
The input is the necessary fourteen-dimensional homogeneous
coefficient kernel in
[the support reduction](admissible_degree_ten_eleven_reduction.md).
No coefficient tuple is assumed to realize an etale source.

## The small exact identity

Use $\beta^2=\beta+3$ and encode $a+b\beta$ by $a+5b$.
Let $\alpha$ satisfy the monic quartic with ascending coefficients
$([5],[2],[6],[7],1)$, and work in
$K_0=\mathbf F_{25}(\alpha)$. A code
$c_0+25c_1+25^2c_2+25^3c_3$ means
$[c_0]+[c_1]\alpha+[c_2]\alpha^2+[c_3]\alpha^3$.
Choose the support consisting of the three roots other than
$\alpha$ and take its cubic $t$ monic.

The retained finite-pole basis has dimension66 on275 coefficient
columns. Reimposing its selected collision congruences and infinity
bounds gives the fourteen-dimensional kernel $B$; its last coordinate
is the coefficient $\kappa$. The calculation uses the same exact
necessary conditions as the support reduction. In particular its
infinity bounds are $12+11j$ for the original coefficient numerators.

Write $N_i=y^iH_{6-i}$. In the computed basis of $B$, the three
coefficient functionals of $x^0y^2,x^1y^2,x^2y^2$ in $N_2$
vanish on its first eleven coordinates and have the following last
three coordinates:
\[
M=\begin{pmatrix}
196628&95150&296310\\
170424&217063&372935\\
303162&128143&357423
\end{pmatrix}.
\]
All entries use the preceding base25 encoding. Exact field arithmetic
gives
\[
(360826,332654,71436)M=(0,0,1).
\]
Thus this linear combination of three coefficients of $N_2$ is
exactly $\kappa$ on the entire necessary source kernel. If $H_4=0$,
then $N_2=y^2H_4=0$, and the displayed identity forces $\kappa=0$.
An actual primitive source requires $\kappa\ne0$, proving $H_4\ne0$.

The fourth coefficient of a sextic is unchanged under translation
in characteristic five: the potential contributions from its leading
two terms have binomial coefficients $\binom64=\binom54=0$.
Consequently the obstruction applies equally in the finite and short
frames. Frobenius over $\mathbf F_{25}$ permutes the four roots of
the irreducible quartic and transports the full coefficient conditions
and this identity, covering all four omitted-root support choices.
Changing the legal nonzero normalization of $t$ only rescales
$\kappa$ and cannot turn it into zero.

## Derivative and scope

In characteristic five,
\[
D=vT^5+4H_4T^3+3H_3T^2+2H_2T+H_1,
\qquad D'=2H_4T^2+H_3T+2H_2.
\]
The coefficient just proved nonzero gives exact derivative degree two.
The independently established
[irreducibility theorem](admissible_degree_eleven_critical_irreducibility.md)
then implies separability and function-field squarefreeness.
Neither this implication nor the source-kernel calculation asserts
squarefreeness of every finite specialization.

## Reproducible evidence

The [producer](../../scripts/oct01_nonzero_source/degree_eleven_inseparable_critical_kernel.py)
reconstructs the necessary fourteen-dimensional kernel from the
retained finite-pole basis, then restricts $N_2,N_3,N_4$ to zero.
That larger restriction has rank9 and homogeneous dimension5, and
its $\kappa$ functional is identically zero. The stronger three-term
identity above uses only $N_2$ and is retained explicitly in the
[exact certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/degree_eleven_inseparable_critical_kernel.json).

The [independent Sage verifier](../../scripts/oct01_nonzero_source/verify_degree_eleven_inseparable_witness.sage)
uses a separate finite-field implementation. It checks the stored
source-kernel identities and ranks, the restriction kernel, the
three-term witness and the vanishing $\kappa$ functional. Its
[executed result](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/degree_eleven_inseparable_critical_verification.json)
is PASS. This independent check verifies the small stored linear
certificate; the producer and the original support-reduction sources
retain the coefficient-construction provenance.

Run each script with `--work` set to the sibling
`litt3-computation-data/oct01_local_continuation/nonzero` directory,
using `python3` for the producer and `sage` for the verifier.
The executed calculations used one core and took0.104 and0.506 seconds
respectively, excluding interpreter startup. There is no parameter
sweep, numerical rank extrapolation or source realization claim.
