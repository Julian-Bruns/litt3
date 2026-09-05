# Canonical gluing order and a large-degree bound

**Status: independently audited PASS. 2026-09-04.**

Auditor: `abelian_p_index_group_audit`, 2026-09-04. No breaking
objections; optional suggestions concern exposition of the see-saw
cross-term and the completion test for descent.
[Audit record](audits/101_CANONICAL_GLUING_ORDER_AND_LARGE_DEGREE_BOUND_AUDIT.md).

This is a parameterized obstruction for genuine common **etale** covers.
Both maps and their differential identifications remain on the same
normalization throughout. It does not exclude all common covers: the
orders of tangent ratios, and singularities with three or more branches,
are not bounded here.

All curves are smooth, projective and connected over
\(k=\overline{\mathbf F}_p\), except the possibly singular joint image.
Put \(s_X=g(X)-1>0\), \(s_Y=g(Y)-1>0\), and assume

\[
                  \operatorname{Hom}(J(X),J(Y))=0.
                                                        \tag{101.1}
\]

Start with a common finite etale cover and replace it by the
normalization of its joint image, as in Proposition 100.1. Thus

\[
 C\subset X\times Y,\qquad \nu:Z\longrightarrow C,
 \qquad f:Z\longrightarrow X,\quad g:Z\longrightarrow Y
\]

have \(f,g\) finite etale, and \(\nu\) is birational. Write
\(d_X=\deg f\), \(d_Y=\deg g\). Necessarily

\[
                         s_Xd_X=s_Yd_Y.                 \tag{101.2}
\]

## 1. The invariant records gluing, not merely a differential divisor

On \(S=X\times Y\) define

\[
 M=\operatorname{pr}_X^*\omega_X\otimes
                         \operatorname{pr}_Y^*\omega_Y^{-1}.
\]

The two etale differential maps give a specified trivialization
\(\tau\) of \(\nu^*(M|_C)\). More precisely, viewed as a section
of \(\operatorname{Hom}(g^*\omega_Y,f^*\omega_X)\), it is
\((df)^{-1}\circ dg\).

The degree of \(M|_C\) is zero by (101.2). It is therefore a point
of the generalized Jacobian \(\operatorname{Pic}^0(C)\). Every such
point over \(\overline{\mathbf F}_p\) is torsion: the curve and the
point descend to some finite field, and the rational points of its
finite-type group scheme form a finite group.

Define the **canonical gluing order**

\[
             t(C)=\operatorname{ord}_{\operatorname{Pic}(C)}(M|_C).
                                                        \tag{101.3}
\]

Equivalently, \(t(C)\) is the least positive integer \(n\) for which
\(\tau^n\) descends from the normalization to a nowhere-vanishing
section of \(M^n|_C\). To see the equivalence, any trivialization on
\(C\) pulls back to a constant multiple of \(\tau^n\), since the
only global units on \(Z\) are \(k^\times\).

Thus triviality on the normalization is automatic, whereas triviality
on the singular image is an additional, measurable condition.

## 2. Gluing order must grow with the degree

### Theorem 101.1

For every positive integer \(n\) such that \(M^n|_C\simeq\mathcal O_C\),

\[
                     d_Y\le 2ns_X,\qquad d_X\le 2ns_Y.
                                                        \tag{101.4}
\]

In particular,

\[
 t(C)\ge
   \left\lceil\frac{d_Y}{2s_X}\right\rceil
 = \left\lceil\frac{d_X}{2s_Y}\right\rceil,
 \qquad
             g(Z)-1\le 2t(C)s_Xs_Y.                    \tag{101.5}
\]

#### Proof

Hypothesis (101.1) implies that

\[
                    \mathcal O_S(C)\simeq A\boxtimes B,
                  \qquad \deg A=d_Y,\quad \deg B=d_X.  \tag{101.6}
\]

Indeed, restricting the line bundle to the fibers over \(X\) gives
a morphism \(X\to\operatorname{Pic}^{d_X}(Y)\). After translation
by its value at a base point, this factors through a homomorphism
\(J(X)\to J(Y)\), which is zero. The see-saw principle then gives
(101.6).

Use the restriction sequence

\[
 0\longrightarrow M^n(-C)\longrightarrow M^n
                \longrightarrow M^n|_C\longrightarrow0.
                                                        \tag{101.7}
\]

The space \(H^0(S,M^n)\) is zero, since its \(Y\)-factor has negative
degree. Under the assumption of the theorem,
\(H^0(C,M^n|_C)=k\), so (101.7) implies

\[
                         H^1(S,M^n(-C))\ne0.
\]

By (101.6) and the Kunneth formula this space is

\[
 H^0(X,\omega_X^n\otimes A^{-1})\otimes
 H^1(Y,\omega_Y^{-n}\otimes B^{-1}).                    \tag{101.8}
\]

The other Kunneth summand is zero because
\(\deg(\omega_Y^{-n}\otimes B^{-1})<0\). In particular,
\(H^0(X,\omega_X^n\otimes A^{-1})\ne0\), which gives
\(d_Y\le 2ns_X\). Applying the same argument to \(M^{-n}\), with
the two factors exchanged, gives \(d_X\le2ns_Y\).
Now use (101.2) and Riemann--Hurwitz. \(\square\)

The proof actually gives the stronger necessary effectivity conditions
\(\omega_X^n\otimes A^{-1}\ge0\) and
\(\omega_Y^n\otimes B^{-1}\ge0\), not just their degree inequalities.

