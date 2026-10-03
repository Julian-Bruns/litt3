# Proof: the quotient containing the actual BT comparison difference

[Statement](../../Theorems/deformations/two_ordinary_bt_comparison.md).
The next-level torsor and comparison criteria are those of
[Cartier realization](versal_bt_cartier_realization.md).

## The intrinsic Cartier map and the endpoint towers

The [absolute torsor](versal_bt_extension_torsor.md) defines the
coherent Cartier map on $L_C=\mathcal O_C(S_C)$. On functions this is
the inverse-Frobenius-semilinear $\mathcal T_C$, commuting with actual
etale pullback and trace and fixing $1$. The same theorem constructs
unique normalized full groups at both ordinary endpoints, starting
with the supplied ACTUAL BT1s, without a global reference.

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

Take the ACTUAL Galois closure $T\to X$ of one leg when its
group $P$ is a five-group. Invariant functions give
$K_{H_T}^P=q^*K_{H_X}=0$. The
[finite-module lemma](versal_bt_extension_torsor.md#five-group-coefficient-modules)
with invariant dimension zero gives $K_{H_T}=0$. Actual pullback
along $T\to Z$ injects $K_{H_Z}$ into this zero space.

At every reached level the two endpoint next groups have a difference
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
