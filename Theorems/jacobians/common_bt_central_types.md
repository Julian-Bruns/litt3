# Common finite groups, Newton jumps, and constant rational coefficients

Let $k$ be algebraically closed and let
$X\xleftarrow f Z\xrightarrow gY$ be an actual coreless finite
bi-étale span of smooth projective connected hyperbolic curves.
Thus $k(X)\cap k(Y)=k$ inside the specified $k(Z)$.

Suppose finite locally free group schemes $B_X/X$ and $B_Y/Y$
have an isomorphism $f^*B_X\simeq g^*B_Y$.
There is a finite group scheme $B_0/k$ such that both families
are geometrically fiberwise isomorphic to $B_0$ on dense opens.
Either this holds everywhere, or there is precisely one further
geometric isomorphism type $B_1$. Its support pulls back to the
unique clump of the span. In particular:

- a common finite group family has at most two geometric fiber types;
- without a clump, every such family is geometrically fiberwise constant;
- generic constancy does not assert constancy of the family or trivial
  monodromy.

## A finite cutoff for integral jumps at fixed Newton polygon

Suppose $\operatorname{char}k=p>0$, and fix dimension $d$ and
codimension $c$, with $c,d>0$. Put
\[
b(c,d)=\left\lfloor\frac{2cd}{c+d}\right\rfloor.
\]
Let $N\ge b(c,d)$, and suppose the common families above are
BT$_N$ groups of this dimension and codimension. At this level
each geometric fiber determines a unique full $p$-divisible-group
isomorphism type, hence a well-defined Newton polygon.

If that Newton polygon is constant, then ALL geometric fibers on
both endpoints have the same full type and the same truncated type.
No jump of the $a$-number, Ekedahl--Oort type, or any higher integral
fiber invariant can occur. Global full-group extensions are not
required.

More generally, if two geometric fiber types occur at this cutoff,
their Newton polygons are different. Their exceptional support is
the unique clump. The full-group version holds in every height:
compatible full groups of constant Newton polygon are geometrically
fiberwise constant, and variable ones have exactly two geometric
types, with different Newton polygons.

For supersingular abelian varieties of dimension $r$, $c=d=r$
and the cutoff is $N=r$. Thus two supersingular abelian-surface
families whose $p^2$-torsion is identified on the actual source
cannot have a varying $a$-number in a coreless span.
A common supersingular height-four BT1 with an $a$-number jump
cannot be extended to compatible constant-Newton BT2 data.

The compatibility assumption may be imposed after a connected
finite étale refinement of $Z$. The two endpoint fields still
have intersection $k$, and the conclusions concern the original
span. The group isomorphism, not merely an isogeny, is essential
for the constant-Newton assertion.

## Global rigidity with a constant rational coefficient

Suppose $p>0$ and FULL $p$-divisible groups $G_X/X,G_Y/Y$ have a
specified isomorphism $f^*G_X\simeq g^*G_Y$. If each is quasi-isogenous
to a constant group, then there is one $G_*/k$ and actual endpoint
isomorphisms $G_X\simeq G_*\times X$, $G_Y\simeq G_*\times Y$ carrying
the specified source comparison to the identity. This applies in
particular when both rational Dieudonné crystals are constant.

More generally, for any finite $B_0/k$, compatible EMBEDDED subgroup
schemes $K_X\subset B_0\times X$ and $K_Y\subset B_0\times Y$ are
pullbacks of the same subgroup $K_0\subset B_0$. These conclusions
need the full comparison or embedded kernels; a constant Newton
polygon or a BT$_1$ comparison does not supply either one.

Version2,24 September2026. The finite-level cutoff and specialization
inputs were checked in primary sources; the constant-rational upgrade
has a separate direct proof. These are restrictions on EXTRA common
group data. They construct no such data and do not exclude either
common-cover candidate.
[Proof](../../Proofs/jacobians/common_bt_central_types.md).
