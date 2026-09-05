# Multibranch interpolation and the canonical gluing exponent

**Status: independently audited PASS. 2026-09-05.**

Auditor: `abelian_p_index_group_audit`, 2026-09-05. No breaking
objections. The valuation-cluster interpolation proof, differential
application and global exponent bound all passed independent checks.
[Audit record](audits/102_MULTIBRANCH_INTERPOLATION_AND_CANONICAL_GLUING_EXPONENT_AUDIT.md).

This extends the gluing mechanism of file 101 to **every** singularity
of a bi-etale joint image. The bound depends on the number of branches
and their tangent ratios, not on the possibly enormous contact orders.
It is not yet an obstruction to all common covers: these two remaining
parameters are not bounded independently of the covering degree.

## 1. Integral interpolation from a pairwise valuation condition

### Lemma 102.1

Let \(R\) be a discrete valuation ring with uniformizer \(\pi\),
fraction field \(K\), and normalized valuation \(v\). Let
\(u_1,\ldots,u_r\in R\) be distinct and \(b_1,\ldots,b_r\in R\).
Suppose an integer \(L\ge r-1\) satisfies

\[
                 v(b_i-b_j)\ge L\,v(u_i-u_j)
                           \qquad(i\ne j).             \tag{102.1}
\]

Then the unique polynomial \(P\in K[y]\) of degree less than \(r\)
with \(P(u_i)=b_i\) belongs to \(R[y]\).

#### Proof

Induct on \(r\); the case \(r=1\) is immediate. Put

\[
 d=\min_{i\ne j}v(u_i-u_j),\qquad
 v_i=(u_i-u_1)/\pi^d,\qquad
 c_i=(b_i-b_1)/\pi^{Ld}.
\]

These elements belong to \(R\), and

\[
                       v(c_i-c_j)\ge L\,v(v_i-v_j).
                                                        \tag{102.2}
\]

Partition the \(v_i\) by their residue classes. There are at least
two classes by the definition of \(d\), so each class has fewer
than \(r\) elements. The induction hypothesis applied within each
class gives an integral interpolating polynomial for the \(c_i\)
in that class.

Let \(F_\alpha(y)=\prod_{i\in\alpha}(y-v_i)\) for the different
classes. The resultants of two different \(F_\alpha\) are units:
all differences between their roots are units. Hence these monic
polynomials generate pairwise comaximal ideals in \(R[y]\).
The Chinese remainder theorem, followed by monic division by their
product, gives \(Q\in R[y]\), \(\deg Q<r\), with
\(Q(v_i)=c_i\) for every \(i\).

Now

\[
                    b_1+\pi^{Ld}
                         Q\bigl((y-u_1)/\pi^d\bigr)   \tag{102.3}
\]

interpolates the original data. Its coefficients are integral:
the term of degree \(j\le r-1\) in \(Q\) introduces a denominator
of at most \(\pi^{jd}\), canceled by \(\pi^{Ld}\).
Uniqueness of interpolation proves the lemma. \(\square\)

## 2. A local differential power descends independently of contact orders

Work in characteristic \(p>0\). Suppose a reduced formal plane curve
has exactly \(r\ge2\) branches

\[
                        y=u_i(x),\qquad i=1,\ldots,r,
                                                        \tag{102.4}
\]

