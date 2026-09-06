# Separable norm recovery from pluricanonical trace moments

Date: 2026-09-05. Author: root. Status: elementary author proof, with
finite-field exact-arithmetic checks. Not independently audited.
This is a finite, degree-dependent reconstruction theorem, not an
obstruction to common etale covers.

## 1. A characteristic-free finite moment theorem

Let \(L\) be any field, let \(\lambda_1,\ldots,\lambda_b\) be pairwise
distinct elements of an extension field, and suppose their power sums
\[
 s_j=\sum_{i=1}^b\lambda_i^j
\]
belong to \(L\). It suffices below to assume this for \(0\le j<2b\).
Set \(s_0=b\), interpreted in \(L\).

**Theorem 1.** The Hankel matrix
\[
 H=(s_{i+j})_{0\le i,j<b}
\]
is invertible. The \(2b\) moments \(s_0,\ldots,s_{2b-1}\) determine the
monic polynomial
\[
 \chi(z)=\prod_i(z-\lambda_i)
           =z^b+\sum_{j=0}^{b-1}c_jz^j.
\]
Its coefficients are the unique solution of
\[
 H(c_0,\ldots,c_{b-1})^{\mathsf t}
       =-(s_b,\ldots,s_{2b-1})^{\mathsf t}.              \tag{1}
\]
In particular the recovered polynomial belongs to \(L[z]\). There is
no restriction on the characteristic or on its divisibility into \(b\).

**Proof.** Put \(V_{ij}=\lambda_j^i\) for \(0\le i<b\),
\(1\le j\le b\). Then \(H=VV^{\mathsf t}\), so
\[
 \det H=(\det V)^2=\prod_{i<j}(\lambda_j-\lambda_i)^2\ne0.
                                                               \tag{2}
\]
Multiplying \(\chi(\lambda_i)=0\) by \(\lambda_i^r\), and summing over
\(i\), gives (1) for \(0\le r<b\). Invertibility proves uniqueness and
membership in \(L\). \(\square\)

The same calculation proves that the full moment sequence has minimal
linear-recurrence order exactly \(b\), with recurrence polynomial
\(\chi\). Indeed an annihilating polynomial \(q\) of smaller degree
would give
\(\sum_i q(\lambda_i)\lambda_i^r=0\) for \(0\le r<b\).
Invertibility of \(V\) forces \(q(\lambda_i)=0\) for every \(i\),
contradicting its degree.

Although (2) is a discriminant identity, no positivity of the Hankel
matrix is intended in characteristic \(p\). Even its top-left entry
may be zero when \(p\mid b\).

## 2. Apply this to one actual joint-minimal correspondence

Let \(X\leftarrow C\to Y\) be a joint-minimal bi-etale span as in
[the fixed-weight norm theorem](FIXED_WEIGHT_NORMS_AND_COMMUTING_CANONICAL_RING_REALIZATION.md),
with right degree \(b\). Choose a basis \(v_1,\ldots,v_h\) of
\(H^0(X,\omega_X^3)\), independent indeterminates \(u_1,\ldots,u_h\),
and the universal section \(s=\sum u_iv_i\). Choose a nonzero rational
differential \(\eta\) on \(Y\).

Multiplication by \(\kappa^3 f^*s/\eta^3\) on the generic etale algebra
gives a matrix \(A_s\) over \(L=k(Y)(u_1,\ldots,u_h)\). Its eigenvalues
are distinct and nonzero. To verify this, split the etale algebra
geometrically. The eigenvalues are linear forms in the \(u_i\).
Their projective classes are the distinct tricanonical points of
the generic fiber in \(X\). Thus none is zero and no two linear
forms are identical.

The moments are precisely
\[
 s_j=\operatorname{tr}(A_s^j)
       =\frac{T_{3j}(s^j)}{\eta^{3j}}.                  \tag{3}
\]
Therefore knowledge of the operators \(T_{3j}\) for
\(1\le j\le 2b-1\), together with the integer \(b\), reconstructs
\(\det(z-A_s)\), hence its determinant, hence the universal
tricanonical norm polynomial. The latter determines the actual
joint image by the audited fixed-weight norm theorem.

This uses evaluations on the universal pure powers \(s^j\); it never
uses polarization divided by \(j!\). The computation is over the
rational parameter field, where the nonzero discriminant can be
inverted. The resulting norm is the polynomial law already defined
geometrically, so no poles in the parameters are introduced into
that final law.

Consequently the generic diagonal higher-trace sequence has exactly
as many independent recurrence modes as the right covering degree.
It is a sum of the \(b\) simple sequences \(\lambda_i^j\) after a
geometric field extension. The eigenvalues need not be globally
labelable; this is not a global splitting of the cover.

## 3. Why the usual characteristic-p ambiguity is not a contradiction

For \(Q(t)=\det(1-tA_s)\) one has
\[
 -tQ'(t)/Q(t)=\sum_{j\ge1}s_jt^j.
                                                               \tag{4}
\]
Over characteristic \(p\), multiplying \(Q\) by a \(p\)-th power
does not change the right side. Such multiplication introduces
root multiplicities divisible by \(p\). The reconstruction theorem
avoids this ambiguity by requiring the original \(b\) eigenvalues
to be distinct and using the known value of \(b\).

For a repeated cycle this hypothesis fails, and ordinary trace
moments recover multiplicities only modulo \(p\). The norm theorem
itself still records integer multiplicities in that case.

More generally, nonzero weights \(w_i\) give moments
\(\sum_i w_i\lambda_i^j\) and the determinant
\[
 \det H=\left(\prod_i w_i\right)
                    \prod_{i<j}(\lambda_j-\lambda_i)^2.
                                                               \tag{5}
\]
Thus the only loss at the level of a generic weighted finite fiber
is an actually zero weight, not divisibility of the total degree.

## 4. An initial vanishing window cannot exceed the degree

Assume the distinct \(\lambda_i\) are nonzero. Some \(s_j\), with
\(1\le j\le b\), is nonzero. In positive characteristic the first such
index is not divisible by \(p\); in particular it is at most \(b-1\)
if \(p\mid b\).

Indeed, write \(Q(t)=1+q_1t+\cdots+q_bt^b\). If all these first \(b\)
power sums vanished, (4) would imply \(Q'=0\): its possible nonzero
terms are already detected by those coefficients. But a nonconstant
polynomial with zero derivative has repeated roots over an algebraic
closure, contrary to the distinct nonzero eigenvalues. Finally,
\(s_{pj}=s_j^p\), so a first nonzero index cannot be divisible by \(p\).

For the universal tricanonical section this implies that some
\(T_{3j}(s^j)\) is nonzero in that range. This is a statement about
diagonal pure-power tests; the earlier interpolation theorem can
detect general sections at better weights. Neither bound is uniform
in the covering degree.

## 5. Exact checks and the remaining limitation

An ephemeral exact-arithmetic program tested Theorem 1 for all
\(1\le b\le30\) over
\(\mathbf F_{125}=\mathbf F_5[t]/(t^3+t+1)\), choosing \(b\) distinct
nonzero roots. For every degree it inverted \(H\), recovered the
coefficients by (1), and verified vanishing of the recovered monic
polynomial at every prescribed root. Degrees \(5,10,15,20,25,30\)
all passed although \(s_0=0\). No persistent computation or
example-search script was added.

The geometric content remains the existence of the actual etale
algebra and both maps. A recurrence of order \(b\) is completely
consistent with arbitrarily large \(b\). A useful nonexistence
argument would need an independent restriction on the mixed moments
or their allowed eigenvalue families for our chosen endpoint curves.
No such restriction is proved here.
