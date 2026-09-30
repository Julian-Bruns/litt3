# Only one Cartier-kernel block can grow in a cyclic five-cover of X

Version3,22September2026. Let $X$ be the fixed genus-nine curve,
$V=\ker C_X$ its three-dimensional space of exact regular forms,
and $q:T\to X$ any connected finite etale cyclic cover of degree
$Q=5^r$, $r\ge1$. Choose a deck generator $\gamma$, put
$t=\gamma-1$, and let $E=\ker C_T$. Then, as an actual deck module,
\[
\boxed{E\simeq k\oplus k\oplus k[t]/(t^L),\qquad
L\in\{2,4,\ldots,Q-1,Q\}.}
\]
In particular
\[
\boxed{a(T)\le 5^r+2.}
\]
This improves the general bound $a(T)\le3\cdot5^r$ for these covers.
In degree five, $a(T)\in\{4,6,7\}$. The parity restriction is a
consequence of the actual symplectic Cartier bundle and the
[cyclic block theorem](../deformations/section_growth/cyclic_symplectic_blocks.md).
It does not assert that every displayed value of $L$ occurs.

There is an intrinsic description of the only possible growing line.
Let $\eta\in H^1(X,\mathcal O_X)$ be the nonzero Frobenius-fixed
Artin--Schreier class of the first degree-five quotient, normalized
by $\eta(\gamma)=1$ in the corresponding group cohomology. Define
\[
R_\eta=\{u\in V:\langle\eta,\tau_X(u,v)\rangle=0
                    \text{ for every }v\in V\},
\]
using Serre duality and the intrinsic double-Cartier operation of
[two-form recognition](two_form_map_descent.md). Then $\dim R_\eta=1$
and
\[
tE\cap E^{\langle\gamma\rangle}\subseteq q^*R_\eta.
\]
This inclusion is equality. The result retains the actual
cover and its deck action; it is not a statement about arbitrary
linear models or only the isogeny class of its Jacobian.

The one-line conclusion genuinely uses cyclicity. There are actual
connected finite etale covers $q_A:T_A\to X$ with
$A\simeq(\mathbf Z/5)^2$ for which, writing $J\subset k[A]$ for
the augmentation ideal and $E_A=\ker C_{T_A}$, one has
\[
\boxed{JE_A\cap E_A^A=E_A^A=q_A^*V,\qquad a(T_A)\ge7.}
\]
One can take the cover defined by any nonzero Artin--Schreier
character and its cubic translate. Thus all three invariant
directions grow in this actual cover. This does not refute the
numerical inequality $a(T_A)\le27$, which is not decided here.

No restriction on an arbitrary mixed-monodromy common cover, finite
closure of a two-leg orbit, or verdict on either original problem follows.
[Proof](../../Proofs/cartier_and_spin/cyclic_cartier_orbit_bound.md).
