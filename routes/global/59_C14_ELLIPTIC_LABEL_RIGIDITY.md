# Label rigidity in the cyclic genus-one coarsening

## Status and purpose

**Status: proved; independent audit pending.**

Assume the full-span degree-nine situation of files 47 and 58, in the
row

\[
             \operatorname{Gal}(V/B)=C_{14},\qquad g(B)=g(E)=1.
\]

Thus there is a cartesian square after normalization

\[
 \begin{array}{ccc}
 V&\longrightarrow&E\\
 \downarrow&&\downarrow\pi\\[-2mm]
 C&\stackrel q\longrightarrow&B,
 \end{array}
\tag{59.1}
\]

where \(\pi\) is an etale cyclic isogeny of degree seven and \(q\) is a
double cover branched at a reduced divisor \(\Delta\) of degree 36.  The
maps of the coefficient theorem and hyperelliptic-descent theorem are

\[
 t:E\longrightarrow\mathbf P^1_t,
 \qquad r:B\longrightarrow\mathbf P^1_x,
 \qquad \deg t=\deg r=9.
\tag{59.2}
\]

This note makes the compatibility in this row substantially more rigid.
First, the two double covers give an exact square-class equation and a
relation between the two degree-nine pencil bundles; the coefficient line
differs from the \(X\)-pencil line by explicit two- and seven-torsion.
Second, every
square-root label from file 44 acquires a concrete support inside the 36
branch points of \(q\).  Equal labels must have the same support, and a
label with support of size \(w\) can occur at most

\[
\begin{array}{c|ccccc}
w&1&3&5&7&9\\ \hline
\text{multiplicity}&7&6&3&1&1.
\end{array}
\tag{59.3}
\]

Combining this with the spectral-conductor budget of file 55 proves that
the 32 labels assume at least ten distinct values.  In particular the
image of \(J(Y)[2]\) under the norm correspondence has dimension at least
four, improving the general full-span bound of three in this cyclic row.
Orthogonality with the pulled-back \(J(X)[2]\) further forces the supports
to have only two parity patterns across the eight branch blocks of \(r\).

## 1. Exact descent of the two hyperelliptic equations

Write

\[
 Y:\ z^2=1-t^{31},\qquad
 X:\ v^2=x^7-x+1,
\]

and put

\[
             L_t=t^*\mathcal O_{\mathbf P^1}(1),
             \qquad L_r=r^*\mathcal O_{\mathbf P^1}(1).
\tag{59.4}
\]

### Proposition 59.1 (square class and pencil bundles)

There is a function \(u\in k(E)^*\) such that

\[
       1-t^{31}=u^2\,\pi^*(r^7-r+1).                  \tag{59.5}
\]

The branch divisor of the quadratic cover \(V\to E\) is exactly
\(\pi^*\Delta\).  Moreover there is a unique class
\(\eta\in J(B)[2]\) such that

\[
                  L_t^7\simeq\pi^*(L_r\otimes\eta).  \tag{59.6}
\]

If \(A\) is the degree-nine coefficient line bundle on \(B\), then

\[
 A\simeq\operatorname{Nm}_\pi(L_t)
   \simeq L_r\otimes\eta\otimes\kappa
 \quad\text{for some }\quad
 \kappa\in\ker\bigl(\pi^*:J(B)\to J(E)\bigr)\simeq C_7. \tag{59.6a}
\]

#### Proof

