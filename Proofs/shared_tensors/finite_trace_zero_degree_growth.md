# Proof: actual adjunction controls zero-degree strongly semistable images

[Statement](../../Theorems/shared_tensors/finite_trace_zero_degree_growth.md).
The Cartier specializations use
[common strongly semistable coefficient vanishing](../../Theorems/shared_tensors/common_finite_coefficients.md).

## Zero-degree quotients preserve the coefficient class

A strongly semistable degree-zero bundle has strongly semistable
degree-zero locally free quotients whenever the quotient degree is
zero. Indeed every Frobenius pullback is exact on a smooth curve,
and each resulting quotient of a semistable degree-zero bundle has
all quotient slopes nonnegative. Its average slope is zero, so it
is semistable of degree zero. Finite étale pullback and pushforward
preserve strong semistability of degree zero. For pushforward, pull
back to the finite étale Galois closure of that SINGLE map; étale
base change gives a sum of conjugate pullbacks. Semistability then
descends. This works after every Frobenius pullback because relative
Frobenius commutes with finite étale base change.

A finite-étale-trivial bundle is strongly semistable of degree zero.
Its locally free quotients have nonnegative degree. Suppose such a
quotient has degree zero. Pull back to a connected finite étale cover
trivializing the original bundle. The quotient is now globally
generated of degree zero. Choose as many global sections as its rank
which are independent at one point. Their determinant is a nonzero
section of a degree-zero line bundle, so it has no zeros. These
sections trivialize the quotient. Thus the original quotient is itself
finite-étale-trivial.

Finite étale pullback and pushforward preserve finite-étale-trivial
bundles. For pushforward, one can trivialize the finite coefficient
and then take a finite étale Galois cover splitting the finite map and
that trivialization. Its pullback pushforward is a sum of trivial
bundles. In particular every generator at a degree-zero stage is
strongly semistable of degree zero, and retains finite étale
triviality when the original seed had that property.

## The mate contains the prior actual image

Write $c:g_*f^*R_X\to V_Y$ for the adjoint of the pullback of
$R_X\to V_X$. Factor $c$ as a surjection onto its actual image
$J_Y$, followed by the inclusion $\beta:J_Y\hookrightarrow V_Y$.
The mate of the surjection is a map
\[
\alpha:f^*R_X\longrightarrow g^*J_Y,
\qquad g^*\beta\circ\alpha=f^*(R_X\to V_X).
\]
Since $g^*\beta$ is injective, the kernel of $\alpha$ is exactly the
pullback of the actual kernel of $R_X\to V_X$. Flatness of $f$
therefore gives an injection $f^*I_X\hookrightarrow g^*J_Y$ with the
stated compatibility. The adjunction is an isomorphism of Hom spaces,
so $c$ and $J_Y$ are nonzero. This uses finite étale ambidextrous
adjunction, not division by either covering degree.

Assume $\deg J_Y=0$. It is a quotient of the strongly semistable
degree-zero bundle $g_*f^*R_X$, hence is strongly semistable of degree
zero. The bundle
$I_X$ is a quotient of $R_X$, so $\deg I_X\ge0$. Its pulled-back
injection into the strongly semistable degree-zero bundle $g^*J_Y$
gives $\deg f^*I_X\le0$. Thus $\deg I_X=0$, and the same quotient
argument makes $I_X$ strongly semistable of degree zero. In the
finite-étale seed case both images are finite by the preceding lemma.
If their ranks agree, the injection is
between bundles of equal rank and degree zero on $Z$. Its torsion
cokernel has degree zero and is empty. The injection is an
isomorphism, providing precisely a common strongly semistable
degree-zero coefficient on the ORIGINAL endpoints and compatible
inclusions into $V$.

Apply this argument repeatedly. At every zero-degree stage the current
image and next generator are strongly semistable of degree zero,
and the next image has nonnegative degree. In the finite-étale seed
case they also retain finite étale triviality. Equal rank would give
the forbidden common object.
Hence zero-degree steps strictly increase rank. All images have rank
at most $N$, proving the bound of $N-r$ such passages. The next
nonzero image has nonnegative degree and cannot have degree zero, so
has positive degree.

## The additional connected-monodromy criterion

In the finite-étale seed case, assume the full endpoint monodromy image
$G_Y$ of $J_Y$ is reached
by $\pi_1(Z)$, and denote that of $I_X$ by $G_X$. Morphisms between finite-étale-trivial
bundles on a proper connected curve are horizontal: trivialize both
on a common connected finite étale cover and use that regular
functions on that cover are constant. Thus the injection above is a
linear intertwiner for the image
$H\subset G_X\times G_Y$ of $\pi_1(Z)$, with its $G_Y$ projection
surjective. Its image subspace in the fiber of $J_Y$ is then stable
under all of $G_Y$: lift each element of $G_Y$ to $H$ and use
intertwining. It descends to a finite subbundle $K_Y\subset J_Y$.
The original source map factors through $g^*K_Y$. Its adjoint factors
through $K_Y\subset V_Y$. Since $J_Y$ was the ACTUAL image of that
adjoint, it follows that $K_Y=J_Y$. Therefore the injection is
surjective and the ranks agree.

The resulting source isomorphism itself supplies the actual common
finite image on both original endpoints. If the $G_X$ projection is
also surjective, finite Goursat gives its usual common-quotient
description; this extra assumption is unnecessary here. No
simultaneous Galois closure is assumed.

