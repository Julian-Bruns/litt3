# The normed hyperelliptic branch pencil in the seven-diamond

## Status and purpose

**Status: proved.**  **Audit: PASS with one minor wording correction** --
`/root/norm_polarization_refinement`, 2026-09-04.  The sentence after
(44.27) misses a factor of two when describing its divisor; no displayed
identity or theorem is affected.  [Audit record](audits/44_NORMED_BRANCH_PENCIL_AUDIT.md).

Assume the exact seven-diamond of files 38 and 40:

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg a=\deg c=M,
 \qquad \deg p=7,
 \tag{44.1}
\]

where all three maps are finite etale, (p) is cyclic with generator
\(\beta\), and (a\beta\ne a).  Write the two fixed curves as

\[
       Y:\ z^2=1-t^{31},
       \qquad
       X:\ v^2=q^7-q+1.
\tag{44.2}
\]

This note retains the entire hyperelliptic pencil on (Y) while taking the
norm through (p).  Its 32 ramified fibers give 32 effective degree-(M)
divisors on (C), each of whose double lies in one fixed degree-(2M)
linear system.  That system is a 14-torsion translate of the pullback of the
hyperelliptic pencil on (X).  All 32 doubled divisors lie on a rational
curve of degree at most seven in that linear system.

This is stronger than retaining only the norm line or its degree.  It is not
yet a contradiction: the remaining question is whether such a norm-polynomial
configuration can occur on an etale cover of the explicit curve (X) without
descending to a visible correspondence.

## 1. The 32 doubled divisors

Let

\[
 \mathcal W=\{\alpha\in k:\alpha^{31}=1\}\cup\{\infty\}
\tag{44.3}
\]

be the branch set of the hyperelliptic map (t:Y\to\mathbf P^1), and let
(P_\alpha\) be its ramification point over \(\alpha\).  Thus

\[
 \operatorname{div}_Y(t-\alpha)=2P_\alpha-2P_\infty
 \qquad(\alpha^{31}=1).
\tag{44.4}
\]

Put

\[
 R_\alpha=a^*P_\alpha,\qquad
 D_\alpha=p_*R_\alpha,
 \qquad
 R_\infty=a^*P_\infty,\qquad D_\infty=p_*R_\infty.
\tag{44.5}
\]

Each (R_\alpha) is a reduced divisor of degree (M), and each
(D_\alpha) is an effective divisor of degree (M); the latter need not be
reduced.

### Proposition 44.1 (normed branch fibers)

For every finite \(\alpha\in\mathcal W\),

\[
 \operatorname{div}_C\!\left(\operatorname{Nm}_{V/C}(t-\alpha)\right)
             =2D_\alpha-2D_\infty.
\tag{44.6}
\]

Consequently, if

\[
                         L=\mathcal O_C(2D_\infty),
\tag{44.7}
\]

then (L) has, for every \(\alpha\in\mathcal W\), a nonzero section
(s_\alpha) with

\[
                         \operatorname{div}(s_\alpha)=2D_\alpha.
\tag{44.8}
\]

Equivalently,

\[
 \epsilon_\alpha:=\mathcal O_C(D_\alpha-D_\infty)
                         \in J(C)[2].
\tag{44.9}
\]

Here (s_\infty) is the canonical section represented by the rational
function (1).

#### Proof

Pulling (44.4) back through the etale map (a) gives

\[
       \operatorname{div}_V(t-\alpha)=2R_\alpha-2R_\infty.
\]

For a finite flat map of smooth curves, the divisor of the field norm is the
pushforward of the divisor.  Applying (p_*) proves (44.6).  A rational
function with divisor (44.6), regarded as a section of
(\mathcal O_C(2D_\infty)), has zero divisor (2D_\alpha).  The same
statement for \(\alpha=\infty\) is represented by (1).  Finally, (44.6)
is exactly the assertion that twice (D_\alpha-D_\infty) is principal,
which proves (44.9).  \(\square\)

The two-torsion classes in (44.9) are not unrelated accidental points.  If

\[
                         h=p_*a^*:J(Y)\longrightarrow J(C),
\tag{44.10}
\]

then

\[
       \epsilon_\alpha=h([P_\alpha-P_\infty]).
\tag{44.11}
\]

The 31 classes ([P_\alpha-P_\infty]) generate (J(Y)[2]); their unique
linear relation is their sum, obtained from

