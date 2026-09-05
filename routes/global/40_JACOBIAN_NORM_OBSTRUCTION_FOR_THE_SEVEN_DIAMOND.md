# Jacobian norm obstruction for the order-seven diamond

## Status and purpose

**Status: proved.**  [Independent audit](audits/40_JACOBIAN_NORM_AUDIT.md).

This note applies to the equal-degree etale diamond of
file 38.  It proves that the residual degree in that diamond is at least
nine.  More structurally, the Jacobian of the cyclic genus-fifteen curve
is absolutely simple, it occurs in the Jacobian of the order-seven
quotient, and its moving part under the order-seven action has dimension at
least thirty.

The last statement also records a sharp limitation of the method.  Seven
distinct translates of the same simple Jacobian need not span seven copies:
the relevant endomorphism algebra allows all seven translates to lie in two
copies.  Thus the tempting dimension bound \(7g(Y)=105\) is not valid.

Throughout,

\[
 k=\overline{\mathbf F}_5,
 \qquad Y:\quad z^2=1-t^{31},
 \qquad J=\operatorname{Jac}(Y).
\]

This is the hyperelliptic model of \(y^{31}=x(x-1)\) from file 20.

## 1. The geometric isogeny type of \(J\)

Put

\[
 K=\mathbf Q(\zeta _{31}),\qquad
 D_0=\langle5\rangle=\{1,5,25\}\subset
              (\mathbf Z/31\mathbf Z)^\times,
 \qquad E=K^{D_0}.
\]

Thus \(E/\mathbf Q\) is the cyclic extension of degree ten of conductor
\(31\).

### Proposition 40.1 (absolute simplicity and the Honda algebra)

The abelian variety \(J\) is absolutely simple.  Its geometric rational
endomorphism algebra

\[
                    \mathscr D=\operatorname{End}^0_k(J)
\]

is a central division algebra of degree three over \(E\):

\[
                  Z(\mathscr D)=E,
             \qquad [\mathscr D:E]=9.                 \tag{40.1}
\]

It contains \(K\) as a maximal commutative subfield.  The Newton slopes of
\(J\), with multiplicities, are

\[
             0^6,\quad (1/3)^9,\quad(2/3)^9,\quad1^6. \tag{40.2}
\]

In particular, the \(5\)-rank is six, agreeing with the direct Cartier
calculation in files 22 and 38.

#### Proof

The automorphism \(t\mapsto\zeta _{31}t\) gives an embedding
\(K\hookrightarrow\operatorname{End}^0_k(J)\).  In characteristic zero the
regular differentials

\[
                    t^{i-1}\frac{dt}{z},\qquad1\leq i\leq15,
\]

show that the corresponding CM type is

\[
                         \Phi=\{1,2,\ldots,15\}.        \tag{40.3}
\]

The same equation has good reduction at \(5\).  The Shimura--Taniyama
formula therefore says that the slope at the prime represented by a coset
\(aD_0\) is

\[
                    \frac{|aD_0\cap\Phi|}{3}.          \tag{40.4}
\]

The powers of \(3\), a generator modulo \(31\), enumerate the ten cosets.
The cosets and their intersection sizes are

\[
\begin{array}{c|c|c}
i&3^iD_0&|3^iD_0\cap\Phi|\\ \hline
0&\{1,5,25\}&2\\
1&\{3,13,15\}&3\\
2&\{8,9,14\}&3\\
3&\{11,24,27\}&1\\
4&\{2,10,19\}&2\\
5&\{6,26,30\}&1\\
6&\{16,18,28\}&0\\
7&\{17,22,23\}&0\\
8&\{4,7,20\}&2\\
9&\{12,21,29\}&1.
\end{array}                                               \tag{40.5}
\]

Let \(F\) be the \(5\)-power Frobenius of \(J/\mathbf F _5\), considered
as a unit of the rational endomorphism algebra, and put
\(\pi=F^3\).  Conjugation by \(F\) sends
\(\zeta _{31}\) to \(\zeta _{31}^5\).  Hence \(\pi\) centralizes \(K\).
The action of \(K\) on any prime-to-\(5\) Tate module has rank one, so \(K\)
is a maximal commutative subfield and its centralizer is \(K\).  It follows
that \(\pi\in K\).  Since \(F\) commutes with \(F^3\), the same conjugation
also fixes \(\pi\), and consequently

