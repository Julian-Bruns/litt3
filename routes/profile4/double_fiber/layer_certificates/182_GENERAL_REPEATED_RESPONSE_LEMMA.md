# General repeated-layer response lemma

## Status and scope

This note is **proved-text** for the local response theorem below, conditional
only on the displayed local equation. It proves the closed raw-response
formula that was previously retained only as a transcript in file 81. It also
shows that the scalar identities used at repeated \(u^{15}\) and repeated
\(u^{25}\) are the same identity, and reduces that identity to the two
low-order quantities \(F\) and \(U_C\).

This note does **not** prove the upstream specialization \(c=d=2\), identify
the missing ambient variable list at repeated \(u^{20}\), or prove the four
remaining primitive scalar inputs

\[
 [s^2]U_I=4,\qquad [s^2]U_L=0,\qquad [s^2]F=2,
 \qquad [s^2]U_C=1.
\]

Here and below \([s^2]\) means the coefficient in the basis
\(1,s,s^2\) of the clean etale cubic algebra from file 80.

## Local setup

Let \(R\) be a \(k\)-algebra, where \(k\) has characteristic \(5\), and
work in \(R((u))\). Suppose a branch of an equation
\(\mathcal F(u,w)=0\) is

\[
 w=uQ(u),\qquad Q(0)=1,
\]

and along this branch

\[
 \mathcal F_w(u,w)=u^5\ell T(u),\qquad
 \ell\in R^\times,\quad T(0)=1.
\tag{182.1}
\]

Put \(z=w^{-1}\) and

\[
 D=(u-1)\frac d{du},\qquad
 \mathcal E=D^4z-z+z^5.
\]

For \(m\geq1\), let \(E_m=[u^{5m}]\mathcal E\). If
\(z=\sum_n Z_nu^n\), then

\[
 E_m=Z_m^5-\sum_{j=0}^4Z_{5m+j}.
\tag{182.2}
\]

Indeed, \(D^4-1\) has order four. For \(r\equiv0\pmod5\), direct
application of \(D\) to \(u^{r+j}\) gives

\[
 [u^r](D^4-1)u^{r+j}=-1\quad(0\leq j\leq4),
\]

and no other monomial can contribute to \([u^r]\). Frobenius gives
\([u^{5m}]z^5=Z_m^5\), proving (182.2).

## The response formula

Introduce a square-zero parameter \(\epsilon\). For nonnegative integers
\(a,b\), perturb the equation by

\[
 \delta\mathcal F
 =\epsilon\,u(u-1)u^a w^b.
\tag{182.3}
\]

Let \(\operatorname{Col}_m(a,b)\) be the coefficient of \(\epsilon\) in
\(E_m\) after following the induced deformation of the branch.

### Theorem

Under (182.1),

\[
 \boxed{
 \operatorname{Col}_m(a,b)=\ell^{-1}
 \left(
 [u^{5m+10-a-b}]-[u^{5m+5-a-b}]
 \right)Q^{b-2}T^{-1}.}
\tag{182.4}
\]

A coefficient with negative exponent is interpreted as zero. In
particular, if \(a+b>5m+5\), the lower-boundary term vanishes and

\[
 \operatorname{Col}_m(a,b)
 =\ell^{-1}[u^{5m+10-a-b}]Q^{b-2}T^{-1}.
\tag{182.5}
\]

### Proof

Implicit differentiation of the perturbed branch equation gives

\[
 \delta w=-\frac{u(u-1)u^aw^b}{u^5\ell T}
 =\ell^{-1}u^{a+b-4}(1-u)Q^bT^{-1}.
\]

Consequently

\[
 \delta z=-w^{-2}\delta w
 =-\ell^{-1}u^{a+b-6}(1-u)Q^{b-2}T^{-1}.
\tag{182.6}
\]

The differential of the Frobenius term \(Z_m^5\) in (182.2) is zero.
Writing \(A=Q^{b-2}T^{-1}\), equations (182.2)--(182.6) therefore give

