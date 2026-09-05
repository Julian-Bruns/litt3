# Scalar compression at the first admissible diamond degree

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

This note complements files 68 and 69.  It clarifies the distinct roles of
the two Jacobians in a redesigned counterexample:

- absolute simplicity is required of (J(Y)), in order to make the norm
  image large; and
- only a finite small-norm condition is required of (J(X)), in order to
  compress a coefficient involution to a scalar.

The main result eliminates a quadratic coefficient curve at the first
degree allowed by the universal norm obstruction.  It applies to arbitrary
curves satisfying the prime genus-ratio setup, and not only to the current
pair of genera (3) and (15).

Throughout, (k) is an algebraically closed field of characteristic
different from (2), (r) is an odd prime different from
(operatorname{char}k), and

\[
 g(X)=s+1,\qquad g(Y)=rs+1,\qquad s\geq1.              \tag{71.1}
\]

Suppose a common cover has produced the prime-ratio diamond of Theorem
68.1,

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg p=r,\qquad \deg a=\deg c=M,                    \tag{71.2}
\]

where \(p\) is a \(C_r\)-torsor and \(a\beta\ne a\).  Assume that \(Y\) is
hyperelliptic and \(J(Y)\) is absolutely simple.  Files 68 then give

\[
 M\geq r+2.                                           \tag{71.3}
\]

We study the case in which the norm-coefficient map has degree two,

\[
 q:C\longrightarrow B,
 \qquad \deg q=2,                                     \tag{71.4}
\]

and write \(\delta\) for its involution.  In Lemma 71.2 we assume that the
hyperelliptic square root is not already in the spectral field, i.e. that
we are in case B of Theorem 68.5.  This assumption is automatic in Theorem
71.3: there \(e=2\) and \(M=r+2\) is odd, whereas case A would require
\(e\mid M\).

## 1. Pullback detects both signs

### Lemma 71.1 (signed pullback rigidity)

Let (f,g:R\to X) be nonconstant morphisms, with (g(X)\geq2).

1. If (f^*=g^*:J(X)\to J(R)), then (f=g).
2. If (f^*=-g^*), then (X) is hyperelliptic and
   (g=\iota_X f), where (iota_X) is its hyperelliptic involution.

#### Proof

Dualizing with the canonical principal polarizations gives the corresponding
identities for pushforward maps (J(R)\to J(X)).

In the first case, fix (P_0\in R).  Abel--Jacobi applied to (P-P_0)
shows that the two Abel--Jacobi curves traced by (f(P)) and (g(P))
differ by a fixed translation of (J(X)).  Thus this translation preserves
the Abel--Jacobi copy of (X).  It induces an automorphism of (X) acting
trivially on (J(X)).  The action of the automorphism group of a curve of
genus at least two on its principally polarized Jacobian is faithful.
Consequently the translation and the automorphism are trivial, and (f=g).

In the second case, the same calculation gives

\[
             f(P)+g(P)\sim f(P_0)+g(P_0)              \tag{71.5}
\]

as degree-two divisors on (X), for every (P\in R).  This is not a
constant family of divisors, since (f) and (g) are nonconstant.  Hence
it is a moving (g^1_2).  The curve (X) is hyperelliptic, and uniqueness
of its (g^1_2) says that the two points in (71.5) are exchanged by the
hyperelliptic involution.  Therefore (g=\iota_X f).  \(\square\)

## 2. The finite scalar window on (J(X))

Let (dagger) denote Rosati adjunction on
(operatorname{End}^0(J(X))).  Say that (J(X)) satisfies
(mathrm{SW}_M) if every integral endomorphism (v\in\operatorname{End}(J(X)))
such that

\[
 v^\dagger=v,
 \qquad [M]\mathbin{+}v\succeq0,
 \qquad [M]\mathbin{-}v\succeq0                     \tag{71.6}
\]

is a scalar ([\lambda]), with (lambda\in\mathbf Z).  Here
(succeq0) is the Rosati-positive semidefinite cone.

This is a finite, exactly checkable condition.  Indeed, the Rosati trace
form is positive definite on the Rosati-fixed subspace, (71.6) bounds all
real eigenvalues by (M), and the actual endomorphism ring is a lattice in
its rational endomorphism algebra.  Thus only finitely many integral points
need be tested.  Notice that (mathrm{SW}_M) neither asserts nor requires
(operatorname{End}(J(X))=\mathbf Z).

Put

\[
                   u=c_*\delta^*c^*
                       \in\operatorname{End}(J(X)).   \tag{71.7}
\]

### Lemma 71.2 (two capacity inequalities in the quadratic-core case)

Suppose that \(z\notin k(E)\) and that \(u=[\lambda]\) is scalar.  Then

\[
 \lambda\ne-M\quad\Longrightarrow\quad g(B)\geq s+1,               \tag{71.8}
\]

and

\[
 \lambda\ne M\quad\Longrightarrow\quad
 g(B)\leq(M-r-1)s-1.                                  \tag{71.9}
\]

#### Proof

Let

\[
 h=p_*a^*:J(Y)\longrightarrow J(C),
 \qquad A=\operatorname{im}h.                         \tag{71.10}
\]

