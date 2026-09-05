# Frobenius-linear differential rigidity in the generalized profiles

## Status and scope

**Status: proved.** This note isolates what can, and what cannot, follow
from a Frobenius-linear relation between the differentials of two
generalized-profile legs. A constant ratio is completely rigid: it gives
only one of the two affine visible symmetries. The weaker condition that
the ratio is a fifth power still gives an exact normal form, a common pole
fiber, and small auxiliary functions, but it does not by itself make the
ratio constant.

Let \(k=\overline{\mathbf F}_5\), let \(C/k\) be a smooth projective
connected curve, and put \(B=\{0,1,\infty\}\). Suppose that
\(x,r:C\to\mathbf P^1\) are separable maps with

\[
\begin{aligned}
 x^*(i)&=31P_i+E_i,\\
 r^*(i)&=31Q_i+F_i \qquad (i=0,1,\infty),
\end{aligned}                                             \tag{34.1}
\]

where all \(E_i,F_i\) are reduced of the same degree \(m\), and both maps
are unramified away from \(B\). Assume also the common-boundary condition

\[
 E_0+E_1+E_\infty=F_0+F_1+F_\infty=:U.                  \tag{34.2}
\]

Thus the two displayed sums are partitions of the same reduced divisor.
In particular, every \(P_i\) and \(Q_i\) lies outside \(U\). This is
exactly the generalized-profile situation obtained in file 16. In the
degree-\(<62\) route one has

\[
             \deg x=\deg r=31+m,\qquad
             0\leq m\leq15,\qquad g(C)=15-m.             \tag{34.3}
\]

Here \(m=0\) includes the degree-\(31\) scheme-source row. The exceptional
rational degree-\(31\) row with only two high fibers is not covered by
(34.1).

## 1. Exact differential divisors

For either leg \(h\), with high points denoted by \(H_i\) and residual
divisors by \(G_i\), one has

\[
 \operatorname{div}(dh)
       =30H_0+30H_1-32H_\infty-2G_\infty.                \tag{34.4}
\]

Indeed, at a tame zero of order \(e\), the differential has order \(e-1\),
and at a tame pole of order \(e\), it has order \(-e-1\). The residual
zeros over \(0\) and \(1\) are simple and contribute zero. There is no
other contribution because the map is unramified away from \(B\).

Riemann--Hurwitz also gives

\[
 2g(C)-2=-2(31+m)+3(31-1)=28-2m,
\]

which proves the numerical assertions in (34.3), including \(m\leq15\).

## 2. Constant differential ratio

### Theorem 34.1

Under (34.1)--(34.2), suppose that

\[
                              dr=c\,dx                   \tag{34.5}
\]

for some \(c\in k^\times\). Then exactly one of the following holds:

\[
                    r=x,\qquad\text{or}\qquad r=1-x.    \tag{34.6}
\]

Consequently a generalized-profile correspondence satisfying (34.5) is
visible. More precisely, the only possibilities are the two elements of
\(\operatorname{Aut}(\mathbf P^1,B)\) which fix infinity.

#### Proof

Since the ratio in (34.5) is constant, (34.4) gives equality of the two
differential divisors. Comparing their negative parts first gives

\[
                  Q_\infty=P_\infty,\qquad
                  F_\infty=E_\infty.                    \tag{34.7}
\]

The coefficients \(-32\) and \(-2\) distinguish the high pole from every
simple pole. Comparing the positive parts then gives

\[
                       \{Q_0,Q_1\}=\{P_0,P_1\}.          \tag{34.8}
\]

Put \(K=k(C)\). Since \(k\) is perfect and \(K/k\) has transcendence
degree one, the kernel of

\[
                         d:K\longrightarrow\Omega^1_{K/k}
\]

is \(K^5\). Equation (34.5) therefore gives

\[
                           r-cx=s^5                       \tag{34.9}
\]

for some \(s\in K\).

Both \(r\) and \(x\) have their only order-\(31\) pole at \(P_\infty\), and
their other poles are the same simple poles by (34.7). It follows from
(34.9) that \(s\) is regular away from \(P_\infty\), and its pole there has
order at most \(6\). At a common simple pole the difference in (34.9) has
pole order at most one, whereas every pole order of a fifth power is
divisible by five, so it is in fact regular there. Thus

