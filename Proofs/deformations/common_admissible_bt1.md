# Proof: remove the fourth-root mismatch before finite-flat descent

[Statement](../../Theorems/deformations/common_admissible_bt1.md).
This is a local continuation of the returned endpoint effectivity
theorem. Its descent uses both original maps from the same source.

Choose theta characteristics and determinant-trivial oper
realizations $(E_C,\nabla_C,L_C)$, $C=X,Y$. Equality of the projective
opers gives a flat two-torsion line $A$ on $Z$ with
\[
f^*E_X\simeq g^*E_Y\otimes A,
\quad f^*L_X\simeq g^*L_Y\otimes A,
\quad f^*I_X\simeq g^*I_Y\otimes A.
\tag{2}
\]
The projective comparison is the specified equality of projective
connections, not one inferred just from degrees. The Hodge line
is the unique maximal-degree line; the curvature kernel is intrinsic.
The determinant trivializations give the horizontal square
trivialization of $A$.

Put $\kappa_C=I_C L_C^5$ and choose flat eighth-torsion $N_C$
with $N_C^4=\kappa_C$. Such roots exist on each geometric curve.
Equation(2) gives
\[
f^*\kappa_X=g^*\kappa_Y\otimes A^6=g^*\kappa_Y.
\tag{3}
\]
For $E_C'=E_C\otimes N_C$, the discrepancy is
\[
D=A\otimes f^*N_X\otimes g^*N_Y^{-1},
\qquad D^4=\mathcal O_Z,
\qquad f^*E_X'=g^*E_Y'\otimes D.
\tag{4}
\]
All these are flat identifications. In particular $D$ gives an
actual etale $\mathbf F_5^\times$-character, not a wild line or a
chosen pointwise scalar. Its connected character cover has degree
equal to its order, at most four.

The [ordinary effectivity theorem](ordinary_oper_bt_effectivity.md)
gives a full group on $Y$, with $H_Y$ its BT1. Form the ACTUAL
group $J=g^*H_Y\otimes\Lambda_D$ on $Z$, choosing the dual
character if needed in the contravariant convention so its evaluated
flat bundle is the right side of (4).

On $X$ the chosen root supplies candidate horizontal maps
\[
F_X:F_{\rm abs}^*E_X'\twoheadrightarrow
F_{\rm abs}^*(E_X'/L_X')\simeq I_X'\hookrightarrow E_X',
\]
\[
V_X:E_X'\twoheadrightarrow E_X'/I_X'\simeq
F_{\rm abs}^*L_X'\hookrightarrow F_{\rm abs}^*E_X'.
\tag{5}
\]
They exist on $X$ without any ordinary hypothesis on $r_X$.
Under (4), the pullbacks of (5) and the arrows of $\mathbf D(J)$
are isomorphisms of the same source and target lines. Their ratios
are two global units on the proper connected $Z$, hence two
constants in $k^\times$. Rescale the two maps (5) on $X$ by
those constants. The WHOLE evaluated datum, including connection,
arrows and Hodge line, now pulls back to $\mathbf D(J)$.

For precision about effectivity, a quasi-nilpotent connection killed
by five determines its finite-presentation crystal on local smooth
Witt lifts. These descriptions and the specified horizontal arrows
glue; see [de Jong, Corollary2.2.3 and Remarks2.2.4,2.4.10](https://www.numdam.org/item/PMIHES_1995__82__5_0.pdf).
Here quasi-nilpotence follows from nilpotent curvature, and may also
be checked after the faithfully flat etale map $f$, where the crystal
is the actual one of $J$. Thus (5) defines a crystal datum $M_X$
whose pullback is $\mathbf D(J)$. No essential-surjectivity claim
for arbitrary truncated matrices is being made.

On $Z\times_X Z$ the pullback of $M_X$ specifies a crystalline
isomorphism between the two ACTUAL pullbacks of $J$. Full
faithfulness for existing finite flat groups supplies its unique
group-scheme isomorphism. Their triple cocycle follows by faithfulness.
Effective finite-flat descent gives $H_X/X$. The properties of being
a BT1 of height two and dimension one and the prescribed
Kodaira--Spencer isomorphism can be checked etale locally, so they
hold for $H_X$. This proves (1) on the original $Z$.

Trivialize $D$ by its connected character cover $h:Z'\to Z$.
Equation(1) becomes an actual comparison between $(fh)^*H_X$ and
$(gh)^*H_Y$. The maps $f$ and $g$ themselves have not been replaced
by unrelated quotients and no simultaneous Galois closure was used.

Conversely the connection, curvature and Hodge line of an
everywhere-versal BT1 give an admissible active projective oper, by
[the Cartier-rigidity calculation](versal_bt_cartier_rigidity.md).
All operations commute with etale pullback. Faithfully flat descent
of equality of projective connections removes any auxiliary source
refinement. This proves the stated equivalence.

Only the datum killed by five was descended through $f$. The full
group on $Y$ does not supply the crystalline comparisons at higher
levels on $Z\times_X Z$. Nonordinary source Cartier classes can
obstruct those comparisons. This is why the argument does not
already invoke the full common-coefficient lifting theorem.