\[
                              \pi\in E.                  \tag{40.6}
\]

The cyclic sequence of integers in the last column of (40.5) is

\[
                         (2,3,3,1,2,1,0,0,2,1).          \tag{40.7}
\]

It has no nontrivial cyclic period: the adjacent pair (0,0) occurs in a
unique position.  The valuation formula (40.4) therefore shows that no
nonidentity element of \(\operatorname{Gal}(E/\mathbf Q)\) preserves the
principal ideal of \(\pi\).  The same remains true after all the
valuations are multiplied by any positive integer \(n\).  Thus

\[
                         \mathbf Q(\pi^n)=E
                         \quad\text{for every }n\geq1.   \tag{40.8}
\]

The prime \(5\) splits completely in \(E\), because its decomposition
group in \(K/\mathbf Q\) is exactly \(D_0\).  Hence the local degrees of
\(E\) at \(5\) are one.  The Honda--Tate local invariants are consequently
the numbers in (40.4), modulo one.  They include \(1/3\) and \(2/3\), so
their least common denominator, and therefore the Schur index of the
Honda division algebra, is three.  The simple isogeny class attached to
\(\pi\) has dimension

\[
                 \frac12[E:\mathbf Q]\cdot3=15.         \tag{40.9}
\]

Since \(J\) itself has dimension fifteen, it is simple over
\(\mathbf F _{125}\).  Equation (40.8) and the unchanged normalized local
invariants show that it remains simple over every finite extension of
\(\mathbf F _{125}\).  Every geometric abelian subvariety and every
geometric endomorphism is defined over some finite extension, so \(J\) is
absolutely simple and its geometric endomorphism algebra is the division
algebra in (40.1).

Finally, (40.5) gives two primes of slope zero, three of slope \(1/3\),
three of slope \(2/3\), and two of slope one.  Each occurs with the Schur
index three in the characteristic polynomial.  This proves (40.2).
\(\square\)

### Exact polynomial audit

As an independent finite check, the \(5\)-Frobenius polynomial is

\[
                         P(T)=Q(T^3),                     \tag{40.10}
\]

where

\[
\begin{aligned}
Q(U)={}&U^{10}-10U^9+169U^8-120U^7-4750U^6+278500U^5\\
      &-593750U^4-1875000U^3+330078125U^2\\
      &-2441406250U+30517578125.
\end{aligned}                                             \tag{40.11}
\]

The polynomial \(Q\) is irreducible over \(\mathbf Q\); for example, its
reduction modulo \(3\) is irreducible.  Its coefficient valuations at \(5\)
have lower-hull vertices

\[
             (0,15),(2,9),(5,3),(8,0),(10,0),             \tag{40.12}
\]

which reproduces (40.2).  Notice the important Honda--Tate point:
\(Q(T)^3\), the polynomial over \(\mathbf F _{125}\), belongs to one
simple fifteen-dimensional isogeny factor of Schur index three.  It is not
the cube of a five-dimensional factor.

## 2. A norm correspondence cannot vanish

We next isolate the geometric input which gives the strongest bound.

### Lemma 40.2 (the orbit-divisor norm)

Let \(p:V\to C\) be a finite etale map of degree seven between smooth
projective connected curves, and let \(a:V\to Y\) be any finite map.  Then

\[
                    p_*a^*:J\longrightarrow J(C)         \tag{40.13}
\]

is nonzero.

#### Proof

For \(c\in C\), form the degree-seven effective divisor

\[
                         D_c=a_*p^*(c)                    \tag{40.14}
\]

on \(Y\).  These divisors define a morphism

\[
                    \varphi:C\longrightarrow\operatorname{Pic}^7(Y),
                    \qquad c\longmapsto\mathcal O_Y(D_c). \tag{40.15}
\]