\[
\begin{aligned}
 \delta E_m
 &=-\sum_{n=5m}^{5m+4}\delta Z_n\\
 &=\ell^{-1}\sum_{n=5m}^{5m+4}
   \left([u^{n-a-b+6}]-[u^{n-a-b+5}]\right)A\\
 &=\ell^{-1}
   \left([u^{5m+10-a-b}]-[u^{5m+5-a-b}]\right)A.
\end{aligned}
\]

The last sum telescopes. This is (182.4), and (182.5) follows immediately.

### Repeated \(u^5\) specialization

File 81 writes the exponent of \(w\) first: a perturbation there is
\(u(u-1)u^bw^a\). Every displayed visible perturbation has \(a+b>10\).
Taking \(m=1\) in (182.5) proves its formerly transcript-only formula

\[
 \mathcal R(a,b)=\ell^{-1}
 [u^{15-a-b}]Q^{a-2}T^{-1}.
\tag{182.7}
\]

Notice that (182.4), rather than (182.5), is the general formula: a lower
boundary term is present when \(a+b\leq5m+5\).

## Formal low-order identities

Now work in the etale cubic algebra \(A=k[s]/(h(s))\) of file 80 and
write

\[
 Q=1+su+q_2u^2+O(u^3),\qquad
 T^{-1}=1+\tau_1u+\tau_2u^2+O(u^3).
\]

Define

\[
\begin{aligned}
 U_L&=[u]Q^{11}T^{-1},&
 U_C&=[u^2]Q^{11}T^{-1},\\
 F&=[u^2](Q^{14}+4Q^{16})T^{-1},&
 H&=[u^2](Q^3+Q)T^{-1}.
\end{aligned}
\tag{182.8}
\]

The response formula immediately gives the normalized identity from file
81

\[
 U_M-U_L=[u](Q^{12}-Q^{11})T^{-1}=s.
\tag{182.9}
\]

Similarly, for the column \(G=[u]Q^{14}T^{-1}\) in file 92,

\[
 G=U_L+3s.
\tag{182.10}
\]

Thus (182.9) and (182.10) require no symbolic certificate beyond the local
response formula.

Expanding (182.8) only through degree two gives

\[
\begin{aligned}
 U_L&=s+\tau_1,\\
 U_C&=q_2+s\tau_1+\tau_2,\\
 F&=s^2+3q_2+3s\tau_1,\\
 H&=3s^2+4q_2+4s\tau_1+2\tau_2.
\end{aligned}
\tag{182.11}
\]

Hence there is the universal identity

\[
 \boxed{H=4F+4s^2+2U_C.}
\tag{182.12}
\]

In particular,

\[
 [s^2]F=2\quad\hbox{and}\quad [s^2]U_C=1
 \quad\Longrightarrow\quad [s^2]H=4.
\tag{182.13}
\]

## Consequences for the later retained layers

The Schur-corrected expression displayed in the earlier revision of file
96 was

\[
 u15_3/p=[u^2](Q^{18}+Q^{21})T^{-1}.
\]

Since \(Q^5\equiv1\pmod{u^5}\) in characteristic \(5\), this is exactly
\(H\) through degree two. The expression retained in file 104 is

\[
 u5_3/p=[u^2](Q^{28}+Q^{31})T^{-1},
\]

which is also \(H\). Therefore the two transcript-only assertions

\[
 [s^2](u15_3/p)=4,
 \qquad [s^2](u5_3/p)=4
\]

are one and the same scalar assertion, and both follow from (182.13).
This removes two independent-looking symbolic obligations; it does not by
itself prove the primitive identities on the left of (182.13).

The proposed repeated-\(u^{20}\) distinguished column has the same expression

\[
 [u^2](Q^{23}+Q^{26})T^{-1}=H.
\]

Consequently the same two-minor argument would close that rank calculation
once the missing normal form proves that the proposed columns are genuinely
new and gives the asserted simple-layer Schur correction. Those provenance
facts are not present in the checkout, so this observation is not a closure
of Task 00.

