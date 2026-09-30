# The fixed genus-nine curve and original genus-twenty-five partner

Work over \(k=\overline{\mathbf F}_5\). Choose \(a\in\mathbf F_{25}\) with
\(a^2+4a+2=0\), and set
\[
\begin{aligned}
F(x)={}&x^{10}+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3ax^6+4ax^5\\
&+(3a+4)x^4+ax^3+(3a+3)x^2+(4a+2)x+(2a+1),\\
L(t)={}&t^{25}+t^5+t.
\end{aligned}
\]
The original pair consists of the smooth projective models
\(X:y^3=F(x)\) and \(Y:z^2=L(t)(L(t)-1)(t-4)\), base changed to \(k\).
Here \(g(X)=9\) and \(g(Y)=25\). The current main pair retains this
same \(X\) but uses the selected genus-two member \(Y_t\) of the
[five-branch family](../Theorems/quotient_geometry/bounded_atlas_partner_finiteness.md).
The separate [backup definition](backup_genus_two_curve.md) fixes
another genus-two member.
Write \(O\) for the point of \(X\) above infinity and
\(\theta=dx/y^2\) for the rational canonical frame. The existence and
properties of this point and frame are assertions in the
[arithmetic statement](../Theorems/curve_arithmetic/fixed_pair_arithmetic.md), not
additional defining hypotheses.

For \(r\ge0\), write
\(W_r(X,O)=\{[E-rO]:E\text{ is an effective divisor of degree }r\}\subset J(X)\).

Sources: [geometry and arithmetic](../Proofs/curve_arithmetic/fixed_pair_arithmetic.md),
Section1; [Cartier eigenforms](../Proofs/cartier_and_spin/fixed_x_cartier_eigenforms.md),
Sections1 and3, for the frame and infinity notation;
[two-primary W3](../Proofs/jacobians/torsion/two_primary_w3.md) for W_r.
