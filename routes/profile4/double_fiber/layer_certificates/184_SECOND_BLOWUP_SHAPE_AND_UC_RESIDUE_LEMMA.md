# Second-blowup shape and three repeated-layer scalar identities

## Status and scope

The lemmas below are **proved-text**. They replace the missing-program
claims

\[
 [s^2]\,[u]Q^{11}T^{-1}=0,\qquad
 [s^2]\,[u^2]Q^{11}T^{-1}=1,
\]

and

\[
 [s^2]\,[u^2](Q^{14}+4Q^{16})T^{-1}=2
\]

recorded in files 81 and 92. Their inputs are only the displayed local tangent
normal form and the clean second-blowup condition. In particular, they do
not use formulas for the old coefficient cubics \(U_{30},U_{29},U_{28}\),
and they do not require the formerly asserted normalizations
\(\alpha^{31}=1\) or \(K=-1\).

This is a local result. It does not prove the upstream specialization
\(c=d=2\), and it does not treat the locus where the second-blowup cubic
has zero discriminant.

## The local equation

Let \(k\) be a field of characteristic \(5\), and let
\(\Phi(x,w)\in k[[x,w]]\) have order four and normalized degree-four
part

\[
 \Phi_4(x,w)=(w+x)(w-x)^3.                 \tag{184.1}
\]

Suppose that the repeated tangent \(w=x\) separates after the second
blow-up, so that

\[
 \Phi(u,u+u^2y)
 =u^7P(u,y),\qquad
 P(u,y)=P_0(y)+uP_1(y)+u^2P_2(y)+O(u^3).  \tag{184.2}
\]

Each coefficient of \(u\) in \(P\) is a polynomial in \(y\).

### Lemma 1 (shape forced by the tangent cone)

Under (184.1)--(184.2),

\[
 \deg P_0\le 3,\qquad [y^3]P_0=2,
\]

\[
 \deg P_1\le 4,\qquad [y^4]P_1=1,
\]

and

\[
 \deg P_2\le 4.
\]

In particular, \(P_2\) has no \(y^5\)-term.

If the four local branches are graphs

\[
 \begin{aligned}
 w_-(u)&=-u+O(u^2),\\
 w_i(u)&=u+s_i u^2+O(u^3),\qquad i=1,2,3,
 \end{aligned}                              \tag{184.3}
\]

then

\[
 P_0(y)=2\prod_{i=1}^3(y-s_i).             \tag{184.4}
\]

Thus \(P_0\) is separable precisely when the three second-order slopes
\(s_1,s_2,s_3\) are distinct.

#### Proof

Write

\[
 \Phi=\sum_{n\ge4}\Phi_n,
\]

where \(\Phi_n\) is homogeneous of total degree \(n\). A monomial
\(x^{n-a}w^a\) becomes

\[
 u^n(1+uy)^a
 =\sum_{j=0}^a {a\choose j}u^{n+j}y^j.    \tag{184.5}
\]

Consequently a term of total degree \(n\ge5\) contributing to the
coefficient of \(u^{7+i}\) has \(y\)-degree at most \(7+i-n\).

For the degree-four part there is an exact calculation:

\[
 \Phi_4(u,u+u^2y)
 =(2u+u^2y)(u^2y)^3
 =2u^7y^3+u^8y^4.                          \tag{184.6}
\]

At order \(u^7\), (184.5) bounds every contribution from \(n\ge5\) by
degree two in \(y\), while (184.6) contributes \(2y^3\). At order \(u^8\),
the contributions from \(n\ge5\) have degree at most three, while (184.6)
contributes \(y^4\). At order \(u^9\), terms with \(n\ge5\) have degree at
most four, and (184.6) has no \(u^9\)-term. This proves all three degree and
leading-coefficient assertions.

For (184.4), factor the reduced local equation into its four branch factors,
times a unit whose constant term is one. After the substitution in (184.2),
the simple factor in (184.3) has leading term \(2u\), and the three repeated
factors have leading terms \(u^2(y-s_i)\). Their product has leading term
\(2u^7\prod_i(y-s_i)\), proving (184.4). \(\square\)

## A quartic residue computation

The next lemma is stated slightly more generally so that every normalization
factor is visible.

### Lemma 2 (cubic coefficient from the escaping fourth root)

Let

\[
 P(u,y)=P_0(y)+uP_1(y)+u^2P_2(y)+O(u^3)
\]

over a characteristic-\(5\) field. Assume that

- \(P_0\) is a separable cubic with leading coefficient \(\gamma\ne0\);
- \(\deg P_1\le4\), with \(\beta=[y^4]P_1\ne0\);
- \(\deg P_2\le4\).

Put

\[
 A=k[s]/(P_0(s)).
\]