where all \(u_i\in xk[[x]]\) are distinct and all \(u_i'\) are units.
Its ring and normalization are

\[
 A=k[[x]][y]\big/\bigl(\prod_i(y-u_i)\bigr),
                     \qquad B=\prod_i k[[x]].          \tag{102.5}
\]

An element \((b_i)\in B\) belongs to \(A\) exactly when its
degree-\(<r\) interpolation polynomial in the nodes \(u_i\) has
integral coefficients. This follows by monic division, just as in
the two-branch case in file 101.

Let \(e\), prime to \(p\), kill all ratios of the nonzero constants
\(u_i'(0)\). Such an \(e\) exists over \(\overline{\mathbf F}_p\).
The canonical differential identification has coefficients
\((u_i')\) in the frame \(dx\otimes dy^{-1}\).

### Theorem 102.2

If \(q=p^a\ge2(r-1)\), then

\[
                         \bigl((u_i')^{eq}\bigr)_i
                                  \in A^\times.       \tag{102.6}
\]

If every pair with contact order at least two has contact order
divisible by \(p\), the weaker condition \(q\ge r-1\) suffices.

#### Proof

Put \(m_{ij}=v_x(u_i-u_j)\ge1\).

If \(m_{ij}=1\), the choice of \(e\) makes the constant terms of
\((u_i')^e,(u_j')^e\) equal, so their difference has valuation at
least one. Taking the \(q\)-th power multiplies this valuation by
\(q\).

If \(m_{ij}\ge2\), differentiation gives

\[
                   v_x(u_i'-u_j')\ge m_{ij}-1.
\]

Taking the \(e\)-th powers cannot lower this valuation. Taking the
\(q\)-th powers then gives

\[
 v_x\bigl((u_i')^{eq}-(u_j')^{eq}\bigr)
                         \ge q(m_{ij}-1)
                         \ge (r-1)m_{ij},             \tag{102.7}
\]

where the last inequality uses \(q\ge2(r-1)\) and \(m_{ij}\ge2\).
For \(m_{ij}=1\) the same final bound follows from the first case.
Lemma 102.1, with \(L=r-1\), proves (102.6). All its branch values
are units with the same nonzero residue, so the descended element
is a unit of the local ring \(A\).

For the sharper assertion, if \(p\mid m_{ij}\ge2\), differentiation
kills the leading term and gives
\(v_x(u_i'-u_j')\ge m_{ij}\). Hence \(q\ge r-1\) suffices for
these pairs and for the pairs with \(m_{ij}=1\). \(\square\)

## 3. Global consequence for all bi-etale correspondences

Use the hypotheses and notation of file 101:
\(\operatorname{Hom}(J(X),J(Y))=0\), and \(Z\) is the normalization
of its joint image \(C\subset X\times Y\), with both projections
finite etale. Let \(t(C)\) be its canonical gluing order.

Let \(R\) be the largest number of branches at a point of \(C\).
One necessarily has \(R\ge2\): every branch is a graph, so if
\(R=1\) the image would be smooth, contradicting the positive
normalization defect \(d_Xd_Y+s_Xd_X\) in Theorem 100.4.

At every singular point and for every pair of branches, form the
ratio of their nonzero slopes in local product coordinates. Changing
either coordinate multiplies all slopes at that point by the same
nonzero scalar, so these ratios are intrinsic. Let \(e\) be the
least common multiple of their multiplicative orders. Define

\[
                q_R=p^{\lceil\log_p(2(R-1))\rceil}.    \tag{102.8}
\]

### Corollary 102.3

The prime-to-\(p\) part of \(t(C)\) is exactly \(e\), and

\[
                         t(C)\mid e q_R.               \tag{102.9}
\]

In particular,

\[
 d_Y\le2s_X e q_R,\qquad d_X\le2s_Y e q_R,
                 \qquad g(Z)-1\le2s_Xs_Y e q_R.        \tag{102.10}
\]

#### Proof

Theorem 102.2 makes \(\tau^{e q_R}\) descend at every singular
point; it already descends at smooth points. Thus it descends
globally and (102.9) follows.

Conversely, descent of \(\tau^n\) requires equality of the residue
values on all branches at every point. It therefore forces every
slope ratio to have \(n\)-th power one, so \(e\mid n\). Together
with (102.9) this identifies the prime-to-\(p\) part. The degree
bounds are Theorem 101.1. \(\square\)

If all the higher contact orders are divisible by \(p\), one may
replace \(q_R\) by \(p^{\lceil\log_p(R-1)\rceil}\).
The exact result for two branches in Proposition 101.2 is sharper
than this general upper bound, and is retained.

### Quantitative interpretation

Since \(q_R<2p(R-1)\), every such common cover satisfies

\[
                         d_Y<4ps_X e(R-1).             \tag{102.11}
\]

Consequently, an unbounded sequence of primitive common-cover
degrees cannot have both bounded branch multiplicity and bounded
combined tangent-ratio order. Increasing only the contact orders
between a bounded number of branches does not evade this bound.

For the current genera \((9,25)\) and \(p=5\), with \(N=d_Y\),

\[
           N\le16e\,5^{\lceil\log_5(2(R-1))\rceil}
                         <160e(R-1).                   \tag{102.12}
\]

If the tangent ratios lie in a fixed finite field \(\mathbf F_q\),
then \(e\mid q-1\). This still does not follow merely from defining
the two original curves over that field.

## 4. Scope and next question

The local interpolation lemma and its differential application are
independent of genus, monodromy group and contact orders. The global
degree bound uses the absence of homomorphisms between the two
Jacobians, but no Galois hypothesis on either leg.

What is missing is a bound or incompatibility for the *remaining*
data on a fixed product: large branch multiplicities and large
combined tangent-ratio orders. The current estimates allow both.
Thus (102.10) is a necessary condition for actual common covers,
not a solution of the full problem.
