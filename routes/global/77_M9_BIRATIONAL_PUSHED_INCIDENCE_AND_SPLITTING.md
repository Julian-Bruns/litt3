# The pushed incidence curve and the exact genus-three splitting type

## Status and purpose

**Status: proved.**

Assume that the degree-nine seven-diamond has been reached:

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a\ }&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{\ c\ }&X,
 \end{array}
 \qquad
 \deg a=\deg c=9,\qquad \deg p=7,
 \tag{77.1}
\]

where all three maps are finite etale,

\[
 X:v^2=x^7-x+1,\qquad Y:z^2=1-t^{31},
 \qquad g(X)=3,\quad g(Y)=15,
 \tag{77.2}
\]

and put

\[
                         h=p_*a^*:J(Y)\longrightarrow J(C).
\tag{77.3}
\]

File 40 proves

\[
                         c_*h=0.                       \tag{77.4}
\]

The first result below packages (77.4) geometrically.  The map

\[
                (cp,a):V\longrightarrow X\times Y
\]

is birational onto its image.  That image is a zero-action incidence
divisor cut out by an exterior-product line bundle of bidegree \((9,63)\).
It therefore turns the moving divisors on \(C\) into one global degree-nine
linear family on \(X\).  The 32 square fibers survive as 32 Veronese points
on a degree-63 rationally parametrized curve in \(|2N|\).

The second result applies in the birational coefficient-map case.  If
\(L\) is the degree-18 coefficient line bundle and

\[
 \delta=L\otimes(c^*H_X)^{-1}\in J(C)[14],
\tag{77.5}
\]

then the vector bundle obtained by pushing \(\delta\) to the hyperelliptic
line has an exact splitting type.  Writing \(n=h^0(C,L)\), one has

\[
                         3\leq \dim W\leq n\leq7,       \tag{77.6}
\]

and the splitting is one of two completely explicit three- or five-step
forms.  Thus the incomplete coefficient subsystem is the only remaining
linear-series freedom: the complete series and its relative position over
the hyperelliptic line are no longer unknown.

## 1. A zero-action incidence curve on \(X\times Y\)

Put

\[
                         f=cp:V\longrightarrow X
\]

and let \(\Gamma\subset X\times Y\) be the reduced image of
\(\Phi=(f,a)\).

### Theorem 77.1 (the pushed map is birational)

The map

\[
                       \Phi:V\longrightarrow\Gamma
\]

is birational.  The normalization projections of \(\Gamma\) are the etale
maps

\[
                    f:V\to X\quad\hbox{and}\quad a:V\to Y
\]

of degrees 63 and 9.  The induced correspondence homomorphism

\[
                         u_\Gamma:J(Y)\longrightarrow J(X)
\]

is zero, and there are base-point-free line bundles

\[
             N\in\operatorname{Pic}^9(X),\qquad
             R\in\operatorname{Pic}^{63}(Y)             \tag{77.7}
\]

such that

\[
                       \mathcal O(\Gamma)\simeq N\boxtimes R.
\tag{77.8}
\]

#### Proof

Let \(e\) be the generic degree of \(V\to\Gamma\), and let
\(\widetilde\Gamma\) be the normalization.  Both component maps factor
through \(\widetilde\Gamma\), so

\[
                  e\mid\gcd(\deg f,\deg a)=\gcd(63,9)=9.
\]

Thus \(e\in\{1,3,9\}\), and the two normalization projections have
degrees \(63/e\) and \(9/e\).

As a cycle,

\[
                         \Phi_*[V]=e[\Gamma].
\]

Its action from \(J(Y)\) to \(J(X)\) is

\[
                       f_*a^*=c_*p_*a^*=c_*h=0
\]

by (77.4).  Hence \([e]u_\Gamma=0\).  The group
\(\operatorname{Hom}(J(Y),J(X))\) is torsion-free, so \(u_\Gamma=0\).

The product decomposition of the Picard group now gives

\[
                       \mathcal O(\Gamma)\simeq N_e\boxtimes R_e,
\]

where

\[
                       \deg N_e=9/e,\qquad
                       \deg R_e=63/e.                 \tag{77.9}
\]

