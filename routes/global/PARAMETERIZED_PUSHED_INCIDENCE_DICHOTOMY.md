# The parameterized pushed-incidence dichotomy

## Status and purpose

**Status: proved; self-check complete.**

Let

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a\ }&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{\ c\ }&X
 \end{array}
 \qquad
 \deg p=r,\qquad \deg a=\deg c=M                     \tag{I.1}
\]

be an equal-degree diamond of connected finite etale covers.  This note
extracts the general content of the pushed-incidence construction used at
\((r,M,g(X),g(Y))=(7,9,3,15)\).

Assume that

\[
             c_*p_*a^*:J(Y)\longrightarrow J(X)
                         \quad\hbox{is zero}.           \tag{I.2}
\]

For example, (I.2) follows from
\(\operatorname{Hom}(J(Y),J(X))=0\).

The image of

\[
                         (cp,a):V\longrightarrow X\times Y
\]

is then a zero-action divisor.  Its possible generic image degree is
controlled by base-point-free line bundles on \(X\), rather than merely
by divisibility.  If the resulting family of divisors on \(X\) is not
birationally parametrized by \(Y\), absolute simplicity of \(J(Y)\)
forces it to be a pencil.  The pencil produces two maps to
\(\mathbf P^1\) whose normalized fiber product is etale over both source
curves; their complete local ramification types must agree.

The final formulas also explain an asymptotic limitation.  The conductor
of the incidence image grows quadratically in its degree and is exactly
large enough to absorb all collisions.  Total defect or discriminant
degree alone can therefore never exclude the diamond.

## 1. The zero-action image

Put

\[
                         f=cp:V\longrightarrow X
\]

and let \(\Gamma\subset X\times Y\) be the reduced image of
\(\Phi=(f,a)\).  Let \(e\) be the generic degree of
\(V\to\Gamma\), and let \(G\) be the normalization of \(\Gamma\).

### Theorem I.1 (generic image degree and exterior-product class)

One has

\[
                              e\mid M.                 \tag{I.3}
\]

The induced maps

\[
                         u:G\to X,\qquad v:G\to Y
\]

are finite etale of degrees

\[
                    \deg u=\frac{rM}{e},\qquad
                    \deg v=\frac{M}{e}.                \tag{I.4}
\]

The correspondence homomorphism \(J(Y)\to J(X)\) induced by
\(\Gamma\) is zero.  There are base-point-free line bundles

\[
 N_e\in\operatorname{Pic}^{M/e}(X),\qquad
 R_e\in\operatorname{Pic}^{rM/e}(Y)                   \tag{I.5}
\]

such that

\[
                    \mathcal O_{X\times Y}(\Gamma)
                              \simeq N_e\boxtimes R_e. \tag{I.6}
\]

In particular,

\[
                     \operatorname{gon}(X)\leq M/e.   \tag{I.7}
\]

Thus every divisor \(e>1\) of \(M\) for which \(X\) has no
base-point-free line bundle of degree \(M/e\) is excluded.  If all such
proper divisors are excluded, then \(\Phi\) is birational onto its image.

#### Proof

Both component maps of \(\Phi\) factor through \(G\).  Hence \(e\)
divides \(rM\) and \(M\), proving (I.3), and the degrees in (I.4)
follow.

The extensions of function fields in

\[
                         V\longrightarrow G\longrightarrow X
\]

are separable intermediate extensions of the etale extension
\(k(V)/k(X)\).  Additivity and nonnegativity of different divisors show
that both maps are etale.  The same argument over \(Y\) proves the
assertion for \(v\).

As a cycle, \(\Phi_*[V]=e[\Gamma]\).  Its action on Jacobians is

\[
                        f_*a^*=c_*p_*a^*=0
\]

by (I.2).  Therefore \(e\) times the action of \(\Gamma\) is zero.
The group \(\operatorname{Hom}(J(Y),J(X))\) is torsion-free, so the
action of \(\Gamma\) itself vanishes.

The standard product description of the Picard group now gives (I.6).
Intersecting with the two fiber classes gives the degrees in (I.5).  A
base point of \(N_e\), respectively \(R_e\), would make the
corresponding vertical, respectively horizontal, fiber a component of
the integral divisor \(\Gamma\).  Both bundles are therefore
base-point-free.  Since \(N_e\) has positive degree, its complete
linear series contains a pencil, proving (I.7).  The final assertions
are immediate. \(\square\)

### Corollary I.2 (the useful hyperelliptic test)

