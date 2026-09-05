# Weighted-grid descent and the cyclic genus-one interval

## Status and purpose

**Status: proved; self-check complete (2026-09-04).**

Keep the exact seven-diamond and norm polynomial of
`38_COPRIME_DESCENT_THROUGH_THE_CYCLIC_ATLAS.md`,
`44_NORMED_HYPERELLIPTIC_BRANCH_PENCIL.md`, and
`47_COEFFICIENT_FIELD_COARSENING.md`:

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg a=\deg c=M,
 \qquad
 P(T)=\operatorname{Nm}_{V/C}(T-t),
 \tag{66.1}
\]

where \(p\) is an etale \(C_7\)-cover and

\[
                  Y:z^2=1-t^{31}.
\tag{66.2}
\]

Here \(M\) is the common leg degree \(\deg(a)=\deg(c)\) in this exact
seven-diamond.  It is not the reduced core degree used in the separate
general core-tower route.

Let \(W\) be the span of the eight homogeneous coefficients of \(P\),
let \(B\) be the normalization of the coefficient image, and suppose that

\[
 [k(C):k(B)]=2,
 \qquad \operatorname{Gal}(k(V)/k(B))\simeq C_{14},
 \qquad g(B)=1.
\tag{66.3}
\]

This note proves the following interval theorem.

### Theorem 66.1 (cyclic genus-one interval exclusion)

Under (66.1)--(66.3), put \(w=\dim W\).  Then neither of the following
can occur:

1. \(9\leq M\leq13\) and \(w\geq6\);
2. \(M\in\{9,10\}\) and \(w\geq5\).

The three hypotheses in (66.3) are assumptions, not conclusions of this
theorem: the coefficient map is required to have degree two, its
degree-fourteen closure is required to be cyclic rather than dihedral, and
the coefficient normalization is required to have genus one.

In particular, it includes the previously isolated endpoint
\((M,w)=(9,8)\) as a special case.  The old special-case theorem file has
therefore been removed; its audit remains archived as provenance.

The new ingredient is a weighted grid lemma.  If the normalization of a
bidegree-\((n,n)\) curve contains more than \(2n^2\) marked points mapping
to a rational grid, then the curve descends even when many marked points
have the same image.  Multiplicity at a common image pays for every such
collision.  In the present problem there are \(28M\) marked points and
\(n=M\), so descent is automatic throughout \(M<14\).

After descent, Castelnuovo's bound leaves at least 30 rational points in
the quadratic branch divisor when \(w\geq6\).  The spectral conductor
allows at most three of their \(C_7\)-fibers to be nonsplit.  This gives at
least 189 points on an elliptic curve over \(\mathbf F_{125}\), whereas
the Weil upper bound is 148.

## 1. Geometry of the cyclic quadratic coarsening

Set

\[
 K=k(V),\qquad F=k(C),\qquad k(E)=k(B)(t).
\tag{66.4}
\]

Proposition 47.1 gives

\[
 [K:F]=[k(E):k(B)]=7,\qquad [K:k(E)]=[F:k(B)]=2,
 \qquad [k(E):k(t)]=M.
\tag{66.5}
\]

Let

\[
                       \pi:E\longrightarrow B
\tag{66.6}
\]

be the degree-seven map.

### Lemma 66.2 (the elliptic spectral cover and its special divisor)

The map \(\pi\) is an etale cyclic cover.  Hence \(g(E)=1\), and after
choosing an origin its generator is a translation

\[
                         \tau=T_Q,\qquad 0\ne Q\in E[7].
\tag{66.7}
\]

The square root \(z\) does not belong to \(k(E)\).  Consequently \(V\) is
the normalization of \(E\times_{\mathbf P^1_t}Y\).  If

\[
                         \Delta=\operatorname{Br}(C/B),
\tag{66.8}
\]

then \(\Delta\) is reduced of degree \(4M\), and

\[
                         S:=\pi^*\Delta
\tag{66.9}
\]

is the reduced divisor of the \(28M\) index-one points of \(t\) above

\[
                  \mathcal A=\mu_{31}\cup\{\infty\}.
\tag{66.10}
\]

In particular, \(S\) is \(\tau\)-invariant and, for every \(P\in S\),

\[
        t(P),t(\tau P),\ldots,t(\tau^6P)\in\mathcal A.
\tag{66.11}
\]

#### Proof

Every inertia group in \(K/k(B)\) meets
\(\operatorname{Gal}(K/F)=C_7\) trivially because \(V\to C\) is etale.
In the cyclic group \(C_{14}\), the only possible nontrivial inertia group
is therefore its unique subgroup of order two.  This subgroup is the root
stabilizer whose fixed field is \(k(E)\).  It follows that \(E\to B\) is
etale, while \(C\to B\) is tamely and simply ramified.  Since \(B\) has
genus one, so does \(E\).  The deck generator of an etale cyclic cover of
elliptic curves is translation by a nonzero seven-torsion point.

