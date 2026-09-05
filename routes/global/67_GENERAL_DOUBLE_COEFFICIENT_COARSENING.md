# General structure of a quadratic coefficient coarsening

## Status, scope, and purpose

**Status: proved; self-check complete (2026-09-04).**

This note works over \(k=\overline{\mathbf F}_5\).  Its hypotheses are the
following, for an arbitrary integer \(M\geq2\):

1. there is an exact seven-diamond of finite-etale maps
   \[
    \begin{array}{ccc}
    V&\xrightarrow{a}&Y\\
    \downarrow p&&\\[-2mm]
    C&\xrightarrow{c}&X,
    \end{array}
    \qquad
    \deg a=\deg c=M,\qquad \deg p=7,                 \tag{67.1}
   \]
   in which \(p\) is a \(C_7\)-torsor and
   \[
    X:v^2=x^7-x+1,\qquad Y:z^2=1-t^{31};
                                                               \tag{67.2}
   \]
2. for the norm polynomial
   \[
                  P(T)=\operatorname{Nm}_{V/C}(T-t),
   \]
   the coefficient map has generic degree two onto the normalization
   \(B\) of its image:
   \[
                         q:C\longrightarrow B,
             \qquad [k(C):k(B)]=2.                   \tag{67.3}
   \]

Write \(b=g(B)\), \(w=\dim W_P\), and let \(\delta\) be the involution of
\(C/B\).  File 46 gives \(3\leq w\leq8\), but **no hypothesis on \(w\)**
is imposed below.  No parity or upper bound on \(M\) is imposed except
where it is explicitly stated.  Files 38 and 47 give
\[
 g(C)=2M+1,\qquad g(V)=14M+1.                        \tag{67.4}
\]

Put
\[
 K=k(V),\qquad F=k(C),\qquad k(E)=k(B)(t).           \tag{67.5}
\]
Then
\[
 [K:F]=[k(E):k(B)]=7,\qquad
 [K:k(E)]=[F:k(B)]=2,\qquad [k(E):k(t)]=M.           \tag{67.6}
\]

The results are uniform in \(M\).  They prove that the degree-fourteen
closure is cyclic or dihedral, exclude \(b=0\), compress every \(b=1\)
quotient through the hyperelliptic involution of \(X\), exclude a general
high-genus band by a Prym rank bound, and exclude the dihedral \(b=1\)
row for every odd \(M\leq15\).

## 1. The degree-fourteen closure for arbitrary \(M\)

### Theorem 67.1 (group, genus, and the rational-base exclusion)

The extension \(K/k(B)\) is Galois, with
\[
 G:=\operatorname{Gal}(K/k(B))\simeq C_{14}
             \quad\text{or}\quad D_{14}.             \tag{67.7}
\]
The double cover \(q\) is tame and has a reduced branch divisor
\(\Delta\) of degree
\[
                         |\Delta|=4(M-b+1).           \tag{67.8}
\]
The genus of the spectral curve \(E\) is
\[
 g(E)=
 \begin{cases}
   7b-6,&G=C_{14},\\
   6M+b,&G=D_{14}.
 \end{cases}                                         \tag{67.9}
\]
In particular, \(b=0\) is impossible for every \(M\).

If \(z\in k(E)\), then \(M\) is even and
\[
                              b=M+1.                  \tag{67.10}
\]
Thus \(q\) is unramified in that case.  Every ramified quadratic
coefficient coarsening consequently has \(z\notin k(E)\).

#### Proof

The irreducible polynomial \(P(T)\in k(B)[T]\) has degree seven and
splits in \(K\).  If \(L\) is its splitting field over \(k(B)\), then
\[
                    k(E)\subseteq L\subseteq K,
             \qquad [L:k(B)]\in\{7,14\}.             \tag{67.11}
\]
If \(L=K\), normality is immediate.  Otherwise \(L/k(B)\) is a Galois
extension of degree seven.  The separable quadratic extension
\(F/k(B)\) is also Galois, and \(FL=K\) because \(t\in L\) and
\(K=F(t)\).  Hence \(K/k(B)\) is Galois in either case.  Its order is
fourteen, so its group is \(C_{14}\) or \(D_{14}\).

The subgroup \(\operatorname{Gal}(K/F)\simeq C_7\) is normal and
\(K/F\) is unramified.  Every inertia group for \(K/k(B)\) therefore
meets this \(C_7\) trivially.  Since the group order is prime to five,
all nontrivial inertia has order two and \(q\) is simply ramified.
Riemann--Hurwitz gives
\[
 |\Delta|=(2g(C)-2)-2(2b-2)=4(M-b+1),                \tag{67.12}
\]
proving (67.8).