The surjectivity assumption is exactly connectedness of the $Y$
monodromy-torsor pullback. It cannot be manufactured by replacing
endpoints with unrestricted connected components. The
[endpoint-refinement theorem](../../Theorems/shared_tensors/cartesian_endpoint_refinement.md)
requires connected one-leg products in its component formulation;
restricting to a proper source monodromy image generally violates
that requirement. Without surjectivity, a proper source subspace can
have a larger orbit span on the opposite endpoint. The strict-rank
alternative above deliberately retains this possibility.

## Rank-three saturation forces one-step generic filling

Let $I_X$ be the actual opposite trace image of $R_Y\subset B_Y$.
The same mate argument gives $g^*R_Y\hookrightarrow f^*I_X$
inside $B_Z$, so its generic rank is at least three. Suppose it is
three, and let $E_X$ be its saturation in $B_X$. Saturation commutes
with étale pullback. Thus
\[
g^*E_Y\subset f^*E_X\subset B_Z
\]
are saturated subbundles of equal rank and equal generic subspace.
They are equal: a saturated subsheaf is the intersection of its
generic subspace with the ambient locally free sheaf. The canonical
Cartier symplectic pairing is compatible with étale pullback.
Taking orthogonals consequently produces an actual common line pair
$A_X=E_X^\perp,A_Y=E_Y^\perp$ embedded in $B$.

Since $\deg A_Y=0$, equality of their pullback degrees makes
$\deg A_X=0$. Line bundles are strongly semistable, so this violates
the selected-pair common degree-zero coefficient vanishing theorem.
The trace image must therefore have rank four. This is only generic
filling: its unsaturated full-rank lattice can still have a torsion
defect. The argument uses neither an endpoint refinement nor a
simultaneous Galois closure. It is consistent with the retained
[common saturated Cartier subbundle classification](../../Theorems/cartier_and_spin/common_cartier_subbundles.md).

## Integral intersections in the double-zero contact case

Use the fixed
[positive Cartier plane and its evaluation](../../Theorems/cartier_and_spin/positive_cartier_plane_orbits.md).
The fiber-contact assertion follows from its surjective rank-two
Frobenius evaluation: over a point of $R_X$ its kernel is one
dimensional and contains the nonzero fiber of $F^*\lambda_X$.
At every point of $q^*W_1$ the evaluated $F^*q^*A_Y$ vanishes,
so its fiber is that same kernel. Frobenius over the perfect residue
field detects equality of the original line fibers.

If the two pulled-back embedded lines agree on EVERY component of
$T\times_XT$, they agree on that full fiber product. Since both are
saturated, generic equality on a component implies equality there.
Fpqc descent of the subbundle $q^*A_Y\subset h^*B_X$ through the
actual finite étale map $h$ then gives a line $A_X\subset B_X$ with
$h^*A_X=q^*A_Y$ as embedded subbundles. Its degree is zero by
étale degree comparison. This forbidden common degree-zero line
contradicts the selected-pair common-coefficient theorem. Thus some
component has distinct generic embedded lines.

On such a component put $P=f^*P_X$. It is a Lagrangian of degree
$7n$, with $A_i\subset P$, $\deg A_i=0$, and
$\deg D_i=8n$. Each $D_i$ is reduced and lies in the same reduced
degree-$13n$ divisor $f^*R_X$. Hence
$m=\deg\min(D_1,D_2)\ge16n-13n=3n$. The nonzero wedge
$A_1\otimes A_2\to\det P$ has zero divisor of degree $7n$.
The two fibers coincide at EVERY point common to $D_1,D_2$, by
the specified contact with $f^*\lambda_X$. Thus that zero divisor
contains $\min(D_1,D_2)$ and $m\le7n$.

The two distinct hyperplanes $A_i^\perp$ intersect generically in
$P$. Therefore $J_1\cap J_2$ is contained in $P$, and
\[
J_i\cap P=A_i+P(-D_i).
\]
At a point of just one $D_i$, the intersection of these two
rank-two lattices has colength one in $P$. At a point of both,
their line fibers coincide; each lattice is the inverse image of
that fiber under $P\to P|_t$, so their intersection again has
colength one. Elsewhere it is $P$. This elementary DVR calculation
gives total colength $\deg D_1+\deg D_2-m=16n-m$, and hence
\[
\deg(J_1\cap J_2)=7n-(16n-m)=m-9n.
\]
There is no assertion that arbitrary coincident fibers outside the
$D_i$ contribute to this intersection defect.

The symplectic pairing on $B_S$ takes values in $\omega_S$, of
degree $16n$. For a degree-zero line $A_i$, its orthogonal
hyperplane has degree $16n$. Requiring its image modulo $D_i$
to lie in $A_i$ imposes colength $2\deg D_i=16n$. Thus
$\deg J_i=0$, and the exact sum-intersection sequence gives
$\deg(J_1+J_2)=9n-m\ge2n$. The sum has rank four. Both $J_i$
lie in $f^*I_X$ by the actual trace adjunction. A full-rank
inclusion of lattices can only increase degree, so
$n\deg I_X\ge2n$, proving the result.

More generally the same local calculation works in a rank-four
symplectic bundle with pairing line of degree $w$, a Lagrangian
of degree $a$, distinct degree-zero lines, and reduced contact
divisors of degree $\delta$. It gives intersection degree
$a-2\delta+m$ and sum degree $2w-2\delta-a-m$, with $m\le a$
when the common contacts lie in the wedge divisor. The selected
application is $w=16n$, $a=7n$, $\delta=8n$. The precise common
fiber-contact hypothesis is essential; support inclusion alone
would not imply this integral intersection formula.
