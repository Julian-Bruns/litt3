# The norm-polynomial system cannot be a pencil

## Status and purpose

**Status: proved.**  **Audit: PASS** --
`/root/norm_pencil_dimension_audit`, 2026-09-04.  No breaking objection;
only optional normalization and edge-case clarifications were suggested.
[Audit record](audits/46_NORM_PENCIL_DIMENSION_AUDIT.md).

Continue with the exact seven-diamond and the notation of files 38, 40,
and 44:

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg a=\deg c=M,
 \qquad \deg p=7,
\tag{46.1}
\]

where all maps are finite etale, \(p\) is a cyclic cover, and

\[
             Y:\quad z^2=1-t^{31}.
\tag{46.2}
\]

File 44 associates to the characteristic polynomial

\[
       P(T)=\operatorname{Nm}_{V/C}(T-t)
\tag{46.3}
\]

a base-point-free coefficient space

\[
       W_P\subseteq H^0(C,L),
       \qquad L=\mathcal O_C(2D_\infty),
       \qquad \dim W_P\leq 8.
\tag{46.4}
\]

The purpose of this note is to prove the complementary lower bound

\[
                         \boxed{\dim W_P\geq3}.         \tag{46.5}
\]

The proof is geometric.  If the coefficients spanned a pencil, the
spectral curve \(V\) would be the normalization of a fiber product of two
maps to \(\mathbf P^1\), of degrees \(2M\) and seven.  Etaleness of
\(p\), together with the 32 simple branch points of the hyperelliptic map
on \(Y\), forces the degree-seven map to carry those 32 points into a set
of either six or eight points.  It would then lift to a degree-seven map
from \(Y\) to a curve of genus two or three.  This contradicts the
absolute simplicity of \(J(Y)\) proved in file 40.

This rules out the smallest possible coefficient span without assuming
that the 32 two-torsion labels in file 44 remain distinct on \(J(C)\).

## 1. The spectral divisor

Write

\[
        \mathcal A=\mu_{31}\cup\{\infty\}
                         \subset\mathbf P^1_t.
\tag{46.6}
\]

The map \(t:Y\to\mathbf P^1_t\) is the double cover branched exactly at
the 32 points of \(\mathcal A\).  We use the same letter \(t\) for its
pullback to \(V\).  Thus

\[
       t:V\longrightarrow\mathbf P^1_t
\tag{46.7}
\]

has degree \(2M\), has ramification index two over every point of
\(\mathcal A\), and is unramified everywhere else.  Indeed, \(a\) is
etale and the hyperelliptic double cover is tame.

By Proposition 44.3, \(P(T)\) is the separable minimal polynomial of
\(t\in k(V)\) over \(k(C)\).  Homogenizing its coefficients gives a
section

\[
 \mathscr P\in
 H^0\!\left(C\times\mathbf P^1_t,
       \operatorname{pr}_C^*L\otimes
       \operatorname{pr}_t^*\mathcal O_{\mathbf P^1}(7)\right).
\tag{46.8}
\]

Its zero divisor is integral, and \(V\) is its normalization via

\[
                    (p,t):V\longrightarrow C\times\mathbf P^1_t.
\tag{46.9}
\]

This follows either from the minimal-polynomial assertion or directly
from \(k(V)=k(C)(t)\).  In particular, the spectral divisor has bidegree
\((7,2M)\).

The coefficient map

\[
 \nu:\mathbf P^1_t\longrightarrow\mathbf P(W_P),
             \qquad T\longmapsto[P(T)]
\tag{46.10}
\]

is defined everywhere and satisfies

\[
                  \nu^*\mathcal O_{\mathbf P(W_P)}(1)
                    \simeq\mathcal O_{\mathbf P^1}(7).
\tag{46.11}
\]

For completeness, \(P(T)\) is never the zero section: otherwise the
constant \(T\in k\cup\{\infty\}\) would be a root of the irreducible
degree-seven polynomial (46.3); at infinity one uses its nonzero leading
coefficient.  Hence the eight homogeneous coefficient polynomials have
no common zero on \(\mathbf P^1_t\).  They therefore define (46.10)
without a common factor, which proves (46.11).

## 2. What a two-dimensional coefficient span would imply

Assume for contradiction that

\[
                            \dim W_P=2.
\tag{46.12}
\]

Since \(W_P\) is base-point free, it defines a finite morphism