The field \(k(E)\) is fixed by a subgroup \(H\leq G\) of order two.
If \(G=C_{14}\), this is the unique order-two subgroup.  All inertia is
contained in \(H\), so it dies in \(E/B\); hence \(E/B\) is an
unramified \(C_7\)-cover and \(g(E)=7b-6\).

If \(G=D_{14}\), every nontrivial inertia group is a reflection.  A
reflection has cycle type \(1\,2^3\) on \(G/H\), so each point of
\(\Delta\) contributes three to the different of \(E/B\).  Thus
\[
 2g(E)-2=7(2b-2)+3|\Delta|=12M+2b-2,
\]
which gives the second line of (67.9).

For \(b=0\), the cyclic formula gives the absurd value \(g(E)=-6\).
In the dihedral case it gives \(g(E)=6M\).  But the degree-seven map
\(E\to B\simeq\mathbf P^1\) and the degree-\(M\) map
\(t:E\to\mathbf P^1\) generate \(k(E)=k(B)(t)\).  Castelnuovo--Severi
would give
\[
                         g(E)\leq(7-1)(M-1)=6M-6,
\]
again a contradiction.

Finally, if \(z\in k(E)\), Proposition 47.2 gives an etale map
\(E\to Y\) of degree \(M/2\).  Thus \(M\) is even and
\[
                         g(E)=7M+1.                  \tag{67.13}
\]
Comparison with either line of (67.9) yields \(b=M+1\), and (67.8)
then says that \(q\) is unramified. \(\square\)

## 2. Compression over a genus-one coefficient curve

For the explicit curve \(X\), file 53 proves
\[
 \operatorname{End}^0(J(X))
 \simeq
 \mathbf Q(\sqrt{-11})\times
 \mathbf Q(\sqrt{-19})\times
 \mathbf Q(i),                                      \tag{67.14}
\]
that the Rosati-fixed subalgebra is \(\mathbf Q^3\), and that
\[
                         \operatorname{Aut}(X)
                           =\{1,\iota_X\}.            \tag{67.15}
\]

For every \(b\), put
\[
                   u=c_*\delta^*c^*\in\operatorname{End}(J(X)).
                                                               \tag{67.16}
\]

### Lemma 67.2 (compressed scalar spectrum)

On the three elliptic isogeny factors of \(J(X)\), the endomorphism \(u\)
acts by integers
\[
                       -M\leq\lambda_i\leq M
                       \qquad (i=1,2,3),              \tag{67.17}
\]
for every \(b\).  If \(b=1\), at least two of them equal \(-M\).

#### Proof

The involution \(\delta^*\) is Rosati self-adjoint.  Hence \(u\) lies in
the \(\mathbf Q^3\) of (67.14).  Its rational coordinates are algebraic
integers because \(u\) is an actual endomorphism, and are therefore
integers.  The identities
\[
 M\operatorname{id}\mathbin{\pm}u
       =c_*(1\mathbin{\pm}\delta^*)c^*               \tag{67.18}
\]
make both sides Rosati-positive semidefinite and prove the bounds.

If \(b=1\), take \(s=q_*c^*:J(X)\to J(B)\).  The double-cover identity
\(q^*q_*=1+\delta^*\) gives
\[
                         s^\dagger s=M\operatorname{id}+u.            \tag{67.19}
\]
Its rank on first cohomology is at most \(2g(B)=2\).  Each nonzero
scalar \(M+\lambda_i\) contributes rank two on the corresponding
elliptic factor.  At most one is nonzero, proving the lemma. \(\square\)

### Theorem 67.3 (all-\(M\) genus-one hyperelliptic compression)

For every \(M\geq2\), if \(b=1\), then
\[
                           c\delta=\iota_Xc.          \tag{67.20}
\]
Consequently there is a degree-\(M\) map
\[
                           r_X:B\longrightarrow\mathbf P^1_x         \tag{67.21}
\]
such that \(C\) is the normalization of
\[
                         B\times_{\mathbf P^1_x}X.    \tag{67.22}
\]
The map \(r_X\) is unramified away from the eight branch values
\(\mathcal A_X\) of \(X\to\mathbf P^1_x\), and all its indices over
\(\mathcal A_X\) are one or two.  If the fiber above
\(\xi\in\mathcal A_X\) has profile \(1^{a_\xi}2^{b_\xi}\), then
\[
 a_\xi+2b_\xi=M,\qquad
 \sum_{\xi\in\mathcal A_X}a_\xi=4M,\qquad
 \sum_{\xi\in\mathcal A_X}b_\xi=2M.                 \tag{67.23}
\]

