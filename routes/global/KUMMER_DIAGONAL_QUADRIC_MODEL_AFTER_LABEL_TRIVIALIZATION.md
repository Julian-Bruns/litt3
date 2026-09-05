# The fixed Kummer complete intersection after killing the square labels

## Status and scope

**Status: proved and self-checked; not yet independently audited.**

This note applies to the cyclic norm-polynomial setup of file 44 and its
odd-prime generalization.  It shows that all of the branch-square data can be
put on one fixed smooth generalized Fermat variety after an explicitly bounded
etale (2)-power base change.  The resulting variety depends only on the
hyperelliptic branch set and on the cyclic degree, not on the putative common
cover.

The construction by itself is not an exclusion theorem.  In the current
\(r=3,s=8\) case it produces a smooth threefold cut out by \(48\) diagonal
quadrics in \(\mathbf P^{51}\), but the available positivity theorems for
Fermat covers do not control curves of the required numerical type.

## 1. Setup

Let (k) be algebraically closed of characteristic different from (2).  Let
(r) be an odd prime, and suppose that there is a diagram of connected smooth
projective curves

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X,
 \end{array}
 \qquad
 \deg p=r,\qquad \deg a=\deg c=M,
 \tag{K.1}
\]

in which all three maps are finite etale and (p) is cyclic.  Write

\[
        g(X)=s+1,\qquad g(Y)=rs+1,
\tag{K.2}
\]

and suppose that (Y) is hyperelliptic.  Let

\[
       t:Y\longrightarrow\mathbf P^1
\]

be its hyperelliptic map and let \(\mathcal B\) be its branch set.  Thus

\[
             q_0:=|\mathcal B|=2rs+4.
\tag{K.3}
\]

For \(\alpha\in\mathcal B\), let \(P_\alpha\) be the corresponding
ramification point, choose one branch value denoted by \(\infty\), and put

\[
  D_\alpha=p_*a^*P_\alpha,\qquad
  \epsilon_\alpha=\mathcal O_C(D_\alpha-D_\infty)\in J(C)[2].
\tag{K.4}
\]

Each (D_\alpha) has degree (M).  The norm identities give sections

\[
 P(\alpha)\in
 H^0\!\left(C,\mathcal O_C(2D_\infty)\right),\qquad
 \operatorname{div}(P(\alpha))=2D_\alpha,
\tag{K.5}
\]

where

\[
 P(T)=\operatorname{Nm}_{V/C}(T-t)
\tag{K.6}
\]

and evaluation at infinity means the leading coefficient.  Finally, with

\[
                 h=p_*a^*:J(Y)\longrightarrow J(C),
\]

one has

\[
      \epsilon_\alpha=h([P_\alpha-P_\infty]).
\tag{K.7}
\]

In particular the span

\[
 E=\langle\epsilon_\alpha:\alpha\in\mathcal B\rangle_{\mathbf F_2}
       \subset J(C)[2]
\tag{K.8}
\]

has dimension (d\le 2g(Y)).

## 2. The bounded connected cover

### Theorem K.1 (simultaneous square-label trivialization)

There is a connected Galois finite etale cover

\[
                 q:C'\longrightarrow C
\tag{K.9}
\]

with group (E^\vee=\operatorname{Hom}(E,\mu _2)) and degree

\[
                 n:=\deg q=2^d\le 2^{2g(Y)},
\tag{K.10}
\]

such that (q^*\epsilon_\alpha) is trivial for every branch value
(\alpha).

Moreover

\[
                 V'=V\times_C C'
\tag{K.11}
\]

is connected.  The induced map (V'\to C') is again a cyclic etale cover of
degree (r), while

\[
          C'\longrightarrow X,\qquad V'\longrightarrow Y
\tag{K.12}
\]

are both etale of degree (Mn).

#### Proof

