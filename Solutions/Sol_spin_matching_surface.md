# Proof: the matching torsor, resolution, and order-seven quotient

[Statement](../Theorems/Thm_spin_matching_surface.md). Author /root,
2026-09-08; bounded medium audit /root/audit_spin_matching_surface.
Work over algebraically closed k of characteristic5. All curves A,B,X,Y
in the statement have genus at least two and all branch divisors are
nonempty and reduced. Put D_W=f*D_A=g*D_B. The formulas to prove are
N_(W/R)=O_W(-2D_W) and N_(Z/T)=omega_Z^(-3). Throughout, normal line
means the tangent cokernel of an unramified map; no embedding is required.

## The global torsor and local resolution

Choose rational primitives H_A,H_B. On a product of local charts, subtract
fifth powers from H_i to remove their poles. This is possible because
dH_i is regular: each polar term of H_i has exponent divisible by5.
The resulting local regular primitives differ on overlaps by fifth powers
of regular functions. The equations z^5=H_A-H_B therefore glue, with
translations of z, to an alpha_5 torsor S over A times B. The right side
is not a fifth power in the product function field since its differential
is alpha_A-alpha_B!=0. Thus S is integral. Its singular locus is precisely
D_A times D_B by the Jacobian criterion; it is normal since a hypersurface
with isolated singularities satisfies R1 and S2. The relative dualizing
line is trivial (the monic hypersurface equations glue by translations),
so omega_S=pi*omega_(A times B).

At a zero, remove the local primitive's terms of order<9; all of them
are fifth powers. Its remaining leading term has degree9 with nonzero
coefficient. Extracting a ninth root of the unit changes parameter so
that the regular primitive is exactly t^9. This proves the formal model.

Blow up the origin in the (t,s)-plane. In the chart s=t*v put z=t*z1;
the normalization has equation z1^5=t^4(1-v^9). Away from the nine roots
of v^9=1 it is regular; its central exceptional curve is rational, since
its residue field is k(v) (ramification index5, residue degree1).
At each root put w=1-v^9. The normalization of z1^5=t^4*w is the
fifth Veronese ring k[a^5,a^4 b,...,b^5], with t=a^5,w=b^5,z1=a^4 b.
Its resolution is the total space of O_P1(-5); this toric description
is valid in characteristic5, without treating mu_5 as an etale group.

Before resolving these nine toric points, the rational self-intersection
of the central divisor is-1/5: its pullback multiplicity from the base
exceptional curve is5 and the cover has degree5. Resolving each toric
point subtracts1/5, giving central square-2. Each outer curve has square-5.
Adjunction then gives K_R.Ecentral=0 and K_R.Eouter=3. The discrepancy
equations are -2a0+9a1=0, a0-5a1=3, hence a0=-27,a1=-6.

For an actual matching W, H_A-H_B is a fifth power in k(W); its unique
root gives a rational section of the torsor, which extends over the
normal curve W because S is finite over the product. Lifting to R uses
properness and the fact that the generic image avoids the singular locus.
Near a point of D_W, use t as parameter on W, since its map to A is etale.
Write s=t*v(t), v(0)=c, c^9=1. In the outer resolution chart the equations are

    w=t*h^5,    z1=t*h,    z=t²*h,    v^9=1-t*h^5.        (3)

The fifth-power condition forces ord(z)>=2, so h is regular on W. Thus W
meets one outer curve transversely, away from its intersection with the
central curve. The coordinate t proves injectivity of the tangent map.
Away from this grid, the etale projection to A proves the same on smooth S.
Pulling back the discrepancy formula gives

    i*omega_R = omega_W² tensor O_W(-6D_W).

Taking determinants in the tangent sequence gives
N_i=omega_W tensor(i*omega_R)^(-1). The common differential identifies
omega_W=O_W(8D_W), proving the first normal formula.

## The order-seven quotient and four forced blowups

For root endpoints, the torsor has a compatible order-seven action.
Choose eigen-primitives by averaging over this tame group; the action
on z has character zeta^3 since 5*3=1 modulo7. Local parameters may be
chosen equivariantly in the preceding ninth-root construction.
In (3), t has character zeta^4 and h=z/t² has character zeta^2.

The root curve W of any original spin match Z is a degree-seven cover
of Z, ramified precisely at D_W, with the same action on t. Consequently
its regular function h(t) has exponents congruent to4 modulo7:

    h(t)=t^4 lambda(t^7).                                (4)

On each outer exceptional curve the action on h has exactly two fixed
points: infinity, meeting the central curve, and h=0. Blow up h=0,
then the three successive finite fixed points forced by (4). After
four blowups a chart has coordinates (t,lambda=h/t^4); the action is
(t,lambda)->(zeta^4*t,lambda). Every W meets this chart at t=0 and finite
lambda. Each blowup subtracts D_W from its normal bundle, so on the
resulting smooth surface R4 its normal line is O_W(-6D_W).

The quotient R4/mu_7 is smooth along EVERY such image: in this chart its
coordinates are (xi=t^7,lambda), and elsewhere W avoids fixed points
because the cyclic action on A is free away from D_A. Resolve any
remaining singularities away from these curves to obtain T. The map
Z=W/mu_7->T is unramified; locally xi is its parameter and the original
etale X-coordinate. The root normal bundle is the pullback of N_(Z/T),
including at these tame branch points, because the normal direction is
lambda and the quotient fixes lambda.

Finally omega_W=pi_W*omega_Z tensor O_W(6D_W)=O_W(8D_W), hence
pi_W*omega_Z=O_W(2D_W). Thus pi_W*N_(Z/T)=pi_W*omega_Z^(-3).
Pullback Pic(Z)->Pic(W) is injective: its kernel is killed by7 by the
norm, and a nontrivial killed order-seven line would give an etale
degree-seven subcover of the RAMIFIED prime-degree cover W->Z, impossible.
This proves the second formula. The morphisms R4->A->X and R4->B->Y are invariant
under the diagonal action, so descend to the coarse quotient and T.

## Limits and relation to the old local classification

Formula (4), after quotienting, gives y=c^7 xi(1-xi³ lambda^5)^(7/9).
This agrees with the existing sharp local spin-Cartier matching formula;
it does not improve its contact bound. The new claim is a SINGLE global
smooth surface for fixed endpoint data and the normal line omega_Z^-3.
Nothing proves these immersed curves have bounded degrees or cannot exist.
Replacing immersion by embedding would be a serious unjustified step.

An optional numerical check on R (not needed for (1) or (2)): if
d_i=deg D_i, then K_R²=478 d_A d_B and c2(R)=74 d_A d_B. Indeed
K_S²=640 d_A d_B and each resolution contributes-162 to K² and+10
to the Euler number. These surfaces therefore do NOT satisfy the
characteristic-zero BMY inequality; no lifting/char0 positivity is assumed.
