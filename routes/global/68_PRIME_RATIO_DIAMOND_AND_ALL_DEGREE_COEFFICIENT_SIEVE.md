# Prime genus ratios and the all-degree coefficient sieve

## Status and purpose

**Status: mixed; the all-degree case-B divisor sieve requires correction.**

**Audit: FAIL on the quadratic-core intersection inference in Theorem
68.5(B)** — `/root/c14_elliptic_translation`, 2026-09-04.
[Audit record](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md).
The prime-ratio diamond, norm lower bound, nonpencil result, all of case A,
and the direct case-B Prym bound remain valid. The claimed quadratic core,
the bound \(d\geq r\), and the resulting case-B divisor list are
conditional on \([F\cap E':B]=2\). This is automatic at coefficient
degree two, but has not been proved in general. Use
[file 81](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md)
for the corrected all-degree construction. The original text is retained
below; its opening all-degree claims must be read with this correction.

This note separates the reusable part of the present counterexample strategy
from the calculations specific to

\[
 X:v^2=x^7-x+1,
 \qquad
 Y:z^2=1-t^{31}.
\]

Let (X,Y) be arbitrary smooth projective curves of genus at least two over
an algebraically closed field (k).  Suppose that, for an odd prime (r),

\[
             g(Y)-1=r\bigl(g(X)-1\bigr).                 \tag{68.1}
\]

The first theorem says that a common finite-etale cover automatically
produces an equal-degree diamond with a free symmetry of order (r).  No
orbifold atlas, automorphism calculation, or special equation is needed for
this step.

When (Y) is hyperelliptic, its degree-two function can then be normed
through the order-(r) cover.  Assuming only a simple Jacobian and the
absence of a degree-(r) pencil on (Y), the resulting coefficient curve
satisfies an all-degree divisor sieve.  In the initial interval

\[
                         r+2\leq M<2r,                  \tag{68.2}
\]

the coefficient map is necessarily birational or quadratic.  For arbitrary
(M), every possible coefficient degree is indexed by a divisor of (M)
which is at least (r).  Thus the reduction remains finite and explicit in
every degree, rather than being a phenomenon confined to (M=9).

The current pair is the specialization

\[
       r=7,\qquad g(X)-1=2,\qquad g(Y)-1=14.
\]

The special-case files are deliberately retained until this theorem has
received an independent audit.

## 1. A prime genus ratio forces an equal-degree diamond

### Theorem 68.1 (prime-ratio diamond)

Assume (68.1).  If (X) and (Y) have a finite-etale cover in common,
then there are smooth projective curves (V,C), an integer (M\geq1), and
finite-etale maps

\[
 \begin{array}{ccc}
 V&\xrightarrow{\ a\ }&Y\\
 \big\downarrow p&&\\[-2mm]
 C&\xrightarrow{\ c\ }&X
 \end{array}                                             \tag{68.3}
\]

such that

\[
 \deg p=r,\qquad \deg a=\deg c=M,                       \tag{68.4}
\]

(p) is a (C_r)-torsor, and, for a generator
(\beta\in\operatorname{Deck}(V/C)),

\[
                              a\beta\ne a.              \tag{68.5}
\]

In particular,

\[
 g(C)-1=M\bigl(g(X)-1\bigr),
 \qquad
 g(V)-1=M\bigl(g(Y)-1\bigr).                            \tag{68.6}
\]

#### Proof

Start with a connected common finite-etale cover and take a connected
Galois closure (W\to X).  Its composite with the map to (Y) is a
finite-etale map

\[
                         a_W:W\longrightarrow Y
\]

of some degree (N).  Put
(G=\operatorname{Deck}(W/X)).  Etale Riemann--Hurwitz and (68.1) give

\[
 |G|\bigl(g(X)-1\bigr)
       =g(W)-1
       =N\bigl(g(Y)-1\bigr)
       =rN\bigl(g(X)-1\bigr),
\]

and hence

\[
                              |G|=rN.                    \tag{68.7}
\]

Let (P\leq G) be a Sylow (r)-subgroup.  Then

\[
                         |P|=r^{v_r(N)+1}.               \tag{68.8}
\]

The map (a_W) cannot be invariant under all of (P).  If it were, it
would descend through the free quotient (W\to W/P), so its degree (N)
would be divisible by (|P|), contrary to (68.8).

Choose a composition series

\[
 1=P_0\triangleleft P_1\triangleleft\cdots\triangleleft P_s=P,
 \qquad P_{i+1}/P_i\simeq C_r.                          \tag{68.9}
\]

There is a first (i) for which (a_W) is invariant under (P_i) but
not under (P_{i+1}).  Set

\[
                         V=W/P_i,\qquad C=W/P_{i+1},
 \qquad M=N/|P_i|.                                      \tag{68.10}
\]

The invariance under (P_i) descends (a_W) to a finite-etale map
(a:V\to Y) of degree (M).  The map (p:V\to C) is the
(C_r)-torsor associated with (P_{i+1}/P_i), and the defining choice
of (i) gives (68.5).  Finally,

\[
 \deg(C/X)=[G:P_{i+1}]
   ={rN\over r|P_i|}=M.
\]

This proves (68.3)--(68.5), and (68.6) is another application of etale
Riemann--Hurwitz.  \(\square\)

## 2. The universal norm obstruction

We isolate the only property of (Y) needed to make the first Jacobian
norm survive.

### Lemma 68.2 (a vanishing norm produces a degree-(r) pencil)

Let (p:R\to D) be a finite separable map of degree (r), and let
(b:R\to Y) be a finite map.  If

\[
                     p_*b^*:J(Y)\longrightarrow J(D)   \tag{68.11}
\]

vanishes, then (Y) admits a morphism of degree (r) to
(\mathbf P^1).

#### Proof

The Rosati dual of (68.11) is the homomorphism induced by

\[
 D\longrightarrow\operatorname{Pic}^r(Y),
 \qquad d\longmapsto
       \mathcal O_Y\bigl(b_*p^*(d)\bigr).               \tag{68.12}
\]

If (68.11) is zero, (68.12) is constant.  Hence all divisors
(b_*p^*(d)) belong to one complete linear system of degree (r).
They do not form a constant family of divisors, since otherwise the
surjective map (b) would have finite image.  They also have no common
base point: for fixed (y\in Y), the parameters whose divisor contains
(y) lie in the finite set (p(b^{-1}(y))).  The containing complete
linear system is therefore positive-dimensional and base-point-free.
Two suitable sections without a common zero give the asserted degree-(r)
map.  \(\square\)

### Theorem 68.3 (uniform lower bound for the diamond degree)

In addition to (68.1), suppose that

1. (J(Y)) is absolutely simple;
2. (g(Y)>g(X)); and
3. (Y) has no degree-(r) morphism to (\mathbf P^1).

Then every diamond (68.3) satisfies

\[
                              M\geq r+2.                 \tag{68.13}
\]

#### Proof

Put

\[
                       h=p_*a^*:J(Y)\longrightarrow J(C).
\]

Lemma 68.2 makes (h) nonzero.  Absolute simplicity therefore makes its
image an abelian subvariety of dimension (g(Y)).  On the other hand,

\[
                 c_*h:J(Y)\longrightarrow J(X)
\]

is zero: a nonzero map from the simple variety (J(Y)) would have finite
kernel, which is impossible because (g(Y)>g(X)).  Thus
(\operatorname{im}(h)) lies in the Prym of (c:C\to X), whose
dimension is

\[
             g(C)-g(X)=(M-1)\bigl(g(X)-1\bigr).         \tag{68.14}
\]

Writing (s=g(X)-1), so that (g(Y)=rs+1), gives

\[
                      rs+1\leq(M-1)s.
\]

Since (s\geq1) and (M) is integral, this is exactly (M\geq r+2).
\(\square\)

### Corollary 68.4 (the hyperelliptic hypothesis)

Assume (\operatorname{char}k\ne2,r), (r) is odd, and (Y) is
hyperelliptic.  Under (68.1), (Y) has no degree-(r) morphism to
(\mathbf P^1).  Hence assumptions 1 and 2 of Theorem 68.3, together
with hyperellipticity, imply (68.13).

#### Proof

If a degree-(r) map existed, it and the hyperelliptic degree-two map
would generate (k(Y)), since their coprime degrees leave no nontrivial
common intermediate degree.  Castelnuovo--Severi would give

\[
                              g(Y)\leq r-1.
\]

But (68.1) gives (g(Y)=r(g(X)-1)+1>r-1), a contradiction.  The
assumption (r\ne\operatorname{char}k) ensures that the degree-(r)
map is separable.  \(\square\)

## 3. The hyperelliptic coefficient curve

Assume for the rest of the note that the hypotheses of Corollary 68.4
hold and choose a hyperelliptic presentation

\[
                         k(Y)=k(t,z),\qquad z^2=f(t).    \tag{68.15}
\]

Write

\[
                         K=k(V),\qquad F=k(C).
\]

The element (t\in K) is primitive for the degree-(r) extension
(K/F).  Indeed, if the generator (\beta) fixed (t), then
(\beta(z)/z\) would have square one.  Since (r) is odd, it would be
one, forcing (a\beta=a), contrary to (68.5).

The homogeneous norm of the hyperelliptic pencil through (p) is a
degree-(r) binary form whose coefficients are sections of a
base-point-free line bundle (L) on (C), with

\[
                              \deg L=2M.                \tag{68.16}
\]

Let (W) be the span of its (r+1) coefficient sections.  Thus

\[
                              \dim W\leq r+1.            \tag{68.17}
\]

In fact the opposite structural bound is uniform as well.

### Proposition 68.4a (the coefficient system is never a pencil)

Under the standing hypotheses,

\[
                              3\leq\dim W\leq r+1.       \tag{68.17a}
\]

#### Proof

A one-dimensional base-point-free space cannot generate the
positive-degree line bundle \(L\).  Suppose that \(\dim W=2\).  The
coefficient construction then gives maps

\[
 f:C\longrightarrow\mathbf P^1_b,\qquad
 R:\mathbf P^1_t\longrightarrow\mathbf P^1_b
\]

of degrees \(2M\) and \(r\), respectively, such that \(V\) is the
normalization of their fiber product.  The map \(R\) is separable because
\(r\ne\operatorname{char}k\).

Let \(\mathcal A\) be the \(2rs+4\) branch values of the hyperelliptic
map \(Y\to\mathbf P^1_t\), put

\[
                    \mathcal B=R(\mathcal A),\qquad
                    m=|\mathcal B|,
\]

and fix \(b\in\mathcal B\).  Let \(k_b\) be the number of points of
\(\mathcal A\) over \(b\), and let \(\ell_b\) be the number of other
points in \(R^{-1}(b)\).  Comparing local ramification indices in the
normalized fiber product shows that there is
\(\rho_b\in\{1,r\}\) such that

\[
 r=\rho_b(k_b+2\ell_b),\qquad k_b\ \text{is odd}.       \tag{68.17b}
\]

The fiber of \(f\) over \(b\) consists of \(M/\rho_b\) points of
ramification index \(2\rho_b\).  Its contribution to the different is
therefore at least

\[
 {M\over\rho_b}(2\rho_b-1)\geq M.                      \tag{68.17c}
\]

On the other hand,

\[
 \deg\operatorname{Diff}(f)
   =2g(C)-2+2\deg f
   =2M(s+2).
\]

Consequently \(m\leq2s+4\).  A degree-\(r\) fiber contains at most
\(r\) points of \(\mathcal A\), so

\[
 m\geq\left\lceil{2rs+4\over r}\right\rceil
 =\begin{cases}
    2s+2,&r=3,\\
    2s+1,&r\geq5.
  \end{cases}                                          \tag{68.17d}
\]

Finally
\[
                         2rs+4=\sum_{b\in\mathcal B}k_b
\]
is even and every \(k_b\) is odd, so \(m\) is even.  Combining this
with (68.17d) gives

\[
                              m\in\{2s+2,2s+4\}.        \tag{68.17e}
\]

The divisor identity (68.17b) says that
\[
                         R^*\mathcal B\equiv\mathcal A
                                      \pmod2.
\]
It therefore lifts \(R\) to a degree-\(r\) map from \(Y\) to the double
cover \(Y_{\mathcal B}\) of \(\mathbf P^1_b\) branched at
\(\mathcal B\).  By (68.17e),

\[
                      g(Y_{\mathcal B})\in\{s,s+1\}.
\]

This is positive and strictly smaller than \(g(Y)=rs+1\).  Pullback
would embed a positive-dimensional proper abelian subvariety in the
absolutely simple \(J(Y)\), a contradiction.  Hence \(\dim W\ne2\),
proving (68.17a). \(\square\)

Let (B) be the normalization of the coefficient image, let

\[
 e=[F:k(B)],\qquad L=q^*A,\qquad d=\deg A.              \tag{68.18}
\]

Then

\[
                              ed=2M.                    \tag{68.19}
\]

The minimal polynomial of (t) over (F) has degree (r), and its
coefficients generate (k(B)).  It remains irreducible over (k(B)).
Let (E) be the smooth curve with

\[
                              k(E)=k(B)(t).              \tag{68.20}
\]

The standard compositum calculation gives

\[
 [k(E):k(B)]=r,\qquad [K:k(E)]=e,\qquad
 [k(E):k(t)]=d,                                        \tag{68.21}
\]

and (V) is the normalization of (C\times_B E).

## 4. The square-root dichotomy in every degree

Put (s=g(X)-1), so (g(Y)-1=rs), and retain

\[
                         h=p_*a^*:J(Y)\longrightarrow J(C).
\]

### Theorem 68.5 (all-degree coefficient dichotomy)

Exactly one of the following occurs.

#### A. The square root is already spectral

If (z\in k(E)), then (a) factors through a finite-etale map

\[
                   a_E:E\longrightarrow Y,\qquad
                   \deg a_E=M/e=d/2,                   \tag{68.22}
\]

and

\[
       q_*h=[e]\,(E/B)_*a_E^*\ne0.                     \tag{68.23}
\]

Consequently

\[
                 g(B)\geq g(Y),\qquad M\geq re.         \tag{68.24}
\]

More exactly, put \(n=M/e\) and

\[
                       \eta_A=ns+1-g(B).                \tag{68.24a}
\]

Then

\[
 \deg\operatorname{Diff}(C/B)=2e\eta_A,\qquad
 \deg\operatorname{Diff}(E/B)=2r\eta_A.                \tag{68.24b}
\]

Thus the two lower maps are etale simultaneously.  In particular,
\(n=r\) forces \(g(B)=g(Y)\), \(\eta_A=0\), and both maps to \(B\)
are etale.

#### B. The square root gives a quadratic core

If (z\notin k(E)), then (e) is even.  Put

\[
                  E'=E(z),\qquad k(D)=F\cap k(E')
\]

inside (K), and put (m=e/2).  There is a normalized fiber square

\[
 \begin{array}{ccc}
 V&\longrightarrow&E'\\
 \big\downarrow&&\big\downarrow\\[-2mm]
 C&\longrightarrow&D
 \end{array}                                             \tag{68.25}
\]

with degrees

\[
 [D:B]=2,\qquad [C:D]=m,\qquad [E':D]=r.                \tag{68.26}
\]

The map (E'\to Y) is finite etale of degree (d).  Moreover,

\[
 q_*h=0,\qquad
 \operatorname{im}(h)\subseteq\operatorname{Prym}(C/B),
 \qquad
 g(B)\leq (M-r)s.                                      \tag{68.27}
\]

Furthermore,

\[
 h_D=(E'/D)_*(E'/Y)^*:J(Y)\longrightarrow J(D)          \tag{68.28}
\]

is nonzero and

\[
                              h=(C/D)^*h_D.              \tag{68.29}
\]

In particular,

\[
                       g(Y)\leq g(D)\leq ds+1,
 \qquad d\geq r.                                       \tag{68.30}
\]

If

\[
                              \eta=ds+1-g(D),            \tag{68.31}
\]

then the two lower maps in (68.25) have exact different degrees

\[
 \deg\operatorname{Diff}(C/D)=e\eta,
 \qquad
 \deg\operatorname{Diff}(E'/D)=2r\eta.                 \tag{68.32}
\]

Thus either lower map is etale if and only if both are etale, and this
happens exactly when (\eta=0).  In particular, (d=r) forces

\[
                              g(D)=g(Y),\qquad\eta=0.    \tag{68.33}
\]

#### Proof

If (z\in k(E)), then (k(Y)\subset k(E)\subset K).  The two maps in
the resulting factorization (V\to E\to Y) are intermediate maps of
the finite-etale cover (V\to Y), so they are finite etale and have the
degrees in (68.22).  Functoriality of pullback and norm gives

\[
                         q_*h=[e](E/B)_*a_E^*.
\]

Lemma 68.2 makes the last homomorphism nonzero.  Simplicity of (J(Y))
therefore gives (g(B)\geq g(Y)).  The map (q) is separable because
its scalar extension to (k(E)) is (K/k(E)), an intermediate extension
of (K/k(Y)).  Riemann--Hurwitz now gives

\[
 Ms=g(C)-1\geq e(g(B)-1)\geq ers,
\]

which proves (68.24).

Since \(E\to Y\) is etale of degree \(n=M/e\),

\[
 g(E)-1=nrs.
\]

Riemann--Hurwitz for \(q:C\to B\) and \(E\to B\), respectively, now
gives

\[
\begin{aligned}
 \deg\operatorname{Diff}(C/B)
   &=2ens-e(2g(B)-2)=2e\eta_A,\\
 \deg\operatorname{Diff}(E/B)
   &=2nrs-r(2g(B)-2)=2r\eta_A.
\end{aligned}
\]

This proves (68.24b).  If \(n=r\), the lower bound \(g(B)\geq g(Y)\)
and the upper bound \(g(B)\leq ns+1\) coincide, proving the endpoint
claim.

Suppose (z\notin k(E)).  Then adjoining (z) gives a quadratic
subextension (k(E')/k(E)) of (K/k(E)), so (e) is even and
([K:k(E')]=e/2=m).  Since (Fk(E')=K), the
compositum--intersection formula gives

\[
 [F:F\cap k(E')]=m,\qquad [F\cap k(E'):k(B)]=2.
\]

This proves (68.25)--(68.26); the equality ([E':D]=r) follows from
([K:F]=r).  Since (E') contains (k(Y)), it is an intermediate curve
of (V\to Y), and (E'\to Y) is finite etale of degree (d).

Let \(\gamma\) be the involution of \(E'/E\), and let
\(\sigma:E'\to E\).  The restriction of \(\gamma\) to \(Y\) is its
hyperelliptic involution \(\iota_Y\).  Therefore

\[
 \sigma^*\sigma_*(E'/Y)^*
   =(1+\gamma^*)(E'/Y)^*
   =(E'/Y)^*(1+\iota_Y^*)=0.
\]

The map \(\sigma^*:J(E)\to J(E')\) has finite kernel, so the displayed
identity forces \(\sigma_*(E'/Y)^*=0\).  Factoring \(V\to E'\) and
using pull-push now gives \(q_*h=0\).  Thus the \(g(Y)\)-dimensional
image of \(h\) lies in \(\operatorname{Prym}(C/B)\), and

\[
 g(Y)\leq g(C)-g(B)=Ms+1-g(B).
\]

Since \(g(Y)=rs+1\), this is the genus bound in (68.27).

Lemma 68.2 applied to the degree-(r) map (E'\to D) proves that
(h_D\ne0).  The equality (68.29) is finite-flat base change for divisor
correspondences in the normalized square (68.25).  Hence simplicity gives
(g(D)\geq g(Y)).

Etale Riemann--Hurwitz for (E'\to Y) gives

\[
                         g(E')-1=drs.
\]

Riemann--Hurwitz for the degree-(r) map (E'\to D) then gives
(g(D)-1\leq ds).  This proves (68.30), including (d\geq r).

Finally (M=md), and Riemann--Hurwitz in the two lower maps gives

\[
\begin{aligned}
 \deg\operatorname{Diff}(C/D)
   &=2mds-m(2g(D)-2)=2m\eta=e\eta,\\
 \deg\operatorname{Diff}(E'/D)
   &=2drs-r(2g(D)-2)=2r\eta.
\end{aligned}
\]

This proves (68.32).  If (d=r), the lower and upper bounds in (68.30)
coincide, proving (68.33).  \(\square\)

## 5. The finite divisor sieve

### Corollary 68.6 (all possible coefficient degrees)

For every (M\geq r+2), the coefficient degree (e=[C:B]) obeys one
of the following two explicitly enumerable conditions.

1. There is a divisor (n\mid M), with (n\geq r), such that
   
   \[
                    z\in k(E),\qquad e=M/n,\qquad d=2n. \tag{68.34}
   \]

2. There is a divisor (d\mid M), with (d\geq r), such that
   
   \[
              z\notin k(E),\qquad e=2M/d.              \tag{68.35}
   \]

In particular:

- if (M<2r), then (e\in\{1,2\});
- if (M\geq r+2) is prime, then (e\in\{1,2\});
- every odd nonbirational coefficient degree satisfies
  
  \[
                              M\geq3r;                  \tag{68.36}
  \]
- in case 2, the endpoint (d=r) has no shared ramification defect.

#### Proof

In case A of Theorem 68.5, put (n=M/e=d/2).  Equations (68.22) and
(68.24) say that (n\mid M) and (n\geq r), giving (68.34).

In case B write (e=2m).  Equation (68.19) becomes (M=md), while
(68.30) gives (d\geq r).  This is (68.35).

If (M<2r), every proper divisor of (M) is at most (M/2<r).  Thus
the only divisor allowed in either (68.34) or (68.35) is (M) itself,
which gives respectively (e=1) and (e=2).  The same reasoning applies
when (M) is prime.  An odd (e>1) can only occur in case A, where
(e\geq3) and (68.24) gives (68.36).  The final assertion is (68.33).
\(\square\)

## 6. What is universal and what remains pair-specific

The following parts of the current strategy are now independent of the
equations of (X) and (Y):

1. the prime-ratio diamond (Theorem 68.1);
2. the norm lower bound (M\geq r+2) under the three transparent
   hypotheses of Theorem 68.3;
3. the hyperelliptic norm-polynomial construction;
4. the square-root dichotomy, quadratic core, exact common defect, and
   divisor sieve in Theorem 68.5 and Corollary 68.6.

The following inputs are genuinely special to a selected pair and may be
optimized by changing it:

1. proving that (J(Y)) is absolutely simple and determining its
   integral endomorphism ring;
2. controlling (\operatorname{End}(J(X))), automorphisms of (X), and
   the position of (J(X)) inside (J(C));
3. arranging the hyperelliptic branch set over a small finite field for
   weighted-grid and Weil-bound arguments;
4. excluding the birational coefficient curve and the remaining quadratic
   cores.

Thus the present progress is not tied to the original two equations.  A
particularly attractive redesign is to keep a small odd prime (r), take
(X) nonhyperelliptic, and choose a hyperelliptic (Y) with absolutely
simple Jacobian and (g(Y)-1=r(g(X)-1)).  One should ask that every
Rosati-symmetric integral endomorphism of (J(X)) in the explicit norm
ball relevant to the first several values of (M) be scalar.  This is a
finite lattice condition.  It cannot be replaced by the formally stronger
condition (\operatorname{End}(J(X))=\mathbf Z): over
(\overline{\mathbf F}_5), every abelian variety descends to a finite field
and acquires a geometric Frobenius endomorphism, so that condition is
impossible in positive dimension.  The realistic small-norm condition
would still make the coefficient-involution compression scalar in the
desired range, while keeping the coefficient-space bound
(\dim W\leq r+1).  Both simplifications can be optimized and certified
when selecting a replacement pair.
