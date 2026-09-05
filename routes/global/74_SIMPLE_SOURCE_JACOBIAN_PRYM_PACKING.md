# Prym packing for a simple source Jacobian

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

This note strengthens file 71.  In the quadratic coefficient case, a
nonhyperelliptic curve \(X\) with absolutely simple \(J(X)\) supplies two
full-dimensional pieces: one invariant and one anti-invariant under the
coefficient involution.  The anti-invariant piece must be orthogonal to the
large copy of \(J(Y)\) supplied by the norm.  This gives a uniform genus
interval and eliminates the first admissible diamond degree without any
endomorphism-lattice calculation.

File 71 is retained until this stronger theorem receives an independent
audit.

Let \(k\) be algebraically closed of characteristic different from \(2\),
let \(r\ne\operatorname{char}k\) be an odd prime, and put

\[
             g(X)=s+1,\qquad g(Y)=rs+1,\qquad s\geq1.                 \tag{74.1}
\]

Assume the prime-ratio diamond and hyperelliptic coefficient construction
of file 68:

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg p=r,\qquad \deg a=\deg c=M,                                    \tag{74.2}
\]

where \(p\) is a \(C_r\)-torsor and \(a\beta\ne a\).  Suppose that
\(J(Y)\) is absolutely simple and that the norm-coefficient map is
quadratic:

\[
                        q:C\longrightarrow B,\qquad \deg q=2.        \tag{74.3}
\]

Write \(\delta\) for the involution of \(q\), and assume that the
hyperelliptic square root is not in the spectral field, i.e. case B of
Theorem 68.5.  Put

\[
 h=p_*a^*:J(Y)\longrightarrow J(C),\qquad A=\operatorname{im}h.      \tag{74.4}
\]

File 68 gives

\[
 \dim A=rs+1,\qquad c_*h=0,\qquad q_*h=0,                             \tag{74.5}
\]

and hence

\[
 A\subseteq\operatorname{Prym}(C/B),\qquad \delta^*|_A=-1.           \tag{74.6}
\]

## 1. The invariant copy

### Lemma 74.1

Assume that \(X\) is nonhyperelliptic and \(J(X)\) is absolutely simple.
Then

\[
                         q_*c^*:J(X)\longrightarrow J(B)             \tag{74.7}
\]

is nonzero and has finite kernel.  In particular,

\[
                              g(B)\geq g(X)=s+1.                      \tag{74.8}
\]

#### Proof

If \(q_*c^*=0\), then

\[
             (1+\delta^*)c^*=q^*q_*c^*=0.                            \tag{74.9}
\]

Thus \((c\delta)^*=-c^*\).  Lemma 71.1 would make \(X\)
hyperelliptic, a contradiction.  Hence (74.7) is nonzero.  The connected
kernel of a nonzero homomorphism out of the simple abelian variety \(J(X)\)
is zero, so its kernel is finite.  Its image has dimension \(s+1\), which
proves (74.8).  \(\square\)

## 2. The anti-invariant copy

### Lemma 74.2

Retain the hypotheses of Lemma 74.1 and suppose that \(q\) is ramified.
Then

\[
                 (1-\delta^*)c^*:J(X)\longrightarrow
                    \operatorname{Prym}(C/B)                         \tag{74.10}
\]

is nonzero, has finite kernel, and its image is orthogonal to \(A\).
Consequently

\[
                              g(B)\leq(M-r-1)s-1.                     \tag{74.11}
\]

#### Proof

If (74.10) vanished, then \((c\delta)^*=c^*\).  Lemma 71.1 would give
\(c\delta=c\), so \(c\) would factor through \(q\).  This is impossible:
at a ramification point of the tame double cover \(q\), the composite of
\(q\) with any map from \(B\) is ramified, whereas \(c\) is étale.
Thus (74.10) is nonzero.  Simplicity of \(J(X)\) again makes its kernel
finite, so its image has dimension \(s+1\).

The image lies in the Prym because it is anti-invariant.  It is orthogonal
to \(A\): equation (74.5) makes \(c^*J(X)\) orthogonal to \(A\), and
self-adjointness of \(\delta^*\), together with \(\delta^*|_A=-1\), gives
the same for \(\delta^*c^*J(X)\).  The two orthogonal abelian subvarieties
have finite intersection, so