\[
                 f:C\longrightarrow\mathbf P^1_b,
                 \qquad f^*\mathcal O(1)\simeq L.
\tag{46.13}
\]

Thus

\[
                          \deg f=\deg L=2M.
\tag{46.14}
\]

After choosing a basis \(u_0,u_1\) of \(W_P\), write

\[
             \mathscr P(T)=A(T)u_0+B(T)u_1,
\tag{46.15}
\]

where \(A,B\) are homogeneous binary forms of degree seven.  They have no
common zero by (46.11).  The pair \([-B:A]\) consequently defines a map

\[
                     R:\mathbf P^1_t\longrightarrow\mathbf P^1_b
\tag{46.16}
\]

of exact degree seven.  With compatible coordinates on the target, the
spectral equation (46.15) says

\[
                         f\circ p=R\circ t.             \tag{46.17}
\]

Equivalently, \(V\) is the normalization of the fiber product of \(f\)
and \(R\).

Both sides of (46.17) are separable.  The map \(R\) is separable because
its degree seven is prime to the characteristic five, and \(t\) is
separable.  Since \(p\) is etale, it follows in particular that \(f\) is
separable.

We next record the special-fiber consequence of the norm construction.
For \(b\in\mathbf P^1_b\), write

\[
                       R^{-1}(b)=\sum_\xi r_\xi[\xi].
\tag{46.18}
\]

For every \(c\in f^{-1}(b)\), the multiset

\[
                       \{t(v):v\in p^{-1}(c)\}
\tag{46.19}
\]

contains \(\xi\) exactly \(r_\xi\) times.  To see this, split the etale
cover \(p\) over a strict henselian neighborhood of \(c\).  The
specialization of the norm form \(\mathscr P\) is, up to a nonzero scalar,
the product of the seven linear forms with roots \(t(v)\).  At a pole of
\(t\), the local twist by \(2D_\infty\) turns the corresponding factor
into the linear form with root infinity.  On the other hand, (46.15)
specializes to the binary form cutting out \(R^{-1}(b)\).  Equality of
these two degree-seven forms proves the multiset assertion.

## 3. Forced ramification over the image of the branch set

Set

\[
                       \mathcal B=R(\mathcal A),
                       \qquad m=|\mathcal B|.
\tag{46.20}
\]

Fix \(b\in\mathcal B\).  Let \(k_b\) be the number of distinct points of
\(\mathcal A\) above \(b\), and let \(\ell_b\) be the number of distinct
points of \(R^{-1}(b)\setminus\mathcal A\).

For \(c\in f^{-1}(b)\) and \(v\in p^{-1}(c)\), multiplicativity of local
ramification indices in (46.17) gives

\[
                 e_f(c)=r_{t(v)}e_t(v),                \tag{46.21}
\]

because \(p\) is etale.  Every point of \(R^{-1}(b)\) occurs in the
multiset (46.19).  Since \(e_t=2\) on \(\mathcal A\) and \(e_t=1\)
off \(\mathcal A\), (46.21) has the following consequences.  There is an
integer \(r_b\) such that

\[
 \begin{cases}
    r_\xi=r_b,&\xi\in R^{-1}(b)\cap\mathcal A,\\
    r_\xi=2r_b,&\xi\in R^{-1}(b)\setminus\mathcal A,
 \end{cases}
 \qquad
                         e_f(c)=2r_b.                  \tag{46.22}
\]

Taking degrees in the fiber of \(R\) gives

\[
                         7=r_b(k_b+2\ell_b).            \tag{46.23}
\]

Thus \(r_b\) is either one or seven.  In the second case
\((k_b,\ell_b)=(1,0)\).  In particular,

\[
                            k_b\ \text{is odd}           \tag{46.24}
\]

for every \(b\in\mathcal B\).

Equation (46.22) also forces substantial ramification of \(f\).  There
are \(M/r_b\) distinct points of \(C\) over \(b\), each of ramification
index \(2r_b\).  Their contribution to the different of \(f\) is at
least

\[
             \frac{M}{r_b}(2r_b-1)
                     =2M-\frac{M}{r_b}\ \geq M.        \tag{46.25}
\]

This lower bound remains valid in the presence of wild ramification,
since the different exponent is always at least \(e-1\).

Now \(g(C)=2M+1\) and \(\deg f=2M\).  Riemann--Hurwitz therefore gives

