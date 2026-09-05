# The orthogonal-complement divisor sieve

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

**Dependency correction, 2026-09-04:** Lemma 75.1 and case A are valid
as stated. Case B and its displayed divisor list require an actual
quadratic core, which file 68 did not establish in general. See the
[FAIL audit](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md)
by `/root/c14_elliptic_translation`. Theorem 81.2 in
[file 81](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md)
proves the corresponding bound for the corrected full-orbit square.

This note strengthens the divisor sieve of file 68 and the endpoint theorem
of file 73.  In either branch of the square-root dichotomy, the norm
construction puts a copy of \(J(Y)\) in the Jacobian of the lower
coefficient curve.  The pushforward of \(J(X)\) to that curve is orthogonal
to this copy.  If \(J(X)\) is simple, that pushforward is either zero or has
the full dimension of \(J(X)\).  The zero case forces a pencil on \(X\);
the nonzero case forces two large orthogonal blocks to fit in the lower
Jacobian.

The result is an all-degree numerical refinement:

\[
 \begin{array}{ll}
 \text{case A:}& e\geq\operatorname{gon}(X)\quad\text{or}\quad n\geq r+2,\\
 \text{case B:}& m\geq\operatorname{gon}(X)\quad\text{or}\quad d\geq r+2.
 \end{array}                                                           \tag{75.1}
\]

Thus the quotient degrees \(r\) and \(r+1\) can occur only when the
complementary degree is at least the gonality of \(X\).

Retain the notation and hypotheses of file 68:

\[
 g(X)=s+1,\qquad g(Y)=rs+1,                                            \tag{75.2}
\]

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg p=r,\qquad \deg a=\deg c=M,                                     \tag{75.3}
\]

where \(Y\) is hyperelliptic, \(J(Y)\) is absolutely simple, and

\[
                         h=p_*a^*:J(Y)\longrightarrow J(C)             \tag{75.4}
\]

is nonzero with \(c_*h=0\).

Assume additionally that \(J(X)\) is absolutely simple, and put

\[
                              \gamma=\operatorname{gon}(X).            \tag{75.5}
\]

## 1. The common orthogonal-complement lemma

### Lemma 75.1

Suppose that the coefficient construction supplies a normalized fiber
square and a factorization

\[
 \begin{array}{ccc}
 V&\longrightarrow&R\\
 \big\downarrow&&\big\downarrow\\[-2mm]
 C&\xrightarrow{q_0}&D,
 \end{array}
 \qquad
 h=q_0^*h_0,                                                           \tag{75.6}
\]

where \(q_0:C\to D\) is finite separable of degree \(m_0\) and

\[
             0\ne h_0:J(Y)\longrightarrow J(D).                        \tag{75.7}
\]

Then either

\[
                              \gamma\leq m_0,                           \tag{75.8}
\]

or

\[
                              g(D)\geq g(Y)+g(X)=(r+1)s+2.              \tag{75.9}
\]

#### Proof

Let

\[
                         v=(q_0)_*c^*:J(X)\longrightarrow J(D).        \tag{75.10}
\]

If \(v=0\), Lemma 73.1 applied to \((q_0,c)\) produces a degree-\(m_0\)
pencil on \(X\), proving (75.8).

Suppose \(v\ne0\).  Since \(J(X)\) is simple, \(v\) has finite kernel and
its image has dimension \(g(X)\).  Since \(J(Y)\) is simple and \(h_0\ne0\),
the image of \(h_0\) has dimension \(g(Y)\).  The two images are
orthogonal.  Indeed,

\[
 v^\dagger h_0=c_*q_0^*h_0=c_*h=0.                                   \tag{75.11}
\]

Their intersection is therefore finite, and both fit in \(J(D)\).  This
gives (75.9).  \(\square\)

## 2. Applying the lemma in case A

In case A of Theorem 68.5, write

\[
 q:C\to B,\qquad \pi:E\to B,\qquad a_E:E\to Y,                         \tag{75.12}
\]

and

\[
 \deg q=e,\qquad \deg\pi=r,\qquad
 \deg a_E=n=M/e.                                                       \tag{75.13}
\]

Finite-flat base change in the normalized fiber square gives

