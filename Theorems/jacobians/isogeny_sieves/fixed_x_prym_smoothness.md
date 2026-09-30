# Integral Prym and norm constraints from one-form map recognition

Version2,22September2026. Let pi:T->W and h:T->X be ACTUAL finite
etale maps of smooth proper connected curves over F5bar, with X the
fixed genus-nine curve. Put
\[
P_\pi=(\ker[\pi_*:J(T)\to J(W)])^0,\qquad
q=h_*|_{P_\pi}:P_\pi\to J(X).
\]
The scheme kernel of pi_* is smooth. One has the exact alternative
\[
\boxed{h\text{ descends through }\pi\iff q=0;\qquad
h\text{ does not descend}\implies q\text{ is smooth and surjective}.}
\tag{1}
Thus a non-descending actual map cannot give a nonzero Prym quotient
whose differential is deficient. Finite etale kernel components are
allowed. This assertion retains integral homomorphisms, also in
five-divisible covering degree.

For ANY integral v:J(W)->J(X) and integer m prime to five, failure
of map descent implies that [m]h_*-v pi_* is smooth and surjective.
In particular an identity
\[
[m]h_*=v\pi_*+\xi,\qquad d\xi=0,
\tag{2}
\]
forces actual descent. The term xi may be [5]psi or a homomorphism
factoring through relative Frobenius. Rational denominators divisible
by five do not satisfy this criterion.

If T is the first Y-Galois closure of an actual jointly minimal span
X<-Z->Y, with group G, then (1) gives a smooth surjection to J(X)
from the actual Prym P_(T/(T/N)) for EVERY nontrivial normal subgroup
N of G. No simultaneous Galois source or order bound is assumed.

There is also a statement about the CROSS norm for any involution
sigma of T. For this statement only, pi:T->T/<sigma> may ramify. Then
\[
\boxed{\operatorname{Tr}_\pi h^*:H^0(X,\omega_X)\hookrightarrow
H^0(W,\omega_W),\qquad
h_*\pi^*:J(W)\to J(X)\text{ is smooth and surjective}.}
\tag{3}
This includes descending maps. It also injects the three-dimensional
Cartier kernel of X into that of W. The trace of the resulting
Jacobian-norm image in a further double tower is not covered by (3).
If sigma has a fixed point, h_* restricted to its Prym is also smooth
and surjective. Both the quotient and the Prym then have Cartier-kernel
dimension at least three and nonordinary dimension at least three.

Return to two ACTUAL etale maps pi,h. If their cross norm is zero and
five divides deg h, the Prym satisfies the stronger finite-height bound
\[
\boxed{h_*\pi^*=0,\quad5\mid\deg h
\quad\Longrightarrow\quad
\dim\ker C_{P_\pi}^{\,t}\ge3\min(t,2),\qquad
\dim P_\pi-f_5(P_\pi)\ge6.}
\tag{4}
\]
Here t is any nonnegative integer and Cartier acts on invariant regular
one-forms of the actual Prym.
In particular the second kernel has dimension at least six. This does
NOT assert a-number at least six: three blocks of length two are
compatible with (4). It applies to any proper normal layer of the
original Y-leg closure whose own cross norm vanishes and whose map to X
has five-divisible degree, not just to the whole-source Prym. Vanishing
of the original endpoint Hom group does not by itself make every
proper-layer norm zero.

The Prym smoothness in (1) does NOT imply that h_*pi^* is nonzero:
actual cored cubic examples, with Hom(J(W),J(X))=0, have zero cross
norm and allow normal layers of unbounded order. Neither original
genus-two common-cover problem is settled by these constraints.

[Proof](../../../Proofs/jacobians/isogeny_sieves/fixed_x_prym_smoothness.md).