Both line bundles are base-point-free.  Indeed, a base point on one
factor would force the corresponding vertical or horizontal fiber to be
a component of the irreducible divisor \(\Gamma\), contrary to finite
dominance over both factors.

The curve \(X\) is hyperelliptic of genus three.  The elementary
hyperelliptic lemma used in Theorem 45.4 says that a base-point-free line
bundle of degree \(d\leq g(X)\) has even degree (and is a power of the
hyperelliptic bundle).  If \(e=3\) or \(9\), then (77.9) gives respectively
\(\deg N_e=3\) or \(1\), both impossible.  Therefore \(e=1\).  Equations
(77.7)--(77.8) follow, and the normalization maps are the original etale
maps \(f,a\).  \(\square\)

The proof isolates the exact hypothesis imported from the Honda theory:
only the vanishing (77.4) is used.  In particular, once that vanishing is
known, Theorem 77.1 does not use absolute simplicity of either Jacobian.

### Proposition 77.2 (the global degree-nine family)

There is a nonconstant morphism

\[
                 \zeta:Y\longrightarrow |N|\simeq\mathbf P^6
\tag{77.10}
\]

such that

\[
                  \zeta^*\mathcal O_{\mathbf P^6}(1)\simeq R,
                  \qquad \deg\zeta^*\mathcal O(1)=63. \tag{77.11}
\]

For \(y\in Y\), its divisor is

\[
          Z_y=(cp)_*a^*(y)=c_*D_y,
          \qquad D_y:=p_*a^*(y),                       \tag{77.12}
\]

an effective divisor of degree nine on \(X\).

Let \(\iota_Y\) be the hyperelliptic involution and
\(t:Y\to\mathbf P^1\) its quotient.  Multiplication of sections gives a
morphism

\[
 \overline\zeta:\mathbf P^1\longrightarrow
      \mathbf P\bigl(H^0(X,N^2)\bigr)=\mathbf P^{15}   \tag{77.13}
\]

characterized by

\[
       \overline\zeta(t(y))=[s_y s_{\iota_Yy}],
       \qquad \operatorname{div}(s_y)=Z_y.             \tag{77.14}
\]

It satisfies

\[
                    \deg\overline\zeta^*\mathcal O(1)=63. \tag{77.15}
\]

At each of the 32 Weierstrass points
\(P_\alpha\), \(\alpha\in\mu_{31}\cup\{\infty\}\), one has

\[
         \overline\zeta(\alpha)=[s_{P_\alpha}^2]
                \in v_2\bigl(\mathbf P H^0(X,N)\bigr). \tag{77.16}
\]

Finally, \(\zeta\) does not factor through \(t\).

#### Proof

By Riemann--Roch,
\(h^0(X,N)=9-3+1=7\) and \(h^0(X,N^2)=18-3+1=16\).  Let

\[
       s\in H^0(X,N)\otimes H^0(Y,R)
\]

be the section cutting out \(\Gamma\).  For every \(y\), its specialization
\(s_y\in H^0(X,N)\otimes R_y\) is nonzero: otherwise the whole horizontal
fiber \(X\times\{y\}\) would be a component of \(\Gamma\).  Thus \(s\)
defines (77.10), with

\[
                       \zeta^*\mathcal O(-1)=R^{-1}.
\]

This proves (77.11).  Intersecting \(\Gamma\) with the horizontal fiber
and using the birational normalization \(V\to\Gamma\) gives exactly
(77.12).

The divisor identity from the norm-polynomial construction is

\[
                       D_y+D_{\iota_Yy}\in|L|.
\]

After applying \(c_*\), (77.12) shows that

\[
                       Z_y+Z_{\iota_Yy}\in|N^2|.
\]

The product \(s_y s_{\iota_Yy}\) is invariant under \(\iota_Y\), so the
corresponding projective morphism descends uniquely through \(t\), giving
(77.13)--(77.14).  Its pulled-back hyperplane bundle on \(Y\) is

\[
                         R\otimes\iota_Y^*R,
\]

