# The nonscalar cross-image trace sieve

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

File 79 treated the cross-correspondence of an etale cover and a ramified
involution after assuming that its action on the target Jacobian is scalar.
The main result here removes that assumption entirely.

For the reduced cross-image, let \(T\) be the trace of its action on first
cohomology and let \(Q\) be its Rosati square norm.  The diagonal
intersection, self-intersection, and adjunction formulas give

\[
 R\leq f(2n-T),\qquad Q\leq n(n+s),\qquad T^2\leq4gQ,              \tag{80.1}
\]

where \(R\) is the ramification degree of the involution,
\(f\) is the generic degree onto the cross-image, \(n=M/f\), and
\(g=s+1\) is the target genus.  These imply a numerical obstruction which
does not require knowledge of the endomorphism ring.

The theorem is parameterized in \(M,s,g\).  It also gives an asymptotic
criterion whenever another argument bounds the quotient genus linearly
and bounds \(n\) from below.  For the explicit pair of file 76 it removes
the last \(M=7\) row without the scalar-window calculation of file 79.

Throughout, \(k\) is algebraically closed of characteristic different
from two.

## 1. Exact cross-image identities

Let \(X\) be a smooth projective curve of genus

\[
                              g=s+1\geq2,
\]

let

\[
                    c:C\longrightarrow X
\]

be finite etale of degree \(M\), and let

\[
                    q:C\longrightarrow B
\]

be a ramified double cover with involution \(\delta\).  Since
\(g(C)=Ms+1\), the reduced ramification divisor of \(q\) has degree

\[
                    R=2Ms-4g(B)+4.                                 \tag{80.2}
\]

Let \(\Gamma\subset X\times X\) be the reduced image of

\[
                    \Phi=(c,c\delta):C\longrightarrow X\times X.
                                                                        \tag{80.3}
\]

Write \(D\) for the normalization of \(\Gamma\), \(f\) for the generic
degree \(C\to D\), and

\[
                              n=M/f.                                \tag{80.4}
\]

Both projections \(\Gamma\to X\) have degree \(n\).  Let

\[
                    v=(p_2)_*(p_1)^*:J(X)\longrightarrow J(X)       \tag{80.5}
\]

be the integral endomorphism induced by the reduced correspondence, and
put

\[
 T=\operatorname{Tr}(v\mid H^1(X,\mathbf Q_\ell)),\qquad
 Q={1\over2}\operatorname{Tr}(v^\dagger v\mid H^1(X,\mathbf Q_\ell)).
                                                                        \tag{80.6}
\]

The Rosati trace form makes \(Q\geq0\).  The quantities in (80.6) are
independent of the auxiliary prime \(\ell\).

### Theorem 80.1 (exact nonscalar cross-image sieve)

With the notation above:

1. \(f\mid M\), both maps \(D\to X\) are finite etale of degree \(n\),
   and
   \[
                              g(D)=ns+1.                             \tag{80.7}
   \]
2. The diagonal intersection gives
   \[
                 R\leq f(2n-T),\qquad
                 f(2n-T)-R\in2\mathbf Z_{\geq0}.                    \tag{80.8}
   \]
3. The product-surface intersection formulas are
   \[
   \begin{aligned}
       \Gamma^2&=2n^2-2Q,\\
       K_{X\times X}\cdot\Gamma&=4ns,\\
       p_a(\Gamma)&=1+n^2-Q+2ns.
   \end{aligned}                                                     \tag{80.9}
   \]
   In particular,
   \[
                              Q\leq n(n+s).                          \tag{80.10}
   \]
4. Cauchy--Schwarz for the Rosati trace form gives
   \[
                              T^2\leq4gQ.                            \tag{80.11}
   \]
   Consequently every such configuration obeys
   \[
          R\leq2M+2\sqrt{\,gM(M+sf)\,}.                             \tag{80.12}
   \]

#### Proof

The two projections of \(\Phi_*[C]=f[\Gamma]\) have degree \(M\).
Therefore the reduced projection degrees are \(n=M/f\), proving
\(f\mid M\).  The first projection factors \(c\) as

\[
                         C\longrightarrow D\longrightarrow X
\]

with degrees \(f,n\).  Ramification indices multiply, and \(c\) is
etale, so both factors are etale.  This proves (80.7).  The same argument
applies to the second projection.

The correspondence Lefschetz formula gives

\[
                         \Gamma\cdot\Delta_X=2n-T.                  \tag{80.13}
\]

Pulling the diagonal back through \(\Phi\) and using the projection
formula gives total degree \(f(2n-T)\).  At a fixed point of \(\delta\),
choose a tame local parameter \(z\) with \(\delta(z)=-z\).  Since \(c\)
is etale, a parameter at \(c(P)\) pulls back with nonzero linear term in
\(z\).  The two maps \(c\) and \(c\delta\) therefore meet to order one
at \(P\).  These are the \(R\) ramification points of \(q\).  Every
remaining coincidence occurs in a two-element \(\delta\)-orbit, with
equal local multiplicities at the two points.  This proves both assertions
of (80.8).

The Künneth component of \([\Gamma]\) in
\(H^1(X)\otimes H^1(X)\) represents \(v\).  Its self-pairing is the
negative Rosati trace norm

\[
                -\operatorname{Tr}(v^\dagger v\mid H^1(X))=-2Q.
\]

The degree components contribute \(2n^2\), proving the first formula in
(80.9).  Pulling back the two canonical divisors through the projections
gives the second, and adjunction gives the third.  Since \(D\) is the
normalization of \(\Gamma\), equations (80.7) and (80.9) imply

\[
 ns+1\leq1+n^2-Q+2ns,
\]

which is (80.10).

For the positive definite Rosati trace pairing

