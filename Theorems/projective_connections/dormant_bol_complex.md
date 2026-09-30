# The dormant Bol complex and horizontal tensors

Let C be a smooth projective curve of genus g>=2 over a perfect field
of odd characteristic p. Fix a spin line L^2=omega and a dormant rank-two
theta-oper with Cartier descent W and det W=O. Its descent is stable.
Write F for absolute Frobenius and n=g-1; on F_* modules a.f=a^p f.

## The intrinsic complex and every line twist

There is an exact complex

    0 -> W -> F_*(L^-1) --D2--> F_*(L^3)
      --D_(p-2)--> W omega ->0,                            (1)

whose middle image/kernel is L Sym^(p-3)(W). Here D2 is the scalar
oper operator D^2-r. The operator D_(p-2) comes from its(p-3)rd
symmetric power, tensored by F^*L, and takes values in the horizontal
subsheaf of F_*(L^(2p-1)). At p=5 it is D^3+rD+3(Dr), with the
last term multiplication.

For ANY line bundle N, tensoring(1) gives

    0 -> W N -> F_*(L^-1 N^p) -> F_*(L^3 N^p)
      -> W omega N ->0.                                   (2)

If d=deg N>3n/p, the final global map is onto, with target dimension
2(n+d) and kernel dimension(p-2)d. The gap between its global kernel
and the preceding global image is canonically H1(W N).
Its residue-dual injection

    H1(W N^-1) -> H1(F_*(L^-1 N^-p))                      (3)

has image the annihilator of that global kernel.

If d>=2g-1, W N is globally generated and h0(W N)=2(d-g+1).
Under its horizontal scalar realization in L^-1 N^p, a nonzero section
is nowhere zero exactly when its scalar tensor has a reduced zero
divisor. Such sections form a nonempty geometric open.

## Characteristic five: cubic twists and the horizontal tower

Let p=5, tau^3=O with a chosen trivialization, and V=W L tau^2.
Taking N=L tau^2 gives

    0 -> V -> F_*(omega^2 tau) --L_tau-->
    F_*(omega^4 tau) --Q_tau--> W L^3 tau^2 ->0.             (4)

The middle kernel is I_tau=Sym^2(W) omega tau^2. Put

    A_tau=H0(W L^3 tau^2),    E_tau=H1(omega^-3 tau^-1),
    J_tau=Ann ker(H0 Q_tau) in E_tau.

Then dim A_tau=dim J_tau=4n and dim ker(H0 Q_tau)=3n.
The injection defining J_tau has source H1(W L^-1 tau).
After coefficient-Frobenius transport, J_tau=A_tau^vee.
Moreover ker(H0 Q_tau)/im(H0 L_tau)=H1(V), of dimension h0(V).

For each j>=0, taking N=L tau^2 omega^j identifies the scalar kernel

    ker[H0(omega^(2+5j) tau) --D^2-r--> H0(omega^(4+5j) tau)]

p-semilinearly with H0(V omega^j). Its dimension is h0(V) for j=0
and4j(g-1) for j>=1. For j>=1, its tensors with reduced zeros form
a nonempty geometric open. When tau=O, the j=0 kernel is the tangent
space of the dormant-oper scheme.

Surjections V->omega^2 tau correspond exactly to the reduced-zero
weight-seven tensors, via Hom(V,omega^2 tau)=V omega.
In genus9 their scalar space has dimension32 for every dormant oper,
and J_tau has dimension32 inside the56-dimensional E_tau.
All constructions commute with etale pullback of the specified data.
They do not supply a normalized twisted atlas criterion or a match
between independently chosen endpoint opers.

Version1. Status: proved. Bounded medium audit by
audit_finite_rank_condensation,2026-09-14, passed the all-prime complex,
symmetric-power twists, global dimensions and dual inclusion, including
p=3. Global generation and the horizontal-tensor specialization are
author deductions.
[Proof](../../Proofs/projective_connections/dormant_bol_complex.md).
