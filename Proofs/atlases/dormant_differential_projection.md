# Proof: specialize the Bol complex and compare the full tensor maps

[Statement](../../Theorems/atlases/dormant_differential_projection.md).
Use the fixed curve, delta, theta=dx/y^2, t, affine ring Acal and
reductions of `scalar_hermitian_data`. Write Theta=O(8O) for the
theta characteristic, so Theta^2=omega=O(16O). Fix a geometric oper
with Cartier descent W. The assertion concerns each such oper.

## The intrinsic complex supplies every local calculation

Apply the [dormant Bol complex](../projective_connections/dormant_bol_complex.md)
with spin line L=Theta and N=Theta.
Its rational scalar frame is the one used here, so its two operators are

    L_r=delta^2-P,       Q_r=delta^3+P delta+3(delta P).

It gives, at every point of C,

    0 -> W(8O) -> F_*O(32O) --L_r--> F_*O(64O)
      --Q_r--> W(24O) ->0,                                  (1)

with middle image/kernel Sym^2(W) omega. The generic fibers give
ker Q_r=im L_r, im Q_r=ker L_r, and both compositions zero over k(C)^5.
Tensoring (1) gives every asserted integer twist. The intrinsic regular
frames already include O; no separate cancellation at its rational-frame
poles is required.

The same theorem makes global Q_r onto, with target dimension32 and
kernel dimension24. Its first short exact sequence gives

    ker(H0 Q_r)/im(H0 L_r)=H1(W(8O)),

whose dimension is h0(W(8O)), since chi(W(8O))=0. Thus the complete
Q kernel is retained at nonacyclic opers.

## The horizontal 32-space is the dual image

The basic Bol complex with N=Theta^-1 gives the scalar inclusion

    W(-8O) -> F_*O(-48O),

whose quotient embeds in F_*O(-16O) and has no global sections.
Its H1 map is therefore injective. Stability and Riemann--Roch give
source dimension32. In the affine/open-neighborhood Cech presentation,
its image consists exactly of classes with rational horizontal
representatives.

Finite-Frobenius duality identifies this map, up to the fixed nonzero
normalization, with the Serre dual of the last map in (1).
Consequently its image in P48 is

    J_r=Ann ker(Q_r:L64->S_U).

This also follows from the Cartier residue pairing with theta in the
Bol theorem. Before coefficient transport the scalar map is
Frobenius-semilinear; over the perfect coefficient field its image
is the stated k-subspace. No bounded/global image of L_r is substituted
for ker Q_r.

## The full tensor comparison and the R-image

With N=Theta^-3, the Bol complex similarly gives

    W(-24O) -> F_*O(-128O),

with quotient contained in F_*O(-96O). Its H1 map is a fixed injection
from dimension64 into dimension136. On Cech cochains the cup product
u tensor eta has scalar representative U eta^5. Thus, before taking
kernels, the old principal-part tensor is J times the64-row cup-product
tensor for one fixed injective matrix J.

In absolute Frobenius coordinates the cup-product matrix is first
raised entrywise to the fifth power; the Wronskian/residue definition
of Ntilde incorporates exactly this power. Hence the comparison holds
for arbitrary sums and every restriction used by the coupled sieve.

For such a tensor in the common kernel put H=sum U_i eta_i^5 and

    T=-aff(H),       V=rem(H).

Then val_O V>=128 and L_r H=0. Hence L_r T=L_r V. The left side is
affine, while the right side vanishes at O: the twisted Bol map puts
it in O(-96O). They therefore vanish identically on the projective
curve. The unreduced R-output is

    Y=kappa^5 V-sum U_i(-rho32(delta eta_i))^5.

Every summand is horizontal, so rho48Y belongs to J_r by the preceding
section. This proves R(ker Ntilde) subset J_r for the entire tensor
space, including every restricted sieve tensor.

The [original bounded audit](../../Research/audits/COHOMOLOGICAL_ODE_COMPARISON_2026_09_07.md)
checked the tensor comparison and R-image. The intrinsic exactness used
above passed the bounded audit recorded with the Bol theorem.
The retained `wronskian_differential_projection.sage` and its JSON verify
the scalar matrix for the first noninvariant F25 oper; that matrix is
also input to the saved line-gradient calculation.

The fixed32-space is a necessary atlas restriction. The full residual
and Wronskian normalization remain part of the atlas criterion.