If \(z\in k(E)\), Proposition 47.2 would give a finite etale map
\(E\to Y\).  This is impossible: an etale map from a genus-one curve to
the genus-fifteen curve \(Y\) contradicts Riemann--Hurwitz.  Thus
\(z\notin k(E)\), and, since \([K:k(E)]=2\), one has \(K=k(E)(z)\).
This is exactly the normalized pullback assertion.

Riemann--Hurwitz for the double cover \(C\to B\), using
\(g(C)=2M+1\), gives

\[
                         \deg\Delta=2g(C)-2=4M.
\tag{66.12}
\]

The cyclic square identifies \(V\to E\) with the pullback of
\(C\to B\), so its branch divisor is \(\pi^*\Delta\).  On the other
hand it is the normalized pullback of the hyperelliptic double cover
\(Y\to\mathbf P^1_t\).  Since \(V\to Y\) is etale, the standard local
ramification-index formula says that \(t\) is unramified away from
\(\mathcal A\), has indices only one or two above \(\mathcal A\), and
the pullback double cover branches precisely at the index-one points.
This proves (66.9)--(66.11). \(\square\)

## 2. Birationality of the translated pair

For this section assume

\[
                              7\nmid M.
\tag{66.13}
\]

### Lemma 66.3 (the translated pair is birational)

The morphism

\[
       \Phi=(t,t\tau):E\longrightarrow\mathbf P^1\times\mathbf P^1
\tag{66.14}
\]

is birational onto its image \(\Gamma\), and \(\Gamma\) has bidegree
\((M,M)\).

#### Proof

The map \(t\) is separable.  Indeed, adjoining the separable quadratic
element \(z\) to \(k(E)/k(t)\) gives the extension
\(K/k(Y)\), which is etale; inseparable degree is unchanged by this
separable quadratic base extension.

Let \(D\) be the normalization of \(\Gamma\), and factor \(\Phi\) as

\[
                         E\stackrel u\longrightarrow D.
\tag{66.15}
\]

Write \(f=\deg u\).  The two coordinate maps both have degree \(M\), so
\(f\mid M\).  The extension is separable, and Riemann--Hurwitz gives
\(g(D)\leq1\).

Suppose first that \(D\simeq\mathbf P^1\).  The two coordinate maps
\(D\to\mathbf P^1\) have the same degree \(M/f\).  Therefore, for
\(L=t^*\mathcal O_{\mathbf P^1}(1)\),

\[
                         L\simeq\tau^*L.
\tag{66.16}
\]

For a degree-\(M\) line bundle on an elliptic curve, translation by \(Q\)
fixes its class exactly when \([M]Q=0\).  This contradicts
\(0\ne Q\in E[7]\) and (66.13).

It remains to consider \(g(D)=1\).  Then \(u\) is etale and, after
choosing origins, is an isogeny.  Its deck group \(H\), of order \(f\),
consists of translations.  It fixes \(t\), commutes with \(\tau\), and
therefore fixes every function \(t\tau^i\), \(0\leq i\leq6\).  Hence it
fixes all coefficients of

\[
                         \prod_{i=0}^6(T-t\tau^i).
\tag{66.17}
\]

The group \(H\) descends through \(E\to B=E/\langle\tau\rangle\).  If
\(f>1\), its descended action is nontrivial, since
\(\gcd(f,7)=1\).  But Proposition 47.1 says that the coefficients in
(66.17) generate \(k(B)\), so an action fixing all of them is trivial.
This contradiction proves \(f=1\).  The bidegree assertion now follows
from \(\deg t=\deg(t\tau)=M\). \(\square\)

## 3. A weighted rational-grid descent lemma

### Lemma 66.4 (marked branches force descent)

Let \(k_0=\mathbf F_q\), let \(G\subset\mathbf P^1\times\mathbf P^1\)
be an integral curve over \(\overline{k_0}\) of bidegree \((n,n)\), and
let \(\nu:\widetilde G\to G\) be its normalization.  Suppose that a
finite reduced set \(R\subset\widetilde G\) satisfies

\[
                         \nu(R)\subset
       (\mathbf P^1\times\mathbf P^1)(k_0).
\tag{66.18}
\]

If

\[
                              |R|>2n^2,
\tag{66.19}
\]

then \(G\) is defined over \(k_0\).

#### Proof

Let \(G^{(q)}\) be the Frobenius conjugate.  Suppose that
\(G^{(q)}\ne G\).  For \(x\in\nu(R)\), put

\[
                         k_x=|R\cap\nu^{-1}(x)|.
\tag{66.20}
\]