In the cyclic group of order fourteen, the subgroups of orders two and
seven have trivial intersection and generate the whole group.  Their fixed
fields are \(k(E)\) and \(k(C)\), respectively.  It follows that
\(k(V)=k(E)k(C)\) over \(k(B)\), so the quadratic extension \(k(V)/k(E)\)
is the pullback of \(k(C)/k(B)\).  The first extension is defined by
\(1-t^{31}\). The [hyperelliptic-descent theorem](58_X_CENTRAL_GLUE_CONGRUENCES.md#2-the-genus-one-and-genus-two-involutions) identifies the second with the pullback of
\(X\to\mathbf P^1_x\), hence it is defined by \(r^7-r+1\).  Two elements
of a field define the same quadratic extension precisely when their ratio
is a square.  This proves (59.5).  It also proves the assertion about the
branch divisor, since \(\pi\) is etale.

We use the following standard normalization calculation.  Let
\(f:G\to\mathbf P^1\) be a separable map from an elliptic curve, and let
\(H\to\mathbf P^1\) be a hyperelliptic double cover of genus \(g\).  If
all ramification of \(f\) is simple, lies over the hyperelliptic branch
divisor, and has index at most two there, then the inverse of the
trace-zero eigensheaf of the normalized pullback (the double-cover
building bundle) is

\[
                         (f^*\mathcal O(1))^{g-1}.     \tag{59.7}
\]

Indeed, before normalization the trace-zero eigensheaf is the pullback of
\(\mathcal O_{\mathbf P^1}(-g-1)\).  Normalization at the simple
ramification divisor \(R_f\) twists that eigensheaf by \(+R_f\).  Since
Riemann--Hurwitz gives
\(\mathcal O_G(R_f)\simeq f^*\mathcal O(2)\), the inverse trace-zero
bundle is
\(f^*\mathcal O(g+1)(-R_f)\simeq f^*\mathcal O(g-1)\), which is (59.7).

Apply (59.7) first to \(t\) and the genus-fifteen curve \(Y\), and then
to \(r\) and the genus-three curve \(X\).  The two building bundles are
therefore \(L_t^{14}\) and \(L_r^2\).  The cartesian square (59.1)
identifies the first with the pullback of the second, so

\[
                         L_t^{14}\simeq\pi^*L_r^2.    \tag{59.8}
\]

Thus \(L_t^7\otimes\pi^*L_r^{-1}\) is a two-torsion line bundle on
\(E\).  Because \(\deg\pi=7\) is prime to two, pullback
\(\pi^*:J(B)[2]\to J(E)[2]\) is an isomorphism.  This gives the unique
\(\eta\) and proves (59.6).

The homogeneous characteristic polynomial of the degree-seven map
\(E\to B\), applied to the two sections defining \(t\), has coefficient
bundle \(\operatorname{Nm}_\pi(L_t)\).  This is exactly the coefficient
bundle \(A\).  If \(\tau\) is translation by the kernel point of \(\pi\),
then

\[
 \pi^*\operatorname{Nm}_\pi(L_t)
       \simeq\bigotimes_{i=0}^6\tau^{i*}L_t\simeq L_t^7.
\]

For the last isomorphism, translation by a point \(Q\) changes the class
of a degree-nine line bundle by \(9Q\), while
\(\sum_{i=0}^6iQ=21Q=0\).  Comparing this identity with (59.6) shows that
\(A\otimes(L_r\otimes\eta)^{-1}\) belongs to the order-seven kernel of
\(\pi^*:J(B)\to J(E)\), proving (59.6a). \(\square\)

## 2. Branch-support description of the square-root labels

Let \(A\) retain the degree-nine coefficient line bundle on \(B\) from
Proposition 59.1.  The characteristic polynomial of \(t\) for the
degree-seven isogeny \(\pi\) is

\[
             \overline P(T)=\operatorname{Nm}_{E/B}(T-t).
\tag{59.9}
\]

Its pullback to \(C\) is the norm polynomial \(P(T)\) of file 44.  For
each

\[
                 \alpha\in\mathcal A_Y=\mu_{31}\cup\{\infty\},
\]

let \(p_\alpha\in H^0(B,A)\) be the corresponding evaluation section
(with the leading-coefficient interpretation at infinity), and write

\[
                 Z_\alpha=\operatorname{div}(p_\alpha),
                 \qquad \deg Z_\alpha=9.              \tag{59.10}
\]

File 44 supplies degree-nine divisors \(D_\alpha\) on \(C\) and labels

\[
 q^*Z_\alpha=2D_\alpha,
 \qquad
 \epsilon_\alpha=\mathcal O_C(D_\alpha-D_\infty)\in J(C)[2].
\tag{59.11}
\]

At every point away from \(\Delta\), the multiplicity in \(Z_\alpha\)
is even.  Define the reduced divisor

\[
 U_\alpha=\sum_{b\in\Delta}
       \bigl(\operatorname{mult}_bZ_\alpha\bmod2\bigr)b,
 \qquad w_\alpha=\deg U_\alpha.                       \tag{59.12}
\]

Then there is a unique effective divisor \(R_\alpha\) with

\[
 Z_\alpha=U_\alpha+2R_\alpha,
 \qquad
 w_\alpha\in\{1,3,5,7,9\},
 \qquad
 \deg R_\alpha=\frac{9-w_\alpha}{2}.                 \tag{59.13}
\]

If \(W_U\) denotes the sum of the ramification points of \(q\) over a
subset \(U\subseteq\Delta\), then

\[
                         D_\alpha=W_{U_\alpha}+q^*R_\alpha. \tag{59.14}
\]

### Lemma 59.2 (equal labels have identical branch support)

For two branch values \(\alpha,\beta\), one has

\[
 \epsilon_\alpha=\epsilon_\beta
 \quad\Longleftrightarrow\quad
 U_\alpha=U_\beta
 \ \text{and}\
 \mathcal O_B(R_\alpha)\simeq\mathcal O_B(R_\beta).  \tag{59.15}
\]

#### Proof

Only the forward implication needs care.  Equality of labels gives a
function \(f\in k(C)^*\) with

\[
                         \operatorname{div}(f)=D_\alpha-D_\beta.
\]

The divisor on the right is invariant under the deck involution \(\delta\)
of \(q\).  Therefore \(\delta(f)/f\) is a constant whose square is one,
so \(f\) is either invariant or anti-invariant.

If \(f\) is invariant, it belongs to \(k(B)^*\).  The coefficient of the
pullback of a divisor from \(B\) at every ramification point of \(q\) is
even.  Comparing (59.14) modulo two therefore gives
\(U_\alpha=U_\beta\), and then comparison after cancelling the branch
terms gives
\(\mathcal O_B(R_\alpha)\simeq\mathcal O_B(R_\beta)\).

If \(f\) is anti-invariant, write \(f=w g\), where
\(k(C)=k(B)(w)\), \(\delta(w)=-w\), and \(g\in k(B)^*\).  The valuation
of \(w\) is odd at every one of the 36 ramification points.  Hence
\(U_\alpha\) and \(U_\beta\) would be complementary subsets of
\(\Delta\).  This is impossible because both have degree at most nine.

Conversely, the two conditions on the right of (59.15), together with
(59.14), make \(D_\alpha-D_\beta\) the pullback of a principal divisor
on \(B\).  This proves the reverse implication. \(\square\)

### Proposition 59.3 (support-sensitive multiplicity bound)

If one value of the label \(\epsilon_\alpha\) occurs \(k\) times and its
common support has degree \(w\), then the bounds in (59.3) hold.

#### Proof

Fix such a label class.  Lemma 59.2 gives a common line bundle

\[
                         N=\mathcal O_B(R_\alpha),
 \qquad \deg N=d=\frac{9-w}{2}.                       \tag{59.16}
\]

After identifying
\(A\simeq\mathcal O_B(U)\otimes N^2\), every evaluation section in the
class has the form

\[
                         p_\alpha=s_U q_\alpha^2,
 \qquad q_\alpha\in H^0(B,N),                         \tag{59.17}
\]

where \(s_U\) is the section with divisor \(U\).  Thus these sections
belong to a space of dimension at most

\[
 \dim\operatorname{im}\bigl(\operatorname{Sym}^2H^0(B,N)
                              \to H^0(B,N^2)\bigr)
 \leq
 \begin{cases}
 8,&d=4,\\
 6,&d=3,\\
 3,&d=2,\\
 1,&d=1,\\
 1,&d=0.
 \end{cases}                                           \tag{59.18}
\]

Here we used \(h^0(B,N)=d\) for positive degree on an elliptic curve;
when \(d=0\), effectiveness forces \(N\simeq\mathcal O_B\).

Because \(\dim W_P=8\), the evaluation curve
\(\alpha\mapsto[p_\alpha]\) is a degree-seven rational normal curve in
\(\mathbf P^7\).  Any at most eight distinct evaluation sections are
linearly independent.  The last four rows of (59.18) immediately give
the bounds for \(w=3,5,7,9\).  For \(w=1\), eight equal-label sections
would span all of \(W_P\).  Equation (59.17) would then make every section
of the coefficient system vanish on the nonempty divisor \(U\), contrary
to its base-point freeness.  Hence the bound is seven in that case.
\(\square\)

## 3. The elliptic spectral conductor

Let

\[
                 \Psi=(\pi,t):E\longrightarrow B\times\mathbf P^1
\tag{59.19}
\]

and let \(\Gamma\) be its reduced image.

### Lemma 59.4 (the 108-collision budget)

The map \(E\to\Gamma\) is the normalization and is birational.  One has

\[
                  p_a(\Gamma)=55,\qquad\delta(\Gamma)=54. \tag{59.20}
\]

If \(\tau\) generates the deck group of \(\pi\), the conductor divisor
on \(E\) is

\[
 \mathfrak C_\Gamma
   =\sum_{j=1}^6(t,t\tau^j)^*\Delta_{\mathbf P^1},
 \qquad \deg\mathfrak C_\Gamma=108.                   \tag{59.21}
\]

In particular, with \(z_{\alpha,b}=\operatorname{mult}_bZ_\alpha\),

\[
        \sum_{\alpha\in\mathcal A_Y}\sum_{b\in\Delta}
             z_{\alpha,b}(z_{\alpha,b}-1)\leq108.     \tag{59.22}
\]

#### Proof

The generic degree of \(E\to\Gamma\) divides both projection degrees
seven and nine, so it is one.  The image has bidegrees seven and nine.
On \(B\times\mathbf P^1\), its self-intersection is \(2\cdot7\cdot9\),
while its intersection with the canonical divisor is
\(\deg t^*K_{\mathbf P^1}=-18\).  Adjunction gives
\(p_a(\Gamma)=55\), and subtracting \(g(E)=1\) gives \(\delta=54\).

Etale-locally on \(B\), the seven branches are the graphs of
\(t,t\tau,\ldots,t\tau^6\).  The usual conductor formula for a union of
smooth graph branches gives the first equality of (59.21).  Each
coincidence divisor has degree \(9+9=18\), and the functions are distinct:
if \(t\tau^j=t\), then \(t\) would descend through the degree-seven map
\(E\to B\), contrary to \(7\nmid9\).  This proves the degree assertion.

At a point \(b\in\Delta\), the \(z_{\alpha,b}\) branches carrying the
same label \(\alpha\) contribute at least one for every ordered pair of
distinct branches to (59.21).  Their total contribution is therefore at
least \(z_{\alpha,b}(z_{\alpha,b}-1)\).  Summing proves (59.22).
\(\square\)

## 4. At least ten labels

### Theorem 59.5 (ten-label theorem)

In the cyclic genus-one row,

\[
             \#\{\epsilon_\alpha:\alpha\in\mathcal A_Y\}\geq10,
 \qquad
             \dim_{\mathbf F_2}h(J(Y)[2])\geq4,       \tag{59.23}
\]

where \(h=p_*a^*:J(Y)\to J(C)\).

#### Proof

For \(b\in\Delta\), all seven points of \(\pi^{-1}(b)\) belong to the
branch divisor of \(V\to E\).  They are therefore unramified points of
\(t\) mapping into \(\mathcal A_Y\).  Consequently, if
\(z_{\alpha,b}=\operatorname{mult}_bZ_\alpha\), then

\[
                         \sum_\alpha z_{\alpha,b}=7.  \tag{59.24}
\]

The elliptic conductor bound (59.22) therefore gives

\[
\begin{aligned}
108
 &\geq\sum_{\alpha,b\in\Delta}
       z_{\alpha,b}(z_{\alpha,b}-1)\\
 &\geq\sum_{\alpha,b\in\Delta}
       \bigl(z_{\alpha,b}-(z_{\alpha,b}\bmod2)\bigr)
  =252-\sum_\alpha w_\alpha.
\end{aligned}                                           \tag{59.25}
\]

Thus

\[
                         \sum_\alpha w_\alpha\geq144. \tag{59.26}
\]

It remains only a small integer optimization using Proposition 59.3.
Suppose there were at most nine label classes, padding the list by empty
classes if necessary.  Let \(l\) be the number of support-one classes,
\(f\) the number of support-five classes, and \(h\) the number of
support-seven or support-nine classes; the remaining classes have support
three.  Their total capacity is at most

\[
                    7l+3f+h+6(9-l-f-h)
                    =54+l-3f-5h.                      \tag{59.27}
\]

Since 32 labels must fit, one necessarily has \(f+h\leq7\).  Indeed, if
\(l=0\) and \(f+h\geq8\), the capacity in (59.27) is at most 30.  If
\(l\geq1\), then \(l+f+h\leq9\); the only new boundary case is
\(l=1,f+h=8\), whose capacity is
\(7+3f+h=31-2h<32\).

Now overestimate every support-one label as having support three.  A
support-five class contributes at most six more to the total support than
the same labels at support three, and a support-seven or support-nine
class contributes at most six more.  Hence

\[
             \sum_\alpha w_\alpha
                \leq3\cdot32+6(f+h)\leq138,           \tag{59.28}
\]

contradicting (59.26).  There are therefore at least ten labels.  File 44
identifies every \(\epsilon_\alpha\) with an element of \(h(J(Y)[2])\).
An \(\mathbf F_2\)-space containing ten distinct elements has dimension
at least four, proving (59.23). \(\square\)

## 5. Orthogonality leaves only two block-parity patterns

For \(\xi\) in the eight-point hyperelliptic branch set
\(\mathcal A_X\), let

\[
 \Delta_\xi=\{b\in B:r(b)=\xi,\ e_b(r)=1\}.
\tag{59.29}
\]

These eight sets partition \(\Delta\), and every \(|\Delta_\xi|\) is
odd.  For a branch value \(\alpha\in\mathcal A_Y\), define its
block-parity vector

\[
 \rho_\alpha=
   \bigl(|U_\alpha\cap\Delta_\xi|\bmod2\bigr)_{
                                      \xi\in\mathcal A_X}
       \in\mathbf F_2^8.                              \tag{59.30}
\]

### Proposition 59.6 (two-pattern constraint)

For every \(\alpha\in\mathcal A_Y\),

\[
                  \rho_\alpha+\rho_\infty
                       \in\{0,{\bf1}\}.              \tag{59.31}
\]

Thus the 32 supports have only two possible parity patterns across the
eight blocks \(\Delta_\xi\).  The number of \(\alpha\)'s for which the
second alternative in (59.31) occurs is odd.

#### Proof

We recall the elementary branch-coordinate description for a ramified
double cover.  If \(P=\operatorname{Prym}(C/B)\), then

\[
 P[2]/q^*J(B)[2]
   \simeq
 \frac{\{\text{even subsets of }\Delta\}}
      {\langle\Delta\rangle}.                         \tag{59.32}
\]

The pairing induced by the Prym polarization on the right is
\((-1)^{|S\cap T|}\).  One sees this directly by writing a two-torsion
divisor as a sum of ramification points plus the pullback of a divisor on
\(B\).  Changing the latter changes the class by \(q^*J(B)[2]\); the
tame-symbol formula for the Weil pairing leaves precisely the intersection
parity of the two branch subsets.  Equivalently, the induced Prym
polarization has type \((1^{17},2)\), its radical on two-torsion is
\(q^*J(B)[2]\), and the nondegenerate quotient is the even-subset space
in (59.32).

Under (59.32), the pullback to \(C\) of the two-torsion class represented
by two Weierstrass points \(\xi,\xi_0\) of \(X\) has branch coordinate

\[
                         \Delta_\xi\mathbin\triangle\Delta_{\xi_0}.
\tag{59.33}
\]

The points over which \(r\) has index two contribute pullbacks from
\(B\) and disappear in (59.32).  Similarly, (59.14) and file 44 show
that

\[
 \epsilon_\alpha=h([P_\alpha-P_\infty])
 \quad\text{has branch coordinate}\quad
                         U_\alpha\mathbin\triangle U_\infty. \tag{59.34}
\]

The identities \(c\delta=\iota_Xc\) and
\(a\gamma=\iota_Ya\), together with the commutation of \(\beta\) and
\(\gamma\), put both \(c^*J(X)\) and \(h(J(Y))\) inside \(P\).
There is no nonzero homomorphism \(J(Y)\to J(X)\), by file 40.  Hence
\(c_*h=0\).  Projection formula for the canonical polarizations says that
the classes in (59.33) and (59.34) are orthogonal.  Formula (59.32) gives,
for every \(\xi\),

\[
 |(\Delta_\xi\mathbin\triangle\Delta_{\xi_0})
       \cap(U_\alpha\mathbin\triangle U_\infty)|\equiv0\pmod2.
\tag{59.35}
\]

Thus every coordinate of \(\rho_\alpha+\rho_\infty\) equals its
\(\xi_0\)-coordinate, which is exactly (59.31).

Finally, for fixed \(\xi\), summing the \(\xi\)-coordinate of
\(\rho_\alpha\) over all \(\alpha\) counts the seven labels above every
point of \(\Delta_\xi\).  By (59.24), its parity is
\(|\Delta_\xi|\equiv1\).  On the other hand, (59.31) makes this sum equal
to the parity of the number of complemented columns.  That number is
therefore odd. \(\square\)

## 6. Exact remaining gap

The theorem does not yet exclude the cyclic genus-one row.  It says that
any survivor must solve the explicit square-class equation (59.5), the
line-bundle equation (59.6), and a much less degenerate branch-incidence
problem than was previously known: its 32 columns have odd support sizes
in \(\{1,3,5,7,9\}\), total support at least 144, and at least ten
different square-root labels, with the class capacities (59.3).  Their
parities across the eight branch blocks of \(r\) must also satisfy the
two-pattern rule (59.31).

For a direct algebraic search, one may parameterize a degree-seven
isogeny \(\pi:E\to B\), two degree-nine pencils \(t,r\), and impose
(59.5).  Equivalently, after choosing invariant differentials, divide the
pullbacks of the binary branch forms by the squares of the two Wronskian
sections.  The resulting singleton-branch sections must agree under
pullback through \(\pi\).  This is a finite system of polynomial equations
on the corresponding pencil and isogeny parameters.  What is still
missing is either a proof that this system is empty or an additional
geometric restriction strong enough to make that elimination small.