#### Proof

Theorem 67.1 first shows that \(z\notin k(E)\), since the other case
would give \(1=b=M+1\).

Let
\[
                         Z=(c,c\delta)_*[C]
\]
be the effective correspondence cycle on \(X\times X\), and put
\(S=\lambda_1+\lambda_2+\lambda_3\).  The cover \(q\) has \(4M\)
ramification points.  Each is fixed by \(\delta\) and contributes one
to the pullback of the diagonal: in a tame parameter \(w\),
\(\delta(w)=-w\), while the etaleness of \(c\) makes the linear term of
\(c(w)-c(-w)\) nonzero.  Therefore
\[
 4M\leq Z\cdot\Delta_X
      =2M-\operatorname{Tr}(u\mid H^1(X))
      =2M-2S.                                        \tag{67.24}
\]
Thus \(S\leq-M\).

Suppose the reduced support of \(Z\) is not the graph of \(\iota_X\).
It then meets that graph properly and nonnegatively.  Since \(\iota_X\)
acts by \(-1\) on \(H^1(X)\),
\[
 0\leq Z\cdot\operatorname{Graph}(\iota_X)=2M+2S.    \tag{67.25}
\]
Thus \(S=-M\).  Lemma 67.2 forces, up to order,
\[
                         (\lambda_1,\lambda_2,\lambda_3)=(-M,-M,M).
                                                               \tag{67.26}
\]

Let \(\Gamma\) be the reduced image of \((c,c\delta)\), let \(f\) be the
generic degree of \(C\to\Gamma\), and put \(n=M/f\).  The cycle identity
\(Z=f\Gamma\) shows that \(f\mid M\), that \(\Gamma\) has bidegree
\((n,n)\), and that its correspondence endomorphism is \(u/f\), with
coordinates \((-n,-n,n)\).  After normalizing \(\Gamma\), both factors
in
\[
                         C\longrightarrow\widetilde\Gamma
                              \longrightarrow X
\]
are etale: their composite is \(c\), and the different is effective
and additive.  Hence
\[
                         g(\widetilde\Gamma)=1+2n.    \tag{67.27}
\]
The standard correspondence self-intersection formula and adjunction
on \(X\times X\) give
\[
 \Gamma^2
  =2n^2-\operatorname{Tr}((u/f)^\dagger(u/f)\mid H^1(X))
  =-4n^2,
\]
\[
 \Gamma\cdot K_{X\times X}=8n,\qquad
 p_a(\Gamma)=1-2n^2+4n.                              \tag{67.28}
\]
Since \(p_a(\Gamma)\geq g(\widetilde\Gamma)\), one gets
\[
                         1-2n^2+4n\geq1+2n,
\]
so \(n=1\).  The curve \(\Gamma\) is now the graph of an automorphism
of \(X\) acting with the mixed signs \((-1,-1,1)\).  This contradicts
(67.15).  The reduced support of \(Z\) is therefore the graph of
\(\iota_X\), proving (67.20).

The function \(x\circ c\) descends through \(q\) to (67.21), while the
anti-invariant function \(v\circ c\) generates \(k(C)/k(B)\) and
satisfies
\[
                         (v\circ c)^2=r_X^7-r_X+1.
\]
This proves (67.22).  The local normalization of a tame double-cover
pullback shows that the etaleness of \(c\) permits only index one or two
over \(\mathcal A_X\), and no ramification elsewhere.  The index-one
points are precisely the \(4M\) branch points of \(q\), proving the
second equality in (67.23); summing the first equality over eight
fibers proves the third. \(\square\)

## 3. A general Prym rank exclusion

Put
\[
 h=p_*a^*:J(Y)\longrightarrow J(C),\qquad
 A=\operatorname{im}(h).                             \tag{67.29}
\]
File 40 proves that \(J(Y)\) is absolutely simple, \(h\neq0\), and
\[
                              c_*h=0.                 \tag{67.30}
\]
Thus \(A\) is a simple abelian variety of dimension fifteen and is
orthogonal to \(c^*J(X)\) in \(J(C)\).

### Theorem 67.4 (all-\(M\) Prym rank bound and high-genus exclusion)