This is an etale cubic algebra. There is a unique
\(y_s(u)\in A[[u]]\) with \(y_s(0)=s\) and
\(P(u,y_s(u))=0\). Set

\[
 q=1+uy_s(u),\qquad L=P_0'(s),\qquad
 T=\frac{P_y(u,y_s(u))}{L}.
\]

Then \(T(0)=1\). If \(\lambda:A\to k\) denotes the coefficient of
\(s^2\) in the representative of degree at most two, then

\[
 \lambda\!\left([u^2]q^{11}T^{-1}\right)
 =\frac{\beta(\beta-\gamma)}{\gamma^2}.     \tag{184.7}
\]

#### Proof

The derivative \(L=P_0'(s)\) is a unit in \(A\), so formal Hensel lifting
gives \(y_s(u)\), and \(T(0)=1\).

Let \(s_1,s_2,s_3\) be the three roots of \(P_0\). Lagrange interpolation
shows that, for every \(a\in A\),

\[
 \lambda(a)
 =\gamma\sum_{i=1}^3\frac{a(s_i)}{P_0'(s_i)}. \tag{184.8}
\]

Indeed, the leading coefficient of
\(P_0(y)/((y-s_i)P_0'(s_i))\) is
\(\gamma/P_0'(s_i)\).

Let \(y_i(u)\) be the Hensel lift of \(s_i\). From the definition of \(T\),
(184.8) gives

\[
 \lambda\!\left([u^2]q^{11}T^{-1}\right)
 =\gamma[u^2]\sum_{i=1}^3
   \frac{(1+uy_i)^{11}}{P_y(u,y_i)}.        \tag{184.9}
\]

In characteristic \(5\),

\[
 (1+uy)^{11}=1+uy+O(u^3),                  \tag{184.10}
\]

because \({11\choose2}=55=0\). Also, the coefficient through \(u^2\) in
(184.9) is unchanged if \(P\) is replaced by

\[
 \widehat P=P_0+uP_1+u^2P_2.              \tag{184.11}
\]

Indeed, the three finite Hensel roots, their derivatives, and hence the
displayed fractions agree modulo \(u^3\).

Over \(k((u))\), the polynomial \(\widehat P\) is a quartic with leading
coefficient \(u\beta+O(u^2)\). Besides the three roots lifting \(s_i\), it has
one escaping root \(y_*(u)\). To determine its leading term, put \(Y=uy\)
and

\[
 \Psi(u,Y)=u^3\widehat P(u,Y/u).
\]

The degree assumptions make \(\Psi\in k[[u]][Y]\), and

\[
 \Psi(0,Y)=Y^3(\gamma+\beta Y).
\]

The nonzero root \(Y_0=-\gamma/\beta\) is simple. Hensel's lemma therefore
gives

\[
 y_*(u)=-\frac{\gamma}{\beta u}+O(1),\qquad
 1+uy_*(u)=\frac{\beta-\gamma}{\beta}+O(u). \tag{184.12}
\]

Since \(\Psi_Y=u^2\widehat P_y\), differentiation at \(Y_0\) gives

\[
 \widehat P_y(u,y_*)
 =u^{-2}\left(-\frac{\gamma^3}{\beta^2}+O(u)\right).
\]

Consequently

\[
 \frac{1+uy_*}{\widehat P_y(u,y_*)}
 =-\frac{\beta(\beta-\gamma)}{\gamma^3}u^2+O(u^3).
                                                               \tag{184.13}
\]

For a quartic with simple roots \(r\), Lagrange interpolation gives

\[
 \sum_r\frac{1+ur}{\widehat P_y(u,r)}=0,   \tag{184.14}
\]

because the numerator has degree one, strictly less than three. The sum of
the three finite-root terms in (184.14) is therefore the negative of
(184.13). Substituting into (184.9) yields

\[
 \gamma\cdot\frac{\beta(\beta-\gamma)}{\gamma^3}
 =\frac{\beta(\beta-\gamma)}{\gamma^2},
\]

which proves (184.7). \(\square\)

### Lemma 3 (the other two primitive scalar coefficients)

In the normalized case \(\gamma=2,\ \beta=1\), retain the notation of
Lemma 2 and
put

\[
 U_L=[u]q^{11}T^{-1},\qquad
 \mathcal F=[u^2](q^{14}+4q^{16})T^{-1}.
\]

Then

\[
 \lambda(U_L)=0,\qquad \lambda(\mathcal F)=2.               \tag{184.15}
\]

#### Proof

The argument preceding (184.9) applies to any polynomial expression \(R(q)\):

\[
 \lambda\!\left([u^n]R(q)T^{-1}\right)
 =2[u^n]\sum_{i=1}^3\frac{R(1+uy_i)}{P_y(u,y_i)}.            \tag{184.16}
\]

As before, coefficients through \(u^2\) may be computed with the quartic
\(\widehat P\) of (184.11).

For \(U_L\), one has \(q^{11}=q+O(u^3)\) on every finite root (in fact the
error starts later). The all-root sum

\[
 \sum_{\widehat P(r)=0}\frac{1+ur}{\widehat P_y(r)}
\]

is zero by (184.14). The escaping-root term starts in degree \(u^2\) by
(184.12)--(184.13), so the finite-root sum has zero \(u\)-coefficient.
Equation (184.16) gives \(\lambda(U_L)=0\).

For \(\mathcal F\), on every finite root,

\[
 q^{14}+4q^{16}=q^4+4q+O(u^3).                              \tag{184.17}
\]

Indeed, after writing \(q=1+t\), the two sides have the same coefficients
through \(t^2\) in characteristic \(5\). Set \(R(q)=q^4+4q\). As a
polynomial in \(y\), its \(y^4\)- and \(y^3\)-coefficients are respectively

\[
 r_4=u^4,\qquad r_3=4u^3.
\]

Write the corresponding coefficients of \(\widehat P\) as

\[
 a_4=u+O(u^2),\qquad a_3=2+O(u).
\]

Polynomial division followed by Lagrange interpolation gives

\[
 \sum_{\widehat P(r)=0}\frac{R(1+ur)}{\widehat P_y(r)}
 =\frac{r_3a_4-r_4a_3}{a_4^2}
 =2u^2+O(u^3).                                                \tag{184.18}
\]

For completeness, the first equality follows because the remainder of
\(R\) modulo \(\widehat P\) has \(y^3\)-coefficient
\(r_3-r_4a_3/a_4\), while that coefficient is also
\(a_4\sum_r R(1+ur)/\widehat P_y(r)\).

At the escaping root, (184.12) gives \(q_*=-1+O(u)\), while

\[
 R(-1)=2,\qquad
 \widehat P_y(u,y_*)=2u^{-2}+O(u^{-1})
\]

in characteristic \(5\). Hence its contribution to (184.18) is
\(u^2+O(u^3)\). The sum over the three finite roots therefore has
\(u^2\)-coefficient \(2-1=1\). Multiplication by the interpolation factor
\(2\) in (184.16) proves \(\lambda(\mathcal F)=2\). \(\square\)

## Application to the repeated-\(u^5\) branch

In the notation of file 79, the degree-four tangent form of
\(\bar f(x,w)=w^{35}f(x,1/w)\) is

\[
 -\pi(w+x)(w-x)^3.
\]

On the proposed double-fiber specialization \(c=d=2\), one has
\(\pi=cd=4=-1\), so the scalar is exactly one and (184.1) holds.
The repeated branches are the three branches in the atom \(B\); the
simple branch is the branch in \(A\). On the clean open used in files
80--83, their second-order slopes are distinct, so \(P_0\) is separable.

Lemma 1 gives \(\gamma=2\) and \(\beta=1\) in Lemma 2. Therefore

\[
 \frac{\beta(\beta-\gamma)}{\gamma^2}
 =\frac{1(1-2)}{2^2}=1\quad\text{in }k.
\]

Finally, differentiating

\[
 \Phi(u,u+u^2y)=u^7P(u,y)
\]

with respect to \(y\) gives

\[
 \Phi_w(u,u+u^2y)=u^5P_y(u,y).
\]

Thus on a repeated branch \(Q=w/u=1+uy_s(u)\), the normalization in file 81
is exactly

\[
 \ell=P_0'(s),\qquad T=P_y/P_0'(s).
\]

Lemmas 2 and 3 consequently prove the formerly transcript-only identities

\[
 \boxed{
 [s^2]U_L=0,\qquad
 [s^2]U_C=1,\qquad
 [s^2]\mathcal F=2,
 }
\]

where

\[
 U_L=[u]Q^{11}T^{-1},\qquad
 U_C=[u^2]Q^{11}T^{-1},\qquad
 \mathcal F=[u^2](Q^{14}+4Q^{16})T^{-1}.
\]

This conclusion depends on \(c=d=2\) only through the tangent scalar
\(-\pi=1\); it is independent of \(\alpha\) and \(K\).

## Independent finite check

As a sign and normalization check, (184.7) was tested in Sage on random
separable cubics \(P_0\), random quartics \(P_1\), and random
degree-at-most-four \(P_2\) over \(\mathbf F_5\). Direct Hensel expansion in
\(\mathbf F_5[s]/(P_0)\) agreed with (184.7) in 784 generalized samples; the
specialized case \(\gamma=2,\beta=1\) agreed in 807 samples. A second run
checked all three boxed scalar identities simultaneously in 979 samples.
These finite checks are not used in the proof.
