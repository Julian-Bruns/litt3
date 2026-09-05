# A parameterized cyclic-hyperelliptic Honda sieve

## Status and scope

**Status: proved.**  Independent audit pending.

This note supplies the arithmetic complement to file 68.  That file proves
the universal prime-ratio diamond, the lower bound $M\ge r+2$, and the
all-degree coefficient/core sieve.  Here we identify the extra information
available when the hyperelliptic curve is the cyclic curve
$Y_\ell:z^2=1-t^\ell$, and separate it from the numerical choices

\[
                 (p,\ell,r,g)=(5,31,7,3).
\]

Here $p$ is the characteristic, $\ell$ is the exponent in the cyclic
hyperelliptic curve, $r$ is the order of the quotient in the diamond, and
$g$ is the genus of the other curve.  The new conclusions are:

1. the Honda algebra and absolute simplicity are decided by a finite coset
   count attached to $(p,\ell)$;
2. the primitive orbit multiplicity is controlled by
   $\operatorname{ord}_\ell(p)$ and $r-1$;
3. all Rosati, coincidence, image, and conductor formulas admit uniform
   versions; and
4. a finite-difference test followed by explicit ideal-
   lattice minima gives an exact algorithm for excluding small odd cross
   correspondences in the *full* geometric endomorphism order.

For composite exponents the Jacobian normally has old factors, so the
Honda and lattice statements must be replaced by factor-by-factor versions.

Throughout, $k=\overline{\mathbf F}_p$, where $p$ is odd.

## 1. A checkable absolute-simplicity criterion

Let $\ell\ne p$ be an odd prime, put

\[
 Y_\ell:\ z^2=1-t^\ell,
 \qquad h=g(Y_\ell)=\frac{\ell-1}{2},
 \qquad J_\ell=\operatorname{Jac}(Y_\ell),              \tag{69.1}
\]

and write

\[
 G=(\mathbf Z/\ell\mathbf Z)^\times,
 \qquad H=\langle p\rangle\le G,
 \qquad f=|H|=\operatorname{ord}_\ell(p),               \tag{69.2}
\]

\[
 K=\mathbf Q(\zeta_\ell),
 \qquad E=K^H,
 \qquad \Phi=\{1,2,\ldots,h\}\subset G.                \tag{69.3}
\]

For a coset $aH\in G/H$, define

\[
                         m(aH)=|aH\cap\Phi|.             \tag{69.4}
\]

### Proposition 69.1 (Honda screen)

Assume that:

1. the function $m:G/H\to\{0,\ldots,f\}$ has trivial stabilizer under
   translation by $G/H$; and
2. the least common multiple of
   \[
       \frac{f}{\gcd(f,m(aH))}\qquad(aH\in G/H),         \tag{69.5}
   \]
   with the value $1$ used when $m(aH)=0$, is $f$.

Then $J_\ell$ is absolutely simple.  Its geometric rational endomorphism
algebra

\[
                  \mathscr D=\operatorname{End}^0_k(J_\ell)
\]

is a central division algebra of degree $f$ over $E$, and $K$ is a maximal
commutative subfield.  If $F$ denotes $p$-power Frobenius, then

\[
 FxF^{-1}=\sigma(x),\qquad \sigma(\zeta_\ell)=\zeta_\ell^p,
 \qquad F^f=\pi\in E,                                   \tag{69.6}
\]

and

\[
                \mathscr D=\bigoplus_{s=0}^{f-1}KF^s.   \tag{69.7}
\]

#### Proof

The automorphism $t\mapsto\zeta_\ell t$ embeds $K$ in
$\operatorname{End}^0(J_\ell)$.  Its eigencharacters on regular
differentials

\[
                         t^{i-1}\frac{dt}{z},
                         \qquad1\le i\le h,
\]

give the CM type $\Phi$.  The Shimura--Taniyama slope formula says that,
at the prime represented by $aH$, the slope is

\[
                            \frac{m(aH)}{f}.             \tag{69.8}
\]

Conjugation by $F$ induces $\sigma$ on $K$.  Hence $F^f$ centralizes $K$.
The $K$-action has rank one on prime-to-$p$ rational Tate modules, so its
centralizer is $K$; therefore $\pi=F^f\in K$.  Since $F$ fixes $F^f$ by
conjugation, $\pi\in E$.

