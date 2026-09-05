# The characteristic-five Schwarzian: triangle reduction and limit

## Status and purpose

**Status: proved reduction; no contradiction obtained.**
[Independent audit with a scope note](audits/39_SCHWARZIAN_AUDIT.md).

Let

\[
             k=\overline{\mathbf F}_5,
             \qquad S_0=\mathbf P^1_k(2,3,62).
\]

This note tests whether the Schwarzian projective connection of a coarse
triangle map supplies the missing invariant in file 29. It gives four
precise conclusions.

1. Two separating functions have the same Schwarzian projective connection
   exactly when they differ by a fractional-linear transformation whose
   coefficients are fifth powers in the function field.
2. In characteristic five, local ramification orders \(2,3,62\) all give
   the same Schwarzian double-pole coefficient. Thus the Schwarzian sees
   the reduced ramification support but forgets its three labels.
3. For two full triangle-profile maps with equal Schwarzian connection, the
   forgotten labeling is controlled by a concrete two-torsion divisor. In
   the nontrivial case the maps have the exact normal form
   \[
                q=A^5u^4+B^5,\qquad r=C^5u^6+D^5.
   \]
   The auxiliary map \(u\) has degree between \(78N\) and \(130N\).
4. If \(r=q\circ\beta\) for a free automorphism of order seven, equality of
   the two Schwarzian connections forces \(7\mid N\). It is not automatic:
   the difference is a meromorphic quadratic differential, and when the
   ramification support is preserved it lies in a space of dimension
   \(200N\).

Consequently this route gives a useful extra obstruction when \(7\nmid N\),
but it does not complete the counterexample. In the remaining case one
would have to eliminate the explicit two-torsion normal form below.

## 1. The exact zero-Schwarzian field

Let \(K/k\) be a one-variable function field and let \(q,r\in K\setminus
K^5\). Write \(\partial=\partial_q\) for the unique \(k\)-derivation with
\(\partial q=1\), and define

\[
 \{r,q\}=\frac{\partial^3r}{\partial r}
       -\frac32\left(\frac{\partial^2r}{\partial r}\right)^2.
                                                               \tag{39.1}
\]

Here and below a fraction with denominator \(\partial r\) is used only for
a separating \(r\). The chain rule for the Schwarzian shows that
\(\{r,q\}=0\) is equivalent to equality of the projective connections
defined by \(q\) and \(r\).

### Proposition 39.2 (the characteristic-five Schwarzian kernel)

One has

\[
 \{r,q\}=0
 \quad\Longleftrightarrow\quad
 r=\frac{a^5q+b^5}{c^5q+d^5}
 \quad\text{for some }a,b,c,d\in K,
 \quad a^5d^5-b^5c^5\ne0.                              \tag{39.2}
\]

The element of \(\operatorname{PGL}_2(K^5)\) in (39.2) is unique.

#### Proof

Put \(F=K^5\). Since \(q\) is separating,

\[
             K=F\oplus Fq\oplus Fq^2\oplus Fq^3\oplus Fq^4.
                                                               \tag{39.3}
\]

Let \(v=\partial r\), and write

\[
                    v=a+bq+cq^2+dq^3,\qquad a,b,c,d\in F.
\]

In characteristic five, \(3/2=4=-1\). Hence (39.1) vanishes exactly when

\[
       vv''+(v')^2=(vv')'=0,
       \qquad\text{or equivalently}\qquad vv'\in F.       \tag{39.4}
\]

Comparing the coefficients of \(q,q^2,q^3,q^4\) in (39.4) gives

\[
                 b^2=3ac,\qquad c^2=3bd,\qquad ad=4bc.    \tag{39.5}
\]

These are the equations of the affine cone over the twisted cubic. More
explicitly, if \(a\ne0\), putting \(x=b/(3a)\) in (39.5) gives

\[
                        v=a(1+xq)^3.
\]

If \(a=0\), equations (39.5) give \(b=c=0\), so \(v=dq^3\). In either case
there are \(\lambda,C,D\in F\), with \(\lambda\ne0\) and
\((C,D)\ne(0,0)\), such that

\[
                         v=\lambda(Cq+D)^3.               \tag{39.6}
\]

Since

\[
 (Cq+D)^{-2}=\frac{(Cq+D)^3}{(Cq+D)^5}
\]

and \((Cq+D)^5\in F^\times\), choose \(A,B\in F\) with

\[
                   AD-BC=\lambda(Cq+D)^5.
\]

Then the \(q\)-derivative of \((Aq+B)/(Cq+D)\) is \(v\). Its difference
from \(r\) lies in the constant field of \(\partial\), which is \(F\), and
that constant can be absorbed into \(A,B\). This proves the forward
implication. The reverse implication follows by direct differentiation.

