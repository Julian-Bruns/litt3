# A cubic-differential torsion constraint for generalized profiles

## Status and scope

**Status: proved.**  This note gives a uniform necessary condition on two
generalized-profile legs with the same residual stacky divisor.  It works in
every genus and does not use lifting, monodromy, or an enumeration of covers.

It does **not** exclude a generalized-profile row by itself.  In fact, the
degree-45, genus-one row is nonempty (see file 31).  The point of the result
below is instead that, once the common residual divisor is fixed, the three
high ramification points of the two legs cannot vary independently: their
difference is 28-torsion in the Jacobian.

Let \(k\) be an algebraically closed field of characteristic \(5\), put

\[
                         B=\{0,1,\infty\}\subset \mathbf P^1_k,
\]

and let \(h:C\to\mathbf P^1\) be a finite separable map from a smooth
projective connected curve.  Suppose that \(h\) is unramified away from
\(B\), and that

\[
 h^*(b)=31P_b+E_b\qquad (b\in B),                         \tag{30.1}
\]

where each \(E_b\) is reduced of degree \(m\).  Write

\[
 D_h=P_0+P_1+P_\infty,
 \qquad U_h=E_0+E_1+E_\infty .                            \tag{30.2}
\]

The points occurring in (30.2) are pairwise distinct except, of course,
that no assertion is being made about the high divisors belonging to two
different maps.

## 1. The symmetric cubic differential

### Theorem 30.3

Under (30.1), there is a canonical line-bundle identity

\[
             \mathcal O_C(28D_h)
             \simeq \omega_C^{\otimes 3}\otimes
                     \mathcal O_C(2U_h).                  \tag{30.3}
\]

Equivalently,

\[
                         28D_h\sim 3K_C+2U_h.              \tag{30.4}
\]

#### Proof

In the coordinate \(t\) on \(\mathbf P^1\), consider the rational cubic
differential

\[
                  \eta=\frac{(dt)^{\otimes3}}
                              {t^2(t-1)^2}.
\]

At infinity, \(dt\) has order \(-2\), while
\(1/(t^2(t-1)^2)\) has order \(4\).  Hence

\[
                         \operatorname{div}(\eta)=-2B.    \tag{30.5}
\]

If a tame map has ramification index \(e\) at \(P\), and a rational
\(q\)-differential downstairs has order \(a\), its pullback has order

\[
                              ea+q(e-1).                   \tag{30.6}
\]

Indeed, after choosing local parameters the map is a unit times
\(z\mapsto z^e\); tameness says that its differential has order \(e-1\).
Here \(q=3\) and \(a=-2\).  Thus a point of index \(31\) above \(B\)
contributes

\[
                       31(-2)+3(31-1)=28,
\]

whereas an unramified point above \(B\) contributes \(-2\).  There are no
other contributions, because \(h\) is unramified away from \(B\).  Since
\(h\) is separable, \(h^*\eta\) is nonzero, and therefore

\[
                   \operatorname{div}(h^*\eta)
                             =28D_h-2U_h.                  \tag{30.7}
\]

The left side is the divisor of a rational section of
\(\omega_C^{\otimes3}\), which proves (30.3) and (30.4). \(\square\)

The exponent \(28=31-3\) is not an accidental determinant calculation.
The cubic differential is the smallest tensor power of the canonical
bundle on \(\mathbf P^1\) which can have the same integral order at all
three points of \(B\): if that common order is \(a\), then
\(3a=-2q\), so \(3\mid q\).

## 2. Two legs with a common residual divisor

### Corollary 30.4 (the 28-torsion constraint)

Let \(x,r:C\rightrightarrows\mathbf P^1\) both satisfy (30.1), and suppose
their residual divisors agree:

\[
                             U_x=U_r=:U.                   \tag{30.8}
\]

Then

\[
               \mathcal O_C(D_x-D_r)\in
               \operatorname{Pic}^0(C)[28].              \tag{30.9}
\]

More precisely, the rational function

\[
                         \frac{x^*\eta}{r^*\eta}
\]

has divisor \(28(D_x-D_r)\).

#### Proof

Both pullbacks are nonzero rational sections of the same line bundle
(\omega_C^{\otimes3}), so their ratio is a rational function.  Formula
(30.7) and (30.8) give

