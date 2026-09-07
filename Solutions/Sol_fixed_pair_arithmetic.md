# Proof record: Geometry and Jacobians of the explicit fixed pair

Canonical statement: [`fixed_pair_arithmetic`](../Theorems/Thm_fixed_pair_arithmetic.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

## Fixed curves and proof scope

Author-proved geometry and arithmetic; no independent whole-statement
verification is claimed. This proof contains only the registered curve
and Jacobian assertions, not historical continuation instructions. Put

\[
                         k=\overline{\mathbf F}_5.
\]

Let \(a\in\mathbf F_{25}\) satisfy \(a^2+4a+2=0\), and define \(X\) as
the smooth projective model of

\[
 y^3={}&x^{10}+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3ax^6+4ax^5\\
      &+(3a+4)x^4+ax^3+(3a+3)x^2+(4a+2)x+(2a+1).
                                                               \tag{76.1}
\]

Over \(\mathbf F_5\), put

\[
                  L(t)=t^{25}+t^5+t
\]

and let \(Y\) be the smooth projective model of

\[
                  z^2=L(t)(L(t)-1)(t-4).              \tag{76.2}
\]

Then

\[
                     g(X)=9,\qquad g(Y)=25,
             \qquad g(Y)-1=3\bigl(g(X)-1\bigr).       \tag{76.3}
\]

Both Jacobians are absolutely simple, \(X\) is nonhyperelliptic, and all
52 branch points of the hyperelliptic map \(Y\to\mathbf P^1\) are rational
over \(\mathbf F_{125}\).

The exact calculations below are reproduced by
[`76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage`](../routes/global/76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage).

## 1. Geometry of the two curves

### Proposition 76.1

The curves in (76.1)--(76.2) are smooth of genera 9 and 25, respectively.
The curve \(X\) is nonhyperelliptic.  The branch divisor of
\(Y\to\mathbf P^1_t\) is reduced and rational over \(\mathbf F_{125}\).

#### Proof

The polynomial on the right of (76.1) is square-free.  Since 3 is prime to
the characteristic and to 10, the degree-three map \(X\to\mathbf P^1_x\)
is tamely totally ramified at its ten finite roots and at infinity.
Riemann--Hurwitz gives

\[
                  2g(X)-2=-6+11(3-1)=16,
\]

so \(g(X)=9\).

If \(X\) were hyperelliptic, its separable maps of coprime degrees 3 and 2
to \(\mathbf P^1\) would generate its function field.  The
Castelnuovo--Severi inequality would then give

\[
                         g(X)\leq(3-1)(2-1)=2,
\]

a contradiction.  Thus \(X\) is nonhyperelliptic.

In characteristic five,

\[
                              L'(t)=1.                 \tag{76.4}
\]

The two fibers \(L=0\) and \(L=1\) are therefore reduced and disjoint.
Moreover \(L(4)=2\), so the additional root 4 lies in neither fiber.
Thus the polynomial in (76.2) has 51 distinct roots.  Its odd-degree
hyperelliptic model has one further branch point at infinity, and hence
genus 25.

Finally, on \(\mathbf F_{125}\),

\[
                    L(t)=\operatorname{Tr}_{125/5}(t).
\]

Each of the fibers \(L=0\) and \(L=1\) has 25
\(\mathbf F_{125}\)-points.  The point 4 has trace 2 and is distinct from
them.  These 51 finite points and infinity are all
\(\mathbf F_{125}\)-rational. \(\square\)

## 2. Absolute simplicity of the genus-nine Jacobian

### Proposition 76.2

The geometric Jacobian \(J(X)\) is absolutely simple.

#### Proof

The \(25\)-power Frobenius polynomial computed from (76.1) is

\[
\begin{aligned}
P_X(T)={}&T^{18}-2T^{17}-29T^{16}+57T^{15}-124T^{14}
 +3716T^{13}+3083T^{12}\\
&-94215T^{11}+141450T^{10}+601875T^9+3536250T^8
 -58884375T^7\\
&+48171875T^6+1451562500T^5-1210937500T^4
 +13916015625T^3\\
&-177001953125T^2-305175781250T+3814697265625.
                                                               \tag{76.5}
\end{aligned}
\]

Its reduction modulo 2 is irreducible, so \(P_X\) is irreducible over
\(\mathbf Q\).  Let \(\pi\) be a root and \(K=\mathbf Q(\pi)\).  An exact
maximal-order calculation gives

\[
 \operatorname{disc}K=
 -3^{11}29^2 10589^2 16451926081^2 24415659240899^2.   \tag{76.6}
\]

We apply the absolute-simplicity criterion of Howe--Zhu, Proposition 3.
First, \(P_X\notin\mathbf Z[T^d]\) for every \(d>1\), because its
\(T^{17}\)-coefficient is nonzero.

It remains to control the roots of unity in \(K\).  If a primitive
\(d\)-th root of unity lies in this degree-18 field, then
\(\varphi(d)\mid18\).  Apart from \(d=1\), the complete list is

\[
                d=2,3,4,6,7,9,14,18,19,27,38,54.      \tag{76.7}
\]

The discriminant tower formula applied to the cyclotomic subfield rules
out every entry except \(2,3,6\).  Indeed, \(d=4\) would introduce a
factor 2 in (76.6), \(d=7,14\) a factor 7, and \(d=19,38\) a factor 19.
For \(d=9,18\), the contribution of
\(\operatorname{disc}\mathbf Q(\zeta_9)= -3^9\), raised to the relative
degree 3, would give 3-adic valuation at least 27, whereas (76.6) has
valuation 11.  For \(d=27,54\), the cyclotomic field already has degree
18 and discriminant of 3-adic valuation 45.

Exact minimal-polynomial calculations give

\[
             [\mathbf Q(\pi^d):\mathbf Q]=18
                    \qquad(d=2,3,6).                  \tag{76.8}
\]

Thus none of the alternatives in the finite set \(D\) of Howe--Zhu's
Proposition 3 occurs.  Consequently

\[
                    \mathbf Q(\pi^n)=K\qquad(n\geq1),
\]

and that proposition proves that \(J(X)\) is absolutely simple.  Notice
that this argument does not assert ordinarity and does not assert the
impossible condition \(\operatorname{End}_kJ(X)=\mathbf Z\). \(\square\)

## 3. Absolute simplicity of the branch-rational Jacobian

The Frobenius polynomial of \(Y/\mathbf F_5\) is most compactly recorded
through its real trace polynomial:

\[
                         P_Y(T)=T^{25}Q_Y(T+5/T),       \tag{76.9}
\]

where

\[
\begin{aligned}
Q_Y(U)={}&U^{25}-2U^{24}-120U^{23}+236U^{22}+6300U^{21}
-12172U^{20}\\
&-190024U^{19}+360412U^{18}+3635782U^{17}-6767504U^{16}
-45967432U^{15}\\
&+84017092U^{14}+387818812U^{13}-697588276U^{12}
-2152004856U^{11}\\
&+3830395252U^{10}+7526742721U^9-13422653422U^8
-15169333376U^7\\
&+27936617472U^6+14306622112U^5-29892350656U^4
-2589320704U^3\\
&+11661025280U^2-962499328U-933754368.
                                                               \tag{76.10}
\end{aligned}
\]

### Proposition 76.3

The geometric Jacobian \(J(Y)\) is ordinary and absolutely simple.

#### Proof

The polynomial \(P_Y\) is irreducible modulo 47.  Its middle coefficient
is

\[
                           -135307468,
\]

which is prime to 5.  Therefore \(J(Y)\) is ordinary and simple over
\(\mathbf F_5\).

The square-free factorization degrees of \(Q_Y\) at three good primes are

\[
\begin{array}{c|c}
47 &(25)\\
173&(24,1)\\
467&(23,2).
\end{array}                                             \tag{76.11}
\]

Let \(G\leq S_{25}\) be the Galois group of \(Q_Y\).  The first row
makes \(G\) transitive.  The second gives an element which is a 24-cycle
with one fixed point.  This forces the action to be primitive: in the only
possible nontrivial block system, consisting of five blocks of size five,
the block containing the fixed point would be invariant and would have to
contain a nonempty proper invariant subset of the 24-cycle.

The last row gives an element of cycle type \((23)(2)\); its 23rd power
is a transposition.  A primitive permutation group containing a
transposition is the full symmetric group (the graph formed by all
conjugates of that transposition is connected, and those edge
transpositions generate the full symmetric group).  Hence

\[
                              G=S_{25}.                \tag{76.12}
\]

Let \(\pi_Y\) be Frobenius and

\[
              K^+=\mathbf Q(\pi_Y+5/\pi_Y).
\]

The polynomial \(Q_Y\) defines \(K^+\).  Since the point stabilizer
\(S_{24}\) is maximal in \(S_{25}\), (76.12) shows that \(K^+\) has no
proper subfield other than \(\mathbf Q\).  It is also not the maximal
real subfield of a cyclotomic field, since such a field is Galois and
abelian, while the normal closure here has group \(S_{25}\).  Finally,
\(P_Y\) is not of the form

\[
                         T^{50}+cT^{25}+5^{25},
\]

as its \(T^{49}\)-coefficient is \(-2\).  All three hypotheses of
Howe--Zhu, Lemma 8, now hold.  It follows that \(J(Y)\) is absolutely
simple. \(\square\)

For the absolute-simplicity criteria used above, see E. Howe and H. Zhu,
[*On the existence of absolutely simple abelian varieties of a given
dimension over an arbitrary field*](https://arxiv.org/abs/math/0002205),
Proposition 3 and Lemma 8.