\[
 \begin{aligned}
 \dim\operatorname{Prym}(C/B)
    &=g(C)-g(B)\\
    &\geq (rs+1)+(s+1).
 \end{aligned}                                                        \tag{74.12}
\]

Since \(g(C)=Ms+1\), this is exactly (74.11).  \(\square\)

### Theorem 74.3 (uniform ramified quadratic interval)

If \(X\) is nonhyperelliptic, both \(J(X)\) and \(J(Y)\) are absolutely
simple, and the quadratic coefficient map is ramified, then necessarily

\[
                    s+1\leq g(B)\leq(M-r-1)s-1.                      \tag{74.13}
\]

In particular, such a quadratic coefficient map cannot exist when

\[
                              (M-r-2)s<2.                             \tag{74.14}
\]

Thus it never exists at

\[
                              M=r+2.                                 \tag{74.15}
\]

It also never exists at \(M=r+3\) when \(g(X)=2\).

#### Proof

The genus interval is Lemmas 74.1 and 74.2.  It is nonempty only if

\[
 s+1\leq(M-r-1)s-1,
\]

which is equivalent to \((M-r-2)s\geq2\).  \(\square\)

## 3. The unramified alternative

### Proposition 74.4

Under the hypotheses of Lemma 74.1, if \(q\) is unramified, then

\[
                              g(B)=\frac{Ms}{2}+1.                    \tag{74.16}
\]

Case B of Theorem 68.5 also gives \(g(B)\leq(M-r)s\).  Consequently an
unramified quadratic coefficient map requires

\[
                              (M-2r)s\geq2.                            \tag{74.17}
\]

In particular, it is impossible at \(M=r+2\).

#### Proof

The first identity is étale Riemann--Hurwitz for \(q:C\to B\):

\[
                              g(C)-1=2(g(B)-1).
\]

Substitution of \(g(C)-1=Ms\), followed by the genus bound from Theorem
68.5, gives

\[
 \frac{Ms}{2}+1\leq(M-r)s,
\]

which is (74.17).  \(\square\)

### Corollary 74.5 (quadratic coefficients at the first degree)

Assume that \(X\) is nonhyperelliptic and that both \(J(X)\) and \(J(Y)\)
are absolutely simple.  Then no prime-ratio diamond of degree \(M=r+2\)
has coefficient degree two.

#### Proof

Because \(M=r+2\) is odd, case A of Theorem 68.5 cannot occur with
coefficient degree \(e=2\): case A requires \(e\mid M\).  Thus one is in
case B.  The ramified case is excluded by Theorem 74.3 and the unramified
case by Proposition 74.4.  \(\square\)

### Corollary 74.6 (a cleaner first-degree design criterion)

Assume the hypotheses of the universal prime-ratio and hyperelliptic norm
theorems in file 68.  Suppose additionally that

1. \(X\) is nonhyperelliptic;
2. \(J(X)\) is absolutely simple; and
3. \(s\geq2r+2\).

Then no prime-ratio diamond can have degree \(M=r+2\).

#### Proof

Corollary 68.6 leaves only coefficient degrees one and two.  Degree two is
excluded by Corollary 74.5.  Degree one is excluded by Lemma 71.4, since
\(s\geq2r+2>2(r+2)-3\).  \(\square\)

## 4. What this changes

For the first admissible degree, the finite scalar-window condition in
file 71 can be replaced by the conceptually simpler hypothesis that
\(J(X)\) is absolutely simple.  This condition is compatible with working
over \(\overline{\mathbf F}_5\): unlike
\(\operatorname{End}(J(X))=\mathbf Z\), absolute simplicity does not
assert that the endomorphism ring is small.

The theorem is uniform in \(M\), but its interval widens as \(M\) grows.
It therefore controls a high-genus band rather than all quadratic rows.
The persistent all-degree cases are the birational coefficient map and
quadratic coefficient curves with

\[
                 s+1\leq g(B)\leq(M-r-1)s-1,
\]

together with the unramified possibilities beginning at (74.17).
