# A common infinite arithmetic coefficient forces a clump

Version3,20 September2026.

Let $k=\overline{\mathbf F}_p$ and let
$X\xleftarrow f Z\xrightarrow g Y$ be an actual finite bi-etale
span of smooth projective connected curves over $k$.
For some $\ell\ne p$, suppose the endpoints carry semisimple geometric
$\overline{\mathbf Q}_\ell$-local systems
$\mathcal L_X,\mathcal L_Y$ of the same rank, with
\[
f^*\mathcal L_X\simeq g^*\mathcal L_Y
\]
as GEOMETRIC local systems on $Z$. Suppose ONE endpoint system has
a semisimple arithmetic extension over a finite-field model, every
irreducible constituent having finite-order determinant.
In particular, an irreducible finite-determinant arithmetic extension
on that one endpoint suffices.

If either geometric system has infinite image, there is a crystalline
companion whose non-generic Newton locus on $Z_k$ is a nonempty
clump. No rank bound, rational-trace hypothesis, integral lattice,
Barsotti--Tate realization, or prior ramification support is needed.
The other arithmetic extension and compatibility of the GIVEN source
isomorphism follow after a finite constant extension from
[arithmetic descent of geometric coefficients](geometric_common_coefficients.md).

If the geometric span is coreless, its unique clump is therefore
detected by that companion. Every nonconstant Newton polygon
among all common companions has exactly this exceptional support,
and has only ONE exceptional polygon there.
Consequently a clumpless coreless span admits no common infinite-image
semisimple geometric coefficient of this one-sided arithmetic origin,
in any rank.

For genus-two $Y$ and $p>2$, there is a stronger rank-two result.
If the compatible systems are absolutely irreducible of rank two,
have finite-order determinant and infinite image, the ORIGINAL
span lifts over a complete mixed-characteristic DVR. There is no
condition on a field of Frobenius traces, its residue degrees,
or its ramification above $p$.

Indeed a nonconstant companion has positive generic slope gap at
most one. Constant normalization and the
[arbitrary-cycle oper construction](../deformations/ramified_rapoport_oper.md)
give an actual oper with enough thickness; one-endpoint lattice
descent supplies compatibility with the other map.
One arithmetic endpoint still suffices, as above.
The selected main pair therefore admits no such common infinite
rank-two system at all. For the backup this forces its still-open
fully liftable branch.

An arbitrary span does not supply such a common local system.
One-leg systems without geometric matching and finite-image systems
do not meet the criterion. Arithmetic origin is still a hypothesis;
arithmetic matching on both legs is no longer a separate one.
Finite determinant of a reducible whole object cannot replace the
constituentwise finite-determinant condition.

[Proof](../../Proofs/shared_tensors/common_companion_jump.md).
Author proof; primary slope-filtration and companion inputs checked.
The all-rank conclusion is a clump, while the rank-two conclusion
is a simultaneous lift. Neither constructs a common coefficient.