of degree 126.  Since \(t\) has degree two, the descended bundle has
degree 63, proving (77.15).  At a Weierstrass point
\(P_\alpha=\iota_YP_\alpha\), the product is a literal square, which is
(77.16).

If \(\zeta\) factored through the degree-two map \(t\), the degree in
(77.11) would be even.  It is 63, so such a factorization is impossible.
\(\square\)

### Proposition 77.2a (only two possible nonbirational incidence pencils)

Let \(U\subseteq H^0(X,N)\) be the linear span of the sections
\(s_y\), and put \(k=\dim U\).  Then exactly one of the following holds.

1. The map \(\zeta:Y\to\zeta(Y)\) is birational.
2. One has \(k\in\{3,4\}\), and \(\zeta\) factors as
   \[
       Y\xrightarrow{\psi}\mathbf P^1
        \xrightarrow{\iota}\mathbf P(U),
       \qquad \deg\psi=21,\quad
       \deg\iota^*\mathcal O(1)=3.                   \tag{77.16a}
   \]
   In this case the incidence divisor descends to a curve on
   \(X\times\mathbf P^1\) whose normalization \(Z\) has etale maps of
   degrees three to \(X\) and nine to \(\mathbf P^1\); in particular
   \(g(Z)=7\).
3. One has \(k=2\), and \(\zeta\) factors through a degree-63 map
   \(\psi:Y\to\mathbf P^1\).  The incidence divisor is then the normalized
   fiber product of \(\psi\) and a degree-nine map \(X\to\mathbf P^1\),
   and both projections from that normalization are etale.

Consequently \(k\geq5\) forces \(\zeta\) to be birational.

#### Proof

Let \(B_\zeta\) be the normalization of \(\zeta(Y)\), let
\(d_\zeta=\deg(Y/B_\zeta)\), and put

\[
              e_\zeta=\deg\mathcal O_{B_\zeta}(1).
\]

Equation (77.11) gives

\[
                         d_\zeta e_\zeta=63.          \tag{77.16b}
\]

In particular \(d_\zeta\) is prime to the characteristic.  If
\(g(B_\zeta)>0\), pullback gives a nonzero homomorphism
\(J(B_\zeta)\to J(Y)\).  The absolute simplicity of \(J(Y)\) makes its
image all of \(J(Y)\), so \(g(B_\zeta)\geq15\).  On the other hand
Riemann--Hurwitz gives

\[
                       14\geq d_\zeta(g(B_\zeta)-1).
\]

It follows that \(d_\zeta=1\).  Thus every nonbirational case has
\(B_\zeta\simeq\mathbf P^1\).

The divisors of 63 are

\[
                         1,3,7,9,21,63.
\]

The hyperelliptic small-pencil lemma rules out the odd degrees
\(3,7,9\), all at most \(g(Y)=15\).  Hence a nonbirational map has degree
21 or 63.  In the first case \(e_\zeta=3\), and a base-point-free
birational subsystem of \(|\mathcal O_{\mathbf P^1}(3)|\) has dimension
three or four.  In the second case \(e_\zeta=1\), so its span is a line.
This proves the asserted values of \(k\).

It remains to record the descent of the incidence curve.  If
\(\zeta=\iota\psi\), pull the universal incidence divisor back along

\[
                 X\times Y\longrightarrow X\times\mathbf P^1.
\]

The resulting curve \(\Gamma_0\subset X\times\mathbf P^1\) has
bidegrees \((9,e_\zeta)\), and \(\Gamma\) is its scheme-theoretic pullback.
Since \(\Gamma\) is irreducible, its normalization \(V\) maps with degree
\(d_\zeta\) to the normalization \(Z\) of \(\Gamma_0\).  The composite
\(V\to Z\to X\) is the etale map \(V\to X\).  Additivity and
nonnegativity of different divisors in this separable tower show that
both \(V\to Z\) and \(Z\to X\) are etale.  Thus \(Z\to X\) has degree
\(e_\zeta=3\) or 1, while \(Z\to\mathbf P^1\) has degree nine.  In the
degree-three case etale Riemann--Hurwitz gives

