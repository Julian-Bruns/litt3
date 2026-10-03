# No abelian quotient of degree four in the actual primitive degree-eight sector

ID: `primitive_degree_eight_abelian_quotient_exclusion`. Version1,2 October2026.

Work over an algebraically closed field of characteristic5. Let Y be a smooth projective genus-two curve, A a nontrivial order-five line, and E a nonsplit extension
\[
0\longrightarrow A^3\longrightarrow E\longrightarrow A^4\longrightarrow0.
\]
Let q:S->Y be connected finite etale of degree8 and G a point of S. Suppose a saturated line L=q^*A^4(-G) in q^*E maps to q^*A^4 with exact zero divisor G. Set lambda=L^2=q^*A^3(-2G).

Require a further connected finite etale map pi:T->S and an ACTUAL finite etale map h:T->X from this SAME source T, with equality of the embedded lines pi^*lambda=h^*lambda_X and omega_X=lambda_X^-8. In the fixed genus-nine endpoint lambda_X=O_X(-2O) and omega_X=O_X(16O).

Then q cannot factor through any connected abelian etale cover of Y of degree4 or8. In particular q cannot be Galois. The conclusion is uniform in deg(pi), including degrees divisible by5.

More generally, the contradiction only requires two distinct nontrivial tame character line summands B,C of q_*O_S, each of order dividing8, with B C^-1 of order2 and with their global eigenforms having trace zero.

In the actual opposite-adjunction and same-target nonzero-character sector, let S be the normalization of k(Y)(chi), chi=phi/u. If the primitive residual parameter m=1, the universal character normal form and square-root calibration give precisely this q,L,lambda and the further ORIGINAL pi,h. Thus no m=1 primitive quotient whose second leg has such an abelian intermediate cover can occur. This does not give a character on an arbitrary unmarked span, identify S with X, or exclude nongalois degree-eight legs having no such quotient.

For the specific universal character-point data, the stronger [complete primitive degree-eight exclusion](primitive_degree_eight_exclusion.md) also excludes the remaining nongalois legs. The present statement retains its more general genus-two extension hypotheses.

The key additional actual-source condition is that M=omega_S tensor lambda^8 is trivialized by pi and hence has prime-to5 torsion. It is not assumed for an arbitrary one-leg degree-eight cover. The line inclusion forces evaluation at G to be a NONZERO multiple of twisted trace; a base point of the full twisted canonical series alone would not suffice.

[Proof](../../Proofs/cartier_and_spin/primitive_degree_eight_abelian_quotient_exclusion.md). The new argument passed one [focused independent audit](../../Research/audits/RECIPROCAL_PRIMITIVE_ABELIAN_GATE_AUDIT_2026_10_02.md). No computation was needed.
