# The dormant differential complex with every cubic torsion twist

Let C be a smooth projective curve of genus g>=2 in characteristic5.
Fix theta^2=omega and a dormant rank-two fixed-theta oper with stable
Cartier descent W and det W=O. Let tau^3=O, with a chosen trivialization.
F denotes absolute Frobenius, using the conventions of the atlas library.

There are intrinsic differential operators

    L_tau:omega^2 tau -> omega^4 tau,
    Q_tau:omega^4 tau -> omega^7 tau,

locally D^2-r and D^3+rD+3Dr in an oper coordinate and horizontal tau
frame. They induce the exact complex of coherent O_C-modules

    0 -> W theta tau^2 -> F_*(omega^2 tau) --L_tau-->
    F_*(omega^4 tau) --Q_tau--> W theta^3 tau^2 ->0.          (1)

The last term is realized by horizontal scalar sections of omega^7 tau.
The common middle image/kernel is canonically

    I_tau = Sym^2(W) tensor omega tau^2.

In particular Q_tau is onto on global sections. If
A_tau=H0(W theta^3 tau^2), then

    dim A_tau=4(g-1),    dim ker(H0 Q_tau)=3(g-1).

Writing E_tau=H1(omega^-3 tau^-1), the residue-dual subspace

    J_tau = Ann ker(H0 Q_tau) in E_tau

has dimension4(g-1) and is the image of the canonical injection

    H1(W theta^-1 tau) -> H1(F_*(omega^-3 tau^-1)).           (2)

After the same coefficient Frobenius transport as in the scalar library,
J_tau is identified with A_tau^vee. No ordinarity or vanishing of
H0(W theta tau^2) is assumed. The latter space measures precisely the
gap between the bounded/global image of L_tau and the kernel of Q_tau.

For g=9 this gives a32-dimensional dual space inside E_tau of dimension56
for EVERY cubic torsion class, not just tau=O. The cohomological Bezout
construction also applies, with V=W theta tau^2, T=omega^-1 and
M=omega^2 tau, giving a(24+h0(V))-square mixed matrix. If h0(V)=0 it
is quadratic24x24 and inverse to cup product, but it need not be symmetric
when tau is nontrivial.

Scope: this proves the twisted operator complex and dual-space construction.
It does NOT yet identify a globally normalized twisted atlas residual with
the resultant gradient or supply its complete64-variable scalar equations.
That compatibility must be proved, not inferred merely by analogy.

Status: author proof,2026-09-07; not independently audited.
[Proof](../Solutions/Sol_twisted_bol_complex.md).
