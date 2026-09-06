# Horizontal Borel reductions: simple collisions and a Mumford boundary

Date: 2026-09-05. Author: `/root/common_horizontal_line_dormant_oper_screen`.
Status: elementary author proofs; not independently audited. These are
screening lemmas, not a proof that a common horizontal Borel forces a core.

## 1. Reduced collisions are automatic

Let `(E, nabla, L)` be a regular rank-two oper on a smooth curve in
characteristic different from two, and let `H` be a saturated horizontal
line subbundle. Then the nonzero map `H -> E/L` has reduced zero divisor.
No zero-p-curvature assumption is needed for this assertion.

Indeed, suppose the two lines meet at a point P. Choose a local generator
h of H and a local frame `(l,q)` of E, with l generating L, and write
`h=u l+v q`. Here `v(P)=0` and `u(P)` is nonzero. Write
`nabla(h)=alpha h`, using horizontality. Modulo L, the value at P of this
identity is

    u(P) KS(l)(P) + dv(P) q(P) = 0.

The oper Kodaira--Spencer map is an isomorphism, so `dv(P)` is nonzero.
Thus v has a simple zero. The projection cannot vanish identically,
because the oper line itself is not horizontal.

For an SL2-oper with `L=theta`, `theta^2=omega`, write the collision
divisor as D. The projection identifies

    H = theta^(-1)(-D).

When the connection is dormant, Cartier descent gives `H=F^*M`, hence

    p deg(M) = -(g-1)-deg(D).

For actual finite etale legs preserving the oper and H, the collision
divisors are actual pullbacks from both endpoints. Thus a nonempty D
already supplies a common reduced divisor. Reducedness imposes no
extra restriction beyond the regular oper and horizontal Borel.

## 2. The arithmetic Mumford construction has no common horizontal Borel

Consider precisely the analytic span and common oper in
[the Mumford construction](DORMANT_OPER_CORELESS_MUMFORD_CONSTRUCTION.md),
over `C_infinity`. Its group `H_group=<Gamma,Gamma'>` contains a nontrivial
element delta in the indicated compact open pro-5 group, with distinct
powers `delta^(5^m)` tending to the identity. The noncentral quaternion
element representing delta is semisimple after extending scalars:
its degree-two minimal polynomial is separable in characteristic five,
and a division algebra has no nonzero nilpotents.

After a constant projective change of coordinates on both the domain
and fiber, delta therefore acts by `z -> lambda z`, where

    lambda = 1+epsilon,     0<|epsilon|<1.

The inequality follows from delta being in the kernel of reduction;
the two eigenvalues of a near-identity representative are near one.
Nontriviality and semisimplicity give epsilon nonzero. In characteristic
five, `delta^(5^m)` acts by `z -> (1+epsilon^(5^m))z`.

Suppose a horizontal Borel reduction were preserved by both actual
legs. Pulling it back to the common uniformizing domain gives an
`H_group`-equivariant analytic map B to `P^1`. The connection there is
trivial, so horizontality says `dB=0`.

If B is not identically infinity, choose a finite domain point z at
which B is finite and analytic. Its Taylor expansion at z contains
only exponents divisible by five. Put `a_m=epsilon^(5^m)`. Equivariance
under `delta^(5^m)` gives

    B((1+a_m)z)-B(z) = a_m B(z).

For this fixed z, the left side is `O(|a_m|^5)` as m tends to infinity.
Dividing by a_m and taking the limit proves `B(z)=0`. This holds on a
nonempty analytic open, so B is identically zero on the connected
uniformizing domain. If B was identically infinity, it was already
constant. Consequently B is a constant delta-fixed point in all cases.

Full equivariance would make this point fixed by Gamma. A subgroup
of `PGL2(C_infinity)` fixing a point is contained in a Borel and is
solvable. Gamma is a nonabelian free group, which is not solvable.
This is a contradiction.

Thus the characteristic-five arithmetic Mumford span used to refute
the oper-only implication does not itself refute the implication
with a compatible horizontal Borel. The argument is analytic over
`C_infinity`; it does not exclude appearance of such a reduction on
specialized fibers over `Fbar5`. Existence of a compatible reduction
can jump in specialization. Moreover, horizontal subline degrees have
not been bounded: the corresponding possible collision degrees are
unbounded, so degree-by-degree parameter spaces give potentially
countably many bad loci. One cannot conclude that a closed point of
a finite-type `F5` model avoids all of them merely because its generic
fiber has no compatible reduction. This note supplies no specialization
theorem for the absence of a horizontal Borel.

## Scope

For a single curve, a dormant oper always admits horizontal line
subbundles: choose a rational line in its Cartier descent and saturate,
then pull back. Their simultaneous preservation by the two prescribed
maps is the additional global problem. Existing generic-Miura/Tango
correspondences concern the everywhere-transverse case; applying them
to a collision-bearing Miura oper requires further marked or logarithmic
data. Neither lemma above proves or refutes the proposed general
corelessness obstruction over `Fbar5`.
