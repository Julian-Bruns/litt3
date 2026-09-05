# The dihedral genus-one coarsening is impossible

## Status and purpose

**Status: proved; independent audit pending.**

Assume the full-span degree-nine situation of files 47 and 53, in the
numerical row

\[
             \operatorname{Gal}(V/B)=D_{14},\qquad g(B)=1,
             \qquad g(E)=55.
\tag{61.1}
\]

Write

\[
 \begin{array}{ccccc}
 &&V&&\\[-1mm]
 &\swarrow p&&\searrow&\\[-1mm]
 C&&&&E\\[-1mm]
 &\searrow q&&\swarrow\pi&\\[-1mm]
 &&B&&
 \end{array}
\tag{61.2}
\]

where \(p\) is the etale \(C_7\)-quotient, \(q\) is a double cover
branched at a reduced divisor \(\Delta\) of degree 36, and \(\pi\) has
degree seven.  The two degree-nine maps supplied by files 47 and 53 are

\[
       t:E\longrightarrow\mathbf P^1_t,
       \qquad r:B\longrightarrow\mathbf P^1_x.
\tag{61.3}
\]

This note rules out (61.1).  The key point is local and exact.  Above
each point of \(\Delta\), the degree-seven dihedral quotient has cycle
type \(2^3 1\).  Its unique unramified sheet is the unique sheet on which
the quadratic pullback of \(Y\) ramifies.  Recording the value of \(t\)
on that sheet partitions all 36 points of \(\Delta\) among the 32 branch
values of \(Y\).  Riemann--Hurwitz forces at least 30 parts of this
partition to be singletons.  Orthogonality with the hyperelliptic
pullback from \(X\), however, forces all singleton points into one fiber
block of the degree-nine map \(r\), an immediate contradiction.

## 1. The odd norm supports partition the branch divisor

Let

\[
 \mathcal A_Y=\mu_{31}\cup\{\infty\}
\tag{61.4}
\]

be the branch set of \(Y\to\mathbf P^1_t\).  For
\(\alpha\in\mathcal A_Y\), take a homogeneous linear form cutting out
\(\alpha\), pull it back by \(t\), and take its norm through \(\pi\).
Denote the resulting section on \(B\) by \(p_\alpha\), and put

\[
                    Z_\alpha=\operatorname{div}(p_\alpha).
\tag{61.5}
\]

Thus \(Z_\alpha=\pi_*t^*(\alpha)\) and \(\deg Z_\alpha=9\).  This
homogeneous definition includes \(\alpha=\infty\) without any separate
pole convention.  The coefficient descent of file 47 and the normed
branch divisors of file 44 give

\[
 q^*Z_\alpha=2D_\alpha,
 \qquad
 \epsilon_\alpha:=\mathcal O_C(D_\alpha-D_\infty)
       =h([P_\alpha-P_\infty]),
 \qquad h=p_*a^*.
\tag{61.6}
\]

In particular, every multiplicity of \(Z_\alpha\) away from \(\Delta\)
is even.  Define its odd support on \(\Delta\) by

\[
 U_\alpha=\sum_{b\in\Delta}
       \bigl(\operatorname{mult}_bZ_\alpha\bmod2\bigr)b.
\tag{61.7}
\]

### Lemma 61.1 (local dihedral label)

The 32 reduced divisors \(U_\alpha\), for
\(\alpha\in\mathcal A_Y\), are pairwise disjoint and satisfy

\[
                    \coprod_{\alpha\in\mathcal A_Y}U_\alpha=\Delta.
\tag{61.8}
\]

Moreover,

\[
 \deg U_\alpha
   =\#\{e\in E:t(e)=\alpha,\ e_e(t)=1\}.
\tag{61.9}
\]

#### Proof

Let \(G=D_{14}=\langle\beta,\gamma\rangle\), where \(\beta\) has
order seven, \(\gamma\) has order two, and
\(\gamma\beta\gamma=\beta^{-1}\).  Then
\(C=V/\langle\beta\rangle\), \(E=V/\langle\gamma\rangle\), and
\(B=V/G\).

Fix \(b\in\Delta\).  Since \(V\to C\) is etale, inertia for
\(V\to B\) at \(b\) is a reflection.  A reflection acts on the seven
cosets of \(\langle\gamma\rangle\) with cycle type \(2^3 1\).  Hence
\(\pi^{-1}(b)\) consists of three points of ramification index two and
one point \(e_b\) of ramification index one.  More precisely, among the
seven conjugate inertia groups above \(b\), exactly one equals
\(\langle\gamma\rangle\).  Multiplicativity of ramification indices in