Suppose that \(X\) is hyperelliptic.  If

\[
                   M/e\leq g(X)\quad\hbox{and}\quad M/e
                   \ \hbox{is odd},                   \tag{I.8}
\]

then \(e\) cannot be the generic image degree.

#### Proof

On a hyperelliptic curve, every base-point-free line bundle of degree at
most the genus is a power of the hyperelliptic pencil and hence has even
degree.  This contradicts (I.5) under (I.8). \(\square\)

## 2. The divisor family and its only nonbirational form

The section cutting out (I.6) defines a nonconstant morphism

\[
                 \zeta:Y\longrightarrow
                 \mathbf P H^0(X,N_e)                 \tag{I.9}
\]

whose point at \(y\) represents the degree-\(M/e\) divisor
\(\Gamma\cap(X\times\{y\})\).  Let \(B_\zeta\) be the normalization of
its image, and write

\[
 d=[k(Y):k(B_\zeta)],\qquad
 \ell=\deg\mathcal O_{B_\zeta}(1).                    \tag{I.10}
\]

### Theorem I.3 (simple Jacobian forces a rational pencil, up to Frobenius)

The family (I.9) satisfies

\[
                 \zeta^*\mathcal O(1)\simeq R_e,
                 \qquad d\ell=\frac{rM}{e}.           \tag{I.11}
\]

Assume in addition that \(J(Y)\) is absolutely simple.  Then exactly one
of the following conclusions applies:

1. \(d=1\), so \(\zeta\) is birational onto its image;
2. \(B_\zeta\simeq\mathbf P^1\); or
3. \(g(B_\zeta)=g(Y)\), the separable degree of \(\zeta\) is one, and
   \(d\) is a positive power of the characteristic.

In particular, if \(\zeta\) is generically separable---for example, if
the characteristic does not divide \(rM/e\)---then only alternatives 1
and 2 occur.

In alternative 2 write

\[
 \psi:Y\longrightarrow\mathbf P^1,\qquad\deg\psi=d.   \tag{I.12}
\]

There is an integral incidence divisor

\[
                \Gamma_0\subset X\times\mathbf P^1
\]

of exterior-product class

\[
                 \mathcal O(\Gamma_0)
                    \simeq N_e\boxtimes\mathcal O(\ell).             \tag{I.13}
\]

If \(Z\) is its normalization, then

\[
 Z\longrightarrow X\quad\hbox{is etale of degree }\ell,\qquad
 Z\longrightarrow\mathbf P^1\quad\hbox{has degree }n:=M/e.           \tag{I.14}
\]

Moreover, \(G\) is the normalization of
\(Z\times_{\mathbf P^1}Y\), and both projections

\[
                         G\to Z,\qquad G\to Y          \tag{I.15}
\]

are etale, of degrees \(d\) and \(n\), respectively.

#### Proof

Write a defining section of \(\Gamma\) as

\[
          s\in H^0(X,N_e)\otimes H^0(Y,R_e).
\]

Its specialization at every \(y\) is nonzero, since otherwise the
horizontal fiber over \(y\) would be a component of \(\Gamma\).  It
therefore gives (I.9), and the tautological quotient gives the line-bundle
identity in (I.11).  The degree identity follows from (I.5).

Suppose \(g(B_\zeta)>0\).  Pullback gives a nonzero homomorphism
\(J(B_\zeta)\to J(Y)\).  Its image is a positive-dimensional abelian
subvariety.  Simplicity of \(J(Y)\) makes that image all of \(J(Y)\), so
\(g(B_\zeta)=g(Y)\).

Factor \(\zeta\) as a power of relative Frobenius followed by a separable
map from the corresponding Frobenius twist of \(Y\) to \(B_\zeta\).  The
twist still has genus \(g(Y)\).  Riemann--Hurwitz for the separable factor
gives

\[
             g(Y)-1\geq d_{\rm sep}\bigl(g(B_\zeta)-1\bigr)
                         =d_{\rm sep}(g(Y)-1),
\]

where \(d_{\rm sep}\) is its separable degree.  Hence
\(d_{\rm sep}=1\).  If the inseparable degree is also one, then \(d=1\);
otherwise \(d\) is a positive power of the characteristic, which is
alternative 3.  Thus every remaining nonbirational, generically separable
case has rational normalized image.