Because (2\ne\operatorname{char}k) and (k) is algebraically closed, the
Kummer sequence identifies (J(C)[2]) with (H^1(C,\mu _2)).  Choose a basis
of (E) and take the fiber product of the associated etale double torsors.
Independence of the classes says exactly that the resulting monodromy map onto
((\mathbf Z/2)^d) is surjective, so its total space (C') is connected.
The tautological trivializations on this torsor trivialize the pullback of
every element of (E), proving (K.9)--(K.10).

The two separable function-field extensions (k(V)/k(C)) and
(k(C')/k(C)) have coprime degrees (r) and (2^d).  Their intersection is
therefore (k(C)), so their compositum is a field and (V') is connected.
All remaining assertions follow by etale base change and composition.
\(\square\)

## 3. The fixed diagonal complete intersection

Put

\[
                 A=\mathcal O_{C'}(q^*D_\infty).
\tag{K.13}
\]

After choosing the tautological trivializations in Theorem K.1 and rescaling
by constants, there are sections

\[
              s_\alpha\in H^0(C',A),\qquad
              s_\alpha^2=q^*P(\alpha),
\tag{K.14}
\]

with

\[
              \operatorname{div}(s_\alpha)=q^*D_\alpha.
\tag{K.15}
\]

Indeed, the two sides of (K.14) are sections of (A^2) with the same divisor,
so they differ by a nonzero constant, and every constant in (k) has a square
root.

Choose nonzero trivializations of the fibers of
(\mathcal O_{\mathbf P^1}(r)) at the points of (\mathcal B), including the
leading-coefficient trivialization at infinity, and let

\[
 \operatorname{ev}:H^0(\mathbf P^1,\mathcal O(r))
          \longrightarrow k^{\mathcal B},\qquad U=\operatorname{im}(\operatorname{ev}).
\tag{K.16}
\]

Evaluation at any (r+1) distinct points is an isomorphism, hence

\[
                         \dim U=r+1.
\tag{K.17}
\]

Define

\[
 W=W(\mathcal B,r)=
 \left\{[X_\alpha]_{\alpha\in\mathcal B}\in\mathbf P^{q_0-1}:
   \sum_{\alpha}c_\alpha X_\alpha^2=0
   \text{ for every }c\in U^\perp\right\}.
\tag{K.18}
\]

Changing the fiber trivializations only diagonally rescales the coordinates.
Thus (W), up to this harmless projective equivalence, depends only on the
fixed branch set (\mathcal B) and (r).

### Theorem K.2 (fixed Kummer model)

The variety (W) is a smooth integral complete intersection of

\[
                         q_0-r-1
\tag{K.19}
\]

independent diagonal quadrics in (\mathbf P^{q_0-1}).  It has dimension
(r), degree (2^{q_0-r-1}), and

\[
           \omega_W\simeq
           \mathcal O_W(q_0-2r-2)
           =\mathcal O_W(2r(s-1)+2).
\tag{K.20}
\]

The sections (K.14) define a nonconstant morphism

\[
                    \psi:C'\longrightarrow W,\qquad
                    x\longmapsto[s_\alpha(x)]_\alpha,
\tag{K.21}
\]

and

\[
                    \psi^*\mathcal O_W(1)\simeq A,
                    \qquad \deg A=Mn.
\tag{K.22}
\]

#### Proof

At a point of (C'), the degree-(r) polynomial (P(T)) can vanish at at
most (r) distinct branch values.  Since (q_0>r), the sections
(s_\alpha) have no common zero.  Their squares are the evaluations of one
degree-(r) polynomial, so their vector belongs to (U).  This proves that
(K.21) is everywhere defined and lands in (K.18).  It also proves (K.22), and
positive degree makes (\psi) nonconstant.

The points of the dual projective space corresponding to evaluation at
the branch values form a rational normal curve.  Equivalently, their
hyperplanes in \(\mathbf P(U)\simeq\mathbf P^r\) are in linear general
position: any (j\le r) meet in codimension (j), and no (r+1) meet.
Coordinatewise squaring gives a finite morphism

\[
 \rho:W\longrightarrow\mathbf P(U),\qquad
 [X_\alpha]\longmapsto[X_\alpha^2],
\tag{K.23}
\]

which is the full Kummer cover with ramification index two along these
(q_0) hyperplanes.  Near a point on exactly (j\le r) hyperplanes, their
linear equations are part of a regular parameter system, and the full cover
is etale-locally given by

\[
                  y_1=x_1^2,\ldots,y_j=x_j^2.
\]

It is therefore regular because the characteristic is not two.

For completeness, the cover is connected.  In the function field of
(\mathbf P^r), fix one evaluation form (\ell_0).  The square classes
(\ell_\alpha/\ell_0), (\alpha\ne0), are independent: a nonempty product
has odd valuation along one of the distinct hyperplanes (H_\alpha).
Consequently the generic Kummer extension has degree (2^{q_0-1}) and is a
field.  Since (K.23) is finite flat, (W) is integral.  Smoothness and the
equations show that it is a complete intersection with the codimension and
degree in (K.19).  Adjunction gives

\[
 K_W=\mathcal O_W\bigl(-q_0+2(q_0-r-1)\bigr),
\]

which is (K.20).  \(\square\)

### Equivariance and coordinate strata

For (G=\operatorname{Gal}(C'/C)=E^\vee), let

\[
             \chi_\alpha(g)=g(\epsilon_\alpha)\in\mu _2
\tag{K.24}
\]

denote the character paired with \(\epsilon_\alpha\).  The trivializations
may be chosen so that

\[
                  g^*s_\alpha=\chi_\alpha(g)s_\alpha,
                  \qquad \chi_\infty=1.
\tag{K.25}
\]

Thus (\psi) is equivariant for the injective diagonal-sign action

\[
 E^\vee\hookrightarrow (\mu _2)^{q_0}/\mu _2=\operatorname{Deck}(\rho).
\tag{K.26}
\]

Injectivity follows because the \(\epsilon_\alpha\) span \(E\).

Let (R_\alpha=W\cap\{X_\alpha=0\}).  Then

\[
                       \psi^*R_\alpha=q^*D_\alpha.
\tag{K.27}
\]

The divisors (R_\alpha) meet transversely, an intersection of (j\le r)
distinct ones is smooth of codimension (j), and an intersection of (r+1)
is empty.  For a set (S\subset\mathcal B) of size (r), the stratum

\[
                       \bigcap_{\alpha\in S}R_\alpha
\]

consists of (2^{q_0-r-1}) reduced points.  A simple full-grid point, at
which the (r) cyclic sheets meet (r) distinct branch values, maps into
exactly the corresponding deepest coordinate stratum.  The construction
retains this unordered incidence and the sign representation (K.26); it does
not retain a global ordering of the (r) sheets.

## 4. Separability and the current numerical case

Both (q) and the Kummer morphism (\rho) are separable.  On the dense torus
where every coordinate is nonzero, (\rho) is etale.  Consequently
(\psi) is generically separable whenever the original coefficient map
defined by (P(T)) is generically separable.  This includes the generic
(e=1) row, where that map is birational onto its image.  Without such a
hypothesis the square-root construction alone does **not** prove that
(\psi) is separable.

Since (C'\to X) is etale of degree (Mn),

\[
             g(C')-1=Mns,\qquad
             \deg\omega_{C'}=2Mns.
\tag{K.28}
\]

For the current values (r=3,s=8),

\[
 q_0=52,\quad
 W\subset\mathbf P^{51}\text{ is a smooth threefold cut out by }48
 \text{ quadrics},\quad
 \omega_W=\mathcal O_W(44),
\tag{K.29}
\]

and

\[
        \deg\psi^*\mathcal O_W(1)=Mn,\qquad
        \deg\omega_{C'}=16Mn.
\tag{K.30}
\]

These identities do not imply a genus contradiction.  For instance, if
(\psi) were an immersion, its normal determinant would have degree
(16Mn-44Mn=-28Mn); negative normal bundles for special curves on a
general-type complete intersection are not impossible.

Likewise, the ordinary cotangent-slope comparison has precisely the expected
slack:

\[
 \frac{\deg\psi^*K_W}{\dim W}
       =\frac{44}{3}Mn
       <16Mn=\deg\Omega^1_{C'}
       \qquad(r=3,s=8).
\tag{K.31}
\]

Thus even a favorable semistability statement for the pulled-back cotangent
bundle would not contradict the differential quotient furnished by a
separable \(\psi\).

## 5. Exact literature boundary and remaining input

The variety (W) is a generalized Fermat variety of type
((r;2,q_0-1)).  Two close bodies of work do not presently supply the needed
curve constraint.

1. Dérand's 2026 positivity and hyperbolicity theorem for Fermat covers of
   hyperplane arrangements is over the complex numbers and assumes
   ramification order at least (2r).  Here the order is (2).  Independently,
   it assumes that the hyperplanes impose at least (4r-2) independent
   conditions on quadrics.  Our dual points lie on a rational normal curve;
   restriction of quadrics to it is
   (H^0(\mathbf P^1,\mathcal O(2r))), so they impose exactly (2r+1)
   conditions.  For (r=3), this is (7<10).  Thus both essential
   hypotheses fail.

2. The generalized-Fermat-manifold literature principally proves uniqueness
   of the diagonal deck group and describes its fixed loci.  It does not give
   a lower-genus bound for curves in (W).  The positive-characteristic
   uniqueness theorem of Hidalgo--Hughes--Leyton-Alvarez also excludes the
   low-order case (k=2) through its hypothesis that (k-1) not be a power
   of the characteristic.  The Sheng--Xu--Zuo Kummer construction concerns
   the special complex Calabi--Yau case of (2r+2) hyperplanes and Hodge
   monodromy, not curves in the present (q_0=2rs+4) cover.

The fixed complete intersection therefore forgets too much by itself.  It
remembers the square labels, their diagonal sign representation, and which
sets of branch values occur on a fiber, but not the cyclic ordering of the
roots or the maps to both fixed curves.  A useful next theorem would have to
constrain **equivariant** curves in this special rational-normal-curve Kummer
cover using that retained cyclic incidence.  A theorem about arbitrary
curves in a smooth complete intersection, or positivity of (K_W) alone,
does not address the surviving configuration.

Primary references checked:

- C. Dérand, *Hyperbolicity of smooth logarithmic and orbifold pairs in
  projective space*, arXiv:2406.04069v2, Theorems D and E.
- R. A. Hidalgo, H. F. Hughes, M. Leyton-Alvarez, *Automorphisms of
  Generalized Fermat manifolds*, arXiv:2010.04628v8.
- R. A. Hidalgo, H. F. Hughes, M. Leyton-Alvarez, *Uniqueness of Generalized
  Fermat Groups in positive characteristic*, arXiv:2410.07085.
- M. Sheng, J. Xu, K. Zuo, *The monodromy groups of Dolgachev's CY moduli
  spaces are Zariski dense*, Adv. Math. 272 (2015), 699--742,
  arXiv:1407.0833.
