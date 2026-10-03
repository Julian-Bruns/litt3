# Two surviving common characters on every smooth family member

Version1,2 October2026. Work over $k=\overline{\mathbf F}_5$ on
$Y_S:V^2=(x^4-1)(x-S)$, $S(S^4-1)\ne0$, and put $\eta_0=dx/V$.
Retain ACTUAL finite etale maps $X\xleftarrow hT\xrightarrow qY_S$
from the SAME smooth connected projective source. Assume
$\phi=h^*f+b^5$, $d\phi=h^*df\ne0$, and a nonzero annihilator $u$.
Require BOTH original second-map descents
\[
2h^*df/u=q^*\eta,\qquad -d\log(u\phi)=q^*\beta,
\]
where $\eta$ is regular with a double Weierstrass zero and
$\beta\ne0$ is regular Cartier-fixed. The second descent is an
additional common-character hypothesis, not a one-leg consequence.

Then
\[
\boxed{\beta=d x\eta_0,\qquad d^2=S.}
\]
Here $d$ is a scalar, not a differential. Exactly TWO of the 24 nonzero
Cartier-fixed vectors survive, for every smooth parameter and all
degrees of the actual maps. Equivalently, for $d\log\ell=-\beta$,
$C(\ell\omega)=0$ for every regular differential $\omega$ on $Y_S$.
The whole-space vanishing is forced by the original source.

Choose $s^2=-S$ so that $d=-2s$, and set
\[
h_s=2x^5+Sx^4+2S+sVx^2,\quad
Q_{s,O}=2h_s^2(sx^2-V),\quad Q_{s,x}=h_s^2/(2s).
\]
Universally in $S$,
$d\log h_s=sx\eta_0$, $dQ_{s,O}=h_s^2\eta_0$,
$dQ_{s,x}=xh_s^2\eta_0$, and
$h_sh_{-s}=4(x^5-S)^2$. Also
$\operatorname{div}h_s=10(P_s-O_Y)$, with $P_s$ one of the two
points over the unique $x_0^5=S$; this is a nontrivial order-five
character, and the opposite sign is its inverse.

For $\eta=\lambda\eta_0$ take $Q=\lambda Q_{s,O}$; for
$\eta=\lambda(x-r)\eta_0$ at a finite Weierstrass point take
$Q=\lambda(Q_{s,x}-rQ_{s,O})$. On the ORIGINAL source there exist
rational $A\ne0,a_0$ with
\[
B=q^*Q+a_0^5,\qquad
\boxed{\phi=A^5/B^2,\qquad u=q^*(h_s^2)A^5/B^3.}
\]
Conversely these formulas on a given field with the original q imply
both differential descents; they do not impose the admissible divisors
or construct an etale map.

In the unique expansion of $h^*f$ in the p-basis
$1,q^*Q,(q^*Q)^2,(q^*Q)^3,(q^*Q)^4$ over $k(T)^5$, the fourth
coefficient vanishes, the third $b_3$ is nonzero, and
$b_2^2=3b_3b_1$. These coefficients are only known to belong to
$k(T)^5$; neither endpoint descent is asserted.

For the actual admissible divisor identities
$\operatorname{div}\phi=3E-5G-10H$ and
$\operatorname{div}u=2E-10H$, the same functions satisfy
\[
\operatorname{div}B=20(q^*P_s-q^*O_Y)+E-5G,
\]
\[
\operatorname{div}A=8(q^*P_s-q^*O_Y)+E-3G-2H.
\]
This retains the selected source zeros. It does not descend the
character through h, manufacture a common finite coefficient, or
solve either unmarked common-cover problem.

[Proof and exact verification](../../Proofs/cartier_and_spin/actual_two_map_twisted_cartier_characters.md).