\[
                 \deg\operatorname{Diff}(f)
                    =2g(C)-2+2\deg f=8M.               \tag{46.26}
\]

Summing (46.25) over \(\mathcal B\) yields

\[
                              m\leq8.                   \tag{46.27}
\]

On the other hand, a degree-seven fiber contains at most seven of the 32
distinct points of \(\mathcal A\), so \(m\geq\lceil32/7\rceil=5\).  The
sets above the points of \(\mathcal B\) partition \(\mathcal A\); hence

\[
                         32=\sum_{b\in\mathcal B}k_b.
\tag{46.28}
\]

Every summand is odd by (46.24), so \(m\) is even.  Combining these facts
gives the sharp alternative

\[
                              m\in\{6,8\}.              \tag{46.29}
\]

## 4. The forbidden lower-genus quotient of \(Y\)

Regard \(\mathcal A\) and \(\mathcal B\) as reduced divisors on their
respective projective lines.  Equations (46.22)--(46.23) imply the
divisor congruence

\[
                         R^*\mathcal B\equiv\mathcal A
                                  \pmod {2}.             \tag{46.30}
\]

Indeed, a point of \(\mathcal A\) occurs in \(R^*\mathcal B\) with
multiplicity \(r_b\in\{1,7\}\), while every point outside
\(\mathcal A\) lying over \(\mathcal B\) occurs with multiplicity
\(2r_b\).

Because \(m\) is even, there is a smooth double cover

\[
                 Y_{\mathcal B}\longrightarrow\mathbf P^1_b
\tag{46.31}
\]

branched exactly over \(\mathcal B\), and

\[
                       g(Y_{\mathcal B})=\frac{m-2}{2}
                                         \in\{2,3\}.    \tag{46.32}
\]

Congruence (46.30) says precisely that \(R\) lifts to a morphism

\[
                         \widetilde R:Y\longrightarrow Y_{\mathcal B}.
\tag{46.33}
\]

Here is an explicit verification.  Choose rational functions
\(F_{\mathcal A}\) and \(F_{\mathcal B}\) whose odd valuation loci are
respectively \(\mathcal A\) and \(\mathcal B\).  The divisor of

\[
                   \frac{F_{\mathcal B}(R(t))}{F_{\mathcal A}(t)}
\tag{46.34}
\]

is even by (46.30).  Since \(\operatorname{Pic}^0(\mathbf P^1)=0\) and
\(k\) is algebraically closed, (46.34) is a square in \(k(t)\).  This
gives (46.33) on function fields.  The lift has degree seven: the degree
of \(k(t)/k(R(t))\) is seven, while the quadratic extension defining
\(Y_{\mathcal B}\) pulls back to the nontrivial quadratic extension
defining \(Y\).  More explicitly, an odd-degree extension of degree seven
cannot contain that quadratic extension, so the two extensions are
linearly disjoint over \(k(R(t))\).  The degree after the quadratic base
change is still seven.

The induced pullback on Jacobians

\[
           \widetilde R^*:J(Y_{\mathcal B})\longrightarrow J(Y)
\tag{46.35}
\]

has positive-dimensional image.  For example,

\[
                 \widetilde R_*\widetilde R^*=[7]
                              \quad\text{on }J(Y_{\mathcal B}),
\tag{46.36}
\]

so its kernel is finite.  By (46.32), this image is a nonzero proper
abelian subvariety of the fifteen-dimensional \(J(Y)\).  This contradicts
the absolute simplicity of \(J(Y)\) from Proposition 40.1.

The assumption (46.12) is therefore impossible.  A one-dimensional
coefficient space is also impossible: a base-point-free one-dimensional
subspace would trivialize the positive-degree line bundle \(L\).  Hence

\[
                              3\leq\dim W_P\leq8,
\tag{46.37}
\]

as claimed.  \(\square\)

## 5. Scope of the obstruction

The proof uses only four structural inputs: the cyclic etale degree-seven
spectral cover, the 32 tame branch points of \(Y\to\mathbf P^1\), the
genus and degree identities on \(C\), and absolute simplicity of \(J(Y)\).
It does not require injectivity of

\[
                       p_*a^*:J(Y)[2]\longrightarrow J(C)[2].
\]

Thus it survives possible collisions among the 32 square-root classes of
file 44.  What remains open on this route is to exclude coefficient spans
of dimensions three through eight, or to show that one of them forces a
visible descent.