\[
                 \langle a,b\rangle
                    =\operatorname{Tr}(a^\dagger b\mid H^1(X)),
\]

one has

\[
 \langle1,1\rangle=2g,\qquad
 \langle v,v\rangle=2Q,\qquad
 \langle1,v\rangle=T.
\]

Cauchy--Schwarz is exactly (80.11).  Combining (80.8), (80.10), and
(80.11) gives

\[
\begin{aligned}
 R&\leq f(2n-T)\\
  &\leq2fn+2f\sqrt{g\,n(n+s)}\\
  &=2M+2\sqrt{gM(M+sf)},
\end{aligned}
\]

which is (80.12). \(\square\)

## 2. Excluding the graph endpoint

The bound (80.12) is useful only when \(f\), or equivalently the reduced
projection degree \(n=M/f\), is controlled.  The largest possible value
\(f=M\) has a transparent geometric meaning.

### Lemma 80.2 (the graph endpoint descends the involution)

If \(f=M\), there is an involution \(\sigma\in\operatorname{Aut}(X)\)
such that

\[
                              c\delta=\sigma c.                      \tag{80.14}
\]

If \(X\) is nonhyperelliptic and \(J(X)\) is absolutely simple, this is
impossible.  Hence under these two hypotheses

\[
                              f<M,\qquad n>1.                        \tag{80.15}
\]

#### Proof

When \(f=M\), both projections from \(D\) have degree one.  The reduced
image is the graph of an automorphism \(\sigma\) of \(X\), proving
(80.14).  Since \(\delta^2=1\) and \(c\) is surjective, one has
\(\sigma^2=1\).

If \(\sigma=1\), then \(c\) is \(\delta\)-invariant and factors through
the quotient \(q\).  This contradicts etaleness of \(c\), because \(q\)
is ramified.  If \(\sigma\ne1\), let \(X_0=X/\langle\sigma\rangle\).
When \(g(X_0)>0\), pullback embeds a positive-dimensional proper abelian
subvariety of \(J(X)\), contrary to absolute simplicity.  Thus
\(g(X_0)=0\), and the degree-two map \(X\to X_0\simeq\mathbf P^1\)
makes \(X\) hyperelliptic.  This is again a contradiction. \(\square\)

### Corollary 80.3 (prime-degree criterion without a scalar window)

Assume \(X\) is nonhyperelliptic, \(J(X)\) is absolutely simple, and
\(M\) is prime.  Then \(f=1\), \(n=M\), and

\[
                   R\leq2M+2\sqrt{\,gM(M+s)\,}.                     \tag{80.16}
\]

Thus the reverse strict inequality excludes the double cover \(q\).

#### Proof

By Lemma 80.2, \(f\) is a proper divisor of the prime \(M\), hence
\(f=1\).  Apply (80.12). \(\square\)

## 3. Linear genus bounds and asymptotic exclusion

The next form isolates exactly what an independent coefficient argument
must supply in order to make the sieve uniform in \(M\).

### Theorem 80.4 (linear coefficient-genus criterion)

Retain the hypotheses of Theorem 80.1 and suppose additionally that

\[
                     g(B)\leq\alpha M+\beta,\qquad n\geq n_0>0,     \tag{80.17}
\]

where \(\alpha,\beta,n_0\) are independent of \(M\).  Every survivor must
satisfy

\[
 s-2\alpha-1+{2(1-\beta)\over M}
       \leq\sqrt{\,g\left(1+{s\over n_0}\right)\,}.                 \tag{80.18}
\]

Put

\[
 \varepsilon=
 s-2\alpha-1-\sqrt{\,g\left(1+{s\over n_0}\right)\,}.              \tag{80.19}
\]

If \(\varepsilon>0\), then:

1. when \(\beta\leq1\), no degree \(M\) can occur;
2. when \(\beta>1\), every degree
   \[
                            M>{2(\beta-1)\over\varepsilon}          \tag{80.20}
   \]
   is impossible.

#### Proof

Equations (80.2) and (80.17) give

\[
 {R\over M}\geq2s-4\alpha+{4(1-\beta)\over M}.                     \tag{80.21}
\]

Since \(f=M/n\), equation (80.12) gives

\[
 {R\over M}\leq
 2+2\sqrt{\,g\left(1+{s\over n}\right)\,}
 \leq2+2\sqrt{\,g\left(1+{s\over n_0}\right)\,}.                   \tag{80.22}
\]

Combining (80.21)--(80.22) and dividing by two proves (80.18).
Equations (80.19)--(80.20) are a rearrangement. \(\square\)

The strict inequality \(\varepsilon>0\) is the structural bottleneck in
this asymptotic form.  A linear upper bound for \(g(B)\) is not enough by
itself: its slope must beat the explicit Rosati threshold in (80.19).
Likewise, a lower bound on the reduced projection degree \(n\) materially
strengthens the result.

## 4. The explicit \(M=7\) consequence

### Corollary 80.5 (the last septic row is impossible)

For the explicit curves of file 76, the cyclic quadratic plane-septic row
displayed in (79.30) cannot occur.

#### Proof

That row has

\[
             M=7,\qquad s=8,\qquad g=9,\qquad R=80.
\]

The curve \(X\) is nonhyperelliptic and \(J(X)\) is absolutely simple by
file 76.  Corollary 80.3 would give

\[
 R\leq14+2\sqrt{9\cdot7(7+8)}
     =14+6\sqrt{105}<80,
\]

contrary to \(R=80\). \(\square\)

Thus the exact scalar-window computation in file 79 is not needed to
eliminate \(M=7\).  It remains useful as a strictly finer sieve when the
cross-image degree has several possible divisors: scalarity adds the
divisibility condition \(f\mid\lambda\) and replaces Cauchy--Schwarz by an
exact one-dimensional norm.