\[
 \operatorname{div}\!\left(\frac{x^*\eta}{r^*\eta}\right)
             =(28D_x-2U)-(28D_r-2U)=28(D_x-D_r).
\]

This is exactly (30.9). \(\square\)

Thus, for fixed \(C\) and \(U\), all possible classes of high divisors lie
in one fiber of multiplication by \(28\) on the Jacobian.  Since \(28\) is
prime to \(5\), that fiber has exactly

\[
                                28^{2g(C)}                 \tag{30.10}
\]

geometric points.  This bounds divisor **classes**, not necessarily
effective divisors: a degree-three class can have a positive-dimensional
complete linear system in low genus.  If \(C\) has gonality at least \(4\),
however, two distinct effective degree-three divisors cannot be linearly
equivalent.  In that case (30.10) also bounds the actual possibilities for
\(D_h\).

## 3. The associated theta characteristic

The torsion statement has a useful square root.  Put

\[
                         L_h=h^*\mathcal O_{\mathbf P^1}(1).
\]

Logarithmic Riemann--Hurwitz gives

\[
                    L_h\simeq\omega_C(D_h+U_h).           \tag{30.11}
\]

Define

\[
          \Theta_h=\mathcal O_C(15D_h)\otimes L_h^{-1}
                  =\mathcal O_C(14D_h-U_h)\otimes
                    \omega_C^{-1}.                        \tag{30.12}
\]

### Proposition 30.5

The line bundle \(\Theta_h\) is a theta characteristic:

\[
                             \Theta_h^{\otimes2}\simeq\omega_C. \tag{30.13}
\]

For two legs satisfying (30.8),

\[
          \Theta_x\otimes\Theta_r^{-1}
                    \simeq\mathcal O_C\bigl(14(D_x-D_r)\bigr). \tag{30.14}
\]

In particular, (30.14) is 2-torsion, and squaring it gives the
trivialization asserted by (30.9).

#### Proof

Using (30.11), (30.12), and then (30.3), one obtains

\[
\begin{aligned}
 \Theta_h^{\otimes2}
   &\simeq \mathcal O_C(30D_h)\otimes L_h^{-2}\\
   &\simeq \mathcal O_C(28D_h-2U_h)\otimes\omega_C^{-2}\\
   &\simeq \omega_C.
\end{aligned}
\]

When \(U_x=U_r\), equation (30.11) gives

\[
                         L_x\otimes L_r^{-1}
                              \simeq\mathcal O_C(D_x-D_r).
\]

Substitution in the first expression in (30.12) proves (30.14). \(\square\)

This refinement splits the \(28^{2g}\) possibilities into the
\(2^{2g}\) possible relative theta characteristics and, after one is fixed,
a fiber of multiplication by \(14\), containing \(14^{2g}\) classes.

## 4. The elliptic specialization

Let \(C=E\) be an elliptic curve and choose an origin.  Under
\(\operatorname{Pic}^0(E)\simeq E\), Corollary 30.4 becomes

\[
       \sum_{P\in D_x}P-\sum_{Q\in D_r}Q\in E[28].        \tag{30.15}
\]

For one leg, (30.4) says

\[
                     2\sum_{u\in U_h}u
                         =28\sum_{P\in D_h}P.
\]

Equivalently, for some \(\epsilon_h\in E[2]\),

\[
                 \sum_{u\in U_h}u
                    =14\sum_{P\in D_h}P+\epsilon_h.       \tag{30.16}
\]

For two legs with the same \(U\), subtracting (30.16) again gives
(30.15).  Thus the elliptic group-law constraint is exactly the genus-one
shadow of the cubic-differential identity, rather than a phenomenon special
to a choice of Weierstrass coordinates.

## 5. What this does and does not reduce

The theorem replaces a continuous search for the high divisor, with
\(C,U\) fixed, by a finite torsion search in its divisor class.  It also
gives a direct certificate for rejecting a proposed pair: compute the two
degree-three Abel--Jacobi classes and test (30.9).

It does not constrain a single leg enough to imply nonexistence.  In genus
one the group \(E[28](k)\) has \(28^2\) points, and degree-three linear
systems have dimension two.  The remaining difficulty is therefore to
couple (30.9) with the two pencils and with the two partitions of the common
residual divisor \(U\); the torsion identity alone cannot decide visibility.
