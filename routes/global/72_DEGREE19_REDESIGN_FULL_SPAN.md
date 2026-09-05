# The degree-19 redesign and its full-span obstruction

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

This note specializes the parameterized results of files 68 and 69 to

\[
       (p,\ell,r,g(X),g(Y))=(5,71,17,3,35).
\tag{72.1}
\]

It has three purposes.  First, it verifies directly that

\[
                         Y:Y^2=1-t^{71}
\tag{72.2}
\]

has absolutely simple Jacobian and that the order-17 orbit in any
prime-ratio diamond has primitive multiplicity exactly 16 at the first
possible degree.  Second, it proves that the full coefficient span at
that degree is impossible for every nonhyperelliptic genus-three curve
with absolutely simple Jacobian.  Third, it records precisely what is
and is not removed at degree 19 by the two currently available methods.

The conclusion is deliberately limited: it eliminates the full span at
the first degree, not every coefficient span and not degrees greater than
19.

## 1. The arithmetic of the 71-cyclic Jacobian

Put

\[
 K=\mathbf Q(\zeta_{71}),\qquad
 H=\langle5\rangle\leq(\mathbf Z/71\mathbf Z)^\times.
\]

One has

\[
 H=\{1,5,25,54,57\},\qquad \operatorname{ord}_{71}(5)=5.
\tag{72.3}
\]

Using 7 as a primitive root modulo 71, the CM-type counts of
Proposition 69.1, indexed by the cosets \(7^iH\), are

\[
 (m_i)_{i=0}^{13}
   =(3,4,4,2,3,0,2,2,1,1,3,2,5,3).
\tag{72.4}
\]

### Proposition 72.1

The Jacobian \(J(Y)\) is absolutely simple.  Its geometric rational
endomorphism algebra is a central division algebra of degree five over

\[
             E=\mathbf Q(\zeta_{71})^{\langle5\rangle},
             \qquad [E:\mathbf Q]=14,
\]

and \(K\) is a maximal commutative subfield.

If a common cover of \(X\) and \(Y\) produces the order-17 diamond of
file 68, its common degree satisfies

\[
                              M\geq19.                 \tag{72.5}
\]

At \(M=19\), the cyclic span of the 17 conjugates of \(a^*J(Y)\) in
\(J(V)\) consists, up to isogeny, of exactly one invariant copy and
exactly 16 primitive copies of \(J(Y)\).

#### Proof

No nonzero cyclic shift fixes the sequence (72.4).  Moreover its values
strictly between zero and five are coprime to five.  Both hypotheses of
Proposition 69.1 hold, proving the first assertion.

The design identity is

\[
             71=2\cdot17\cdot(3-1)+3,
\]

and the hyperelliptic curve \(Y\) has no separable degree-17 pencil:
such a pencil together with its degree-two pencil would give
\(g(Y)\leq16\) by Castelnuovo--Severi, whereas \(g(Y)=35\).  The norm
bound of file 68 therefore gives \(M\geq17+2=19\).

For the primitive multiplicity, Theorem 69.4 gives a positive multiple
of

\[
            \frac{17-1}{\gcd(17-1,5)}=16.             \tag{72.6}
\]

At \(M=19\), the Prym of \(V\to C\) has dimension

\[
       (17-1)M(g(X)-1)=16\cdot19\cdot2=608.
\]

Since \(16\dim J(Y)=560\), while \(32\dim J(Y)=1120>608\), the
primitive multiplicity is exactly 16.  The invariant multiplicity is
exactly one by Theorem 69.4. \(\square\)

### Corollary 72.2 (near saturation of the two Jacobian images)

At \(M=19\), put

\[
 h=p_*a^*:J(Y)\longrightarrow J(C),\qquad
 A=\operatorname{im}h,\qquad D=c^*J(X).
\tag{72.7}
\]

If \(J(X)\) is absolutely simple, then

\[
       \dim A=35,\qquad \dim D=3,\qquad A\perp D,
       \qquad \dim J(C)=39.                            \tag{72.8}
\]

Thus \(A+D\) has dimension 38 and codimension one in \(J(C)\).

