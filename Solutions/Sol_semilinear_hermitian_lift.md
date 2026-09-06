# Proof: the horizontal differential retraction eliminates the extension

Canonical [statement](../Theorems/Thm_semilinear_hermitian_lift.md).
All extension classes include their specified end terms. F_C is absolute
Frobenius; additive operations below are 5-semilinear on k-vector spaces.

## The rank-two necessity

Given a normalized atlas form beta and V=E/O_C, the adjoint
phi:E -> (F_C^*E)^vee tensor M induces the identity on the quotient M,
because beta(-,F_C^*e)=q. Its restriction is therefore an isomorphism

    j:K -> (F_C^*V)^vee tensor M.

In particular F_C^*V is K^vee tensor M. Its unique HN subline is
omega tensor M, of degree 3kappa, and its quotient is M, of degree
2kappa, where kappa=2g-2. If V had a subline R of degree at least
kappa/2, then F_C^*R could not map nontrivially to M. It would lie
in the HN subline. Since Frobenius preserves subbundles on a smooth
curve, F_C^*R is saturated and must EQUAL that subline. This would give
5 deg R=3kappa, impossible under the stated assumption. Thus V is stable.

## The extension equation

Apply Ext^1(M,-) to 0 -> O_C -> K -> T -> 0. Negative degrees give
Hom(M,T)=0, and Ext^2 of bundles on a smooth curve vanishes. Hence

    0 -> A --i--> U -> Ext^1(M,T) -> 0.                          (1)

All lifts of eta are xi_lambda=xi_0+i(lambda), with lambda in A.
Their middle bundles E_lambda contain the prescribed K and O_C.
The quotient by O_C is V with its prescribed extension structure:
its identification is unique because Hom(M,T)=0.

Viewed as extensions of V by O_C, their classes satisfy

    alpha_lambda=alpha_0+pi^*(lambda).                          (2)

This follows either from the defining pullback/pushout description of
Baer sum, or from upper-triangular transition matrices for the two-step
filtration O_C subset K subset E. In the latter description, adding
lambda changes only the top-right extension cocycle, which pulls back
along pi when E is viewed as an extension of V.

The desired adjoint phi is an isomorphism of the two exact sequences

    0 -> K -> E_lambda -> M -> 0,
    0 -> F_C^*V^vee tensor M -> F_C^*E_lambda^vee tensor M -> M -> 0,

with kernel map j and quotient map the identity. Such a morphism
exists exactly when their extension classes agree after identifying
kernels. It is automatically an isomorphism. By (2) that equality is

    xi_0+i(lambda) = j^-1_*D(alpha_0) + j^-1_*D(pi^*lambda),

which is (*). Defining D as the actual dual exact sequence fixes any
Cech sign convention; dualization must not be silently replaced by
unsigned transposition of a representative matrix.

The adjoint defines a nonsingular beta with the required column q.
The audited atlas criterion supplies automatic transversality and an
actual finite etale atlas. Conversely any such lift gives (*).

Riemann--Roch and the line filtration of K give dim A=5(g-1),
dim U=12(g-1); their difference is 7(g-1). Replacing xi_0 by
xi_0+i(mu) replaces b by b+T_j(mu)-i(mu), exactly the translation
lambda -> lambda-mu, proving independence of this choice.

## The differential retraction

Tensor j by M^-1 to identify J=K tensor M^-1 with F_C^*(V^vee).
The latter has the canonical connection nabla with zero p-curvature.
Transfer that connection to J. The filtration of K gives

    0 -> N=M^-1 --i--> J --q--> Q=omega^-1 tensor M^-1 -> 0,

and Q tensor omega=N. Its second fundamental map

    c=(q tensor1)nabla i:N -> N

is O_C-linear: the Leibniz correction vanishes because qi=0. Since C
is connected and projective, c is multiplication by a scalar in k.
This scalar is nonzero. Otherwise nabla preserves N; Cartier descent
would make N a Frobenius pullback, forcing its degree -2(2g-2) to be
divisible by5, contrary to the hypothesis.

For this particular line-subbundle assertion, descent can also be seen
locally without a general theorem: in a canonical horizontal frame of
F_C^*(V^vee), a saturated line has a generator (1,h) after choosing a
unit coordinate and rescaling. Invariance under the connection forces
dh=0. Over the perfect field k, h is a fifth power in the function
field, and its fifth root is regular by its nonnegative valuations.
The resulting local lines in V^vee glue by uniqueness. This proves
the divisibility assertion used above.

Define the first-order k-linear sheaf differential operator

    R=c^-1(q tensor1)nabla:J -> N.

Its restriction to N is the identity. Thus the induced map
P_j=H1(R):H1(J)->H1(N) is a retraction of i. Although R is not
O_C-linear, it is a morphism of sheaves of k-vector spaces. Coherent
cohomology is the same underlying sheaf cohomology, so this induced map
is legitimate. It can equivalently be computed on Cech cocycles for an
affine open cover and its affine intersections.

## Why all dual Frobenius extensions are killed

If alpha represents an extension of V by O_C, its Cech class lies in
H1(V^vee). Frobenius pullback followed by duality and tensoring by M
gives, after j and cancellation of M, the signed Frobenius pullback
class in H1(F_C^*(V^vee)). In a local frame its cocycle entries are
fifth powers. Such sections are horizontal for the canonical connection.
Consequently R annihilates these cocycles, regardless of the duality sign:

    P_j j^-1_*D(alpha)=0.                                  (3)

In particular P_j T_j(lambda)=0 for every lambda. Applying P_j to
the extension equation (*) therefore forces

    lambda=P_j b=-P_j xi_0.                                (4)

Conversely substituting (4) into (*) leaves exactly the residual (***)
in ker P_j; its image under P_j is already zero. This proves necessity
and sufficiency, uniqueness of the extension candidate, and the residual
dimension dim U-dim A=7(g-1). It applies to every allowed torsion twist
tau, since the two line bundles satisfy Q tensor omega=N regardless
of tau. The projection is determined by the fixed j and markings, not
claimed independent of changing those data.

Replacing xi_0 by xi_0+i(mu) replaces (4) by lambda-mu, so the actual
candidate extension class xi_0+i(lambda) does not change. The argument
is pointwise in fixed geometric data; a relative construction on a
nonreduced base requires its own justification.

## A useful rank bound

Dualizing the quotient presentation of V gives

    0 -> M^-1 -> V^vee -> omega -> 0.

Stability of the positive-degree V gives H0(V^vee)=0. Hence H0(omega),
of dimension g, injects into H1(M^-1) as the exact kernel of pi*.
The latter map has rank5(g-1)-g=4g-5. Since T_j factors through pi*,
its rank is at most4g-5. Frobenius twists the kernel coordinates but
does not change this dimension over the perfect field k.

## Exact remaining issue

For genus nine, the40 extension variables are uniquely determined for
each fixed V,pi,j; there are56 residual coordinates to test. They cannot
be dismissed. The finite set of dormant rank-two classes still leaves
continuous choices of quotient maps and identifications. This theorem
supplies no atlas exclusion. Its explicit fixed-X implementation is
`scalar_hermitian_reconstruction`.
