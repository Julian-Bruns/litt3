# Saturated Tango lines and a sharper all-rank count

**Status: author proof, 2026-09-05; not independently audited.**
Author: `/root`.

This identifies exactly when the degree-(p-1) bound on an affine line
of dormant connections is attained. It then improves the elementary
global count in every positive p-rank. The result is parameterized
by p and the p-rank, not by individual covering degrees.

Throughout k is algebraically closed of characteristic p > 2, C is
smooth, projective and connected, and gamma(C) = f > 0. The notions
of a regular dormant connection on omega_C and a maximal Tango
structure are as in files 111 and 115. Let D(C) denote the set of
regular dormant connections on omega_C. When nonempty this is an
affine space under

\[
 V_C=\{\beta\in H^0(C,\omega_C):\operatorname{Car}(\beta)=\beta\},
 \qquad \dim_{\mathbf F_p} V_C=f.
\]

We use the untwisted Cartier notation over the perfect field k.
The subset Tan(C) of D(C) consists of the connections whose rational
horizontal differentials are Cartier-zero.

## 1. A p-basis describes every affine line exactly

Fix a nonzero beta in V_C and an affine line

\[
                      \ell=\{\nabla_0+t\beta:t\in\mathbf F_p\}
                                \subset D(C).
\]

Cartier's logarithmic criterion gives h in K^*, where K=k(C), with

\[
                              \beta=dh/h.
\]

Since beta is nonzero, h is not a p-th power. Thus K = K^p(h)
and 1,h,...,h^(p-1) is a basis over K^p.

Choose a nonzero rational differential xi horizontal for nabla_0.
Such a differential exists by Cartier descent at the generic point.
There is a unique expression

\[
                  \xi=\sum_{j=0}^{p-1} c_j^p h^j\,dh,
                  \qquad c_j\in K.                     \tag{117.1}
\]

The coefficients are not all zero.

### Proposition 117.1

The number of Tango structures on ell is exactly the number of zero
coefficients in (117.1). More precisely,

\[
 \begin{aligned}
 \nabla_0\in\operatorname{Tan}(C)
       &\Longleftrightarrow c_{p-1}=0,\\
 \nabla_0+t\beta\in\operatorname{Tan}(C)
       &\Longleftrightarrow c_{t-1}=0
                    &&(1\le t\le p-1).
 \end{aligned}                                           \tag{117.2}
\]

#### Proof

For t represented by an integer from 0 through p-1, a horizontal
differential for nabla_0 + t beta is h^(-t) xi. Indeed
d(h^(-t)) = -t h^(-t) beta.

Cartier is linear over p-th powers, with their p-th roots on the
output, and

\[
 \operatorname{Car}(h^jdh)=0\ (0\le j<p-1),\qquad
 \operatorname{Car}(h^{p-1}dh)=dh,\qquad
 \operatorname{Car}(dh/h)=dh/h.
\]

After multiplication by h^(-t), exactly one index j has
j-t congruent to p-1 modulo p. For t=0 this index is p-1,
and the Cartier image is c_(p-1) dh. For t>0 the index is
t-1, and the Cartier image is c_(t-1) dh/h. This proves
(117.2). The generic Cartier-zero test is equivalent to the
embedded line lying in B_C^1 everywhere, as in file 111.
\(\square\)

This also proves the at-most-(p-1) bound on a line without expanding
the local differential polynomial P_(p-1).

## 2. The equality case has a unique missing connection

For a nonzero rational differential beta, let nabla_beta be the
unique rational connection on omega_C for which beta is horizontal.
Locally, if beta=b dx, its coefficient in the frame dx is -b'/b.

### Theorem 117.2 (classification of saturated lines)

For the fixed nonzero Cartier-fixed regular differential beta:

1. The connection nabla_beta is regular if and only if every
   coefficient of div(beta) is divisible by p. When regular, it
   is dormant but is NOT Tango.
2. An affine line in D(C) with direction beta contains p-1 Tango
   structures if and only if nabla_beta is regular and the line
   is exactly

\[
                              \nabla_\beta+\mathbf F_p\beta.
                                                               \tag{117.3}
\]