\[
 h=q^*h_B,\qquad
 h_B=\pi_*a_E^*:J(Y)\longrightarrow J(B).                              \tag{75.14}
\]

Lemma 68.2 gives \(h_B\ne0\), and Theorem 68.5 gives

\[
                              g(B)\leq ns+1.                           \tag{75.15}
\]

### Theorem 75.2 (case A refinement)

In case A,

\[
                    e\geq\gamma\qquad\text{or}\qquad n\geq r+2.       \tag{75.16}
\]

Equivalently, if \(n\in\{r,r+1\}\), then \(e\geq\gamma\).

#### Proof

If \(e<\gamma\), Lemma 75.1 and (75.15) give

\[
                    (r+1)s+2\leq g(B)\leq ns+1.
\]

Thus

\[
                              (n-r-1)s\geq1,
\]

which forces \(n\geq r+2\).  \(\square\)

## 3. Applying the lemma in case B

In case B of Theorem 68.5, write

\[
 q_D:C\to D,\qquad \pi_D:E'\to D,\qquad a_{E'}:E'\to Y,                \tag{75.17}
\]

and

\[
 \deg q_D=m=M/d,\qquad \deg\pi_D=r,\qquad
 \deg a_{E'}=d.                                                       \tag{75.18}
\]

File 68 proves

\[
 h=q_D^*h_D,\qquad
 0\ne h_D=(\pi_D)_*a_{E'}^*:J(Y)\longrightarrow J(D),                 \tag{75.19}
\]

and

\[
                              g(D)\leq ds+1.                           \tag{75.20}
\]

### Theorem 75.3 (case B refinement)

In case B,

\[
                    m\geq\gamma\qquad\text{or}\qquad d\geq r+2.       \tag{75.21}
\]

Equivalently, if \(d\in\{r,r+1\}\), then \(m\geq\gamma\).

#### Proof

Apply Lemma 75.1 with \(q_0=q_D\), and combine (75.9) with (75.20).
If \(m<\gamma\), the resulting inequality is

\[
                     (r+1)s+2\leq ds+1,
\]

so \(d\geq r+2\).  \(\square\)

## 4. Refined all-degree divisor list

### Corollary 75.4

Under the hypotheses above, every coefficient degree in Corollary 68.6
obeys one of the following stronger alternatives.

1. In case A there is a divisor \(n\mid M\) with \(n\geq r\),
   \[
                         e=M/n,\qquad d_{\mathrm{coeff}}=2n,
   \]
   and
   \[
                         M/n\geq\gamma\quad\text{or}\quad n\geq r+2.
                                                                         \tag{75.22}
   \]

2. In case B there is a divisor \(d\mid M\) with \(d\geq r\),
   \[
                         e_{\mathrm{coeff}}=2M/d,\qquad m=M/d,
   \]
   and
   \[
                         M/d\geq\gamma\quad\text{or}\quad d\geq r+2.
                                                                         \tag{75.23}
   \]

In particular, the defect-free endpoint \(n=r\) or \(d=r\), and also the
near-endpoint \(r+1\), are impossible whenever the complementary divisor
of \(M\) is smaller than \(\gamma\).

### Example 75.5 (the \(r=3\), \(\gamma\geq3\) initial rows)

For a nonhyperelliptic \(X\), one has \(\gamma\geq3\).  At \(M=6\), the
case-A choice \((e,n)=(2,3)\) and the case-B choice \((m,d)=(2,3)\)
are impossible.  At \(M=8\), the case-A choice \((e,n)=(2,4)\) and the
case-B choice \((m,d)=(2,4)\) are impossible.  These conclusions are
independent of equations for \(X\) and \(Y\).

## 5. Scope

The new test is strongest near the lower divisor endpoint and when \(X\)
has high gonality.  It is genuinely all-degree, but it does not remove
the persistent choices \(e_{\mathrm{coeff}}=1,2\), nor divisors for which
both factors are large.  Those remain the main infinite families.

As in file 73, absolute simplicity can be weakened: it is enough that
\(h_0\) have finite kernel and that every nonzero map
\(J(X)\to J(D)\) under consideration have finite kernel.
