# Proof: the quotient containing the actual BT comparison difference

[Statement](../../Theorems/deformations/two_ordinary_bt_comparison.md).
The next-level torsor and comparison criteria are those of
[Cartier realization](versal_bt_cartier_realization.md).

## Weighted Cartier preserves the pole-bound space

The product $\pi_C^*a\Omega_C$ is regular for $a\in V_C$:
the double poles over S are canceled by the order-two zeros of
$\Omega_C$. Cartier preserves regularity. It preserves the character
of $\Omega_C$, since the character takes values in $\mathbf F_5^*$.
Dividing its image by $\Omega_C$ therefore gives an invariant rational
function with pole order at most two on R, hence at most one on S
downstairs. This proves that $\mathcal T_C$ has the asserted target.

These operators commute with the actual etale pullbacks and traces.
Since the endpoint kernels vanish, the two finite-dimensional
semilinear endpoint operators are bijective. Their pulled-back images
are stable and bijective, and so is their sum U: it is mapped onto
itself and has finite dimension over the perfect field k. Thus
$K_{H_Z}\cap U=0$.

If a class $[v]\in Q$ is killed by induced Cartier, then
$\mathcal T_Z(v)\in U$. By bijectivity on U there is a unique
$u\in U$ with $\mathcal T_Z(u)=\mathcal T_Z(v)$. The difference
$v-u$ is a kernel representative of $[v]$. This proves surjectivity
in (1); the preceding intersection proves injectivity.

In the coreless case the intersection of the two endpoint spaces
is k, because it lies in their actual function-field intersection.
Riemann--Roch gives $\dim V_C=3g(C)-3$. Etale Riemann--Hurwitz
gives $g(Z)-1=n(g(X)-1)$, proving the dimensions in the statement.

## A five-group normal closure

Suppose for example that the normal closure $T\to X$ of f has
five-group deck group P. Pull back the original H to T. Descent of
invariant functions with the specified poles, and Cartier functoriality,
give
\[
K_{H_T}^{P}=q^*K_{H_X}=0.
\]
Every nonzero finite-dimensional representation of a finite p-group in
characteristic p has a nonzero invariant vector: its group algebra is
local, or equivalently every simple module is trivial. Hence
$K_{H_T}=0$. Pullback along the actual refinement $T\to Z$ is
injective on rational functions and maps $K_{H_Z}$ into this zero
space. Thus $K_{H_Z}=0$.

At every reached level the two supplied next groups have a difference
in this zero space. Their unique marked normalized comparison extends
the preceding comparison. Induction gives compatible comparisons at
all levels, which identify the full groups. The argument is symmetric
in the legs and does not require corelessness or a genus-two endpoint.

## The remaining obstruction is not a choice of origin

In the general case the actual $h_N$ is already in $K_{H_Z}$.
It belongs to U precisely when it is zero, by (1). Thus membership
is a sufficient criterion but is not weaker than the remaining
vanishing problem. The two endpoint extension torsors have single
points; their two images on the source torsor can still have a
nonzero relative displacement. Torsor functoriality does not write
this displacement as a difference of endpoint vectors without an
additional compatible origin.

The two trace equations add nothing: both traces of ANY source
kernel vector land in the zero endpoint kernels. An etale source
refinement likewise cannot kill a nonzero difference, since its
pullback is injective on functions. The genuine unresolved test is
therefore the particular quotient class, or equivalently its actual
polar coefficients at the supersingular points.

In the [cored case](cored_ordinary_bt_transport.md), a finite common
Galois refinement and prime-to-five affine averaging produce the
prescribed full comparison with only the genus-two endpoint
indigenous-ordinary. No such finite refinement is supplied by a
coreless span; the quotient class above remains the comparison test.