After translating the target to \(J\), the homomorphism induced by
\(\varphi\) on Jacobians is \(a_*p^*:J(C)\to J\).  This is dual, under the
canonical principal polarizations, to (40.13).

Suppose (40.13) were zero.  The induced homomorphism of (40.15) would be
zero, so the universal property of the Jacobian would make
\(\varphi\) constant.  All \(D_c\) would then belong to one complete linear
system of degree seven.

The family is not constant as a family of divisors, and it has no common
base point.  Indeed, for any \(y\in Y\), the parameters \(c\) for which
\(y\) occurs in \(D_c\) lie in the finite set \(p(a^{-1}(y))\).  Thus the
complete linear system containing the \(D_c\) is positive-dimensional and
base-point-free.  It contains a base-point-free pencil and hence gives a
degree-seven map \(Y\to\mathbf P^1\).

On the other hand \(Y\) has its hyperelliptic map of degree two.  Since
\(2\) and \(7\) are coprime, the two maps generate \(k(Y)\).  The
Castelnuovo--Severi inequality would give

\[
                           g(Y)\leq(2-1)(7-1)=6,
\]

contrary to \(g(Y)=15\).  Therefore (40.13) is nonzero. \(\square\)

## 3. Consequences for the equal-degree diamond

Assume now that file 38 has produced

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\longrightarrow&X,
 \end{array}                                               \tag{40.16}
\]

where both horizontal maps have degree \(M\), the map \(p\) is a
\(C_7\)-torsor generated by \(\beta\), and \(a\beta\ne a\).  Recall that

\[
                         g(V)=14M+1,
               \qquad g(C)=2M+1.                           \tag{40.17}
\]

### Theorem 40.3 (Jacobian lower bound)

In the configuration (40.16):

1. the Prym of \(C\to X\) contains an abelian subvariety isogenous to
   \(J\);
2. the \(\beta\)-primitive Prym
   \(\ker(p_*:J(V)\to J(C))^0\) contains a \(J\)-isotypic abelian
   subvariety of dimension at least \(30\);
3. the \(J\)-isotypic part of \(J(V)\) has dimension at least \(45\), with
   at least one invariant copy and at least two primitive copies; and
4. necessarily
   
   \[
                              M\geq9.                      \tag{40.18}
   \]

#### Proof

Lemma 40.2 says that \(p_*a^*:J\to J(C)\) is nonzero.  Proposition 40.1
says that \(J\) is absolutely simple, so this homomorphism has finite
kernel onto a fifteen-dimensional abelian subvariety.

Let \(c:C\to X\) denote the other horizontal map in (40.16).  There is no
nonzero homomorphism \(J\to J(X)\): the connected kernel of such a
homomorphism would be an abelian subvariety of the absolutely simple
fifteen-fold \(J\), while a finite-kernel map from \(J\) to the
three-dimensional \(J(X)\) is impossible.  It follows that

\[
                    c_*p_*a^*:J\longrightarrow J(X)
\]

is zero.  The image of \(p_*a^*\) therefore lies in the connected Prym of
\(c\).  Its dimension is

\[
       \dim\ker(c_*:J(C)\to J(X))^0=g(C)-g(X)=2M-2.
\]

Consequently \(2M-2\geq15\), which proves \(M\geq9\) and item 1.

It remains to prove the primitive statement.  First observe that

\[
                E\cap\mathbf Q(\zeta _7)=\mathbf Q.       \tag{40.19}
\]

Indeed, \(E\subset\mathbf Q(\zeta _{31})\), and cyclotomic fields of the
coprime prime conductors \(31\) and \(7\) have trivial intersection.  Thus
\(\Phi _7\) remains irreducible over \(E\), of degree six.

The division algebra \(\mathscr D\) contains no nontrivial element of order
seven.  Such an element would generate inside \(\mathscr D\) the
commutative \(E\)-algebra

\[
                     E(\zeta _7),\qquad [E(\zeta _7):E]=6,
\]

whereas every commutative subfield of a central division algebra of degree
three has degree at most three over its center.