## 3. Exact local orders at every two-branch singularity

Since both maps on the normalization are etale, every formal branch
of \(C\) is smooth and is a graph over either coordinate. A
unibranch point is therefore smooth. Suppose a singular point has
exactly two branches. In local coordinates \(x,y\) these are

\[
                         y=u(x),\qquad y=v(x),
\]

where \(u(0)=v(0)=0\) and \(u',v'\) are units. Its completed local
ring, inside the normalization, is

\[
 \widehat{\mathcal O}_{C,P}
  =\{(a,b)\in k[[x]]\oplus k[[x]]:
                                 a-b\in(u-v)k[[x]]\}.   \tag{101.9}
\]

For completeness, reduction modulo the monic polynomial
\((y-u)(y-v)\) expresses every element as \(A(x)+B(x)y\).
Its two values differ by \(B(x)(u-v)\); conversely every pair in
the right side has this form. This proves (101.9).

In the frame \(dx\otimes dy^{-1}\) of \(M\), the two coefficients
of \(\tau\) are \(u'\) and \(v'\). Consequently

\[
 \tau^n\text{ descends at }P
       \quad\Longleftrightarrow\quad
                     u'^{,n}-v'^{,n}\in(u-v)k[[x]].  \tag{101.10}
\]

### Proposition 101.2

Let \(m=\operatorname{ord}_x(u-v)\), the intersection multiplicity
of the two branches.

1. If \(m=1\), the local gluing order is the multiplicative order
   of \(\lambda=u'(0)/v'(0)\in k^\times\). This is an ordinary
   node and \(\lambda\ne1\).
2. If \(m\ge2\) and \(p\mid m\), the local gluing order is one.
3. If \(m\ge2\) and \(p\nmid m\), the local gluing order is exactly
   \(p\).

These orders do not grow with the tangency multiplicity.

#### Proof

For \(m=1\), congruence (101.10) is just equality of the constant
terms, equivalently \(\lambda^n=1\).

For \(m\ge2\), the two derivative constants coincide. If \(p\mid m\),
differentiating \(u-v\) kills its leading term and gives
\(\operatorname{ord}_x(u'-v')\ge m\), including the possibility
that the derivative is zero. Thus \(n=1\) works.

If \(p\nmid m\), this derivative has order \(m-1\). Write
\(n=p^a b\) with \(p\nmid b\). The equality of the nonzero
derivative constants implies

\[
          \operatorname{ord}_x(u'^{,n}-v'^{,n})
                             =p^a(m-1).                \tag{101.11}
\]

This is at least \(m\) exactly when \(a\ge1\): here
\(p(m-1)\ge m\) for \(m\ge2\). Thus (101.10) holds exactly
when \(p\mid n\). \(\square\)

## 4. A whole geometric class has bounded degree

Assume every singular point of \(C\) has exactly two branches.
Let \(e\) be the least common multiple of the multiplicative orders
of the tangent ratios at its ordinary nodes; put \(e=1\) if there
are no ordinary nodes. Define \(\epsilon=1\) if some tangency has
intersection multiplicity not divisible by \(p\), and \(\epsilon=0\)
otherwise. Since \(e\) is prime to \(p\), Proposition 101.2 gives

\[
                         t(C)=e p^\epsilon.            \tag{101.12}
\]

Indeed, descent is local on \(C\), can be checked after completion,
and a section whose normalized values are units is a unit whenever
it descends. Hence the global order is exactly the least common
multiple of the displayed local orders.

### Corollary 101.3

Under these hypotheses,

\[
                  d_Y\le2s_X e p^\epsilon,
       \qquad     d_X\le2s_Y e p^\epsilon.              \tag{101.13}
\]

Thus arbitrarily high two-branch tangencies alone cannot produce
unbounded covering degrees. In the absence of ordinary nodes, there
is the uniform bound \(d_Y\le2p s_X\), independent of all contact
orders. If every such contact order is divisible by \(p\), the
stronger bound is \(d_Y\le2s_X\).

If all ordinary-node tangent ratios belong to \(\mathbf F_q^\times\),
then \(e\mid q-1\). In particular, this holds if the nodes, their
two branches, and the maps are all rational over \(\mathbf F_q\).
The bound is then \(d_Y\le2s_Xp^\epsilon(q-1)\). This is a
conditional bound on the tangent data, **not** an assertion that
defining \(X,Y\) over \(\mathbf F_q\) makes all nodes rational.

For the current genera \((9,25)\) in characteristic five, put
\(N=d_Y\), so \(d_X=3N\). The bounds become

\[
                       N\le16e5^\epsilon.              \tag{101.14}
\]

In particular, joint images with only two-branch tangencies and no
ordinary nodes have \(N\le80\); if all their contact orders are
divisible by five, they have \(N\le16\). These are not exclusions
of arbitrary common covers of higher degree.

## 5. What remains, and the link to file 100

The conductor criterion in file 100 keeps the full different of each
projection. This note additionally retains how the two differential
identifications glue between branches of the same singular image.
Its local test applies even to the high-contact model
\((y-x)(y-x-x^{5^m})\) from that file: its local gluing order is one,
despite its arbitrarily large normalization defect.

The current unbounded-degree escape is now more precise within the
two-branch class: the ordinary-node tangent ratios must have unbounded
combined multiplicative order. Singularities with three or more
branches require additional analysis. Neither escape has yet been
excluded for our fixed curves, so this theorem does not solve the
common-cover problem.