\[
                        V\longrightarrow E\longrightarrow B
\]

therefore shows that \(V\to E\) ramifies exactly at \(e_b\), and is
unramified at the other three points of \(\pi^{-1}(b)\).

By Theorem 47.3, \(V\to E\) is the normalized pullback through \(t\) of
the hyperelliptic double cover \(Y\to\mathbf P^1_t\), and every index of
\(t\) above \(\mathcal A_Y\) is one or two.  The elementary local model
is

\[
                         z^2=u^e,
\]

where \(e=e_e(t)\).  Its normalization is ramified over \(E\) exactly
when \(e\) is odd.  It follows that \(t(e_b)=\alpha_b\) for one unique
\(\alpha_b\in\mathcal A_Y\) and \(e_{e_b}(t)=1\).  Any of the other
three points over \(b\) which maps to a member of \(\mathcal A_Y\) has
index two under \(t\).

The divisor-of-a-norm formula gives, also at infinity by the homogeneous
definition,

\[
 \operatorname{mult}_bZ_\alpha
   =\sum_{\substack{e\in\pi^{-1}(b)\\t(e)=\alpha}}e_e(t).
\tag{61.10}
\]

All terms from the three ramified sheets are even, while the unique
unramified sheet contributes one precisely for \(\alpha=\alpha_b\).
Thus \(b\) belongs to exactly \(U_{\alpha_b}\), proving (61.8).
Conversely, the branch points of \(V\to E\) are exactly the index-one
points of \(t\) above \(\mathcal A_Y\), so the assignment
\(b\mapsto e_b\) also proves (61.9). \(\square\)

## 2. At least thirty supports are singletons

### Lemma 61.2 (the only two ramification distributions)

Exactly one of the following holds:

1. 31 fibers of \(t\) above \(\mathcal A_Y\) have type \(2^4 1\), and
   the remaining fiber has type \(2^2 1^5\);
2. 30 fibers have type \(2^4 1\), and the remaining two fibers have type
   \(2^3 1^3\).

Consequently at least 30 of the divisors \(U_\alpha\) are singletons.

#### Proof

Write the fiber above \(\alpha\) as \(1^{a_\alpha}2^{b_\alpha}\).
Then

\[
                 a_\alpha+2b_\alpha=9,
                 \qquad 0\leq b_\alpha\leq4.
\tag{61.11}
\]

Theorem 47.3 gives \(\deg\operatorname{Diff}(t)=126\), all of it simple
and supported over the 32 members of \(\mathcal A_Y\).  Therefore

\[
                 \sum_{\alpha\in\mathcal A_Y}b_\alpha=126,
 \qquad
                 \sum_\alpha(4-b_\alpha)=2.
\tag{61.12}
\]

The only partitions of the final deficiency are \(2\) and \(1+1\).
They give precisely the two distributions in the statement.  Lemma 61.1
says \(\deg U_\alpha=a_\alpha\), so respectively 31 or 30 supports are
singletons.  Notice that the argument treats the fiber over infinity in
exactly the same way as every finite branch fiber. \(\square\)

## 3. Orthogonality allows only two block patterns

Let \(\mathcal A_X\) be the eight-point branch set of the hyperelliptic
map \(X\to\mathbf P^1_x\).  For \(\xi\in\mathcal A_X\), set

\[
 \Delta_\xi=\{b\in B:r(b)=\xi,\ e_b(r)=1\}.
\tag{61.13}
\]

Theorem 53.3 says that these eight sets partition \(\Delta\).  Each has
odd size, and

\[
                         1\leq|\Delta_\xi|\leq9.
\tag{61.14}
\]

For \(\alpha\in\mathcal A_Y\), define

\[
 \rho_\alpha=
   \bigl(|U_\alpha\cap\Delta_\xi|\bmod2\bigr)_
                              {\xi\in\mathcal A_X}
       \in\mathbf F_2^8.
\tag{61.15}
\]

### Lemma 61.3 (two-pattern constraint in the dihedral row)

For every \(\alpha\in\mathcal A_Y\),

\[
                   \rho_\alpha+\rho_\infty
                         \in\{0,{\bf1}\}.
\tag{61.16}
\]

#### Proof

We spell out why the argument of Proposition 59.6 remains valid in the
dihedral case.  For the ramified double cover \(q:C\to B\), the standard
branch-coordinate description is

