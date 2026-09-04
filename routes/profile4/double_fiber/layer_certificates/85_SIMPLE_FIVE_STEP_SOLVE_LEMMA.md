# Simple-branch five-step solve lemma

## Status

`proved-text`, subject to the displayed local normal-form hypotheses.  The
lemma proves a response calculation; it does not prove that the incoming
repeated-layer solution space is nonempty or correctly constructed.

## Lemma

Work over \(k=\overline{\mathbb F}_5\).  Let \(u=x\), and suppose a simple
branch of the local curve equation has

\[
 w=-u+O(u^2),\qquad z=w^{-1},\qquad
 D=(u-1)\frac d{du},\qquad E=D^4z-z+z^5.
\]

Put \(q=w/u\), and assume more precisely that the old curve equation has
the form

\[
 F_{\mathrm{old}}(u,uq)=u^4G(u,q),\qquad
 G(0,q)=G_0(q)=a(q-1)^3(q+1),\qquad a\in k^\times.
\]

For the normalized entry-zero equation, [file
79](../79_ENTRY_ZERO_DOUBLE_FIBER_REDUCTION.md) gives this leading form with
\(a=-\pi=-cd\). It does not prove \(a=1\). The response calculation uses
both the order \(4\) and this leading scalar, not merely the tangent
\(q(0)=-1\).

Thus the simple branch is the root \(q(0)=-1\), and

\[
 G_0'(-1)=2a\in k^\times.
\]

Fix \(m\in\{2,3,4,5\}\). Suppose a new scalar \(v\) occurs in no
coefficient of the substituted curve equation below degree \(5m+9\), and
that its entire contribution in degree \(5m+9\) comes from

\[
 u(u-1)v\,w^{5m+8}.
\]

Then the equation \([u^{5m}]E=0\) has the form

\[
 R+a^{-1}\lambda_m v=0,
 \qquad
 \lambda_m=
 \begin{cases}
 3,&m\text{ even},\\
 2,&m\text{ odd},
 \end{cases}
\]

where \(R\) is independent of \(v\). Thus this equation uniquely solves
for \(v\) and imposes no equation on the older variables.

## Proof

Write

\[
w=-u+\sum_{n\ge2}b_nu^n.
\]

The new term first contributes to the curve equation in degree \(5m+9\),
with coefficient

\[
 (-1)^{5m+8+1}v=(-1)^{m+1}v.
\]

After division by the displayed factor \(u^4\), this is degree \(5m+5\).
The new coefficient of \(q\) at that degree is \(b_{5m+6}\), and its
coefficient in the implicit equation is \(G_0'(-1)=2a\). Since \(v\) occurs
nowhere earlier, the degree-\(5m+9\) equation in the original curve equation
is

\[
 2a\,\delta b_{5m+6}+(-1)^{m+1}v=0.
\]

Hence

\[
 \delta b_{5m+6}=a^{-1}\lambda_m v,
\]

with the displayed values of \(\lambda_m\).  Since this is the first
occurrence of \(v\), the dependence is affine-linear, not merely a
first-order calculation.

It follows that

\[
 \delta z=-a^{-1}\lambda_m v\,u^{5m+4}+O(u^{5m+5}).
\]

Only the four lowering terms in \(D^4\) can move this leading term to degree
\(5m\), and

\[
 (5m+4)(5m+3)(5m+2)(5m+1)=4\quad\text{in }\mathbb F_5.
\]

Thus the contribution to \([u^{5m}]D^4z\) is
\(-4a^{-1}\lambda_m v=a^{-1}\lambda_m v\). The term \(-z\) is too high.
Finally, Frobenius gives \(z^5=\sum \zeta_n^5u^{5n}\); the coefficient relevant to
\([u^{5m}]z^5\) depends only on an earlier coefficient of \(z\), before the
first occurrence of \(v\).  Hence \(z^5\) is independent of \(v\) at this
degree.  This proves the formula.

## Four applications

| ODE layer | \(m\) | new variable \(v\) | coefficient |
| --- | ---: | --- | ---: |
| \(u^{10}\) | 2 | \(U_{17}(0)\) | \(3a^{-1}\) |
| \(u^{15}\) | 3 | \(U_{12}(0)\) | \(2a^{-1}\) |
| \(u^{20}\) | 4 | \(U_7(0)\) | \(3a^{-1}\) |
| \(u^{25}\) | 5 | \(U_2(0)\) | \(2a^{-1}\) |

When the separate specialization \(\pi=-1\) is assumed, file 79 gives
\(a=1\), recovering the formerly displayed coefficients \(3,2,3,2\). The
last application is available as a local response statement, but its place
in the tower is conditional on the missing repeated-\(u^{20}\) step.