\[
                              (s)_\infty\leq6P_\infty.   \tag{34.10}
\]

If \(Q_0=P_0\), then \(r\) and \(x\) both vanish to order \(31\) at
\(P_0\). Hence \(s^5\) vanishes there to order at least \(31\), and \(s\)
vanishes to order at least \(7\). This is incompatible with (34.10) for
a nonconstant function. Therefore \(s=0\), and evaluation at
\(P_1=Q_1\) gives \(c=1\), so \(r=x\).

The only other case in (34.8) is \(Q_1=P_0\) and \(Q_0=P_1\). At \(P_0\),
the functions \(r-1\) and \(x\) both vanish to order \(31\). Since

\[
                  (s-1)^5=r-1-cx,
\]

the function \(s-1\) vanishes at \(P_0\) to order at least \(7\) and still
has polar divisor bounded by \(6P_\infty\). Thus \(s=1\). Evaluation at
\(P_1=Q_0\) gives \(c=-1\), and \(r=1-x\). This proves (34.6). \(\square\)

Notice that the proof of Theorem 34.1 does not use the upper bound on
\(m\); the bound \(d<62\) is needed to arrive at the generalized-profile
list, not for the rigidity once (34.1) holds.

## 3. A fifth-power differential ratio

The natural weaker condition has a precise, but genuinely weaker,
consequence.

### Theorem 34.2

Retain (34.1)--(34.2), put \(K=k(C)\), and suppose

\[
                         \frac{dr}{dx}\in K^5.           \tag{34.11}
\]

There are unique \(a,b\in K\) such that

\[
                    \frac{dr}{dx}=a^5,\qquad
                    r=a^5x+b^5.                          \tag{34.12}
\]

Moreover the entire pole fibers agree:

\[
                  P_\infty=Q_\infty,\qquad
                  E_\infty=F_\infty,                    \tag{34.13}
\]

and \(a\) has the exact divisor

\[
       \operatorname{div}(a)
          =6\bigl(Q_0+Q_1-P_0-P_1\bigr).                 \tag{34.14}
\]

In particular,

\[
\begin{aligned}
 (a)_\infty&\leq6(P_0+P_1),\\
 (b)_\infty&\leq6(P_1+P_\infty),\\
 (a+b)_\infty&\leq6(P_0+P_\infty).                     \tag{34.15}
\end{aligned}
\]

Thus the three auxiliary maps have degrees at most \(12\). Equations
(34.12)--(34.15) are a finite-dimensional reduction of (34.11); without
an additional argument they do not imply that \(a\) is constant.

#### Proof

Choose the unique \(a\in K\) with \(dr/dx=a^5\). Then

\[
                         d(r-a^5x)=0.
\]

The description of the kernel of \(d\) used above gives the unique
\(b\in K\) in (34.12).

Let

\[
       R_x=P_\infty+E_\infty,\qquad
       R_r=Q_\infty+F_\infty
\]

be the reduced pole divisors. Subtracting the two instances of (34.4)
gives

\[
\begin{aligned}
 5\operatorname{div}(a)
   ={}&30(Q_0+Q_1-P_0-P_1)-30(Q_\infty-P_\infty)\\
      &\mathrel{}-2(R_r-R_x).                            \tag{34.16}
\end{aligned}
\]

Reducing the coefficients modulo \(5\) shows that \(R_r-R_x\) is divisible
by \(5\) as a divisor. Both \(R_x\) and \(R_r\) are reduced, so every
coefficient of their difference belongs to \(\{-1,0,1\}\); hence

\[
                               R_x=R_r.                  \tag{34.17}
\]

The unique point of \(R_x\) outside \(U\) is \(P_\infty\), while the unique
point of \(R_r\) outside \(U\) is \(Q_\infty\). The common-boundary
hypothesis therefore turns (34.17) into (34.13). Substitution in (34.16)
proves (34.14), and its first pole bound follows immediately.

