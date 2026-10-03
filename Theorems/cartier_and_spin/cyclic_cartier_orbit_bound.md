# Only one Cartier-kernel block can grow in a cyclic five-cover of X

Version4,3 October2026. Let $X$ be the fixed genus-nine curve,
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
This inclusion is equality. The Frobenius-fixed
Artin--Schreier space has its intrinsic three-dimensional F25
structure from the cubic automorphism. The radical assignment
identifies its F25 projective plane with exactly
\[
\boxed{651=(25^3-1)/(25-1)}
\]
possible growing lines in V. Each line corresponds to six of the
3906 connected degree-five covers, counted without a deck
generator. This is an intrinsic finite projective geometry;
no character census is required.

On N_T=H^1(T,O_T)_nil, the
[actual free deck-module theorem](../jacobians/etale_frobenius_degree_gap.md)
gives N_T~=R^3, R=k[t]/(t^Q). The linearization of semilinear
Frobenius has Smith entries t,t,t^L (t^Q=0), equivalently
\[
\operatorname{coker}F_T\simeq k\oplus k\oplus R/(t^L).
\]
This identifies its first kernel and cokernel as deck modules;
Smith form alone does not determine Frobenius iterates.

The one-line conclusion genuinely uses cyclicity. There are actual
connected finite etale covers $q_A:T_A\to X$ with
$A\simeq(\mathbf Z/5)^2$ for which, writing $J\subset k[A]$ for
the augmentation ideal and $E_A=\ker C_{T_A}$, one has
\[
\boxed{JE_A\cap E_A^A=E_A^A=q_A^*V,\qquad a(T_A)\ge15.}
\]
There are exactly651 such cubic-stable rank-two covers, one for
each possible growing line: use a nonzero Artin--Schreier
character and its cubic translate. All three invariant directions
grow in each of these actual covers. The lower bound15 follows
from the later augmentation-layer bound and in fact holds for
EVERY actual (C5)^2 cover of X. This does not refute the
numerical inequality $a(T_A)\le27$, which is not decided here.

No restriction on an arbitrary mixed-monodromy common cover, finite
closure of a two-leg orbit, or verdict on either original problem follows.
[Proof](../../Proofs/cartier_and_spin/cyclic_cartier_orbit_bound.md).
