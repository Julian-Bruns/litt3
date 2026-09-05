# Coreless joint deformation: the exact rigidity-source boundary

**Status: bounded primary-source inspection, 2026-09-05; not a new
theorem or an independent audit.** Reviewer:
`/root/gluing_cohomology_rigidity`.

No applicable all-degree rigidity theorem was found for characteristic-p
proper bi-etale correspondences with both no core and
Hom(J(X),J(Y))=0. This records the outcome of this bounded search,
not a claim that the strengthened problem is currently open or false.

## Selected primary theorem

Source: Raju Krishnamoorthy,
[Correspondences without a core, ANT 12 (2018)](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
The targeted proof inspected was Corollary 4.13, printed p. 1189.

Its statement is: over an integral finite-type complex base S, a finite
etale correspondence between smooth proper geometrically integral
hyperbolic S-curves is etale locally constant if its generic fiber has
no core.

The proof specializes corelessness, applies characteristic-zero Shimura
arithmeticity, and uses countability versus constructibility over C.
It concludes constancy over a reduced base, not vanishing of the tangent
space at the moduli point.

Question 8.3 and Remark 8.4, pp. 1202–1203, explicitly separate this
result from infinitesimal rigidity. Example 3.19 describes coreless
etale Hecke correspondences deforming in characteristic p. These are
not examples with the additional Jacobian Hom vanishing required here.
No proof of that stronger implication is supplied by this source.

## Translation to the present deformation problem

For the actual maps f:Z -> X and g:Z -> Y, the source's joint tangent
space is exactly

\[
 \ker\!\left(H^1(X,T_X)\oplus H^1(Y,T_Y)
             \xrightarrow{\ a_f-a_g\ }H^1(Z,T_Z)\right)
       \simeq a_fH^1(X,T_X)\cap a_gH^1(Y,T_Y).
\]

This is the direction space in [110](110_TWO_LEG_WITT_OBSTRUCTION_AND_NONZERO_CROSS_TRACE.md),
not the affine mixed-characteristic lifting obstruction. Even its
vanishing would not prove that the W_2 intersection is nonempty.
[116](116_ETALE_REFINEMENT_PRESERVES_SIMULTANEOUS_DEFORMATIONS.md)
preserves the full simultaneous deformation functor under refinement;
it does not force either existence of a lift or tangent-space vanishing.

File 110 also rules out inferring quadratic cross-trace vanishing merely
from Hom(J(X),J(Y))=0. Its counterexample has a core, so it does not
refute a stronger assertion using both hypotheses.

The bounded singular-image and foliation searches supplied no additional
matched theorem. In particular, no step here constructs a global
p-closed foliation, a compatible two-leg connection, or a finite orbit
saturated under both maps. A reconstructed smaller curve is never
assumed to retain the original map to Y. The older
[joint-geometry source record](JOINT_GEOMETRY_LITERATURE_BOUNDARY_2026_09_05.md)
records the distinct invariant-section and singular-image boundaries.
