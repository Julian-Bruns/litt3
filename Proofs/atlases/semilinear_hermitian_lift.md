# Proof: a differential retraction selects the extension candidate

[Statement](../../Theorems/atlases/semilinear_hermitian_lift.md).
Extension classes retain their specified end terms; F_C is absolute
Frobenius, so its operation on cohomology is5-semilinear.

## Rank-two necessity and stability

For a normalized atlas, E/O_C=V. Its adjoint induces the identity on M,
since beta(-,F_C^*e)=q, and restricts to
j:K~>(F_C^*V)^vee tensor M.

Put kappa=2g-2. The HN subline of F_C^*V=K^vee tensor M has degree
3kappa, with quotient M of degree2kappa. A subline R of V with
deg R>=kappa/2 pulls back into this HN line: its degree exceeds2kappa,
so its projection to M is zero. Frobenius preserves saturated lines
on the smooth curve, hence F_C^*R equals that line. Then5deg R=3kappa,
contrary to5 not dividing kappa. Thus V is stable.

## The differential retraction

After canceling M, transport the canonical connection to
J=K tensor M^-1=F_C^*(V^vee). Its filtration is

    0 -> N=M^-1 --i--> J --q--> Q=omega^-1 tensor M^-1 -> 0.

Because Q tensor omega=N, the second fundamental map
c=(q tensor1)nabla i is an endomorphism of the line N, hence a scalar.
It is nonzero. Otherwise N is horizontal and descends under Frobenius by
[Katz, Theorem5.1 (Cartier descent)](https://www.numdam.org/item/PMIHES_1970__39__175_0.pdf#page=17).
Its degree -2kappa would be divisible by5, contradicting the hypothesis.

The differential operator R=c^-1(q tensor1)nabla:J->N restricts to
the identity on N. It is a morphism of sheaves of k-vector spaces,
so P_j=H1(R) retracts i:H1(N)->H1(J). This can be computed on Čech
cocycles of an affine cover; O_C-linearity is unnecessary.

For alpha in Ext^1(V,O_C)=H1(V^vee), the class D_j(alpha), after the
same cancellation of M, is its signed Frobenius pullback in H1(J).
Its cocycle entries in canonical frames are fifth powers, hence horizontal.
R annihilates them. Therefore

    P_j D_j(alpha)=0.                                     (3)

## The canonical candidate and its exact criterion

Applying Ext(M,-) to0->O_C->K->T->0 gives

    0 -> A --i--> U --h--> Ext^1(M,T) -> 0,

since Hom(M,T)=0 and Ext^2 vanishes on a smooth curve. The retraction
splits U=i(A) direct-sum ker P_j; thus h|ker P_j is an isomorphism.
This proves formula(1) and its independence of the chosen xi_0.

Every lift xi of eta has a middle bundle E with E/O_C=V. Its extension
identification is unique because Hom(M,T)=0; let alpha_xi be its class
in Ext^1(V,O_C). The required adjoint is exactly an isomorphism between

    0 -> K -> E -> M -> 0,
    0 -> (F_C^*V)^vee tensor M -> (F_C^*E)^vee tensor M -> M -> 0,

inducing j on the kernel and the identity on M. Classification of
extensions makes this equivalent to xi=D_j(alpha_xi). Such a morphism
is automatically invertible. Its form has the prescribed normalized
column, and the Hermitian atlas criterion gives global etaleness.

By(3), every compatible xi lies in ker P_j, hence must equal xi_*.
Conversely equality(2) supplies the required adjoint for E_*.
This proves necessity, sufficiency and uniqueness of the candidate.
The dual exact sequence defines the sign in D_j intrinsically.

## Frobenius injectivity and the exact semilinear rank

Riemann–Roch gives dim A=5(g-1) and dim U=12(g-1), hence residual
dimension7(g-1). In coordinates xi=xi_0+i(lambda), the canonical
candidate is lambda=-P_j xi_0. Baer sum gives

    alpha_xi=alpha_0+pi^*lambda,

so the semilinear coefficient map is T_j=D_j pi^*.

Write F=F_C and use B_1 in the notation of
[Joshi, Theorem1.1](https://www.numdam.org/item/10.1016/j.crma.2004.02.019.pdf#page=2):

    0 -> O_C -> F_* O_C -> B_1 -> 0.

The theorem makes B_1 stable of rank4 and slope g-1. V is stable of
rank2 at the same slope, so Hom(V,B_1)=0. Tensoring this sequence by
V^vee and using the projection formula proves

    F^*:H1(V^vee) -> H1(F^*(V^vee)) is injective.

The source uses absolute Frobenius, as here. Thus D_j, which is this
map up to its sign and the fixed kernel identification, is injective.
No ordinarity hypothesis is needed.

Dualizing eta yields0->M^-1->V^vee->omega->0.
Stability gives H0(V^vee)=0; the connecting copy of H0(omega) is
therefore exactly ker(pi^*), of dimension g. Hence

    ker T_j=ker(pi^*),
    rank T_j=rank(pi^*)=5(g-1)-g=4g-5.

All twists tau are retained. For genus nine, the40 extension coordinates
are determined before testing the56 residual coordinates; the scalar
realization is [scalar_hermitian_reconstruction](scalar_hermitian_reconstruction.md).