\[
                         g(Z)-1=3(g(X)-1)=6.
\]

For \(e_\zeta=1\), \(Z\simeq X\), giving the stated normalized fiber
product.  \(\square\)

### Corollary 77.2b (the two exact common branch profiles)

The two nonbirational alternatives in Proposition 77.2a have the following
forced tame ramification.

1. In the degree-21 alternative, the two maps to \(\mathbf P^1\)
   \[
                  Z\longrightarrow\mathbf P^1,
                  \qquad Y\longrightarrow\mathbf P^1
   \]
   have exactly five common branch values.  Above each one their fiber
   types are respectively
   \[
                              3^3\qquad\hbox{and}\qquad3^7. \tag{77.16c}
   \]
2. In the degree-63 alternative, the maps
   \[
                  X\longrightarrow\mathbf P^1,
                  \qquad Y\longrightarrow\mathbf P^1
   \]
   have exactly three common branch values.  After ordering them, the
   fiber types are
   \[
   \begin{array}{c|ccc}
      &b_1&b_2&b_3\\ \hline
    X&3^3&9&9\\
    Y&3^{21}&9^7&9^7.
   \end{array}                                         \tag{77.16d}
   \]

#### Proof

We use a local observation.  Suppose that two separable maps
\(A_1,A_2\to B\) have a normalized fiber product whose projections to
both \(A_i\) are etale.  Fix \(b\in B\), and choose arbitrary points
\(x_i\in A_i\) above \(b\).  Every component of the normalization above
\((x_1,x_2)\) has ramification index over \(B\) equal both to the
ramification index of \(x_1\) and to that of \(x_2\), because its maps to
the two local branches are unramified.  Hence every point in both fibers
has one common ramification index \(e_b\).  In particular, \(e_b\) divides
both map degrees.  The branch supports of the two maps are equal.

For the first alternative the degrees are 9 and 21, so every nontrivial
\(e_b\) equals three.  Riemann--Hurwitz for the degree-nine map from the
genus-seven curve \(Z\) gives total different

\[
                    2g(Z)-2+2\cdot9=30.
\]

A uniform \(3^3\)-fiber contributes six.  There are therefore exactly
five such fibers.  The degree-21 map from \(Y\) has total different
\(28+42=70\), and five \(3^7\)-fibers contribute exactly \(5\cdot14=70\).

For the second alternative, a common nontrivial index is three or nine.
Let \(A\) and \(B\) be the numbers of the two kinds of branch fibers.
The degree-nine map from the genus-three curve \(X\) has total different
22, so

\[
                              6A+8B=22.
\]

The unique nonnegative solution is \((A,B)=(1,2)\).  The corresponding
contributions for the degree-63 map from \(Y\) are 42 and 56, and

\[
                         42+2\cdot56=154=28+2\cdot63.
\]

Thus there is no further ramification.  All indices are three or nine,
which are prime to the characteristic five, so the ramification is tame.
\(\square\)

## 2. A splitting lemma over a genus-three hyperelliptic line

The next lemma is independent of \(Y\) and of the prime seven.

### Lemma 77.3 (exact splitting of a torsion-twisted hyperelliptic pullback)

Let \(X_0\) be a hyperelliptic curve of genus three over a field of odd
characteristic, let

\[
 \pi:X_0\to\mathbf P^1,\qquad H=\pi^*\mathcal O_{\mathbf P^1}(1),
\]

and let \(c_0:C_0\to X_0\) be a connected finite etale map of degree
\(M\).  Put \(b=\pi c_0\), and let \(\delta_0\in\operatorname{Pic}^0(C_0)\)
be torsion of order prime to the characteristic.  Set

\[
                  L_0=b^*\mathcal O(1)\otimes\delta_0,
                  \qquad n=h^0(C_0,L_0),               \tag{77.17}
\]

and let \(\epsilon=1\) if \(\delta_0\simeq\mathcal O_{C_0}\), and
\(\epsilon=0\) otherwise.  Then