Assume \(z\notin k(E)\), and let \(P_q=\operatorname{Prym}(C/B)\).
For every prime \(\ell\neq5\),
\[
 \operatorname{rank}_{\mathbf Q_\ell}
  (M\operatorname{id}-u\mid H^1(J(X),\mathbf Q_\ell))
       \leq 2(2M-b-14).                              \tag{67.31}
\]
Consequently no ramified quadratic coefficient coarsening can satisfy
\[
                         2M-15\leq b\leq M.           \tag{67.32}
\]
The assertion is uniform in \(M\); the displayed integer band is
nonempty only for \(M\leq15\).

At the unramified endpoint \(b=M+1\), the same argument shows that, if
\(M\leq16\), then
\[
                              c\delta=c.              \tag{67.33}
\]
In particular, the non-descending-square-root endpoint is impossible
for odd \(M\leq16\).

#### Proof

Theorem 66.2 gives \(q_*h=0\), so \(A\subseteq P_q\).  Moreover
\[
 q^*q_*h=(1+\delta^*)h=0,
\]
and hence \(\delta^*=-1\) on \(A\).  Since
\(\dim P_q=g(C)-b=2M+1-b\), the orthogonal complement of \(A\) inside
\(P_q\) has dimension \(2M-b-14\).

The connected image
\[
                     T=\operatorname{im}((1-\delta^*)c^*)
\]
lies in \(P_q\).  It is orthogonal to \(A\): equation (67.30) gives
\(c^*J(X)\perp A\), and Rosati self-adjointness gives
\[
 \langle a,\delta^*c^*x\rangle
   =\langle\delta^*a,c^*x\rangle
   =-\langle a,c^*x\rangle=0.                        \tag{67.34}
\]
Therefore
\[
                              \dim T\leq2M-b-14.       \tag{67.35}
\]
Since
\[
                 M\operatorname{id}-u=c_*(1-\delta^*)c^*,
\]
its image is a quotient of \(T\), proving (67.31).

Each nonzero scalar \(M-\lambda_i\) contributes rank two to the left
side of (67.31).  If \(b\geq2M-15\), at least two
\(\lambda_i\)'s equal \(M\).  The bounds (67.17) then give
\[
                         S=\sum_i\lambda_i\geq M.     \tag{67.36}
\]
If \(q\) is ramified, its \(4(M-b+1)>0\) fixed points give
\[
 0<4(M-b+1)\leq Z\cdot\Delta_X=2M-2S\leq0,
\]
a contradiction.  Here the diagonal intersection is proper: if \(Z\)
were supported on the diagonal, then \(c\delta=c\), which is impossible
at a ramification point of \(q\) because \(c\) is etale.  This proves
(67.32).

Now suppose \(b=M+1\), \(M\leq16\), and \(z\notin k(E)\).  The inclusion
\(A\subseteq P_q\) first forces \(M\geq15\), and (67.35) again forces at
least two \(\lambda_i=M\).  If the support of \(Z\) is not the diagonal,
proper-intersection positivity gives \(0\leq2M-2S\leq0\).  Hence
\(S=M\), and the spectrum is \((M,M,-M)\).  The adjunction argument
(67.27)--(67.28) is independent of \(b\): for the reduced support
\(\Gamma\), with generic degree \(f\) and \(n=M/f\), it gives
\[
 g(\widetilde\Gamma)=1+2n,\qquad
 p_a(\Gamma)=1-2n^2+4n.
\]
Thus \(n=1\), which would produce an automorphism of \(X\) with a mixed
sign pattern, contrary to (67.15).  Therefore \(Z\) is supported on the
diagonal and \(c\delta=c\).  The map \(c\) factors through the
degree-two map \(q\), so \(M\) is even. \(\square\)

## 4. The dihedral genus-one row for odd \(M\)

Assume in this section that
\[
                  G=D_{14},\qquad b=1,\qquad M\text{ is odd}.         \tag{67.37}
\]
Then \(z\notin k(E)\).  Choose the reflection \(\gamma\in G\) whose
fixed field is \(k(E)\).  It fixes \(t\), negates \(z\), and descends to
\(\delta\) on \(C\), so
\[
 p\gamma=\delta p,\qquad a\gamma=\iota_Ya.           \tag{67.38}
\]
Theorem 67.3 gives \(c\delta=\iota_Xc\).

### Lemma 67.5 (odd supports and the two-pattern constraint)