\[
             \operatorname{div}_Y(z)
                =\sum_{\alpha^{31}=1}P_\alpha-31P_\infty.
\tag{44.12}
\]

Thus the possible coincidences among the classes (\epsilon_\alpha) are
controlled exactly by the kernel of the already nonzero homomorphism (h)
on two-torsion.

## 2. The torsion relation with the fixed curve (X)

Let

\[
 H_Y=\mathcal O_Y(2P_\infty),\qquad
 H_X=\mathcal O_X(2Q_\infty)
\tag{44.13}
\]

be the hyperelliptic pencil line bundles.  Since (g(Y)=15) and (g(X)=3),

\[
                   \omega_Y\simeq H_Y^{14},
                   \qquad \omega_X\simeq H_X^2.
\tag{44.14}
\]

### Theorem 44.2 (a torsion-translated pulled pencil)

The line bundle (L) in (44.7) satisfies

\[
                         L^{14}\simeq\omega_C^7.
\tag{44.15}
\]

In particular,

\[
       \delta:=L\otimes(c^*H_X)^{-1}\in J(C)[14],
\tag{44.16}
\]

and

\[
       \tau:=L^2\otimes\omega_C^{-1}=\delta^2\in J(C)[7].
\tag{44.17}
\]

More finely, put (Q_X=\mathcal O_X(Q_\infty)), so that
(Q_X^2=H_X), and define

\[
       \varepsilon=\mathcal O_C(D_\infty)\otimes(c^*Q_X)^{-1}.
\tag{44.18}
\]

Then

\[
       \varepsilon\in J(C)[28],
       \qquad
       \mathcal O_C(D_\alpha)
          \simeq c^*Q_X\otimes\varepsilon\otimes\epsilon_\alpha
          \quad(\alpha\in\mathcal W).
\tag{44.19}
\]

Thus all 32 effective degree-(M) divisors differ from the pullback of the
degree-one divisor (Q_\infty) on (X) by 28-torsion; their relative
differences belong to the particular subgroup (h(J(Y)[2])\).

#### Proof

Set (A=a^*H_Y=\mathcal O_V(2R_\infty)).  Since (a) and (p) are
etale, (44.14) gives

\[
                  A^{14}\simeq a^*\omega_Y
                     \simeq\omega_V\simeq p^*\omega_C.
\tag{44.20}
\]

Taking the norm through the degree-seven map (p), and using

\[
 \operatorname{Nm}_{V/C}(A)=\mathcal O_C(2D_\infty)=L,
 \qquad
 \operatorname{Nm}_{V/C}(p^*\omega_C)=\omega_C^7,
\]

proves (44.15).

The map (c) is etale, so

\[
                 \omega_C\simeq c^*\omega_X\simeq(c^*H_X)^2.
\tag{44.21}
\]

Equations (44.15) and (44.21) imply
(L^{14}\simeq(c^*H_X)^{14}), proving (44.16).  Squaring (44.16) and
using (44.21) gives (44.17).

The square of (44.18) is precisely \(\delta\).  Since
(\delta^{14}\simeq\mathcal O_C), one gets
(\varepsilon^{28}\simeq\mathcal O_C).  Finally, (44.9) gives

\[
 \mathcal O_C(D_\alpha)
   \simeq\mathcal O_C(D_\infty)\otimes\epsilon_\alpha
   \simeq c^*Q_X\otimes\varepsilon\otimes\epsilon_\alpha,
\]

which is (44.19).  \(\square\)

As a small additional symmetry, Riemann--Roch and (44.17) give

\[
                 h^0(C,L)=h^0(C,L\otimes\tau^{-1}),
\tag{44.22}
\]

because \(\deg L=g(C)-1=2M\) and
(\omega_C\otimes L^{-1}\simeq L\otimes\tau^{-1}).

## 3. The degree-seven norm polynomial

Let (K=k(V)), (F=k(C)), and form

\[
       P(T)=\operatorname{Nm}_{K/F}(T-t)
            =\prod_{j=0}^6\bigl(T-\beta^j(t)\bigr)
            \in F[T].
\tag{44.23}
\]

### Proposition 44.3 (a low-dimensional curve of square sections)

The orbit of (t) under \(\beta\) has size seven.  Consequently (P) is
the separable minimal polynomial of (t) over (F).

