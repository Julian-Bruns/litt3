# Proof: finite affine averaging transports the unique ordinary tower

[Statement](../../Theorems/deformations/cored_ordinary_bt_transport.md).
## The ordinary endpoint already has its unique full group

The [absolute extension torsor](versal_bt_extension_torsor.md) has
zero zeroth and first cohomology for the supplied ordinary $H_Y$.
It therefore constructs its unique normalized full group $G_Y$ on
the ORIGINAL Y without a global reference. The finite argument below
transports this definite tower, retaining the specified BT1 comparison.

## The core supplies a finite group, and its relevant index is prime to five

The [cored orbifold bridge](../quotient_geometry/cored_orbifold_bridge.md)
supplies an actual finite etale refinement W of the ORIGINAL Z, Galois
over both endpoints. Put A, B, G as in the statement. The common BT1
$H_W$ has the actual A-descent data from $H_X$ and B-descent data from
$H_Y$. Therefore every member of the finite group G preserves its
isomorphism class.

By [tame BT1 point stabilizers](versal_bt_tame_automorphisms.md), every
five-subgroup of G acts freely on W. For a Sylow-five subgroup P,
etale Riemann--Hurwitz gives
\[
|P|\mid g(W)-1=|B|(g(Y)-1).
\]
Since $5\nmid g(Y)-1$ and B is a subgroup of G, this forces
$v_5(|G|)=v_5(|B|)$, or $5\nmid[G:B]$.
The same symmetry theorem gives $|G|\le24(g(W)-1)$ and hence
$[G:B]\le24(g(Y)-1)$. The latter numerical bound is not needed
for the averaging argument.

The analogous statement is unavailable in the coreless case: the
alternating closures need not terminate, so G is not a finite
automorphism group of one proper curve.

## Retain the actual BT1 action without discarding its scalar ambiguity

Let $\widetilde G$ be the group of pairs $(\sigma,u_1)$ with
$\sigma\in G$ and $u_1:\sigma^*H_W\simeq H_W$. The generic scalar
endomorphism theorem and torsion-freeness of the finite Hopf algebras
give
\[
1\longrightarrow\mathbf F_5^*\longrightarrow\widetilde G
\longrightarrow G\longrightarrow1.
\]
This is a finite central extension. The prescribed A- and B-descent
data give actual lifts of those two subgroups to $\widetilde G$;
no splitting over all of G is being assumed.

Inductively suppose the pullback $M_N=G_Y[5^N]|_W$ carries the
$\widetilde G$-action extending these first-level maps, with scalars
acting by their Teichmuller lifts. For each pair its determinant
comparison is defined to be the Teichmuller lift of its first-level
determinant comparison. This prescription respects composition.
It holds at $N=1$ by definition.

Consider normalized marked BT$_{N+1}$ extension classes of this
actual $M_N$. They form a nonempty additive $K_{H_W}$-torsor,
with a reference supplied by $G_Y[5^{N+1}]|_W$. Pullback and the
specified lower-level maps give a genuine affine action of
$\widetilde G$ on this torsor. Central $a\in\mathbf F_5^*$ acts
trivially on its classes: multiplication by $[a]$ on any extension
realizes the change of lower marking and has the prescribed
determinant $[a^2]$. Thus the affine action factors through G.
Its linear part is ordinary pullback on $K_{H_W}$.

## Average an actual extension class, then use endpoint uniqueness

Write $b$ for the reference class from Y. It is B-fixed. Let
$m=[G:B]$, prime to five. Affine averaging is intrinsically defined by
\[
\overline b=b+m^{-1}\sum_{\sigma B\in G/B}(\sigma b-b).
\]
Coset representatives do not matter because b is B-fixed. The
coefficients sum to one, so G permutes the summands and fixes
$\overline b$. This uses only the additive $\mathbf F_5$-structure
of the actual extension torsor, not an unchosen vector-space origin.

The difference between two B-fixed points lies in
\[
K_{H_W}^{B}=q^*K_{H_Y}=0.
\]
Here invariant functions with the supersingular pole bound descend
along the etale Galois cover $q:W\to Y$, and Cartier commutes with
that descent. Consequently $\overline b=b$. The SPECIFIED extension
from Y is therefore G-fixed, not just replaceable by a better average.

For each $(\sigma,u_1)$ there is now an actual normalized marked
isomorphism of the next extensions lifting its already specified
$u_N$. Such an isomorphism is unique. Indeed the marked normalized
automorphism kernel is zero for a generically ordinary everywhere-versal
group on a reduced proper curve, as in
[all-level comparison rigidity](versal_bt_display_descent.md).
Existence here follows from equality of actual extension classes, using
[Cartier realization](versal_bt_cartier_realization.md).

Uniqueness forces composition and gives the $\widetilde G$-action
at level $N+1$. On B it is the original action from $G_Y$, and
the scalar subgroup acts by Teichmuller scalars. This completes
the induction while retaining all earlier maps.

## Descent to the original endpoints and source

Restrict the action to the actual lifted subgroup A. Since W->X
is finite etale, effective descent of the finite locally free Hopf
algebras gives normalized groups $G_{X,N}$ on X. Their lower
marking is exactly the originally specified $H_X$ descent. The
inclusions and multiplication maps commute with the coherent action,
so the descended levels form a full group $G_X$.

The two pullbacks agree on W with the prescribed first-level map.
At every higher level the marked normalized comparison descends
to Z by [separable source descent](versal_bt_display_descent.md).
Alternatively its two pullbacks on W times_Z W agree by uniqueness,
and finite-flat descent gives it on Z. The resulting maps agree
under truncation by the same uniqueness, proving the full comparison.

Any other such pair has the same pullback on Z; uniqueness and
faithfully flat descent identify it with the constructed pair on X.
If $K_{H_X}=0$ and another full extension is supplied there, endpoint
rigidity identifies its marked normalized levels successively with
these, so the comparison concerns that supplied group as well.

The known cyclic-five full-existence descent counterexample does not
contradict this statement: its upper full reference is on an endpoint
with positive indigenous defect. The B-fixed point in its affine
extension space is not unique, so the last averaging conclusion fails.