Let \(\mathcal A_Y=\mu_{31}\cup\{\infty\}\) be the 32 branch values of
\(Y\to\mathbf P^1_t\).  For \(\alpha\in\mathcal A_Y\), define
\[
 Z_\alpha=\pi_*t^*(\alpha),\qquad \pi:E\to B,
\]
homogeneously also at infinity, and let \(U_\alpha\) be the odd support
of \(Z_\alpha\) on \(\Delta\).  Then
\[
                 \coprod_{\alpha\in\mathcal A_Y}U_\alpha=\Delta.     \tag{67.39}
\]
If the fiber of \(t\) over \(\alpha\) has profile
\(1^{a_\alpha}2^{b_\alpha}\), then
\[
                              \deg U_\alpha=a_\alpha.                 \tag{67.40}
\]

For \(\xi\in\mathcal A_X\), put
\[
 \Delta_\xi=\{x\in B:r_X(x)=\xi,\ e_x(r_X)=1\}.
\]
The eight sets \(\Delta_\xi\) partition \(\Delta\), each has odd
cardinality at most \(M\), and the vectors
\[
 \rho_\alpha=
  (|U_\alpha\cap\Delta_\xi|\bmod2)_{\xi\in\mathcal A_X}
       \in\mathbf F_2^8
\]
satisfy
\[
                    \rho_\alpha+\rho_\infty\in\{0,\mathbf1\}.        \tag{67.41}
\]

#### Proof

At a point \(x\in\Delta\), inertia in \(D_{14}\) is a reflection.  It
has cycle type \(1\,2^3\) on the seven sheets of \(E/B\).  Thus there is
one unramified sheet \(e_x\) and three ramified sheets, and \(V/E\)
ramifies exactly at \(e_x\).

The map \(V/E\) is the normalized pullback through \(t\) of
\(Y/\mathbf P^1_t\).  Locally it is the normalization of
\(z^2=w^j\).  Because \(V\to Y\) is etale, \(t\) is unramified away
from \(\mathcal A_Y\), and its indices over \(\mathcal A_Y\) are one
or two.  The quadratic pullback ramifies exactly at an index-one point.
Hence \(t(e_x)\) is one unique \(\alpha_x\in\mathcal A_Y\).

The divisor-of-a-norm formula gives
\[
 \operatorname{mult}_x Z_\alpha
   =\sum_{\substack{e\in\pi^{-1}(x)\\t(e)=\alpha}}e_e(t).             \tag{67.42}
\]
The three ramified sheets contribute even terms, and the unique
unramified sheet contributes one exactly for \(\alpha=\alpha_x\).
This proves (67.39).  Conversely, the index-one points over
\(\mathcal A_Y\) are precisely the branch points of \(V/E\), proving
(67.40).

The assertions about \(\Delta_\xi\) follow from (67.23) and the oddness
of \(M\).  Relations (67.38) and (67.20) give
\[
                         \delta^*h=-h,\qquad \delta^*c^*=-c^*.       \tag{67.43}
\]
Thus \(h(J(Y))\) and \(c^*J(X)\) lie in the Prym and are orthogonal by
(67.30).

For a ramified double cover, the branch-coordinate description is
\[
 \operatorname{Prym}(C/B)[2]/q^*J(B)[2]
  \simeq
 \frac{\{\text{even subsets of }\Delta\}}{\langle\Delta\rangle},     \tag{67.44}
\]
with Weil pairing given by intersection parity.  The pullback of the
class represented by two Weierstrass points \(\xi,\xi_0\) of \(X\) has
coordinate
\[
                       \Delta_\xi\mathbin\triangle\Delta_{\xi_0}.
\]
The norm-divisor identity of file 44 is
\[
 q^*Z_\alpha=2D_\alpha,\qquad
 \mathcal O_C(D_\alpha-D_\infty)
     =h([P_\alpha-P_\infty]).                        \tag{67.45}
\]
Writing \(Z_\alpha=U_\alpha+2R_\alpha\) shows that the second class has
coordinate \(U_\alpha\mathbin\triangle U_\infty\).  Orthogonality says
that its intersection parity with every
\(\Delta_\xi\mathbin\triangle\Delta_{\xi_0}\) is zero.  Equivalently,
all eight coordinates of \(\rho_\alpha+\rho_\infty\) are equal, which
is (67.41). \(\square\)

### Theorem 67.6 (odd dihedral interval exclusion)

Under (67.37), the configuration is impossible whenever \(M\leq15\).

#### Proof