\[
\boxed{
 b_*\delta_0\simeq
 \mathcal O^{\epsilon}
 \oplus\mathcal O(-1)^{\,n-2\epsilon}
 \oplus\mathcal O(-2)^{\,2M-2n+2\epsilon}
 \oplus\mathcal O(-3)^{\,n-2\epsilon}
 \oplus\mathcal O(-4)^{\epsilon}.}
\tag{77.18}
\]

In particular all exponents in (77.18) are nonnegative.

#### Proof

The bundle

\[
                         E=(c_0)_*\delta_0
\]

on \(X_0\) has degree zero and is semistable.  One direct way to see
semistability is to pass to a finite etale Galois cover dominating
\(c_0\) and then to a further finite etale cover trivializing all conjugates
of the prime-to-characteristic torsion line bundle \(\delta_0\).  On that
cover the pullback of \(E\) is trivial.  A positive-degree subbundle of
\(E\) would pull back to a positive-degree subbundle of a trivial bundle,
which is impossible.

Write the Birkhoff--Grothendieck splitting

\[
                         b_*\delta_0=\bigoplus_{i=1}^{2M}\mathcal O(a_i).
\tag{77.19}
\]

If some \(a_i>0\), its inclusion in (77.19), by adjunction, would give a
nonzero map

\[
                    \pi^*\mathcal O(a_i)\longrightarrow E
\]

from a positive-degree line bundle to a semistable degree-zero bundle.
Thus

\[
                              a_i\leq0.                 \tag{77.20}
\]

Since \(c_0\) is etale and \(g(X_0)=3\),

\[
                   \omega_{C_0}=b^*\mathcal O(2),
          \qquad \omega_{C_0/\mathbf P^1}=b^*\mathcal O(4).
\]

Finite-flat duality consequently gives

\[
     b_*\delta_0^{-1}\simeq (b_*\delta_0)^\vee\otimes\mathcal O(-4).
\tag{77.21}
\]

Applying (77.20) to \(\delta_0^{-1}\) and using (77.21) yields

\[
                              -4\leq a_i.               \tag{77.22}
\]

A degree-zero torsion line bundle has a section precisely when it is
trivial.  Equations (77.19)--(77.22) therefore show that exactly
\(\epsilon\) of the \(a_i\)'s are zero.  Applying the same statement to
\(\delta_0^{-1}\) and using (77.21) shows that exactly \(\epsilon\) of
them are \(-4\).

Now

\[
 n=h^0\bigl(\mathbf P^1,(b_*\delta_0)(1)\bigr)
   =2\epsilon+\#\{i:a_i=-1\}.                          \tag{77.23}
\]

Moreover \(\deg L_0=g(C_0)-1=2M\), so Riemann--Roch and
\(\omega_{C_0}=b^*\mathcal O(2)\) give

\[
 h^0(C_0,L_0)
   =h^0\bigl(C_0,b^*\mathcal O(1)\otimes\delta_0^{-1}\bigr).
\tag{77.24}
\]

Using (77.21) in (77.24) gives

\[
                     \#\{i:a_i=-3\}=n-2\epsilon.      \tag{77.25}
\]

All remaining summands have degree \(-2\), and their number is forced by
the rank \(2M\).  This is exactly (77.18).  \(\square\)

## 3. Specialization to the birational coefficient curve

Assume now that the coefficient map

\[
                  q_W:C\longrightarrow\mathbf P(W^\vee)
\]

is birational.  File 44 gives

\[
 L=(\pi c)^*\mathcal O(1)\otimes\delta,
 \qquad \delta\in J(C)[14].                           \tag{77.26}
\]

Since 14 is prime to 5, Lemma 77.3 applies.

### Corollary 77.4 (finite splitting list at \(M=9\))

Put

\[
                         w=\dim W,\qquad n=h^0(C,L).
\]

Then

\[
                         3\leq w\leq n\leq7.           \tag{77.27}
\]

If \(\delta\ne0\), then

\[
 (\pi c)_*\delta\simeq
       \mathcal O(-1)^n\oplus
       \mathcal O(-2)^{18-2n}\oplus
       \mathcal O(-3)^n.                              \tag{77.28}
\]

If \(\delta=0\), then

