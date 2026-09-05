# A non-Galois etale degree-five cover of an ordinary curve can be nonordinary

**Status: exact computation and author proof, 2026-09-05; not independently
audited.**

Over \(k=\overline{\mathbf F}_5\), there is an ordinary curve \(Y\) of genus
three and a connected non-Galois finite etale map

\[
                         D\longrightarrow Y
\]

of degree five for which \(g(D)=11\) and \(f(D)=9\).  In particular,
ordinariness does not ascend through non-Galois etale covers of degree equal
to the characteristic.

## 1. Two explicit hyperelliptic curves

Put

\[
 f_1=x^2+1,\qquad f_2=x^6+x^3+x,
\]

and let

\[
 C_1:y_1^2=f_1,\qquad C_2:y_2^2=f_2,
 \qquad Y:y^2=f_1f_2.
\]

The factorizations over \(\mathbf F _5\) are

\[
\begin{aligned}
 f_1&=(x+2)(x+3),\\
 f_2&=x(x^2+4x+2)(x^3+x^2+4x+3).
\end{aligned}
\]

Thus the two polynomials are square-free and coprime.  The curves have genera
zero, two, and three, respectively.

For a square-free hyperelliptic equation \(z^2=f(x)\) in characteristic five,
write

\[
                  f(x)^2=\sum_n c_nx^n.
\]

Its Cartier--Manin matrix, up to transpose, is
\((c_{5i-j})_{1\leq i,j\leq g}\).  Direct expansion gives

\[
 H_{C_2}=\begin{pmatrix}2&0\\2&0\end{pmatrix}.
\]

Every positive power of this matrix has rank one, so \(f(C_2)=1\).  Since

\[
 f_1f_2=x^8+x^6+x^5+2x^3+x,
\]

the corresponding matrix for \(Y\) is

\[
 H_Y=\begin{pmatrix}
 4&0&1\\
 1&4&2\\
 2&2&1
 \end{pmatrix},
 \qquad \det(H_Y)=4.
\]

Hence \(Y\) is ordinary and \(f(Y)=3\).

## 2. The etale biquadratic cover

Let \(B\) be the smooth projective normalization of

\[
       y_1^2=f_1(x),\qquad y_2^2=f_2(x),
\]

and set \(y=y_1y_2\).  The simultaneous sign change

\[
              \tau:(y_1,y_2)\longmapsto(-y_1,-y_2)
\]

has quotient \(Y\).  It has no fixed finite point, since the zero sets of
\(f_1\) and \(f_2\) are disjoint.  At infinity both even-degree double covers
are unramified and their hyperelliptic involutions interchange their two
points at infinity, so \(\tau\) has no fixed point there either.  Consequently

\[
                         B\longrightarrow Y
\]

is an etale double cover and \(g(B)=5\).

The three nontrivial quotients of the Klein-four cover \(B\to\mathbf P^1\)
are \(C_1,C_2,Y\).  The standard Klein-four idempotent decomposition gives

\[
                         J(B)\sim J(Y)\times J(C_2),
\]

because \(J(C_1)=0\).  Therefore

\[
                         f(B)=3+1=4.
\]

On the \(J(Y)\)-summand, \(\tau\) acts as \(+1\).  On the \(J(C_2)\)-summand
it induces the hyperelliptic involution and hence acts as \(-1\).  It follows
that the anti-invariant subspace

\[
 H^1_{\mathrm{et}}(B,\mathbf F _5)^-
\]

has dimension one.

## 3. The dihedral closure and the non-Galois quotient

Choose a nonzero class

\[
             \alpha\in H^1_{\mathrm{et}}(B,\mathbf F _5)^-.
\]

It defines a connected etale \(C_5\)-torsor \(W\to B\).  Since
\(\tau^*\alpha=-\alpha\), the kernel defining this torsor is preserved by
\(\tau\), and \(\tau\) lifts to an automorphism \(\widetilde\tau\) of \(W\)
which conjugates a deck generator \(\sigma\) to \(\sigma^{-1}\).

Moreover \(\widetilde\tau^2\in\langle\sigma\rangle\).  It is fixed by
conjugation by \(\widetilde\tau\), but that conjugation is inversion, whose
fixed subgroup in \(C_5\) is trivial.  Thus \(\widetilde\tau^2=1\), and

\[
            \langle\sigma,\widetilde\tau\rangle\cong D_{10}.
\]

The composite \(W\to B\to Y\) is therefore an etale Galois cover with group
\(D_{10}\).  Define

\[
                      D=W/\langle\widetilde\tau\rangle.
\]

Then \(D\to Y\) is connected, etale, and of degree five.  It is non-Galois
because a reflection subgroup is not normal in \(D_{10}\).

For the etale \(C_5\)-cover \(W\to B\), Deuring--Shafarevich gives

\[
                  f(W)-1=5(f(B)-1),
\]

so \(f(W)=16\).  The rational permutation modules of
\(D_{10}=C_5\rtimes C_2\) satisfy

\[
 \mathbf Q[D_{10}]\oplus\mathbf Q^2
 \simeq
 \mathbf Q[D_{10}/C_5]\oplus
 \mathbf Q[D_{10}/C_2]^2.                         \tag{3.1}
\]

Indeed, their characters agree on the identity, a nonidentity rotation, and
a reflection.  Pairing (3.1) with \(V_5(J(W))\), and using
\(V_5(J(W/K))\simeq V_5(J(W))^K\) for every subgroup \(K\), gives

\[
                  f(W)+2f(Y)=f(B)+2f(D).
\]

Substitution yields

\[
                         f(D)=9.
\]

Finally, etale Riemann--Hurwitz for the degree-five map \(D\to Y\) gives

\[
                         g(D)-1=5(g(Y)-1)=10,
\]

so \(g(D)=11\).  Therefore \(D\) is not ordinary.  This example shows that
Galois closure followed by passage to a nonnormal intermediate subgroup does
not preserve the ordinariness conclusion available for etale Galois
\(p\)-group covers.