In that case the morphism from \(\mathbf P^1\) to the projective space
in (I.9) is defined by a base-point-free subsystem of
\(H^0(\mathbf P^1,\mathcal O(\ell))\).  The universal incidence section
therefore descends \(s\) to a section of
\(N_e\boxtimes\mathcal O(\ell)\) on \(X\times\mathbf P^1\).
Faithfully flat pullback through \(\psi\) shows that its zero divisor
\(\Gamma_0\) is integral, and (I.13) gives the two degrees in (I.14).

The normalization \(G\) of \(\Gamma\) is the normalization of
\(Z\times_{\mathbf P^1}Y\).  Its map to \(X\) factors as

\[
                         G\longrightarrow Z\longrightarrow X.
\]

The composite is etale by Theorem I.1.  The two intermediate
function-field extensions are separable, so additivity of the different
makes both maps etale.  The projection \(G\to Y\) is already etale by
Theorem I.1.  The degrees now follow from (I.11)--(I.14). \(\square\)

### Corollary I.4 (hyperelliptic restriction on the parameter degree)

If \(Y\) is hyperelliptic and the rational-pencil alternative of
Theorem I.3 holds, assume also that \(\psi\) is separable.  Then an odd
value of \(d\) must satisfy

\[
                              d>g(Y).                  \tag{I.16}
\]

#### Proof

If \(d\) were odd and at most \(g(Y)\), the maps \(Y\to\mathbf P^1\)
of degrees \(d\) and two would generate \(k(Y)\).  Castelnuovo--Severi
would give \(g(Y)\leq d-1\), a contradiction. \(\square\)

## 3. Exact common ramification

The fiber-product conclusion contains more than equality of numerical
ramification indices.

### Proposition I.5 (common complete local type)

In the pencil alternative of Theorem I.3, put

\[
                 \varphi:Z\to\mathbf P^1,\qquad\deg\varphi=n.
\]

Assume that \(\varphi\) and \(\psi\) are separable (as is automatic when
the characteristic does not divide \(nd\)).  Then the branch supports of
\(\varphi\) and \(\psi\) are equal.  For each
point \(b\in\mathbf P^1\), all completed local extensions at all points
of both fibers are mutually isomorphic over
\(\widehat{\mathcal O}_{\mathbf P^1,b}\).  In particular there are
integers

\[
                 q_b\geq1,\qquad \Delta_b\geq q_b-1                 \tag{I.17}
\]

such that both fibers have one common ramification index \(q_b\), with
profiles

\[
                   \varphi^{-1}(b):q_b^{\,n/q_b},
                   \qquad
                   \psi^{-1}(b):q_b^{\,d/q_b},         \tag{I.18}
\]

and every point in the two fibers has different exponent \(\Delta_b\).
Consequently

\[
 q_b\mid\gcd(n,d),                                    \tag{I.19}
\]

\[
 \frac{\deg\operatorname{Diff}(\varphi)}n
   =\sum_b\frac{\Delta_b}{q_b}
   =\frac{\deg\operatorname{Diff}(\psi)}d.             \tag{I.20}
\]

If the two maps are tame, then \(\Delta_b=q_b-1\), so the entire pair of
ramification profiles is determined by the finite list of common divisors
\(q_b\mid\gcd(n,d)\).

#### Proof

Fix arbitrary points \(z\in Z\) and \(y\in Y\) over \(b\), and choose a
point of the normalization of the fiber product over \((z,y)\).  Its
completed fraction field is the compositum of the two completed local
fields.  By (I.15), this compositum is unramified over each one.
The residue field is algebraically closed, so a finite unramified
extension of either complete local field is trivial.  The two local
extensions of the base are therefore isomorphic.  Since \(z,y\) were
arbitrary, the common local type depends only on \(b\).

This proves (I.17)--(I.19).  A fiber contains \(n/q_b\), respectively
\(d/q_b\), points.  Summing its different contributions proves (I.20).
The tame statement is immediate. \(\square\)

### Corollary I.6 (the normalized Hurwitz identity)

Under the separability hypothesis of Proposition I.5, one has

\[
 \frac{g(Z)-1}{n}=\frac{g(Y)-1}{d},                   \tag{I.21}
\]

and hence

\[
                       d\ell\,(g(X)-1)
                           =n\,(g(Y)-1).               \tag{I.22}
\]

These identities are necessary consistency checks, but in a prime-ratio
diamond they reduce to the already known equalities

\[
 g(Y)-1=r(g(X)-1),\qquad d\ell=rn.
\]

#### Proof