The prime $p$ splits completely in $E$ and is unramified of residue degree
$f$ in $K/E$.  The local Honda invariants are thus the fractions (69.8)
modulo one.  Assumption 2 says that their least common denominator, hence
the Schur index of the associated simple isogeny class, is $f$.

If an automorphism of $E/\mathbf Q$ fixed $\pi^N$ for some $N\ge1$, it
would preserve the valuations of its principal ideal at all primes above
$p$.  Those valuations are $N m(aH)$, so Assumption 1 forces the
automorphism to be trivial.  Consequently

\[
                         \mathbf Q(\pi^N)=E
                         \qquad(N\ge1).                  \tag{69.9}
\]

The simple Honda factor attached to $\pi$ has dimension

\[
             \frac12[E:\mathbf Q]f
                =\frac{\ell-1}{2}=h.                    \tag{69.10}
\]

It therefore accounts for all of $J_\ell$.  Equation (69.9), together
with the unchanged normalized local invariants after finite constant-field
extension, shows that this factor stays simple over every finite extension.
Thus $J_\ell$ is absolutely simple and its geometric division algebra has
degree $f$ over $E$.  Dimension now makes $K/E$ a maximal subfield and
gives (69.7). \(\square\)

### Remark 69.2

Both hypotheses are finite combinatorics on subsets of
$(\mathbf Z/\ell\mathbf Z)^\times$.  If every value strictly between $0$
and $f$ is coprime to $f$, then Assumption 2 follows as soon as one such
value occurs.  The stronger condition

\[
        \gcd(m(aH),f)=1\quad\text{whenever }0<m(aH)<f    \tag{69.11}
\]

will later ensure coefficientwise control at $p$.  It is automatic when
$f$ is prime.

## 2. Arithmetic multiplicity in the prime-order diamond

Let $Y$ be any hyperelliptic curve of genus $h\ge2$.  Let $X$ be a smooth
projective curve of genus $g\ge2$, and let $r\ne p$ be an odd prime.
Suppose a common-cover reduction has produced smooth curves $V,C$ and
finite etale maps

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a\ }&Y\\
 \big\downarrow\scriptstyle q&&\\[-2mm]
 C&\xrightarrow{\ c\ }&X
 \end{array}
 \qquad
 \deg a=\deg c=M,qquad \deg q=r,                       \tag{69.12}
\]

where $q$ is a $C_r$-torsor generated by $\beta$ and
$a\beta\ne a$.

### Lemma 69.3 (maps are detected by Jacobian pullback)

If $f_1,f_2:W\to Y$ are nonconstant maps to a curve of genus at least two
and

\[
                         f_1^*=f_2^*:J(Y)\to J(W),       \tag{69.13}
\]

then $f_1=f_2$.

#### Proof

Dualizing (69.13) gives equality of the pushforwards.  Abel--Jacobi applied
to divisors $w-w_0$ then shows that the two maps into the Abel--Jacobi copy
of $Y\subset J(Y)$ differ by one fixed translation.  That translation
preserves the Abel--Jacobi curve and induces an automorphism of $Y$ acting
trivially on its Jacobian.  The natural action of the automorphism group of
a genus-at-least-two curve on its principally polarized Jacobian is
faithful.  Hence the translation and the automorphism are trivial.
\(\square\)

Theorem 68.1 produces (69.12) from any common cover whenever
$h-1=r(g-1)$.  Its norm theorem and hyperelliptic corollary give

\[
              \eta=q_*a^*\ne0,\qquad M\ge r+2.          \tag{69.14}
\]

For $Y=Y_\ell$, the genus relation is the useful design equation

\[
                         \ell=2r(g-1)+3.                 \tag{69.15}
\]

We use these results from file 68 without reproving them.

### Theorem 69.4 (primitive orbit multiplicity)

Assume now that $Y=Y_\ell$ satisfies Proposition 69.1, that $r\ne\ell$,
and that

\[
                                f<r-1.                   \tag{69.16}
\]

Put

\[
                     m_0=\frac{r-1}{\gcd(r-1,f)}.        \tag{69.17}
\]

The $J_\ell$-isotypic part generated in $J(V)$ by

\[
                 a^*J_\ell,\ \beta^*a^*J_\ell,\ldots,
                 \beta^{(r-1)*}a^*J_\ell
\]