\[
 \operatorname{Prym}(C/B)[2]/q^*J(B)[2]
   \simeq
 \frac{\{\text{even subsets of }\Delta\}}
      {\langle\Delta\rangle},
\tag{61.17}
\]

and its Weil pairing is intersection parity.  Namely, the pairing of
the classes represented by even subsets \(S,T\subseteq\Delta\) is
\((-1)^{|S\cap T|}\).

Theorem 53.3 gives \(c\delta=\iota_Xc\), where \(\delta\) is the deck
involution of \(q\), so \(c^*J(X)\) lies in the Prym.  Although
\(\gamma\) does not commute with \(\beta\) in \(D_{14}\), it normalizes
\(\langle\beta\rangle\) and hence descends to \(\delta\) on \(C\).
Using \(p\gamma=\delta p\) and \(a\gamma=\iota_Ya\), functoriality of
pullback and norm gives

\[
 \delta^*h
   =\delta^*p_*a^*
   =p_*\gamma^*a^*
   =p_*(a\gamma)^*
   =p_*a^*\iota_Y^*
   =-h.
\tag{61.18}
\]

Thus the connected image \(h(J(Y))\) also lies in the Prym.  File 40
proves \(\operatorname{Hom}(J(Y),J(X))=0\), so \(c_*h=0\).  Since
\(c_*\) is the Rosati adjoint of \(c^*\), the subvarieties
\(c^*J(X)\) and \(h(J(Y))\) are orthogonal.

In (61.17), the pullback of a two-torsion class represented by two
Weierstrass points \(\xi,\xi_0\) of \(X\) has branch coordinate

\[
                        \Delta_\xi\mathbin\triangle\Delta_{\xi_0}.
\tag{61.19}
\]

To identify the other coordinate, write uniquely

\[
             Z_\alpha=U_\alpha+2R_\alpha
\tag{61.20}
\]

with \(R_\alpha\) effective on \(B\), and let \(W_U\) denote the sum of
the ramification points of \(q\) above \(U\subseteq\Delta\).  Equation
(61.6) gives

\[
             D_\alpha=W_{U_\alpha}+q^*R_\alpha.
\tag{61.21}
\]

Therefore \(\epsilon_\alpha\) has branch coordinate
\(U_\alpha\mathbin\triangle U_\infty\).  Orthogonality now gives, for
every \(\xi\),

\[
 |(\Delta_\xi\mathbin\triangle\Delta_{\xi_0})
       \cap(U_\alpha\mathbin\triangle U_\infty)|
          \equiv0\pmod2.
\tag{61.22}
\]

Hence all eight coordinates of \(\rho_\alpha+\rho_\infty\) are equal,
which is exactly (61.16). \(\square\)

## 4. Elimination of the row

### Theorem 61.4

The row

\[
                    \operatorname{Gal}(V/B)=D_{14},
                    \qquad g(B)=1
\]

in Theorem 47.3 cannot occur.

#### Proof

By Lemma 61.2, there is a set \(S\subseteq\mathcal A_Y\) of at least 30
values for which \(U_\alpha\) is a singleton.  Since the
\(U_\alpha\)'s partition \(\Delta\), these singleton supports are
distinct.

If \(U_\alpha=\{b\}\) and \(b\in\Delta_\xi\), then
\(\rho_\alpha\) is the standard basis vector \(e_\xi\), of Hamming
weight one.  Lemma 61.3 says that all such vectors belong to the
two-element set

\[
                        \{\rho_\infty,
                          \rho_\infty+{\bf1}\}.
\tag{61.23}
\]

The two vectors in (61.23) are complementary vectors of length eight.
At most one of them has Hamming weight one.  It follows that every
singleton support has the same vector \(e_{\xi_0}\), for one fixed
\(\xi_0\in\mathcal A_X\).  Hence \(\Delta_{\xi_0}\) contains at least
30 distinct points.  This contradicts
\(|\Delta_{\xi_0}|\leq9\) from (61.14). \(\square\)

## 5. Consequence for the full-span endpoint

Of the four full-span rows in Theorem 47.3, the dihedral genus-one row is
therefore eliminated unconditionally.  The proof uses no choice of a
finite affine coordinate: both the norm-support partition and the
ramification-deficiency count include \(\infty\).  Its only global input
beyond the degree-fourteen reduction is the already proved genus-one
factorization of file 53 and the vanishing
\(\operatorname{Hom}(J(Y),J(X))=0\) from file 40.