Theorem 67.1 gives \(g(E)=6M+1\).  The degree-\(M\) map
\(t:E\to\mathbf P^1\) has only simple ramification, all above
\(\mathcal A_Y\).  Thus Riemann--Hurwitz gives
\[
                     \sum_{\alpha\in\mathcal A_Y}b_\alpha
                       =\deg\operatorname{Diff}(t)=14M.              \tag{67.46}
\]
Put \(k=(M-1)/2\).  Since \(a_\alpha+2b_\alpha=M\) and
\(b_\alpha\leq k\),
\[
 \sum_{\alpha\in\mathcal A_Y}(k-b_\alpha)
       =32k-14M=2M-16.                               \tag{67.47}
\]
For \(M\leq7\), this is already impossible.  For \(9\leq M\leq15\),
at least
\[
                              48-2M                  \tag{67.48}
\]
fibers have \(b_\alpha=k\), hence \(a_\alpha=1\).  Their
\(U_\alpha\)'s are distinct singletons by Lemma 67.5.

If \(U_\alpha=\{x\}\) and \(x\in\Delta_\xi\), then
\(\rho_\alpha=e_\xi\).  Equation (67.41) puts all singleton vectors in
the complementary pair
\[
                         \{\rho_\infty,\rho_\infty+\mathbf1\}.
\]
At most one vector in a complementary pair in \(\mathbf F_2^8\) has
weight one.  Hence all singleton points lie in one fixed block
\(\Delta_{\xi_0}\).  This is impossible because
\[
                         |\Delta_{\xi_0}|\leq M<48-2M
\]
for \(M\leq15\). \(\square\)

## 5. Exact range table and remaining boundary

Here “all \(w\)” means every allowed coefficient dimension
\(3\leq w\leq8\).  Rows marked “combined” use the cited earlier theorem
in addition to this note.

| \(M\) | \(b\) | \(w\) | group | extra hypothesis | conclusion |
|---:|---:|---:|:---:|:---|:---|
| every \(M\geq2\) | \(0\) | all | \(C_{14}\) or \(D_{14}\) | none | excluded by Theorem 67.1 |
| every \(M\geq2\) | \(1\) | all | either | none | \(c\delta=\iota_Xc\), Theorem 67.3 |
| every \(M\geq2\) | \(2M-15\leq b\leq M\) | all | either | \(z\notin k(E)\) | excluded by Theorem 67.4; nonempty only for \(M\leq15\) |
| odd \(M\leq15\) | \(1\) | all | \(D_{14}\) | automatic \(z\notin k(E)\) | excluded by Theorem 67.6 |
| odd \(M\leq16\) | \(M+1\) | all | either | \(z\notin k(E)\) | excluded by the endpoint clause of Theorem 67.4 |
| \(9\) | \(2\) | all | either | none | excluded, combined with files 56, 58, and 60 |
| \(9\) | \(1\) | \(w\geq5\) | \(C_{14}\) | none | excluded, combined with file 66 |

For clarity about the \(M=9,b=2\) row: the proofs of Theorems 56.1,
58.4, and 60.2 use full coefficient span only to produce the quadratic
quotient.  Once \(e=2\) and \(b=2\) are assumed, their local argument
applies unchanged.  The integral congruences force
\(c\delta=\iota_Xc\); then the fifteen-dimensional image of \(J(Y)\)
and the three-dimensional image of \(J(X)\) are orthogonal
anti-invariant subvarieties of the seventeen-dimensional Prym, which is
impossible.

At \(M=9\), Theorem 66.2 gives \(b\leq4\).  The table excludes
\(b=0,2,3,4\), and Theorem 67.6 eliminates the dihedral \(b=1\) row.
Thus any surviving quadratic coefficient coarsening at \(M=9\) must have
\[
              G=C_{14},\qquad b=1,\qquad z\notin k(E).                \tag{67.49}
\]
The weighted-grid theorem in
66_WEIGHTED_GRID_CYCLIC_INTERVAL_EXCLUSION.md excludes this row for
\(w\geq5\).  Only \(w=3,4\) remains.

For general \(M\), the present method leaves cyclic genus-one
coarsenings outside the weighted-grid interval, and middle-genus
coarsenings with \(b<2M-15\).  In the latter range the complement of
\(h(J(Y))\) inside the Prym has dimension at least two, so (67.31) no
longer forces two scalar coordinates to be extremal.  These are genuine
boundaries of the proof, not hidden uses of full coefficient span.