#### Proof

The norm map \(h\) is nonzero by file 68, so simplicity of \(J(Y)\)
makes its image 35-dimensional.  Any homomorphism from the simple
35-fold \(J(Y)\) to the threefold \(J(X)\) is zero.  Hence
\(c_*h=0\), which is precisely the Rosati orthogonality of \(A\) and
\(c^*J(X)\).  Finally \(g(C)-1=M(g(X)-1)=38\). \(\square\)

## 2. Coefficient degree and Castelnuovo bounds

Let \(W\) be the span of the 18 coefficients of the norm binary form,
and write

\[
                         w=\dim W.
\]

File 68 gives

\[
                         3\leq w\leq18.                \tag{72.9}
\]

Let \(B\) be the normalization of the coefficient image and let
\(e=[k(C):k(B)]\).  Since \(M=19\) is prime, Corollary 68.6 gives

\[
                         e\in\{1,2\}.                  \tag{72.10}
\]

The coefficient line bundle on \(C\) has degree 38.  Consequently the
nondegenerate coefficient image in \(\mathbf P^{w-1}\) has degree

\[
                         \frac{38}{e}.                 \tag{72.11}
\]

Recall that if \(d-1=q(N-1)+\epsilon\), with
\(0\leq\epsilon<N-1\), Castelnuovo's bound is

\[
 \operatorname{Cast}(d,N)
       ={q\choose2}(N-1)+q\epsilon.                   \tag{72.12}
\]

### Lemma 72.3

At \(M=19\):

1. coefficient degree \(e=1\) is impossible whenever \(w\geq15\);
2. if \(e=2\) and \(w=18\), then \(g(B)\leq2\).

#### Proof

If \(e=1\), then \(B=C\), so \(g(B)=39\).  For \(w\geq15\), generic
projection of the nondegenerate degree-38 image to
\(\mathbf P^{14}\) preserves its degree and birationality.  But

\[
             \operatorname{Cast}(38,14)=35<39,
\]

a contradiction.

If \(e=2\) and \(w=18\), the coefficient image has degree 19 in
\(\mathbf P^{17}\).  Here

\[
             \operatorname{Cast}(19,17)=2,
\]

so its normalization has genus at most two. \(\square\)

## 3. The full coefficient span is impossible

### Theorem 72.4 (full-span obstruction at \(M=19\))

Let \(X/k\) be a nonhyperelliptic genus-three curve whose Jacobian is
absolutely simple.  Then an order-17 diamond between \(X\) and the curve
\(Y\) in (72.2), of common degree \(M=19\), cannot have full coefficient
span

\[
                              \dim W=18.               \tag{72.13}
\]

#### Proof

By (72.10), the coefficient degree is one or two.  Lemma 72.3 excludes
degree one.

Suppose \(e=2\), and let

\[
                         q:C\longrightarrow B
\]

be the coefficient map, with involution \(\delta\).  Since \(e=2\)
does not divide the odd prime \(M=19\), case A of Theorem 68.5 is
impossible; this is the quadratic-core case B.  Lemma 72.3 gives
\(g(B)\leq2\).

Consider

\[
             \phi_+=(1+\delta^*)c^*
                    =q^*q_*c^*:J(X)\longrightarrow J(C).            \tag{72.14}
\]

Its image lies in \(q^*J(B)\), which has dimension at most two.  Since
\(J(X)\) is a simple threefold, a nonzero homomorphism out of \(J(X)\)
has three-dimensional image.  Therefore \(\phi_+=0\), and

\[
                         \delta^*c^*=-c^*.             \tag{72.15}
\]

The signed pullback rigidity lemma (Lemma 71.1) applied to the maps
\(c\delta,c:C\to X\) says that (72.15) can hold only when \(X\) is
hyperelliptic, with \(c\delta=\iota_Xc\).  This contradicts the choice
of \(X\).  Hence degree two is impossible as well. \(\square\)

## 4. A concrete curve \(X\) for the full-span theorem

The preceding theorem is not conditional on the existence of a suitable
genus-three curve.  For example, over \(\mathbf F_5\), let \(X_0\) be
the smooth plane quartic