contains one invariant copy and at least $m_0$ primitive copies of
$J_\ell$.  More precisely, its primitive multiplicity is a positive
multiple of $m_0$.  The primitive part lies in
$\operatorname{Prym}(V/C)$, so necessarily

\[
 m_0h\le(r-1)M(g-1).                                    \tag{69.22}
\]

#### Proof

Let $\mathscr D=\operatorname{End}^0(J_\ell)$ and

\[
 \mathcal H=\operatorname{Hom}^0(J_\ell,J(V)),
 \qquad e=a^*,\qquad T=\beta^*.

This is a right $\mathscr D$-space and $T$ is $\mathscr D$-linear.
If the line $e\mathscr D$ were $T$-invariant, then $Te=e u$ for some
$u\in\mathscr D$ with $u^r=1$.  Since $E\subset\mathbf Q(\zeta_\ell)$
and $r,\ell$ are distinct primes,

\[
                       E\cap\mathbf Q(\zeta_r)=\mathbf Q.
\]

A nontrivial $u$ would therefore generate a degree-$(r-1)$ field over
$E$ inside the degree-$f$ division algebra $\mathscr D$, contradicting
(69.16).  Thus $u=1$.  Lemma 69.3 would then give $a\beta=a$, contrary to
(69.12).  The primitive part of the cyclic module generated by $e$ is
therefore nonzero.

Because $\Phi_r$ is irreducible over $E$, the action on a primitive
$\mathscr D$-space of dimension $m$ embeds

\[
                         E(\zeta_r)\hookrightarrow M_m(\mathscr D).
\tag{69.23}
\]

A separable field embedded in a central simple algebra has degree dividing
the degree of that algebra.  Hence

\[
                              r-1\mid fm,
\]

so $m$ is a positive multiple of $m_0$.

The norm $1+T+\cdots+T^{r-1}$ kills this primitive part.  On the other
hand,

\[
 (1+T+\cdots+T^{r-1})e=q^*q_*a^*=q^*\eta\ne0
\]

by (69.14).  Thus the invariant multiplicity is exactly one in
the cyclic span: it is nonzero, while all $r$ cyclic generators have the
same image under the invariant projector, so it is at most one.  Finally

\[
 \dim\operatorname{Prym}(V/C)
      =g(V)-g(C)=(r-1)M(g-1),
\]

which gives (69.22). \(\square\)

## 3. Uniform Rosati and conductor identities

Continue with the abstract diamond (69.12) under the prime-ratio and
hyperelliptic hypotheses of file 68, and put

\[
 e=a^*,\qquad T=\beta^*,\qquad
 N=1+T+\cdots+T^{r-1}=q^*q_*,                          \tag{69.24}
\]

\[
 \eta=q_*a^*,\qquad s=\eta^\dagger\eta=e^\dagger Ne.  \tag{69.25}
\]

For $1\le j\le r-1$, let

\[
 I_j=\deg(a,a\beta^j)^*\Delta_Y                         \tag{69.26}
\]

with local intersection multiplicities.

### Proposition 69.7 (norm and coincidence formulas)

If $J(Y)$ is absolutely simple, then

\[
 e^\dagger e=[M],\qquad N^\dagger=N,\qquad N^2=rN,     \tag{69.27}
\]

\[
                         0<s<[rM]                       \tag{69.28}
\]

in the Rosati-positive cone, and

\[
 \operatorname{Tr}(s\mid H^1(Y))
       =2M(h+r-1)-\sum_{j=1}^{r-1}I_j.                  \tag{69.29}
\]

Moreover $I_j=I_{r-j}$.

#### Proof

The pull--push identities give (69.27) and (69.25).  Equation (69.14) and
absolute simplicity make $s$ positive definite.  Also

\[
                   [rM]-s=e^\dagger(r-N)e
\]

is positive.  If it vanished, the image of $e$ would lie in the invariant
part of $J(V)$, giving $Te=e$ and then $a\beta=a$ by Lemma 69.3.  This
proves strictness.

The $j=0$ term $a_*a^*=[M]$ has trace $2hM$ on $H^1(Y)$.  For $j\ne0$,
the Lefschetz formula gives

\[
 \operatorname{Tr}(a_*\beta^{j*}a^*\mid H^1(Y))=2M-I_j.
\]

Summing proves (69.29).  The substitution $v\mapsto\beta^jv$ identifies
the coincidence divisors for $j$ and $r-j$, including multiplicities.
\(\square\)

### Proposition 69.8 (image and conductor formulas)

The map

\[
                         (q,a):V\longrightarrow C\times Y
\]

is birational onto its reduced image $D$.  All branches of $D$ are smooth,
and

\[
 D^2=\sum_{j=1}^{r-1}I_j-2M(h-1),                       \tag{69.30}
\]

\[
 \mathfrak C_D=\sum_{j=1}^{r-1}(a,a\beta^j)^*\Delta_Y, \tag{69.31}
\]

\[
 \delta(D)=\frac12\sum_{j=1}^{r-1}I_j,
 \qquad
 p_a(D)=M(h-1)+1+\frac12\sum_{j=1}^{r-1}I_j.           \tag{69.32}
\]

#### Proof

The generic degree of $V$ over the normalization of $D$ divides the prime
degree $r$ of $q$.  If it were $r$, then $a$ would factor through $q$ and
$a\beta=a$.  Hence it is one.

In $\operatorname{NS}(C\times Y)$, the class of $D$ has fiber part of
bidegree $(r,M)$ and correspondence part represented by $\eta$.  The
correspondence summand has square
$-\operatorname{Tr}(s\mid H^1(Y))$.  Therefore (69.29) gives

\[
 D^2=2rM-\operatorname{Tr}(s\mid H^1(Y))
     =\sum_{j=1}^{r-1}I_j-2M(h-1).
\]

Etale-locally on $C$, the $r$ normalization branches are graphs of etale
maps to $Y$.  On one branch, its conductor exponent is the sum of its
intersection multiplicities with the other $r-1$ branches.  These are
exactly the divisors in (69.31).  Every unordered pair is counted twice,
which proves the delta formula.  Finally $g(V)=M(h-1)+1$, giving the
arithmetic-genus formula. \(\square\)

### Proposition 69.9 (individual cross images)

For $1\le j\le r-1$, let $\Gamma_j$ be the reduced image of
$(a,a\beta^j):V\to Y\times Y$, let $e_j$ be its generic degree, and put

\[
                              d_j=M/e_j.                 \tag{69.33}
\]

Then $e_j\mid M$, the normalization projections of $\Gamma_j$ are etale
of degree $d_j$, and its induced endomorphism $w_j\in\operatorname{End}J(Y)$
satisfies

\[
 \delta(\Gamma_j)
   =d_j^2+(h-1)d_j-\frac12\langle w_j,w_j\rangle.       \tag{69.34}
\]

Consequently

\[
                    \langle w_j,w_j\rangle
                       \le2d_j(d_j+h-1).                 \tag{69.35}
\]

If $d_j\le h$ is odd, then $w_j\ne0$.

#### Proof

The function-field factorization proves the divisibility and etaleness.
For an effective bidegree-$(d_j,d_j)$ curve on $Y\times Y$, its
self-intersection is

\[
                         2d_j^2-\langle w_j,w_j\rangle.
\]

Adjunction, followed by subtraction of the etale-normalization genus
$d_j(h-1)+1$, gives (69.34), and nonnegativity of delta gives (69.35).
If $w_j=0$ and $d_j\le h$, the low-degree hyperelliptic correspondence
theorem (Theorem 45.4) says that $d_j$ must be even. \(\square\)

## 4. A general Frobenius-lattice exclusion test

Return to $Y=Y_\ell$ and assume Proposition 69.1.  In addition assume
$f\ge2$ and the slope-coprimality condition (69.11).  For each prime
$\mathfrak P$ of $K$ over $p$, put

\[
                         m_{\mathfrak P}=v_{\mathfrak P}(\pi).
\]

These are the integers (69.4), up to permutation.  For
$0\le s\le f-1$, define

\[
 \mathcal I_s=\mathfrak D_{K/E}^{-1}
       \prod_{\mathfrak P\mid p}
       \mathfrak P^{-\lfloor s m_{\mathfrak P}/f\rfloor}.             \tag{69.36}
\]

Here

\[
                  \mathfrak D_{K/E}=(1-\zeta_\ell)^{f-1}.             \tag{69.37}
\]

For $1\le s\le f-1$, let

\[
 \mu_s=\min_{0\ne x\in\mathcal I_s}
        p^s\operatorname{Tr}_{K/\mathbf Q}(x\overline x),
 \qquad
 \mu=\min_{1\le s<f}\mu_s.                           \tag{69.38}
\]

These are exact minima of positive-definite ideal lattices of rank
$\ell-1$.

### Proposition 69.10 (full-order coefficient envelope)

If

\[
             v=\sum_{s=0}^{f-1}x_sF^s\in\operatorname{End}(J_\ell),
\]

then

\[
                              x_s\in\mathcal I_s
                              \qquad(0\le s<f).           \tag{69.39}
\]

Moreover the graded pieces are Rosati-orthogonal and

\[
 \langle v,v\rangle
   =\sum_{s=0}^{f-1}p^s
        \operatorname{Tr}_{K/\mathbf Q}(x_s\overline{x_s}).            \tag{69.40}
\]

#### Proof

At every prime away from $p$, a prime-to-$p$ Tate lattice is locally free
of rank one over $\mathcal O_K$.  Frobenius is a semilinear automorphism.
If an $E$-linear operator

\[
                         A=\sum_s a_s\sigma^s
\]

preserves this lattice, then $a_s\in\mathfrak D_{K/E}^{-1}$.  Indeed,
for every integral $u$, the integral matrix trace of
$uA\sigma^{-s}$ is $\operatorname{Tr}_{K/E}(u a_s)$; this is exactly the
definition of the inverse different.  The semilinear coefficient of $F$
is a unit away from $p$, proving the inverse-different part of (69.39).
This argument includes the full matrix order at the ramified prime
$\ell$.

At a prime over $p$ with $0<m_{\mathfrak P}<f$, condition (69.11) makes
the local Honda algebra a division algebra of degree $f$.  In its unique
valuation ring, the $f$ terms $x_sF^s$ have pairwise distinct fractional
valuations

\[
                       v_{\mathfrak P}(x_s)
                            +\frac{s m_{\mathfrak P}}f.
\]

They cannot cancel.  Integrality therefore gives

\[
 v_{\mathfrak P}(x_s)
      \ge-\left\lfloor\frac{s m_{\mathfrak P}}f\right\rfloor.
\tag{69.41}
\]

When $m_{\mathfrak P}=0$, the etale height-$f$ factor of the
$p$-divisible group has a Tate lattice free of rank one over the
unramified ring $\mathcal O_{K,\mathfrak P}$, and the trace argument gives
$v_{\mathfrak P}(x_s)\ge0$.

If $m_{\mathfrak P}=f$, complex conjugation carries $\mathfrak P$ to an
$m=0$ prime, since $\pi\overline\pi=p^f$.  The adjoint of one term is

\[
 (x_sF^s)^\dagger
   =p^s\pi^{-1}\sigma^{f-s}(\overline{x_s})F^{f-s}.     \tag{69.42}
\]

Applying the $m=0$ result to the integral endomorphism $v^\dagger$ gives
$v_{\mathfrak P}(x_s)\ge-s$, which is (69.41) at $m=f$.
This proves (69.39) globally.

Finally $F^\dagger F=p$, the reduced trace vanishes on every nontrivial
graded summand, and the cohomological trace on $K$ is the field trace.
These facts give (69.40). \(\square\)

### Remark 69.10A (adjoint symmetry halves the enumeration)

For $1\le s<f$, adjunction gives an isometry between the two weighted
ideal lattices indexed by $s$ and $f-s$.  Explicitly,

\[
 x\longmapsto
 p^s\pi^{-1}\sigma^{f-s}(\overline x)                 \tag{69.40A}
\]

carries $\mathcal I_s$ bijectively to $\mathcal I_{f-s}$ and preserves
the weighted trace norm.  The ideal statement follows directly by
comparing the valuations in (69.36), using
$m_{\overline{\mathfrak P}}=f-m_{\mathfrak P}$; norm preservation is
also immediate from (69.42).  Hence

\[
                              \mu_s=\mu_{f-s}.
\]

Only $\lfloor f/2\rfloor$ ideal lattices need to be enumerated.

### Proposition 69.11 (finite-difference elimination of the $K$-part)

Let $\Gamma\subset Y_\ell\times Y_\ell$ be a reduced irreducible
effective correspondence of bidegree $(d,d)$, with etale normalization
projections, where $d\ge2$.  Let
$v\in\operatorname{End}(J_\ell)$ be its induced endomorphism.  If

\[
                    4d+1<\left\lceil\frac{\ell}{f-1}\right\rceil,     \tag{69.43}
\]

then the $K$-component of $v$ in (69.7) is zero.

#### Proof

For $b\in\mathbf F_\ell$, put

\[
 t_b=\langle v,\rho^b\rangle,
 \qquad \rho(t,z)=(\zeta_\ell t,z).
\]

Intersecting $\Gamma$ with the graphs of $\rho^b$ and of the composite
of $\rho^b$ with the hyperelliptic involution gives

\[
                         t_b\in\mathbf Z,
                         \qquad |t_b|\le2d.              \tag{69.44}
\]

Write $x$ for the $K$-component of $v^\dagger$.  Coefficient extraction
at $\ell$ gives

\[
                  x\in\mathfrak D_{K/E}^{-1}
                    =(1-\zeta_\ell)^{1-f}\mathcal O_K.
\]

\[
                         t_b=\operatorname{Tr}_{K/\mathbf Q}
                                  (x\zeta_\ell^b).
\]

Taking $f$ forward differences multiplies the trace argument by
$(\zeta_\ell-1)^f$.  Since

\[
 \operatorname{Tr}_{K/\mathbf Q}
       ((1-\zeta_\ell)\mathcal O_K)\subset\ell\mathbf Z,
\]

we get $\Delta^ft_b=0$ modulo $\ell$.  Thus $b\mapsto t_b\pmod\ell$ is
a polynomial function of degree at most $f-1$ on $\mathbf F_\ell$.

A nonconstant polynomial of that degree has at least
$\lceil\ell/(f-1)\rceil$ values.  But (69.44) supplies at most $4d+1$
values, so (69.43) makes the polynomial constant.  The same inequality
implies $4d<\ell$, hence reduction modulo $\ell$ is injective on
$[-2d,2d]$; all the integers $t_b$ are equal.  Their sum is zero because
$\sum_b\rho^b=0$, so every $t_b=0$.  Nondegeneracy of the cyclotomic trace
frame gives $x=0$, and hence the $K$-component of $v$ is zero.
\(\square\)

### Theorem 69.12 (algorithmic exclusion of odd cross degrees)

Under the hypotheses of Proposition 69.10, let $d$ be odd with

\[
 2\le d\le h,
 \qquad
 4d+1<\left\lceil\frac{\ell}{f-1}\right\rceil,
 \qquad
 \mu>2d(d+h-1).                                        \tag{69.45}
\]

Then $Y_\ell\times Y_\ell$ has no reduced irreducible effective
bidegree-$(d,d)$ correspondence whose normalization projections are
etale.

Consequently, in a diamond (69.12), no cross map
$(a,a\beta^j)$ can have normalized image degree $d_j$ satisfying
(69.45).

#### Proof

If such a correspondence existed, its endomorphism $v$ would be nonzero:
$d\le h$ and Theorem 45.4 exclude zero action in odd degree.  Proposition
69.11 kills its $K$-component.  Propositions 69.10 and (69.38) then give

\[
                             \langle v,v\rangle\ge\mu.
\]

On the other hand, (69.35), applied to its normalization, gives

\[
                     \langle v,v\rangle\le2d(d+h-1),
\]

contradicting (69.45).  The cross-map statement follows from Proposition
69.9. \(\square\)

## 5. How to use the parameterized theorem

For a proposed prime-order reduction, the inexpensive screen is now:

1. solve the forced design equation $\ell=2r(g-1)+3$ and retain prime
   $\ell$;
2. choose $p$ and compute the finite coset counts (69.4);
3. test Proposition 69.1 and record $f=\operatorname{ord}_\ell(p)$;
4. conclude immediately that any residual diamond has $M\ge r+2$ and,
   when $f<r-1$, impose the primitive multiplicity (69.17);
5. for each possible proper divisor $d=M/e$, test the elementary
   value-set inequality (69.43); and
6. only for the surviving small $d$, enumerate the exact ideal lattices
   (69.36)--(69.38).

For $(p,\ell,r,g)=(5,31,7,3)$, the coset values are
$0,0,1,1,1,2,2,2,3,3$, one has $f=3$ and $m_0=2$, and (69.17) gives
the primitive multiplicity two; file 68 gives $M\ge9$.  At $d=3$,
(69.43) reads $13<16$.  File 67 computes
$\mu=106$, while the surface bound is $2\cdot3(3+14)=102$.  Thus the
special cubic exclusion is exactly the first strict instance of the
general test, rather than an isolated numerical coincidence.