The multiplicity of \(G\) at \(x\) is at least the number of its
normalization branches there, and hence at least \(k_x\).  Because \(x\)
is rational, \(G^{(q)}\) has the same multiplicity at \(x\).  The local
Bezout inequality for two curves without a common component gives

\[
 i_x(G,G^{(q)})
   \geq \operatorname{mult}_x(G)\operatorname{mult}_x(G^{(q)})
   \geq k_x^2.
\tag{66.21}
\]

(Equivalently, blow up \(x\): the first term in the local intersection
formula is the product of the two multiplicities and all remaining terms
are nonnegative.)  Global intersection on
\(\mathbf P^1\times\mathbf P^1\) now gives

\[
 2n^2=G\cdot G^{(q)}
   \geq\sum_{x\in\nu(R)}k_x^2
   \geq\sum_{x\in\nu(R)}k_x=|R|,
\tag{66.22}
\]

contrary to (66.19).  Thus \(G^{(q)}=G\), which is precisely descent to
\(k_0\). \(\square\)

### Proposition 66.5 (descent throughout \(M<14\))

Assume \(7\nmid M\) and \(M<14\).  The elliptic curve \(E\), the
functions \(t,t\tau\), the point \(Q\), the translation \(\tau\), the
quotient \(\pi:E\to B\), and the branch divisor \(\Delta\) all descend
to

\[
                            k_0=\mathbf F_{125}.
\tag{66.23}
\]

#### Proof

All points of \(\mathcal A\), including infinity, are \(k_0\)-rational
because \(31\mid124\).  By Lemma 66.2,

\[
                         \Phi(S)\subset\mathcal A^2.
\tag{66.24}
\]

Lemma 66.3 identifies \(E\) with the normalization of the bidegree-
\((M,M)\) curve \(\Gamma\).  Since

\[
                         |S|=28M>2M^2
                            \quad\Longleftrightarrow\quad M<14,
\tag{66.25}
\]

Lemma 66.4 makes \(\Gamma\) descend to \(k_0\).  Its normalization and
the two coordinate functions therefore descend simultaneously, giving
models of \(E,t,t\tau\) over \(k_0\).

The Weil lower bound gives a \(k_0\)-point on \(E\); choose it as origin.
Write

\[
 D_0=t^{-1}(\infty),\qquad
 D_1=(t\tau)^{-1}(\infty)=T_{-Q}D_0.
\tag{66.26}
\]

Both degree-\(M\) divisors are rational, and in \(J(E)=E\) their
difference is

\[
                           [D_1-D_0]=-[M]Q.
\tag{66.27}
\]

If \(F_0\) is 125-power Frobenius, (66.27) gives
\([M](F_0Q-Q)=0\).  It also gives \([7](F_0Q-Q)=0\), because \(Q\) is
seven-torsion.  Hypothesis (66.13) forces \(F_0Q=Q\).  Thus \(Q,\tau\),
and the quotient \(\pi\) descend.

Finally, \(S\) is intrinsically the reduced divisor of index-one points
of the descended function \(t\) over \(\mathcal A\).  Hence \(S\)
descends, and so does its quotient \(\Delta=\pi(S)\). \(\square\)

## 4. Coefficient singularities and the spectral conductor

For integers \(d,r\geq2\), write \(\operatorname{Cast}(d,r)\) for
Castelnuovo's bound for a nondegenerate integral degree-\(d\) curve in
\(\mathbf P^r\).  Explicitly, if

\[
                     d-1=q(r-1)+s,\qquad0\leq s<r-1,
\tag{66.28}
\]

then

\[
       \operatorname{Cast}(d,r)
          ={q\choose2}(r-1)+qs.
\tag{66.29}
\]

### Proposition 66.6 (the quantitative point lower bound)

Assume \(7\nmid M\) and \(M<14\).  Then

\[
 \#E(k_0)\ \geq\
 7\left(
    4M-2\bigl(\operatorname{Cast}(M,w-1)-1\bigr)
       -\left\lfloor\frac{2M}{7}\right\rfloor
   \right).
\tag{66.30}
\]

#### Proof

The norm coefficients define over \(k_0\) a morphism

\[
                       \chi:B\longrightarrow B'
                             \subset\mathbf P^{w-1}.
\tag{66.31}
\]

Indeed, the coefficient line is the norm of the descended degree-\(M\)
line \(t^*\mathcal O(1)\), and the space of constant linear relations
among its eight descended sections commutes with scalar extension.  Thus
their \(k_0\)-span has the same dimension \(w\).  Proposition 47.1 says
that \(B\) is the normalization of \(B'\).  The curve \(B'\) is
nondegenerate of degree \(M\), so

\[
 \delta(B')=p_a(B')-g(B)
       \leq\operatorname{Cast}(M,w-1)-1.
\tag{66.32}
\]