\[
\begin{aligned}
0={}&3x^4+2x^2y^2+xy^3+3x^3z+4x^2yz+3y^3z\\
   &+x^2z^2+2xyz^2+2y^2z^2+xz^3+2yz^3+3z^4.
\end{aligned}                                           \tag{72.16}
\]

### Proposition 72.5

The curve \(X_0\) is smooth, nonhyperelliptic, and has absolutely simple
Jacobian.

#### Proof

The three partial derivatives of (72.16) have no common projective zero
on the quartic, so \(X_0\) is smooth.  A smooth plane quartic is a
nonhyperelliptic curve of genus three.

Exact point counts over the first three extensions are

\[
       \#X_0(\mathbf F_5)=7,
       \quad\#X_0(\mathbf F_{25})=31,
       \quad\#X_0(\mathbf F_{125})=145.
\tag{72.17}
\]

They give the Frobenius polynomial

\[
 P(T)=T^6+T^5+3T^4+9T^3+15T^2+25T+125.               \tag{72.18}
\]

This polynomial is irreducible over \(\mathbf Q\).  To check geometric
simplicity, form the ratio resultant

\[
                R(v)=\operatorname{Res}_u(P(u),P(vu)).
\]

Up to the nonzero scalar \(5^9\), its factorization over \(\mathbf Q\)
is

\[
\begin{aligned}
R(v)={}&(v-1)^6\\
 &\cdot(125v^6+125v^5+105v^4+209v^3
                    +105v^2+125v+125)\\
 &\cdot(125v^{12}+300v^{11}+495v^{10}+604v^9+739v^8
                    +878v^7+967v^6\\
 &\hspace{31mm}+878v^5+739v^4+604v^3+495v^2+300v+125)^2.
\end{aligned}                                           \tag{72.19}
\]

The two displayed non-linear factors are irreducible and are not
associates of monic integral polynomials, hence are not cyclotomic.
Thus no quotient of two distinct Frobenius roots is a root of unity.
It follows that \(P(T)\) remains the minimal polynomial of Frobenius
after every finite constant-field extension.  The Jacobian stays simple
over every finite extension, and is therefore absolutely simple.
The accompanying Sage certificate verifies smoothness, the point counts,
and all polynomial assertions. \(\square\)

## 5. Exact remaining degree-19 cases

For any nonhyperelliptic genus-three \(X\) with absolutely simple
Jacobian, Theorem 72.4 eliminates the single row

\[
                         (M,w)=(19,18).                \tag{72.20}
\]

More finely, Lemma 72.3 and its proof give the following current table:

| coefficient degree | eliminated coefficient spans | spans not eliminated here |
|---:|:---|:---|
| \(e=1\) | \(15\leq w\leq18\) | \(3\leq w\leq14\) |
| \(e=2\) | \(w=18\) | \(3\leq w\leq17\) |

There are two possible next improvements.

1. If \(J(X)\) satisfies the finite scalar-window condition
   \(\mathrm{SW}_{19}\) of file 71, then Theorem 71.3 eliminates
   coefficient degree two for every \(3\leq w\leq18\).  Even then, the
   birational rows \(e=1,\ 3\leq w\leq14\) remain.
2. The explicit \(\mathbf F_5\)-curve (72.16) is excellent for the
   dimension-saturation argument but does **not** satisfy
   \(\mathrm{SW}_{19}\): its Frobenius-plus-Verschiebung endomorphism is
   a non-scalar Rosati-symmetric integral endomorphism whose real
   eigenvalues lie in \([-2\sqrt5,2\sqrt5]\).  Thus scalar compression
   of all quadratic rows requires either a curve with a different field
   of definition and a certified small Rosati ball, or a new argument
   that does not use \(\mathrm{SW}_{19}\).

Accordingly, the exact unresolved work at \(M=19\) is now the lower-span
birational range \(3\leq w\leq14\), together with the lower-span
quadratic range \(3\leq w\leq17\) unless a suitable scalar-window curve
is supplied.  Degrees \(M>19\) require the all-degree divisor sieve of
file 68 rather than this endpoint argument.