The universal norm argument in file 68 gives

\[
 \dim A=g(Y)=rs+1,
 \qquad c_*h=0.                                       \tag{71.11}
\]

In the quadratic-core case, Theorem 68.5 also gives (q_*h=0).  Hence
((1+\delta^*)h=q^*q_*h=0), so (delta^*=-1) on (A) up to isogeny.

Consider

\[
 \phi_+=(1+\delta^*)c^*,
 \qquad
 \phi_-=(1-\delta^*)c^*.                              \tag{71.12}
\]

Since (c_*c^*=[M]), direct calculation gives

\[
 \phi_+^\dagger\phi_+=[2(M+\lambda)],
 \qquad
 \phi_-^\dagger\phi_-=[2(M-\lambda)].                \tag{71.13}
\]

If (lambda\ne-M), the first map therefore has image of dimension
(g(X)=s+1).  Its image lies in (q^*J(B)), proving (71.8).

If (lambda\ne M), the second map has image of dimension (s+1).  It
lies in (operatorname{Prym}(C/B)), and it is orthogonal to (A): both
(c^*J(X)) and (delta^*c^*J(X)) are orthogonal to (A), by (71.11)
and (delta^*=-1) on (A).  Hence

\[
 \begin{aligned}
 g(C)-g(B)
   &=\dim\operatorname{Prym}(C/B)\\
   &\geq (rs+1)+(s+1).
 \end{aligned}                                        \tag{71.14}
\]

Using (g(C)=Ms+1) gives (71.9).  \(\square\)

### Theorem 71.3 (quadratic compression at (M=r+2))

Assume (M=r+2), that (X) is nonhyperelliptic, and that (J(X))
satisfies (mathrm{SW}_{r+2}).  Then the norm-coefficient map cannot have
degree two.

#### Proof

The endomorphism (u) in (71.7) is Rosati self-adjoint.  Moreover

\[
 [M]\mathbin{\pm}u
   =c_*(1\mathbin{\pm}\delta^*)c^*\succeq0,           \tag{71.15}
\]

because twice the right side is
(((1\mathbin{\pm}\delta^*)c^*)^\dagger
 ((1\mathbin{\pm}\delta^*)c^*)).  Condition
(mathrm{SW}_M) therefore gives (u=[\lambda]).

If neither (lambda=M) nor (lambda=-M), Lemma 71.2 gives

\[
                         s+1\leq g(B)\leq s-1,        \tag{71.16}
\]

which is impossible.  Thus (lambda=\pm M).

If (lambda=M), equation (71.13) gives
((1-\delta^*)c^*=0).  Lemma 71.1 yields

\[
                              c\delta=c.              \tag{71.17}
\]

Thus (c) factors through the degree-two quotient (q), forcing (M)
to be even.  But (M=r+2) is odd.

If (lambda=-M), the other equality in (71.13) gives
((1+\delta^*)c^*=0).  Lemma 71.1 then says that (X) is
hyperelliptic, contrary to the hypothesis.  Both extremal cases are
impossible.  \(\square\)

## 3. Combining the quadratic and birational alternatives

The preceding theorem treats coefficient degree two.  Coefficient degree
one has a simple genus obstruction which is useful well beyond the first
degree.

### Lemma 71.4 (birational coefficient genus bound)

If the coefficient map is birational, then

\[
              Ms+1\leq\frac{(2M-1)(2M-2)}2.           \tag{71.18}
\]

Consequently a birational coefficient map is impossible whenever

\[
                              s>2M-3.                 \tag{71.19}
\]

#### Proof

The coefficient system is base-point-free and has line-bundle degree
(2M).  Its image is therefore an integral curve of degree (2M), with
normalization (C).  Generic projection to a plane preserves its degree
and birationality.  The plane genus bound gives

\[
 g(C)\leq(2M-1)(2M-2)/2.
\]

Since (g(C)=Ms+1), this is (71.18), and rearranging gives (71.19).
\(\square\)

### Corollary 71.5 (a finite design criterion at the first degree)

Assume all the hypotheses of Theorem 68.3 and its hyperelliptic
coefficient construction.  Suppose additionally that

1. (X) is nonhyperelliptic;
2. (s\geq2r+2); and
3. (J(X)) satisfies (mathrm{SW}_{r+2}).

Then no prime-ratio diamond can have degree (M=r+2).

#### Proof

Since (r+2<2r), Corollary 68.6 says that the coefficient degree is one
or two.  Degree two is excluded by Theorem 71.3.  For degree one, the
hypothesis (s\geq2r+2) gives (s>2(r+2)-3=2r+1), so Lemma 71.4 applies.
\(\square\)

This corollary does **not** by itself exclude a common cover: a diamond of
larger degree may still exist.  Its value is that all three extra inputs
are concrete design conditions.  Absolute simplicity is checked on
(J(Y)); nonhyperellipticity is checked on (X); and
(mathrm{SW}_{r+2}) is a finite endomorphism-lattice calculation on
(J(X)).  The remaining all-degree problem is to turn a larger-degree
diamond into a smaller one, or to obtain a degree-independent replacement
for the scalar-window compression.
