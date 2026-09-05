# A defect-free coefficient endpoint forces a pencil

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

**Dependency correction, 2026-09-04:** the general norm-zero lemma and
the argument for an actual normalized lower square remain valid. The
case-B application inherits the unproved quadratic-core assertion in
file 68 unless \([F\cap E':B]=2\) is assumed. See the
[FAIL audit](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md)
by `/root/c14_elliptic_translation`. The corrected square in
[file 81](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md)
uses the full orbit and may have more than two sign choices.

This note strengthens the all-degree coefficient sieve in file 68.  At
either endpoint where the shared ramification defect vanishes, the lower
curve has the same genus as \(Y\).  Absolute simplicity of \(J(Y)\) then
turns the norm correspondence into an isogeny.  Orthogonality to the
\(X\)-leg forces a low-degree pencil on \(X\).

The result is uniform in the prime ratio \(r\), the genera, and the diamond
degree \(M\).  It excludes all defect-free endpoints below
\(r\operatorname{gon}(X)\).

Let

\[
 g(X)=s+1,\qquad g(Y)=rs+1,                            \tag{73.1}
\]

and retain the prime-ratio diamond and hyperelliptic coefficient
construction of file 68:

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg p=r,\qquad \deg a=\deg c=M.                     \tag{73.2}
\]

Assume that \(J(Y)\) is absolutely simple.  Put

\[
                         h=p_*a^*:J(Y)\longrightarrow J(C).          \tag{73.3}
\]

As in Theorem 68.3,

\[
                              h\ne0,\qquad c_*h=0.                    \tag{73.4}
\]

## 1. A norm-zero lemma in arbitrary degree

The proof of Lemma 68.2 does not use primality of the degree.  We record
the version needed here.

### Lemma 73.1 (norm zero produces a pencil)

Let \(q:R\to D\) be a finite separable morphism of degree \(m\), and let
\(b:R\to X\) be a finite morphism.  If

\[
                          q_*b^*:J(X)\longrightarrow J(D)            \tag{73.5}
\]

vanishes, then \(X\) admits a morphism of degree \(m\) to
\(\mathbf P^1\).  In particular,

\[
                              \operatorname{gon}(X)\leq m.           \tag{73.6}
\]

#### Proof

The Rosati dual of (73.5) is the homomorphism induced by

\[
 D\longrightarrow\operatorname{Pic}^m(X),
 \qquad d\longmapsto\mathcal O_X\!\left(b_*q^*(d)\right).             \tag{73.7}
\]

If (73.5) vanishes, this map is constant.  The effective divisors in
(73.7) therefore move in one complete linear system of degree \(m\).
They are not a constant family, because \(b\) is surjective, and they have
no common base point: for fixed \(x\in X\), the parameters whose divisor
contains \(x\) lie in the finite set \(q(b^{-1}(x))\).  Two suitable
sections without a common zero define a degree-\(m\) morphism to
\(\mathbf P^1\).  \(\square\)

## 2. The square-root-is-spectral endpoint

In case A of Theorem 68.5, write

\[
 q:C\to B,\qquad \pi:E\to B,\qquad a_E:E\to Y,                         \tag{73.8}
\]

with degrees

\[
 \deg q=e,\qquad \deg\pi=r,\qquad \deg a_E=n=M/e.                     \tag{73.9}
\]

The curve \(V\) is the normalized fiber product \(C\times_B E\), and
\(a\) is induced by \(a_E\).

### Theorem 73.2 (case A endpoint)

If \(n=r\), then

\[
                              \operatorname{gon}(X)\leq e=M/r.       \tag{73.10}
\]

#### Proof

At \(n=r\), Theorem 68.5 gives

\[
                              g(B)=g(Y)                               \tag{73.11}
\]

and says that both \(C\to B\) and \(E\to B\) are étale.  Finite-flat
base change in the fiber square gives

\[
 h=q^*h_B,\qquad
 h_B=\pi_*a_E^*:J(Y)\longrightarrow J(B).                              \tag{73.12}
\]

Lemma 68.2 gives \(h_B\ne0\).  Since \(J(Y)\) is simple and
\(\dim J(Y)=\dim J(B)\), the map \(h_B\) is an isogeny.

Equations (73.4) and (73.12) imply

\[
                              c_*q^*=0                                \tag{73.13}
\]

in the rational homomorphism group: one may cancel the isogeny \(h_B\).
Taking Rosati duals gives \(q_*c^*=0\).  Lemma 73.1 applied to
\((q,c)\) proves (73.10).  \(\square\)

## 3. The quadratic-core endpoint

In case B of Theorem 68.5, write

\[
 q_D:C\to D,\qquad \pi_D:E'\to D,\qquad a_{E'}:E'\to Y,                \tag{73.14}
\]

with degrees

\[
 \deg q_D=m=M/d,\qquad \deg\pi_D=r,\qquad \deg a_{E'}=d.              \tag{73.15}
\]

File 68 proves

\[
 h=q_D^*h_D,\qquad
 h_D=(\pi_D)_*a_{E'}^*:J(Y)\longrightarrow J(D).                       \tag{73.16}
\]

### Theorem 73.3 (case B endpoint)

If \(d=r\), then

\[
                              \operatorname{gon}(X)\leq m=M/r.       \tag{73.17}
\]

#### Proof

At \(d=r\), Theorem 68.5 gives

\[
                              g(D)=g(Y)                               \tag{73.18}
\]

and says that both lower maps in the fiber square are étale.  It also
gives \(h_D\ne0\).  Simplicity and equality of dimensions make \(h_D\)
an isogeny.

Now (73.4) and (73.16) imply \(c_*q_D^*=0\).  Dualizing gives
\((q_D)_*c^*=0\), and Lemma 73.1 proves (73.17).  \(\square\)

### Corollary 73.4 (uniform endpoint exclusion)

In either case A or case B, a defect-free endpoint is impossible if

\[
                              M<r\operatorname{gon}(X).               \tag{73.19}
\]

For case A, “defect-free endpoint” means \(n=r\); for case B it means
\(d=r\).

### Corollary 73.5 (the first new row for an \(r=3\) redesign)

Suppose \(r=3\), \(X\) is nonhyperelliptic, and \(M=6\).  Then case B
with coefficient degree \(e=4\) is impossible.

#### Proof

Here the divisor relation \(ed=2M\) gives \(d=3=r\) and
\(m=e/2=2\).  Theorem 73.3 would give a degree-two pencil on \(X\), which
is equivalent to hyperellipticity.  \(\square\)

## 4. Scope

The theorem uses absolute simplicity only to conclude that a nonzero map
from \(J(Y)\) to an equal-dimensional Jacobian is an isogeny.  It remains
valid under the weaker explicit hypothesis that the relevant map \(h_B\)
or \(h_D\) is an isogeny.

This is an all-degree statement, but it concerns only the endpoint divisor
choices in Corollary 68.6.  Non-endpoint coefficient divisors and the
birational or quadratic choices \(e=1,2\) remain the principal infinite
families.