Every coefficient of (P(T)), viewed as a rational function on (C), has
pole divisor bounded by (2D_\infty).  Hence its eight coefficients span a
subspace

\[
                 W_P\subseteq H^0(C,L),
                 \qquad \dim W_P\leq8.
\tag{44.24}
\]

This subspace is base-point free, contains all the sections in Proposition
44.1, and the map

\[
       \nu:\mathbf P^1\longrightarrow\mathbf P(W_P),
       \qquad \alpha\longmapsto[P(\alpha)]
\tag{44.25}
\]

is the projection of the degree-seven Veronese curve.  At the 32 points of
\(\mathcal W\), its corresponding section has an even zero divisor:

\[
                         \operatorname{div}(P(\alpha))=2D_\alpha
\tag{44.26}
\]

when (P(\alpha)) is regarded as a section of (L), with the evident
leading-coefficient interpretation at infinity.

#### Proof

Suppose \(\beta^j(t)=t\) for some (1\leq j\leq6).  Since seven is prime,
(t) is then fixed by all of \(\langle\beta\rangle\).  The two maps (a)
and (a\beta) have the same hyperelliptic coordinate.  Their (z)-coordinates
therefore differ by a constant sign.  The negative sign is impossible after
the seventh iterate, while the positive sign gives (a\beta=a).  Both
contradict (44.1).  Thus the orbit has size seven.  Since ([K:F]=7), the
element (t) generates (K/F), proving the first assertion.

Fix a point (x\in C).  On the seven sheets above a strict henselian
neighborhood of (x), suppose exactly (m_x) points occur in
(R_\infty), counted with the multiplicity appearing in (D_\infty).
Each conjugate of (t) has a pole of order two on its corresponding selected
sheet and is regular on the other sheets.  An elementary symmetric polynomial
in the seven conjugates can therefore have a pole of order at most (2m_x).
This is exactly the coefficient of (x) in (2D_\infty).  Hence all eight
coefficients of (P) are sections of (L), proving (44.24).

Evaluation of the polynomial gives, up to the harmless sign
((-1)^7), the norm in (44.6).  This proves (44.26) for finite
\(\alpha\); the monic leading coefficient gives the section at infinity.
The evaluation map (44.25) is obtained from
([1:\alpha:\cdots:\alpha^7]) by the linear map whose coordinates are the
coefficients of (P), proving the Veronese assertion.

It remains to check base-point freeness.  At a fixed (x\in C), at most
seven finite values of \(\alpha\) can occur among the (t)-values of the
seven points above (x).  If some of those points lie over (t=\infty),
the leading-coefficient section may vanish at (x), but one may choose a
finite branch value \(\alpha^{31}=1\) not among the remaining at most seven
values.  The corresponding norm section does not vanish at (x).  If no
point lies over infinity, the leading-coefficient section is already
nonzero.  Thus the sections have no common zero.  \(\square\)

The 31 finite norm sections satisfy the exact product relation

\[
 \prod_{\alpha^{31}=1}\operatorname{Nm}_{V/C}(t-\alpha)
   =\operatorname{Nm}_{V/C}(t^{31}-1)
   =-\operatorname{Nm}_{V/C}(z)^2.
\tag{44.27}
\]

Its divisor is the norm of (44.12), and it is the section-level form of the
unique relation among the 31 generating Weierstrass two-torsion classes.

## 4. Exact remaining question exposed by the lemma

The preceding statements package data which the rank, degree, stability,
Rosati, and generic trace calculations of files 40--43 discard.  A putative
common cover forces all of the following simultaneously on the etale
degree-(M) cover (c:C\to X):

1. a line (L=c^*H_X\otimes\delta) with
   \(\delta\in J(C)[14]\);
2. an at-most eight-dimensional base-point-free subsystem of (L) traced
   by a degree-at-most-seven rational curve;
3. 32 specified points of that rational curve whose sections have doubled
   effective zero divisors of degree (M);
4. relative square roots forming exactly the image of the Weierstrass
   configuration (J(Y)[2]\) under (h=p_*a^*\).

To finish the counterexample along this route, it would be enough to prove
that such a configuration on an etale cover of the explicit (X) forces the
degree-seven polynomial (44.23), and hence the map to (Y), to descend to a
finite common quotient.  No assertion of that kind is made here.  In
particular, a count of torsion points alone is far too weak because
\(|J(C)[2]|=2^{4M+2}\).
