# Two mixed coefficients recover the degree-eleven annihilator divisor

Version1, 1 October2026. Retain an actual connected primitive finite
étale source $h:S\to X$ of degree eleven with the fixed admissible
divisor data $H=h^*O$, $E$ reduced of degree 55, and $G$ effective of
degree eleven, disjoint from $E$, such that
\[
\operatorname{div}\phi=3E-5G-10H,\qquad
h_*E=5(2O+D_{\rm fin}).
\]
Here $D_{\rm fin}$ is the reduced nine-point finite support,
$\operatorname{div}t=D_{\rm fin}-9O$, and
$\operatorname{div}v=h_*G-11O$. Thus each finite endpoint has five
selected $E$-sheets, while infinity has ten selected sheets and one
unselected sheet. Choose the scalar normalization of $t$ so that the
actual primitive polynomial in the short coordinate has form
\[
F(T)=\phi(T)Q(T)-t^3,\quad \phi(T)=T^5+q,
\quad\deg Q=6,\quad\operatorname{lc}F=v.
\]
Put $D(T)=\partial_TQ$, using formal degree five, so $F'=\phi D$,
and $\Delta=\operatorname{Res}_{11,5}(F,D)\ne0$.
Write $L_m=H^0(X,\mathcal O_X(mO))$.

For any polynomial $U$ of degree at most six, put $u=U(W)/D(W)$.
Then $\operatorname{div}u=2E-10H$, after scalar norm normalization,
if and only if the following polynomial identities have auxiliaries
in the stated spaces.

First choose $a_j,a_j'\in L_{10j}$ for $1\le j\le4$,
$a_5\in L_{42}$ and $a_6\in L_{50}$, and define
\[
M(Z)=Z^{11}-a_1Z^{10}+a_2Z^9-a_3Z^8+a_4Z^7-a_5Z^6+a_6Z^5
-t^2a_4'Z^4+t^4a_3'Z^3-t^6a_2'Z^2+t^8a_1'Z-t^{10}.
\]
Require the formal-degree carry identity
\[
\operatorname{Res}_{11,6}(F,ZD-U)=v\Delta M(Z).
\]
Next choose $b_5\in L_{50}$ and $b_{10}\in L_{145}$ and require
\[
[z^5]\operatorname{Res}_{11,10}(F,\phi D+zU)
=\Delta t^{10}b_5,
\]
\[
[z^{10}]\operatorname{Res}_{11,10}(F,\phi D+zU)
=\Delta b_{10}.
\]
All identities retain the formal degrees when leading coefficients
vanish; none divides by $v,t$ or $\Delta$.

The carry identity supplies finite regularity of both $u$ and
$u'=t^2/u$, and their pole bounds ten on every infinity sheet.
The fifth mixed coefficient assigns the selected finite divisor;
the tenth assigns the ten selected infinity sheets. Necessarily
$b_{10}$ has exact pole order 145. Also
$\operatorname{Tr}u$ has exact pole order ten, so its $y$ coefficient
in $L_{10}$ is nonzero. In particular an annihilator with zero ordinary
trace cannot exist in this degree-eleven profile.

Conversely every actual annihilator supplies such a degree-six $U$
by the uniform trace-dual interpolation lemma. This is an exact divisor
detector on an already actual primitive étale source. It does not decide
existence of that source or nontriviality of its order-five class, and
does not assert any reciprocal low-degree numerator.

[Proof](../../Proofs/cartier_and_spin/admissible_degree_eleven_mixed_divisor_detector.md).