Put \(U=\operatorname{im}(a^*:J\to J(V))\).  If \(\beta^*U=U\), the
restriction of \(\beta^*\) to \(U\), viewed in
\(\operatorname{End}^0(U)\simeq\mathscr D\), has order dividing seven and
is therefore the identity.  It follows that

\[
                            (a\beta)^*=a^*.                \tag{40.20}
\]

For completeness, equality of pullbacks for two finite maps \(f,g:V\to Y\)
forces \(f=g\) here.  Dualizing gives \(f_*=g_*\).  Abel--Jacobi applied to
the divisors \(P-P_0\) then says that the two maps into the Abel--Jacobi
copy of \(Y\subset J\) differ by one fixed translation.  Such a translation
would induce an automorphism of \(Y\) acting trivially on regular
differentials.  The explicit group
\(\operatorname{Aut}(Y)=C_{31}\times C_2\) from file 20 acts faithfully on
regular differentials, so the translation and the automorphism are both
trivial.  Hence (40.20) would give \(a\beta=a\), contrary to (40.16).
Therefore \(\beta^*U\ne U\).

In the rational isogeny category, set

\[
                    H=\operatorname{Hom}^0(J,J(V)).        \tag{40.21}
\]

It is a right vector space over \(\mathscr D\), and composition with
\(\beta^*\) is \(\mathscr D\)-linear.  The \(\mathscr D\)-line represented
by \(a^*\) is not invariant.  Since \(T^7-1=(T-1)\Phi _7(T)\), the cyclic
submodule it generates has a nonzero \(\Phi _7\)-part.  If that part has
dimension \(m\) over \(\mathscr D\), its order-seven operator embeds

\[
                         E(\zeta _7)\hookrightarrow
                         M_m(\mathscr D).                  \tag{40.22}
\]

The central simple algebra on the right has degree \(3m\) over \(E\).
A commutative subfield has degree at most \(3m\), so (40.19) and (40.22)
give \(6\leq3m\), hence \(m\geq2\).  The corresponding abelian subvariety
is isogenous to at least \(J^2\), and has dimension at least thirty.
The norm \(1+\beta^*+\cdots+\beta^{6*}\) vanishes on this primitive part,
so it lies in the connected Prym.

Finally,

\[
 p^*p_*a^*=(1+\beta^*+\cdots+\beta^{6*})a^*.             \tag{40.23}
\]

The left side is nonzero by Lemma 40.2, because \(p^*\) has finite kernel.
Thus the cyclic submodule also has a nonzero invariant \(J\)-isotypic part,
of dimension at least fifteen.  The invariant and primitive parts are
disjoint up to isogeny, proving items 2 and 3. \(\square\)

## 4. The exact limit of the translate-counting argument

The primitive lower bound in Theorem 40.3 is sharp at the level of rational
endomorphism algebras.  Put \(L=E(\zeta _7)\).  At every prime of \(E\)
above \(5\), the local degree of \(L/E\) is six, because \(5\) has order six
modulo \(7\).  This kills the \(1/3\)-valued local invariants of
\(\mathscr D\).  There are no other nonzero finite local invariants.  Hence

\[
                         \mathscr D\otimes_E L
                            \simeq M_3(L).                 \tag{40.24}
\]

The degree-six field (L/E) consequently embeds as a maximal subfield of
the degree-six central simple algebra \(M_2(\mathscr D)\).  In particular,
\(M_2(\mathscr D)\) contains an element of order seven.  A generic
\(\mathscr D\)-line in \(\mathscr D^2\) then has seven distinct translates
whose sum still spans only \(\mathscr D^2\).

This is why pairwise distinct maps

\[
                         a,a\beta,\ldots,a\beta^6
\]

do **not** yield seven independent copies of \(J\) in \(J(V)\).  The
unconditional numerical conclusion obtained here is \(M\geq9\), coming
from the nonvanishing norm, absolute simplicity, and the two Prym
decompositions in the diamond.  For \(M\geq9\), the
Newton polygon, \(5\)-rank, and the rational \(C_7\)-representation all
have enough room for the invariant \(J\) and primitive \(J^2\) found above.
Ruling out the remaining diamonds therefore requires information beyond
these bare Jacobian isogeny invariants.