3. On that line, its only non-Tango point is nabla_beta. Thus,
   for each direction beta, at most ONE parallel affine line
   can attain the p-1 bound.

#### Proof

At a point with local parameter x, write b=x^e u with u a unit.
Then

\[
                    -db/b=-e\,dx/x-du/u.
\]

The second term is regular; the first is regular precisely when
p divides e. This proves the regularity criterion. A connection
with a nonzero rational horizontal section has zero p-curvature
generically, hence everywhere when regular. But beta is Cartier-fixed
and nonzero, so nabla_beta is not Tango.

Now suppose ell contains p-1 Tango points. Proposition 117.1 says
that exactly one coefficient in (117.1) is nonzero, say c_j. Thus

\[
                             \xi=c_j^p h^jdh.
\]

Let t_0 be the element of F_p congruent to j+1. The corresponding
horizontal differential h^(-t_0) xi is a nonzero p-th-power multiple
of dh/h = beta: the exponent j-t_0+1 is divisible by p. Multiplying
a horizontal differential by a p-th power does not change its
connection. Therefore the sole missing connection is nabla_beta.
It belongs to D(C), so it is regular, and ell is (117.3).

Conversely suppose nabla_beta is regular. For every nonzero t in
F_p, a horizontal differential for nabla_beta+t beta is

\[
                h^{-t}\beta=-\frac1t\,d(h^{-t}),
\]

which is exact. These p-1 connections are Tango, whereas nabla_beta
is not. This proves all assertions. \(\square\)

## 3. Improved all-rank bound

### Corollary 117.3

For every C of positive p-rank f,

\[
              \boxed{\quad |\operatorname{Tan}(C)|
                      \le (p-2)p^{f-1}+1.\quad}         \tag{117.4}
\]

If there exists a nonzero beta in V_C whose divisor is not
coefficientwise divisible by p, then

\[
                    |\operatorname{Tan}(C)|\le(p-2)p^{f-1}.
                                                               \tag{117.5}
\]

#### Proof

If D(C) is empty there is nothing to prove. Otherwise fix a
nonzero direction beta and partition the p^f points of D(C)
into its p^(f-1) parallel affine F_p-lines. By Theorem 117.2,
at most one such line has p-1 Tango points, and every other
line has at most p-2. Summing proves (117.4).

For a beta as in the last assertion, nabla_beta is not regular,
so no parallel line can have p-1 Tango points. This proves
(117.5). \(\square\)

In characteristic five, this is |Tan(C)| <= 3*5^(f-1)+1,
improving the elementary 4*5^(f-1) bound for every f>1.
It is not a proof of a bound independent of f.

For f=1, equality |Tan(C)|=p-1 holds precisely when a nonzero
Cartier-fixed regular differential has p-divisible divisor. This
condition is independent of its nonzero F_p-scalar normalization.

## 4. Known geometric realizations of saturated lines

Hoshi's construction in
[A Note on the Existence of Tango Curves, Theorem 3 and Remark 10](https://www.kurims.kyoto-u.ac.jp/preprint/file/RIMS1917.pdf)
starts with an ordinary elliptic curve and supplies, for every
genus g=1+pn, a smooth curve with a regular logarithmic differential
whose divisor is p times an effective divisor. Hence it supplies
the saturated line of Theorem 117.2 in every such genus.
The construction does not by itself specify the p-rank of the
resulting curve.

For the simplest characteristic-five test, take an elliptic curve
E with a nonzero point P of order five and a function f_E with
div(f_E)=5P-5O. The normalization of w^6=f_E over E is a degree-six
tame cover, totally ramified at P and O, of genus six. Its
logarithmic differential dlog(w) has divisor

\[
                              5P_Y+5O_Y.
\]

It therefore has at least four maximal Tango structures, from
the one saturated line. This is NOT a statement that these are
all its Tango structures or that its p-rank is one.

## 5. Strategic boundary

The classification localizes the possible equality cases and gives
a finite, exact test for further examples. It does not yet prevent
Tango structures from appearing when p-rank grows along an etale
cover. Its numerical bound is still exponential in p-rank, so it
does not extend file 115 to arbitrary common covers.

In particular, no new common-cover degree is excluded for the
fixed genus-nine/genus-25 pair by this note.
