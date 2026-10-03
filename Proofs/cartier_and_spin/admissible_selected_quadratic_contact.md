# Proof of selected short quadratic contact

Version1,1 October2026. [Statement](../../Theorems/cartier_and_spin/admissible_selected_quadratic_contact.md). The contact and residue argument originates in Section3 of the incoming [critical-cubic report](../../../litt3-computation-data/oct01_pro_replies/critical_cubic_archive/critical_cubic/REPORT.md). This proof adds the $v=s_4=0$ boundary. The report's separate assumption $Q_f(0)(P)=0$ is not used or inferred here. The actual divisor, coefficient, and moment inputs are those of [critical incidence](admissible_critical_quadratic_incidence.md).

Work over $R=k[[r]]$ at a selected endpoint; actual etaleness splits the completed source into ten copies of $R$. Label their Laurent-series roots $W_i$. Generic separability and interpolation give
\[
U(T)=\sum_i\frac{u_i}{\phi_i}\,v\prod_{j\ne i}(T-W_j).
\]
The selected roots vanish. A selected branch shows $q_s=\phi_i-W_i^5$ has order three. Every finite nonselected root therefore has nonzero residue, since its $\phi_i$ is a unit. A pole root of order $g_i$ belongs to $G$.

On a selected branch, the four other selected roots contribute at least four to $\operatorname{ord}F'(W_i)$; the negative pole-root contributions cancel against the content $\operatorname{ord}v=\sum g_i$. Thus $F'(W_i)$ has order at least four and $D(W_i)$ has order at least one. Consequently $D\bmod r$ vanishes at $T=0$.

Evaluation of $F(W_i)=0$ on a selected branch shows $S(W_i)$ is a unit: $\phi_iS(W_i)$ must cancel $t^3$, both of order three, whereas $v\phi_i^2$ has order at least six. It follows that
\[
F\bmod r=T^5H_0(T),\quad H_0(0)\ne0,\quad D\bmod r=H_0'(T),\quad H_0'(0)=0.
\]
Primitive Gauss content shows that the roots of $H_0$, counted with multiplicities, are precisely the finite nonselected root residues. The universal numerator jets give $U\bmod r=T^3L$, with $\deg L\le2$.

Fix a nonzero root $\lambda$ of $H_0$ of multiplicity $m$, and use the ideal $I=(r,T-\lambda)$ in the regular local ring. In the interpolation formula, a selected term has all $m$ cluster factors and only a simple coefficient pole in $r$. A finite nonselected term in that cluster has $m-1$ cluster factors and regular coefficient. Other finite terms have all $m$ factors. For a pole index $i$, the polynomial quotient has content order at least $g_i$, contains all $m$ cluster factors, and its coefficient $u_i/\phi_i$ has order $5g_i$. Therefore $rU\in I^m$. Since $(I^m:r)=I^{m-1}$, specialization gives
\[
(T-\lambda)^{m-1}\mid U\bmod r,\qquad (T-\lambda)^{m-1}\mid L.
\]
The colon identity follows by inspecting monomials in the two regular parameters. It requires no reduced specialized fiber.

Put $\xi_i=u_i^2/\phi_i$. The exact quadratic trace formula can be written
\[
Q(T)=v\rho^2-\sum_i\xi_i\frac{D(W_i)-D(T)}{W_i-T}.
\]
At $T=0$ the selected terms specialize to zero, since $\xi_i$ has order one; pole terms also specialize to zero because $\xi_iW_i^j$ has positive order for $j\le2$. A repeated finite residue contributes zero, since $D_0(\lambda)=H_0'(\lambda)=0$. At a simple finite residue, $u_i=\lambda^3L(\lambda)/H_0'(\lambda)$, so its trace summand specializes to $L(\lambda)^2/H_0'(\lambda)$.

The rational function $L^2/H_0$ has no pole at any repeated root: the divisibility just proved gives order at least $m-2$. Hence its simple-pole residues sum to its $T^{-1}$ coefficient at infinity. If $v(P)\ne0$, then $\deg H_0=5$ and this coefficient is $U_5(P)^2/v(P)=v(P)\rho(P)^2$. If $v(P)=0$ but $s_4(P)\ne0$, then $\deg H_0=4$ and $U_5(P)=0$ gives $\deg L\le1$, so the coefficient is zero. If both vanish, $U_5(P)=U_4(P)=0$ gives $\deg L\le0$ and $\deg H_0\le3$. Degrees two and three again give zero coefficient, as does degree zero. Degree one is impossible because $H_0'(0)=0$ while a linear polynomial has nonzero constant derivative. Thus in every case the residue sum equals $v(P)\rho(P)^2$, proving $Q_s(0)(P)=0$.

The translation identity gives only $Q_f(a(P))(P)=0$. The origin of the finite frame is a different point: selected finite roots have value $a(P)$, not zero. A separate zero at that origin would require another input. This proof makes no such assumption.