\[
 (\pi c)_*\mathcal O_C\simeq
       \mathcal O\oplus
       \mathcal O(-1)^{n-2}\oplus
       \mathcal O(-2)^{20-2n}\oplus
       \mathcal O(-3)^{n-2}\oplus
       \mathcal O(-4).                                \tag{77.29}
\]

In the full remaining coefficient dimension \(w=7\), one necessarily has
\(n=7\).  Thus (77.28) becomes

\[
       \mathcal O(-1)^7\oplus\mathcal O(-2)^4
                              \oplus\mathcal O(-3)^7,  \tag{77.30}
\]

while (77.29) becomes

\[
       \mathcal O\oplus\mathcal O(-1)^5
       \oplus\mathcal O(-2)^6
       \oplus\mathcal O(-3)^5\oplus\mathcal O(-4).   \tag{77.31}
\]

#### Proof

The lower bounds in (77.27) are file 46 and the inclusion
\(W\subseteq H^0(C,L)\).  Since \(W\) is base-point-free and birational,
the complete system \(|L|\) is also base-point-free and birational.

Suppose \(n\geq8\).  Choose an eight-dimensional subsystem of
\(H^0(C,L)\) containing \(W\).  It is still base-point-free and
birational, and maps \(C\) to a nondegenerate degree-18 curve in
\(\mathbf P^7\).  Castelnuovo's bound there is

\[
 \pi_0(18,7)
   ={2\choose2}(7-1)+2\cdot5=16,
 \quad 17=2(7-1)+5.
\]

This contradicts \(g(C)=19\).  Hence \(n\leq7\).  Formulas
(77.28)--(77.29) are Lemma 77.3 with \(M=9\), and the last two displays
are their specialization to \(n=7\).  \(\square\)

## 4. Why etaleness alone cannot bound the incidence defect

The following identity records both the useful conclusion and the exact
limitation of a general self-intersection argument.

### Proposition 77.5 (exact defect of a zero-action etale incidence curve)

Let \(X_0,Y_0\) be smooth projective curves of genera at least two, and
suppose

\[
                 \operatorname{Hom}(J(Y_0),J(X_0))=0.
\]

Let \(Z_0\) be a smooth connected curve with finite etale maps

\[
 u:Z_0\longrightarrow X_0,\qquad v:Z_0\longrightarrow Y_0
\]

of degrees \(d_X,d_Y\), and assume that

\[
       \nu=(u,v):Z_0\longrightarrow X_0\times Y_0
\]

is birational onto its reduced image \(\Gamma_0\).  Then

\[
 \Gamma_0^2=2d_Xd_Y,
 \qquad
 p_a(\Gamma_0)=1+d_Xd_Y+2(g(Z_0)-1),                 \tag{77.33}
\]

and its total normalization defect is

\[
 \boxed{\quad
 \delta(\Gamma_0):=p_a(\Gamma_0)-g(Z_0)
       =d_Xd_Y+g(Z_0)-1.\quad}                       \tag{77.34}
\]

Equivalently, since \(\Gamma_0\) is a Cartier curve on a smooth surface,
its conductor has degree

\[
                        2d_Xd_Y+2g(Z_0)-2.           \tag{77.35}
\]

If \(\nu\) is an immersion, its normal line bundle has degree

\[
                         \deg N_\nu=2-2g(Z_0),       \tag{77.36}
\]

and (77.33)--(77.34) can be rewritten as the self-intersection formula

\[
                         \Gamma_0^2=\deg N_\nu+2\delta(\Gamma_0).
                                                               \tag{77.37}
\]

In particular, an immersed zero-action etale correspondence cannot be
embedded: all of the positive self-intersection is paid for by
self-incidence.  On the other hand, etaleness puts no local upper bound on
the contribution of a single self-incidence.  Indeed, in formal
coordinates on a smooth surface the two smooth branches

\[
                         y=x,\qquad y=x+x^q           \tag{77.38}
\]

have both coordinate projections etale at the origin and have intersection
multiplicity \(q\), for every \(q\geq2\).

#### Proof