Apply Riemann--Hurwitz to (I.20), cancel the common additive term \(2\),
and then use the etale map \(Z\to X\) of degree \(\ell\). \(\square\)

## 4. Exact asymptotic defect and the remaining input

### Proposition I.7 (general zero-action defect identity)

Let \(X_0,Y_0\) be smooth curves of genera at least two with
\(\operatorname{Hom}(J(Y_0),J(X_0))=0\).  Let \(Z_0\) have finite etale
maps to \(X_0,Y_0\) of degrees \(d_X,d_Y\), and suppose
\(Z_0\to X_0\times Y_0\) is birational onto its reduced image \(D\).
Then

\[
\begin{aligned}
 D^2&=2d_Xd_Y,\\
 p_a(D)&=1+d_Xd_Y+2(g(Z_0)-1),\\
 \delta(D)&=d_Xd_Y+g(Z_0)-1.                         \tag{I.23}
\end{aligned}
\]

The conductor divisor on \(Z_0\) has degree \(2\delta(D)\).  If the map
to the product is an immersion, its normal line has degree
\(2-2g(Z_0)\), and

\[
                         D^2=\deg N_{Z_0/(X_0\times Y_0)}
                                  +2\delta(D).         \tag{I.24}
\]

#### Proof

The Hom hypothesis makes \(\mathcal O(D)\) an exterior product.  Its
degrees on the two factors are \(d_Y,d_X\), so \(D^2=2d_Xd_Y\).
Furthermore

\[
 K_{X_0\times Y_0}\cdot D
 =d_X(2g(X_0)-2)+d_Y(2g(Y_0)-2)=4(g(Z_0)-1)
\]

by etale Riemann--Hurwitz.  Adjunction and normalization give (I.23).
The conductor formula holds for every reduced Cartier curve on a smooth
surface.  In the immersed case, the tangent-normal sequence and the two
etale identifications

\[
                   u^*T_{X_0}\simeq T_{Z_0}
                   \simeq v^*T_{Y_0}
\]

give \(\deg N=2-2g(Z_0)\), proving (I.24). \(\square\)

Write \(s=g(X)-1\) and \(n=M/e\).  Etale Riemann--Hurwitz gives

\[
                         g(G)-1=rn\,s.
\]

Applying Proposition I.7 to \(\Gamma\subset X\times Y\) gives

\[
 \boxed{\quad
  \delta(\Gamma)
       =rn^2+rns=rn(n+s),\qquad
  \deg\mathfrak C_\Gamma=2rn(n+s).\quad}              \tag{I.25}
\]

Thus the defect grows quadratically with the reduced incidence degree
\(n\).  This is not an upper-bound contradiction: it is the exact amount
of self-incidence forced by adjunction.  Likewise, (I.20) says that all
ramification of either pencil is exactly matched by the other one.

The genuinely dimension-specific inputs left after this theorem are:

1. exclusion of the finite set of base-point-free degrees \(M/e\) on the
   particular curve \(X\);
2. exclusion of the finite common local profiles (I.18) on the particular
   curves \(Z,Y\); or
3. a restriction on how the cyclic norm labels can consume the conductor
   (I.23).

Neither total ramification, Hodge index, nor normalization defect alone
distinguishes a putative diamond from the exact equality case.

This failure is local as well as numerical.  In formal coordinates on a
smooth surface, the two branches

\[
                           y=x,\qquad y=x+x^q          \tag{I.26}
\]

are immersed and etale over both coordinate axes at the origin, but have
intersection multiplicity \(q\), for any \(q\geq2\).  Thus the etale
condition puts no local cap on how the defect (I.25) can be concentrated.

## 5. The degree-nine specialization

For the original values

\[
                  (r,M,g(X),g(Y))=(7,9,3,15),
\]

Corollary I.2 excludes \(e=3,9\), so \(e=1\).  If the divisor family is
nonbirational, (I.11) and Corollary I.4 leave only

\[
 (d,\ell)=(21,3)\quad\hbox{or}\quad(63,1).
\]

Proposition I.5 then gives exactly the two profiles

\[
\begin{array}{c|c|c}
(d,\ell)&Z\to\mathbf P^1&Y\to\mathbf P^1\\ \hline
(21,3)&3^3\text{ at five values}&3^7\text{ at five values}\\
(63,1)&3^3,9,9&3^{21},9^7,9^7.
\end{array}
\]

This recovers the M=9 incidence reduction while separating its two
special hyperelliptic degree tests from the parameterized mechanism.