It remains to justify the other two bounds in (34.15). From

\[
                         b^5=r-a^5x                     \tag{34.18}
\]

and (34.14), a pole of \(b\) can occur only at \(P_1\) or \(P_\infty\).
At \(P_0\), a possible pole of \(a\) has order at most \(6\), while the
order-\(31\) zero of \(x\) makes \(a^5x\) regular. At a common residual
pole, both \(r\) and \(a^5x\) have pole order at most one; their difference
is a fifth power, so it is regular. At \(P_1\), a possible pole of
\(a^5x\) has order at most \(30\), and at \(P_\infty\) the difference of
the two order-\(31\) poles in (34.18) has pole order at most \(30\), because
its order must be divisible by \(5\). These observations prove

\[
                         (b)_\infty\leq6(P_1+P_\infty).
\]

Finally rewrite (34.12), using characteristic five, as

\[
                    r=a^5(x-1)+(a+b)^5.
\]

The same argument, with the fibers \(0\) and \(1\) interchanged, gives the
last bound in (34.15). \(\square\)

There is also a sharper consequence which uses all three residual
partitions, rather than only the pole partition.

### Corollary 34.3 (the only remaining case is hyperelliptic)

Under the hypotheses of Theorem 34.2, the function

\[
                  w=\frac{r(r-1)}{a^5x(x-1)}             \tag{34.19}
\]

has divisor

\[
                  \operatorname{div}(w)
                       =Q_0+Q_1-P_0-P_1.                 \tag{34.20}
\]

If \(C\) has gonality at least \(3\), then \(a\) is constant and

\[
                              r=x\quad\text{or}\quad r=1-x.
                                                               \tag{34.21}
\]

Consequently, if \(g(C)\geq2\), a non-visible generalized-profile pair
satisfying \(dr/dx\in K^5\) can occur only on a hyperelliptic curve.

#### Proof

The common pole fiber (34.13) and the common-boundary identity (34.2) give

\[
\begin{aligned}
 \operatorname{div}\!\left(\frac{r(r-1)}{x(x-1)}\right)
   &=
   31(Q_0+Q_1-P_0-P_1)\\
   &\quad +(F_0+F_1-E_0-E_1)\\
   &=31(Q_0+Q_1-P_0-P_1).
\end{aligned}
\]

Subtracting \(5\operatorname{div}(a)\) and using (34.14) proves
(34.20). If its right side is nonzero, then \(w\) is a nonconstant
function with polar divisor bounded by \(P_0+P_1\), and hence has degree at
most \(2\). This is impossible when the gonality is at least \(3\).
Therefore

\[
                         Q_0+Q_1=P_0+P_1
\]

as divisors. Formula (34.14) now makes \(a\) a nowhere-vanishing rational
function on the projective curve, so \(a\in k^\times\). Theorem 34.1
proves (34.21). For a curve of genus at least two, gonality at most two is
equivalent to hyperellipticity. \(\square\)

## 4. Exactly which visible symmetries satisfy (34.11)

Let \(\sigma\in\operatorname{Aut}(\mathbf P^1,B)\simeq S_3\), and suppose
\(r=\sigma\circ x\). Then

\[
             \frac{dr}{dx}\in K^5
       \quad\Longleftrightarrow\quad
             \sigma(\infty)=\infty
       \quad\Longleftrightarrow\quad
             \sigma(t)=t\ \text{ or }\ 1-t.             \tag{34.22}
\]

Indeed, the forward implication follows from (34.13): the pole fiber of
\(\sigma\circ x\) must equal the pole fiber of \(x\), so
\(\sigma^{-1}(\infty)=\infty\). The stabilizer of infinity in the
six-element group preserving \(B\) consists of \(t\) and \(1-t\), whose
derivatives are the constants \(1\) and \(-1\). Since \(k\) is
algebraically closed, both constants are fifth powers. This proves
(34.22).

Thus a nonconstant fifth-power ratio, if it occurs, is not one of the
remaining four visible target symmetries. Excluding such a ratio requires
using the small-function system (34.12)--(34.15), rather than treating
(34.11) as if it already meant constant proportionality.