For every \(b\in\Delta\), all seven roots of the corresponding
homogeneous norm form belong to \(\mathcal A\).  Its coefficient point
\(\chi(b)\) therefore lies in \(B'(k_0)\), including when one or more
roots are infinity.

Let \(N\) be the number of geometric points of \(\Delta\) which are not
\(k_0\)-rational.  Every such Frobenius orbit lies in a normalization
fiber over a rational point of \(B'\).  If such a fiber contains \(R\geq2\)
nonrational points, its delta invariant is at least \(R-1\geq R/2\).
Summing over the fibers gives

\[
             N\leq2\delta(B')
                \leq2\bigl(\operatorname{Cast}(M,w-1)-1\bigr).
\tag{66.33}
\]

Thus at least the first two terms inside the parentheses in (66.30)
count \(k_0\)-rational points of \(\Delta\).

It remains to bound the rational fibers which do not split.  Consider

\[
             \Psi=(\pi,t):E\longrightarrow B\times\mathbf P^1.
\tag{66.34}
\]

Its generic degree divides both \(7\) and \(M\), hence is one.  Its image
has projection degrees \((7,M)\).  Adjunction on the product of an elliptic
curve and \(\mathbf P^1\) gives arithmetic genus \(6M+1\).  Since its
normalization is the elliptic curve \(E\), its total delta invariant is

\[
                              6M.
\tag{66.35}
\]

Call \(b\in\Delta\) constant-labelled if \(t\) has the same value at all
seven points of \(\pi^{-1}(b)\).  Such a fiber gives seven distinct smooth
branches through one point of the spectral image; the local delta is at
least

\[
                              {7\choose2}=21.
\tag{66.36}
\]

Consequently at most

\[
                              \left\lfloor\frac{6M}{21}\right\rfloor
                              =\left\lfloor\frac{2M}{7}\right\rfloor
\tag{66.37}
\]

points of \(\Delta\) are constant-labelled.

If a rational point \(b\in\Delta(k_0)\) is not constant-labelled, its
\(C_7\)-fiber splits completely.  Indeed, Frobenius acts on the fiber as
\(\tau^j\).  Since \(t,\tau\), and all seven values in \(\mathcal A\) are
rational, \(j\ne0\) would make the seven values equal; thus \(j=0\).
Every remaining rational nonconstant fiber therefore contributes seven
distinct points of \(E(k_0)\).  Combining (66.33) and (66.37) proves
(66.30). \(\square\)

## 5. The interval contradiction

#### Proof of Theorem 66.1

For \(9\leq M\leq13\), the hypotheses \(M<14\) and \(7\nmid M\) hold.
If \(w\geq6\), monotonicity of Castelnuovo's bound in the ambient
dimension and (66.29) give

\[
 \operatorname{Cast}(M,w-1)
    \leq\operatorname{Cast}(M,5)=2M-14.
\tag{66.38}
\]

Hence (66.33) leaves at least

\[
                 4M-2(2M-15)=30
\tag{66.39}
\]

rational points of \(\Delta\).  Moreover

\[
            \left\lfloor\frac{2M}{7}\right\rfloor\leq3.
\tag{66.40}
\]

Proposition 66.6 now gives

\[
                            \#E(k_0)\geq7(30-3)=189.
\tag{66.41}
\]

But the Weil bound for an elliptic curve over \(k_0=\mathbf F_{125}\)
is

\[
              \#E(k_0)\leq
              \left\lfloor126+2\sqrt{125}\right\rfloor=148,
\tag{66.42}
\]

a contradiction.  This proves item 1.

For \(w\geq5\), use projective dimension four.  Formula (66.29) gives

\[
 \operatorname{Cast}(9,4)=7,
 \qquad
 \operatorname{Cast}(10,4)=9.
\tag{66.43}
\]

For both values of \(M\), at least 24 points of \(\Delta\) are rational,
and at most two are constant-labelled.  Thus

\[
                           \#E(k_0)\geq7(24-2)=154>148,
\tag{66.44}
\]

which proves item 2. \(\square\)

## 6. Scope and exact boundary

The argument is deliberately numerical and reusable.  In any cyclic
genus-one quadratic coarsening with \(7\nmid M<14\), the single inequality

\[
 7\left(
    4M-2\bigl(\operatorname{Cast}(M,w-1)-1\bigr)
       -\left\lfloor\frac{2M}{7}\right\rfloor
   \right)>148
\tag{66.45}
\]

is sufficient for nonexistence.

The method reaches a natural wall at \(M=14\): the marked-branch count and
the Frobenius intersection number become equal,

\[
                           28M=2M^2=392,
\]

and \(M\) is no longer coprime to seven.  For coefficient dimensions below
those in Theorem 66.1, Castelnuovo permits enough normalization collisions
that the present Weil estimate no longer contradicts existence.  New
information about the 32 square-root labels or the singularity types of the
coefficient image would be needed to cross either boundary.