If two matrices give the same function, cross multiplication gives a
quadratic relation in \(q\) over \(F\). The first three members of (39.3)
are independent, so the matrices are scalar multiples. This proves
uniqueness in \(\operatorname{PGL}_2(F)\). \(\square\)

Thus the relevant constants are \(K^5\), not merely \(k\). Proposition
39.2 is consequently much weaker than saying that \(r\) is obtained from
\(q\) by an ordinary target automorphism.

## 2. The three triangle labels collapse locally

For a separating rational function \(q\), let \(\mathfrak P(q)\) denote
its Schwarzian projective connection. In a local parameter \(t\), it is
represented by

\[
 \left(\frac{q'''}{q'}-\frac32\left(\frac{q''}{q'}\right)^2\right)(dt)^2.
                                                               \tag{39.7}
\]

Changing \(t\) adds the usual Schwarzian coordinate-change term. Hence
\(\mathfrak P(r)-\mathfrak P(q)\) is an intrinsically defined rational
quadratic differential.

### Lemma 39.5 (local principal part)

If \(q\) has tame local degree \(e\) at \(P\), then

\[
             \mathfrak P(q)=
             \left(\frac{1-e^2}{2t^2}+O(t^{-1})\right)(dt)^2.  \tag{39.8}
\]

In particular, in characteristic five each of

\[
                              e=2,3,62
\]

has double-pole coefficient \(1\).

#### Proof

After a constant fractional-linear change on the target, write
\(q=t^eu(t)\), where \(u(0)\ne0\). Substitution in (39.7) gives (39.8).
The same calculation applies at a pole because \(q\mapsto1/q\) does not
change the Schwarzian. Finally \(2^2=3^2=62^2=4\) in \(\mathbf F_5\), and
\((1-4)/2=1\). \(\square\)

The collapse is not only a coincidence of leading terms. In
\(k((t))\), the functions \(t^2,t^3,t^{62}\) have identical Schwarzian
connections, and

\[
               t^3=\frac{t^5}{t^2},\qquad
               t^{62}=t^{60}t^2,                         \tag{39.9}
\]

where \(t^5,t^{60}\in k((t))^5\). Thus Proposition 39.2 can genuinely
interchange all three local labels. No argument using only the local
Schwarzian singularity can distinguish them.

## 3. The exact residual two-torsion obstruction

Let \(q,r:V\to\mathbf P^1\) have the full uniform triangle profile

\[
\begin{aligned}
 q^*(0)&=2A_2,&q^*(1)&=3A_3,&q^*(\infty)&=62A_{62},\\
 r^*(0)&=2A'_2,&r^*(1)&=3A'_3,&r^*(\infty)&=62A'_{62}.
\end{aligned}                                               \tag{39.10}
\]

Write \(\deg(q)=\deg(r)=186N\). Then

\[
 \deg A_2=93N,\qquad \deg A_3=62N,\qquad \deg A_{62}=3N,
 \qquad g(V)=14N+1.                                      \tag{39.11}
\]

Put

\[
             R=A_2+A_3+A_{62},\qquad
             R'=A'_2+A'_3+A'_{62}.
\]

### Theorem 39.7 (two-torsion and the \(4/6\) normal form)

Assume

\[
                         \mathfrak P(q)=\mathfrak P(r).   \tag{39.12}
\]

Then the following assertions hold.

1. The reduced ramification divisors are equal as divisors:

   \[
                                  R'=R.                   \tag{39.13}
   \]

2. Set \(\Delta_i=A'_i-A_i\). Then
   \(\Delta_2+\Delta_3+\Delta_{62}=0\), and

   \[
       \mathcal O_V(\Delta_2)\in\operatorname{Pic}^0(V)[2],
       \qquad
       \mathcal O_V(\Delta_3)\simeq\mathcal O_V.          \tag{39.14}
   \]

   These are statements of linear equivalence; they do not assert equality
   of the corresponding effective fiber divisors.

3. Either \(r=q\), or there are a separating \(u\in k(V)\) and
   \(A,B,C,D\in k(V)\), with \(A,C\ne0\), such that

   \[
       \operatorname{div}(u)=2\Delta_2,
       \qquad
       q=A^5u^4+B^5,
       \qquad
       r=C^5u^6+D^5.                                    \tag{39.15}
   \]

Conversely, any two separating functions of the form displayed in
(39.15) have equal Schwarzian projective connections. The profile
conditions in (39.10), however, are additional and are not automatic.

#### Proof

At every point of \(R\), Lemma 39.5 gives a nonzero double pole of
\(\mathfrak P(q)\), while the connection is regular away from \(R\).
The same applies to \(r\). Equality therefore gives (39.13).

Let

\[
                              f=\frac{dr}{dq}.
\]

The differential divisors are

\[
 \operatorname{div}(dq)=A_2+2A_3-63A_{62},\qquad
 \operatorname{div}(dr)=A'_2+2A'_3-63A'_{62}.             \tag{39.16}
\]

Using (39.13), direct subtraction gives the two exact divisor identities

\[
\begin{aligned}
 \operatorname{div}\!\left(f\frac{q-1}{r-1}\right)&=2\Delta_2,\\
 \operatorname{div}\!\left(f\frac q r\right)&=3\Delta_3.
\end{aligned}                                             \tag{39.17}
\]

This already proves that \(\mathcal O_V(\Delta_2)\) is two-torsion and
\(\mathcal O_V(\Delta_3)\) is three-torsion. Let \(u\) be the first
function in (39.17), so \(\operatorname{div}(u)=2\Delta_2\). Moreover,

\[
                  \operatorname{div}(r/q)=64\Delta_2+62\Delta_3.
\]

It follows that \((r/q)u^{-32}\) has divisor \(62\Delta_3\). Together
with the second identity in (39.17) and

\[
                              2\cdot62-41\cdot3=1,
\]

this produces a function \(h\) with

\[
                              \operatorname{div}(h)=\Delta_3. \tag{39.18}
\]

This proves the second assertion, including the distinction between
equality and linear equivalence.

The divisor of \(f\) is

\[
 \operatorname{div}(f)=64\Delta_2+65\Delta_3
                       =32\operatorname{div}(u)+65\operatorname{div}(h).
\]

Since \(V\) is projective and connected, after absorbing a constant fifth
power one can write

\[
                              f=a^5u^2                  \tag{39.19}
\]

for some \(a\in K^\times\).

Now use the part of (39.12) not yet used. With primes denoting
\(\partial_q\), the equation \(\{r,q\}=0\) is, in characteristic five,

\[
                            (ff')'=0.                    \tag{39.20}
\]

Thus \(ff'\in K^5\). Substitution of (39.19) shows that
\(u^3u'\in K^5\), and hence

\[
                         (u^4)'\in K^5.
\]

There are \(c,d\in K\) such that

\[
                              u^4=c^5q+d^5.              \tag{39.21}
\]

If \(c=0\), then \(u\in K^5\). Since
\(\operatorname{div}(u)=2\Delta_2\) and every coefficient of
\(\Delta_2\) belongs to \(\{-1,0,1\}\), this forces \(\Delta_2=0\).
Theorem 36.20 then gives \(r=q\).

Otherwise \(u\) is separating and \(c\ne0\). Equation (39.21) gives the
first normal form in (39.15). Differentiating (39.21) and using
\(dr=a^5u^2dq\) gives

\[
                         dr=4(a/c)^5u^5du.
\]

Since \(d(u^6)=u^5du\) in characteristic five, integration gives the
second normal form in (39.15).

Conversely, fifth powers are constants for \(\partial_u\), and the local
monomial formula gives

\[
                 \{A^5u^4+B^5,u\}=0,
                 \qquad
                 \{C^5u^6+D^5,u\}=0,
\]

because \(4^2=6^2=1\) in \(k\). The Schwarzian chain rule proves the last
assertion. \(\square\)

The nontrivial normal form has a useful numerical consequence.

### Proposition 39.10 (the auxiliary map must be large)

In the nontrivial case of Theorem 39.7, let

\[
                s=\deg(\Delta_2)_+
                 =\#(A'_2\setminus A_2).
\]

Then

\[
                         39N\le s\le65N,
       \qquad          78N\le\deg(u)=2s\le130N.          \tag{39.22}
\]

#### Proof

The zero and pole divisors of \(u\) consist respectively of the points in
\(A'_2\setminus A_2\) and \(A_2\setminus A'_2\), each with multiplicity
two. Hence \(\deg u=2s\). Since the complement of \(A_2\) in the common
support \(R\) has degree \(65N\), one has \(s\le65N\).

Write \(r=C^5u^6+D^5\) as in (39.15). Then

\[
                              dr=C^5u^5du.               \tag{39.23}
\]

At each of the \(93N\) points in \(A'_2\), equation (39.23) implies
\(\operatorname{ord}(du)\ge1\). At each point in
\(A'_3\cup A'_{62}\) which is not a pole of \(u\), it implies
\(\operatorname{ord}(du)\ge2\), because both \(2\) and \(-63\) are
congruent to \(2\) modulo five. Exactly \(s\) points of this latter union
are poles of \(u\); each is a pole of order two, so \(du\) has order
\(-3\) there. There are no other poles of \(du\).

Since \(\deg\operatorname{div}(du)=2g(V)-2=28N\), the degree of its zero
divisor is \(28N+3s\). The preceding lower bounds give

\[
                28N+3s\ge93N+2(65N-s)=223N-2s.
\]

Thus \(s\ge39N\), proving (39.22). \(\square\)

The interval (39.22) is restrictive, but not empty. No contradiction is
claimed.

## 4. Order seven and the quadratic-differential defect

Suppose now that \(q:V\to S_0\) is representable finite etale, with coarse
degree \(186N\), and that \(\beta\in\operatorname{Aut}(V)\) acts freely and
has order seven. Put \(r=q\circ\beta\).

### Corollary 39.12 (a seven-divisibility obstruction)

If

\[
                         \mathfrak P(q\circ\beta)=\mathfrak P(q),
                                                               \tag{39.24}
\]

then \(7\mid N\). Therefore the Schwarzian connections are automatically
different whenever \(7\nmid N\).

#### Proof

Theorem 39.7 says that (39.24) makes the reduced ramification support \(R\)
\(\beta\)-stable. Freeness makes every \(\beta\)-orbit in \(R\) have
seven elements. But

\[
                         \deg R=(93+62+3)N=158N.
\]

As \(7\nmid158\), this forces \(7\mid N\). \(\square\)

To state exactly what remains when \(7\mid N\), define

\[
       Q_\beta=\mathfrak P(q\circ\beta)-\mathfrak P(q).
                                                               \tag{39.25}
\]

This is a rational quadratic differential. If \(R_\beta=\beta^{-1}R\)
and \(I\) is the coefficientwise minimum of the reduced divisors
\(R,R_\beta\), Lemma 39.5 gives

\[
 Q_\beta\in
 H^0\!\left(V,\omega_V^{\otimes2}
            \bigl(2R+2R_\beta-3I\bigr)\right).           \tag{39.26}
\]

Indeed, a point lying in only one support gives a double pole, while at a
common point the equal double-pole coefficients cancel and leave at most a
simple pole. In the only case in which (39.24) is possible one first has
\(R_\beta=R\), and then

\[
                    Q_\beta\in H^0(V,\omega_V^{\otimes2}(R)),
       \qquad h^0(V,\omega_V^{\otimes2}(R))=200N.         \tag{39.27}
\]

The dimension follows from (39.11), \(\deg R=158N\), and Riemann--Roch.
Thus preservation is the vanishing of a particular vector in a large
space, not a formal consequence of naturality.

There is also an exact cocycle identity. Pullback gives

\[
 Q_{\beta^j}=\sum_{i=0}^{j-1}(\beta^i)^*Q_\beta,
 \qquad
                   \sum_{i=0}^6(\beta^i)^*Q_\beta=0.     \tag{39.28}
\]

The trace-zero identity does not imply \(Q_\beta=0\). Averaging instead
produces some invariant projective connection; it does not make the
connection selected by \(q\) invariant.

### Proposition 39.15 (free order seven does not give intrinsicity)

There are a smooth projective curve \(V/k\), a free order-seven automorphism
\(\beta\), and a separating \(q\in k(V)\) for which \(Q_\beta\ne0\).

#### Proof

Take a genus-two curve \(C/k\) and a line bundle of exact order seven in
\(\operatorname{Pic}^0(C)\). Its connected Kummer torsor \(V\to C\) is
finite etale of degree seven. A deck generator \(\beta\) acts freely and
\(g(V)=8\).

Choose \(P\in V(k)\). Riemann--Roch supplies

\[
 q\in H^0(V,\mathcal O_V(22P))
       \setminus H^0(V,\mathcal O_V(21P))
\]

such that \(dq(\beta P)\ne0\). The two requirements are complements of
proper linear subspaces: the derivative condition is nontrivial because
\(\deg(22P-2\beta P)=20>2g(V)-2\). They therefore meet over the infinite
field \(k\).

At \(P\), the function \(q\) has pole order \(22\equiv2\pmod5\), so
Lemma 39.5 gives a double pole of \(\mathfrak P(q)\). The function
\(q\circ\beta\) is unramified at \(P\) by construction, so its connection
is regular there. Hence \(Q_\beta\ne0\). \(\square\)

This last example does not have the triangle profile. Its role is to show
that no argument from the abstract curve, freeness, or averaging can make
\(\mathfrak P(q)\) intrinsic. For the actual triangle reduction, the exact
remaining Schwarzian question is whether the nontrivial normal form
(39.15), with the profile (39.10), a free order-seven symmetry, and
necessarily \(7\mid N\), can occur. The results above do not decide it.