The divisor \(\Gamma_0\) induces a homomorphism
\(J(Y_0)\to J(X_0)\), which is zero by the Hom hypothesis.  The standard
product decomposition of the Picard group therefore gives

\[
                    \mathcal O(\Gamma_0)\simeq A\boxtimes B
\]

with

\[
                         \deg A=d_Y,\qquad \deg B=d_X.
\]

Consequently \(\Gamma_0^2=2d_Xd_Y\).  Moreover

\[
 K_{X_0\times Y_0}\cdot\Gamma_0
   =d_X(2g(X_0)-2)+d_Y(2g(Y_0)-2).
\]

Etale Riemann--Hurwitz says that both summands on the right equal
\(2g(Z_0)-2\).  Adjunction now gives the second equality in (77.33), and
subtracting \(g(Z_0)\) proves (77.34).  Formula (77.35) is the standard
conductor-degree formula for a reduced Cartier curve on a smooth surface.

If \(\nu\) is an immersion, its tangent-normal sequence is

\[
 0\longrightarrow T_{Z_0}\longrightarrow
 u^*T_{X_0}\oplus v^*T_{Y_0}\longrightarrow N_\nu\longrightarrow0.
\]

Both maps are etale, so each of \(u^*T_{X_0}\) and \(v^*T_{Y_0}\) is
isomorphic to \(T_{Z_0}\).  Taking degrees proves (77.36), and substitution
in (77.34) proves (77.37).

Finally, both branches in (77.38) are immersed, and the derivatives of
both their \(x\)- and \(y\)-coordinates are units at the origin.  Their
intersection algebra is \(k[[x]]/(x^q)\), of length \(q\).  Thus even the
local defect can be concentrated in arbitrarily high tangency without
violating etaleness of either projection.  \(\square\)

Proposition 77.5 shows that a general normalization-defect estimate cannot
close the argument.  For fixed bidegree it supplies an exact total, not a
smaller upper bound; locally, arbitrary tangencies consume that total.
Any useful bound must exploit the special cyclic labels, square fibers, or
monodromy, rather than the etale condition alone.

## 5. Scope and remaining obstruction

The absolute simplicity of \(J(Y)\) enters the route only upstream: it is
used in file 40 to make the nonzero orbit norm \(h\) have
15-dimensional image and to force its composite with \(J(C)\to J(X)\)
to vanish.  The actual reusable hypotheses for Theorem 77.1 are simply

\[
                h\ne0\text{ with finite kernel},
                \qquad \operatorname{Hom}(J(Y),J(X))=0. \tag{77.32}
\]

Absolute simplicity of \(J(X)\) is never required.  For an arbitrary
prime-ratio cyclic diamond, the same pushed-incidence argument works once
(77.32) is available.  Its birationality conclusion holds whenever every
proper quotient \(M/e\) which can occur as the degree on \(X\) is an odd
integer at most the genus of a hyperelliptic \(X\).  The present
\((r,M,g(X))=(7,9,3)\) case is exactly such an endpoint.

Lemma 77.3 is independent of the prime ratio and works for every etale
degree \(M\) over a genus-three hyperelliptic target.  Its particularly
symmetric form uses \(g(X)=3\); for a general hyperelliptic target the
relative-duality shift is \(g(X)+1\), so (77.18) must be replaced by the
corresponding longer splitting interval.

The results above do not yet contradict the diamond.  They identify two
precise remaining pieces of geometry:

1. the degree-63 curve \(\zeta(Y)\subset|N|\), whose hyperelliptic norm
   passes through the 32 Veronese points (77.16), must be excluded using
   the fact that its incidence normalization is etale over both targets;
2. in the birational coefficient model, one must exclude the finite list
   (77.28)--(77.29), together with the subsystem
   \(W\subseteq H^0(C,L)\).

Pure discriminant degree does not do this: because both normalization
projections are etale, the pulled-back discriminant is exactly twice the
conductor divisor.  A successful continuation must therefore use the
special \(\mathbf F_2^5\)-indexed square fibers, the multiplication maps
of the explicit splitting (77.18), or an integral restriction on the
incidence monodromy rather than only its total discriminant.
