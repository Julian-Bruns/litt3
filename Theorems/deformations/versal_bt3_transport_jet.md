# The sharp formal jet controlling a BT3 polar discrepancy

Version1,21 September2026. Let $R=k[[t]]$, $k=\overline{\mathbf F}_5$,
and let $G/R$ be the effective universal height-two, dimension-one
group with contravariant window
\[
F=\begin{pmatrix}t&5\\1&0\end{pmatrix},\qquad
V=\begin{pmatrix}0&5\\1&-t\end{pmatrix},\qquad
\sigma(t)=t^5.
\]
Fix the alternating form
$\lambda\left(\begin{smallmatrix}0&1\\-1&0\end{smallmatrix}\right)$
with $\lambda\in W(k)^\times$ and $\sigma(\lambda)=-\lambda$; it
specifies the multiplicative determinant
$\det G[5^m]\simeq\mu_{5^m}$.
Put $A_N=G[5^N]$. Let $\mathscr A_N$ be the group of strict formal
coordinates $\varphi=t+O(t^2)$ with an ACTUAL determinant-preserving
isomorphism $\eta_N:A_N\simeq\varphi^*A_N$, inducing the identity
on both closed Hodge graded lines. This isomorphism is unique.

Use $\eta_N^{-1}$ to mark $\varphi^*A_{N+1}$, and let
$a_N(\varphi)=[t^{-1}]\Delta(A_{N+1},\varphi^*A_{N+1})$.
For $\varphi\in\mathscr A_2$, put
\[
A=(\varphi/t)^{1/4}\in1+tk[[t]],\qquad u_{11}=[t^{11}]A.
\]
Then
\[
a_2(\varphi)=2(u_{11}-u_{11}^{1/25}).
\tag{1}
\]
The least coordinate jet order determining this coefficient is EXACTLY
$M_2=12$: equality modulo $t^{13}$ suffices, and equality modulo
$t^{12}$ does not. The fourth-root coefficients are computed recursively
from the12-jet by
\[
u_r=4^{-1}\left(\varphi_{r+1}
-[t^r](1+\sum_{i<r}u_it^i)^4\right),\quad1\le r\le11.
\]

For every $z\in k$ there is an ACTUAL effective example
\[
\varphi_z=t+z^5t^{12}+O(t^{13})\in\mathscr A_2,
\qquad a_2(\varphi_z)=2(z^{1/5}-z^5).
\tag{2}
\]
In particular $z^3+z+1=0$ gives the nonzero value
$1+4z+4z^2$. The matrices used in the proof retain the crystalline
Taylor correction; an $F,V$-linear but nonhorizontal comparison is
not counted as an element of $\mathscr A_2$.

## Immediate consequences of the actual difference cocycle

For strict formal coordinates, pullback preserves the coefficient of
$t^{-1}$. Therefore $a_2:\mathscr A_2\to(k,+)$ is a group
homomorphism. It is surjective by (2), and vanishes on $\mathscr A_3$.
This does NOT identify its kernel with $\mathscr A_3$: the regular
part of $\Delta$ can remain nonzero.

If the coordinate coefficients belong to $\mathbf F_{5^r}$, the value
in (1) has zero field trace to $\mathbf F_{5^{\gcd(r,2)}}$.
In particular a coordinate over $\mathbf F_{25}$ has $a_2=0$.
These are necessary finite-field consequences; they do not assert
that every trace-zero value has an example over that SAME finite
field, or that universal coordinates for a global span have that
field of definition.

[Proof](../../Proofs/deformations/versal_bt3_transport_jet.md).
