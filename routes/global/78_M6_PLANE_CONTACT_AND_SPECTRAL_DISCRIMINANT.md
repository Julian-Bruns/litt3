# The degree-six plane contact budget and discriminant double plane

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

**Dependency correction, 2026-09-04:** the original reduction in Theorem
78.1 used the unproved all-degree quadratic core in file 68. Its omitted
case-B possibilities are handled separately in Corollary 81.4 of
[file 81](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md).
The cubic-closure and discriminant-surface arguments below remain valid.
The earlier PASS audit did not detect this inherited dependency issue;
see the later [field-intersection audit](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md)
by `/root/c14_elliptic_translation`, 2026-09-04. The replacement proof
has its own audit status in file 81.

This note treats the first unresolved degree for the explicit
order-three pair in file 76.  It proves four things.

1. At \(M=6\), all coefficient choices reduce to two plane models.
2. In the quadratic model, the \(S_3\) spectral closure is impossible;
   only the cyclic \(C_6\) closure survives.
3. The 52 special evaluation lines do not by themselves exceed the
   Pluecker/discriminant budget in either surviving model.  A
   characteristic-free incidence calculation identifies the exact slack:
   it is 48 in the birational model and 24 in the cyclic quadratic model.
4. A stronger use of the cubic discriminant eliminates both models.  The
   coefficient curve lifts to the discriminant double plane; classification
   of all plane sections of the binary-cubic discriminant surface and
   Hodge index bound its genus by 31 or 7, respectively.

The contact calculation uses discriminants of finite flat incidence curves
rather than separability of the plane Gauss map.  It therefore remains valid in
characteristic five, for nonreduced contact divisors, and for singular
plane models.  The final double-plane argument proves that every
order-three diamond for the explicit pair has degree at least seven.

Retain the explicit curves \(X,Y\) of file 76.  Thus

\[
 g(X)=9,\qquad g(Y)=25,\qquad r=3,\qquad s=8,
\tag{78.1}
\]

both Jacobians are absolutely simple, \(X\) is nonhyperelliptic of
gonality three, and the 52 branch values

\[
                 \mathcal A\subset\mathbf P^1(\mathbf F_{125})
\tag{78.2}
\]

of the hyperelliptic map of \(Y\) are rational.

## 1. Exact reduction at \(M=6\)

Let

\[
 \begin{array}{ccc}
 V&\xrightarrow{a}&Y\\
 \downarrow p&&\\[-2mm]
 C&\xrightarrow{c}&X
 \end{array}
 \qquad \deg p=3,\qquad \deg a=\deg c=6
\tag{78.3}
\]

be a prime-ratio diamond, and let \(W\) be its norm-coefficient space.
Write \(w=\dim W\), let \(B\) be the normalization of the coefficient
image, and put \(e=[k(C):k(B)]\).

### Theorem 78.1 (the two residual plane rows)

Exactly the following two coefficient configurations remain after files
68, 74, and 75.

1. **Birational row:**
   \[
       e=1,\qquad w=3.
   \]
   The coefficient image is an integral plane curve of degree 12 with
   normalization \(C\), genus 49, and total delta invariant 6.
2. **Quadratic-core row:**
   \[
       e=2,\qquad w=3.
   \]
   The coefficient image is an integral plane sextic with normalization
   \(B\), where
   \[
        g(B)\in\{9,10\}.
   \]
   The double cover \(C\to B\) is ramified, and its reduced branch
   divisor \(\Delta\) has degree respectively
   \[
        |\Delta|=64\quad\hbox{or}\quad60.             \tag{78.4}
   \]

#### Proof

The degree-three equation of \(X\) and its nonhyperellipticity give
\(\operatorname{gon}(X)=3\).  At \(M=6\), the divisor list of file 68
has four presentations:

\[
\begin{array}{c|c|c}
\text{case}&\text{lower divisor}&\text{coefficient degree}\\ \hline
A&n=3&e=2\\
A&n=6&e=1\\
B&d=3&m=2,\ e=4\\
B&d=6&m=1,\ e=2.
\end{array}                                             \tag{78.5}
\]

The two rows with lower divisor three are the defect-free endpoints.
Their complementary degree is two, smaller than the gonality of \(X\),
so Theorem 75.2 and Theorem 75.3 exclude them.  This leaves precisely
the case-A coefficient degree one and the case-B coefficient degree two.

File 68 gives \(3\leq w\leq r+1=4\).  If \(e=1,w=4\), the
coefficient image is a nondegenerate degree-12 curve in
\(\mathbf P^3\).  Castelnuovo's bound is

\[
                         \operatorname{Cast}(12,3)=25<49=g(C),
\]

so \(w=3\).  The plane arithmetic genus is 55, and hence its total
delta is \(55-49=6\).

Now suppose \(e=2\).  The unramified inequality in Proposition 74.4 is
impossible because \((M-2r)s=0<2\); thus \(C\to B\) is ramified.
The ramified Prym interval gives

\[
                    9\leq g(B)\leq15.                 \tag{78.6}
\]

If \(w=4\), the degree-six coefficient image lies nondegenerately in
\(\mathbf P^3\), where Castelnuovo gives genus at most four.  Therefore
\(w=3\).  A plane sextic has arithmetic genus ten, so (78.6) reduces to
\(g(B)=9\) or 10.  Finally Riemann--Hurwitz for the ramified double cover
of the genus-49 curve \(C\) gives

\[
       |\Delta|=2g(C)-2-2(2g(B)-2)=100-4g(B),
\]

which is (78.4). \(\square\)

## 2. The evaluation cubic and a Gauss-free contact lemma

Let \(R=C\) in the birational row and \(R=B\) in the quadratic row.
The four coefficients of the homogeneous cubic norm polynomial are
sections of a line bundle \(A\) on \(R\), of degree

\[
 n=\deg A=
 \begin{cases}
 12,&R=C,\\
 6,&R=B.
 \end{cases}                                           \tag{78.7}
\]

They span the three-dimensional space \(W\).  For
\(\alpha=[u:v]\in\mathbf P^1\), evaluation of the binary cubic gives
a section \(s_\alpha\in W\), hence a line

\[
                \ell_\alpha\subset\mathbf P(W^*)=\mathbf P^2.
\tag{78.8}
\]

### Lemma 78.2 (the evaluation lines form a rational cubic)

The map

\[
 \lambda:\mathbf P^1\longrightarrow\mathbf P(W),
            \qquad\alpha\longmapsto[s_\alpha]
\tag{78.9}
\]

is the normalization of a nondegenerate rational plane cubic.  In
particular it is separable.  It can identify at most one pair of
parameters, so it is safest to regard the 52 branch values as 52 marked
parameters on this normalization rather than to assume that all 52 line
points are distinct.

#### Proof

The map is the linear projection of the rational normal cubic of binary
cubics.  Its projection center is not on that cubic: otherwise
\(s_\alpha\) would be the zero section for some \(\alpha\), making the
constant \(\alpha\) a root of the irreducible cubic minimal polynomial.
Thus \(\lambda^*\mathcal O(1)=\mathcal O_{\mathbf P^1}(3)\).

The image is nondegenerate because the sections \(s_\alpha\) span all
of \(W\).  Degree of the image times generic degree of \(\lambda\) is
three.  A nondegenerate plane image cannot be a line, so it is a cubic
and the generic degree is one.  A rational plane cubic has only a node
or cusp as the possible genus defect, which proves the last assertion.
\(\square\)

We next give the contact count in a form which does not mention the
Gauss map.

### Lemma 78.3 (incidence discriminant)

Let \(R\) be a smooth curve of genus \(g\), let \(A\) be a line bundle
of degree \(n>0\), and let an integral binary cubic with coefficients in
\(H^0(R,A)\) define

\[
 \Sigma\subset R\times\mathbf P^1.
\]

Assume no evaluation section is identically zero and that the induced
degree-\(n\) map from the normalization to \(\mathbf P^1\) is separable.
Then:

1. \(\Sigma\) is a Cartier divisor of class
   \(A\boxtimes\mathcal O(3)\), and
   \[
                         p_a(\Sigma)=3g+2n-2;          \tag{78.10}
   \]
2. projection \(\Sigma\to\mathbf P^1\) is finite flat of degree \(n\);
3. if its normalization \(\widetilde\Sigma\) has genus \(\widetilde g\),
   then
   \[
   \begin{aligned}
    \delta(\Sigma)&=3g+2n-2-\widetilde g,\\
    \deg\operatorname{Disc}(\Sigma/\mathbf P^1)
       &=6(g+n-1)\\
       &=\deg\operatorname{Diff}(\widetilde\Sigma/\mathbf P^1)
          +2\delta(\Sigma).                           \tag{78.11}
   \end{aligned}
   \]
4. if the evaluation divisor over \(\alpha\) has degree \(n\) and
   support of cardinality \(k_\alpha\), then
   \[
       \operatorname{ord}_\alpha\operatorname{Disc}
                          \geq n-k_\alpha.             \tag{78.12}
   \]

These conclusions do not require a separable Gauss map or reduced
evaluation divisors.

#### Proof

Adjunction on \(R\times\mathbf P^1\) gives

\[
 \Sigma^2=6n,\qquad
 K\cdot\Sigma=3(2g-2)-2n,
\]

which proves (78.10).  No fiber of the second projection is a component,
so the projection is finite; a finite map from this Cartier curve to the
smooth base is flat.  If
\(\mathcal E=\pi_*\mathcal O_\Sigma\), then

\[
 \deg\mathcal E=\chi(\mathcal O_\Sigma)-n=1-p_a(\Sigma)-n.
\]

The discriminant is a section of \((\det\mathcal E)^{-2}\), giving its
degree in (78.11).  Riemann--Hurwitz on the normalization gives the last
equality there.

For (78.12), reduce the trace pairing of the finite flat algebra modulo
a uniformizer at \(\alpha\).  Its rank is at most the number
\(k_\alpha\) of reduced points in the fiber: the nilradical of each
local Artin factor lies in the radical of the trace pairing.  Hence at
least \(n-k_\alpha\) invariant factors of its Gram matrix are divisible
by the uniformizer.  Its determinant has the asserted valuation.
\(\square\)

## 3. The birational row: exact slack 48

Let \(\Gamma\subset\mathbf P^2\) be the degree-12 coefficient curve.
For every \(\alpha\in\mathcal A\), file 44 gives

\[
             \chi_C^*\ell_\alpha=2D_\alpha,
             \qquad \deg D_\alpha=6.                 \tag{78.13}
\]

Thus each marked evaluation divisor has at most six support points.

### Proposition 78.4

In the birational row, the spectral incidence curve has

\[
 \begin{array}{c|c|c|c|c}
 p_a(\Sigma)&g(\widetilde\Sigma)&\delta(\Sigma)&
 \deg\operatorname{Diff}&\deg\operatorname{Disc}\\ \hline
 169&145&24&312&360.
 \end{array}                                           \tag{78.14}
\]

The 52 divisors (78.13) force discriminant degree at least

\[
                         52\cdot6=312.                 \tag{78.15}
\]

Consequently the contact-line count has exact remaining allowance

\[
                         360-312=48=2\delta(\Sigma).   \tag{78.16}
\]

It yields no contradiction.

#### Proof

Here \(R=C\), \(g=49\), and \(n=12\).  The incidence cubic is
irreducible because it is the minimal polynomial of \(t\) over
\(k(C)\).  Since coefficient degree is one, its normalization is \(V\),
whose genus is

\[
                         g(V)-1=6(g(Y)-1)=144.
\]

Lemma 78.3 gives the arithmetic genus, delta, and discriminant degree.
The map \(t:V\to\mathbf P^1\) is the composite of the degree-six etale
map \(V\to Y\) and the hyperelliptic map.  It has six simple ramification
points above each of the 52 branch values and none elsewhere, so its
different has degree 312.  Finally (78.13) and (78.12) give (78.15).
Equation (78.11) identifies all remaining allowance with the conductor
of the spectral incidence. \(\square\)

For comparison, the plane curve \(\Gamma\) itself has delta six.  In a
separable characteristic-zero Pluecker count this lowers the naive polar
class from \(12\cdot11\) to at most 120, and intersection with the cubic
of evaluation lines has budget 360.  The Gauss-free calculation above
recovers exactly that budget without assuming ordinary nodes, reflexivity,
or separability of the Gauss map.

## 4. The quadratic row: the \(S_3\) closure is impossible

Let \(K=k(V)\), \(F=k(C)\), and let

\[
                         k(E)=k(B)(t).
\]

Then

\[
 [K:F]=[E:B]=3,\qquad [K:E]=[F:B]=2,\qquad [E:k(t)]=6. \tag{78.17}
\]

Exactly as in file 47, \(K/B\) is Galois: the cubic minimal polynomial
of \(t\) has all three roots in \(K\); its splitting field is either
the degree-three field \(E\) or all of \(K\), and adjoining the quadratic
field \(F\) gives \(K\) in the former case.  Hence

\[
                         \operatorname{Gal}(K/B)=C_6
                         \quad\hbox{or}\quad S_3.      \tag{78.18}
\]

### Proposition 78.5 (the nonabelian closure is impossible)

The \(S_3\) alternative in (78.18) cannot occur.

#### Proof

The cover \(K/F\) is etale.  Thus inertia over a point of \(\Delta\)
is a transposition.  In its degree-three action a transposition has cycle
type \(2,1\), so every member of \(\Delta\) contributes one to the
different of \(E/B\).  Riemann--Hurwitz and (78.4) give

\[
                         g(E)=g(B)+48,
\]

namely 57 or 58.

On the other hand, \(E\) is the normalization of the integral spectral
incidence curve in \(B\times\mathbf P^1\).  Lemma 78.3, with \(n=6\),
gives

\[
                         p_a(\Sigma)=3g(B)+10,
\]

namely 37 or 40.  A normalization cannot have genus greater than the
arithmetic genus.  This contradiction excludes \(S_3\). \(\square\)

## 5. The cyclic quadratic row: exact slack 24

It remains to take \(\operatorname{Gal}(K/B)=C_6\).  The degree-three
map \(E\to B\) is then etale, so

\[
                         g(E)=3g(B)-2.                 \tag{78.19}
\]

The incidence curve has delta 12 in both genera.

### Proposition 78.6

For the cyclic quadratic row, the two possible numerical profiles are

\[
\begin{array}{c|c|c|c|c|c}
g(B)&g(E)&p_a(\Sigma)&\delta(\Sigma)&
\deg\operatorname{Diff}(t)&\deg\operatorname{Disc}\\ \hline
9&25&37&12&60&84\\
10&28&40&12&66&90.
\end{array}                                             \tag{78.20}
\]

All of the different of \(t\) lies over the 52 marked values.  Thus the
contact/discriminant budget has exact slack

\[
                  84-60=90-66=24=2\delta(\Sigma).      \tag{78.21}
\]

#### Proof

Equation (78.19) and Lemma 78.3 give every entry except the different.
The quadratic map \(V\to E\) is the normalized pullback through \(t\)
of the hyperelliptic cover \(Y\to\mathbf P^1\), while \(V\to Y\) is
etale.  The local normalized-fiber-product calculation shows that \(t\)
is unramified away from \(\mathcal A\) and has only indices one and two
above \(\mathcal A\).  Riemann--Hurwitz gives different degree 60 or 66.
The final assertion is (78.11). \(\square\)

There is nevertheless a useful exact restriction on the branch labels.
Put

\[
 Z_\alpha=\chi_B^*\ell_\alpha,
 \qquad
 U_\alpha=\{b\in B:\operatorname{mult}_bZ_\alpha\text{ is odd}\}.
\tag{78.22}
\]

The identity \(q^*Z_\alpha=2D_\alpha\) gives
\(U_\alpha\subseteq\Delta\).

### Proposition 78.7 (many branch fibers have three distinct labels)

For each \(b\in\Delta\), the three points of the etale fiber
\(E_b\) map under \(t\) to members of \(\mathcal A\).  Let \(N_3\) be
the number of \(b\) for which those three labels are distinct.  Then

\[
 N_3\geq
 \begin{cases}
 40,&g(B)=9,\\
 36,&g(B)=10.
 \end{cases}                                           \tag{78.23}
\]

#### Proof

In the cyclic group, the order-two inertia is killed in the quotient
\(E\to B\), so the latter is etale, while \(V\to E\) ramifies at all
three points above each \(b\in\Delta\).  The normalized hyperelliptic
pullback description says that these are precisely index-one points of
\(t\) over \(\mathcal A\).  The divisor-of-a-norm formula then says that
membership of \(b\) in \(U_\alpha\) is the parity of the number of these
three points carrying label \(\alpha\).

If the three labels are distinct, \(b\) belongs to three odd supports;
otherwise it belongs to one.  Hence

\[
                   \sum_{\alpha\in\mathcal A}|U_\alpha|
                         =|\Delta|+2N_3.               \tag{78.24}
\]

Let \(k_\alpha=|\operatorname{Supp}Z_\alpha|\).  Since
\(\deg Z_\alpha=6\), while exactly \(|U_\alpha|\) of its multiplicities
are odd,

\[
                   k_\alpha\leq
                         \frac{6+|U_\alpha|}{2}.       \tag{78.25}
\]

Lemma 78.3 therefore gives

\[
 \deg\operatorname{Disc}\geq
 \sum_{\alpha\in\mathcal A}(6-k_\alpha)
 \geq156-\frac{|\Delta|}{2}-N_3.                      \tag{78.26}
\]

Substituting respectively \((|\Delta|,\deg\operatorname{Disc})=(64,84)\)
and \((60,90)\) proves (78.23). \(\square\)

Every point of \(\Delta\) maps to a coefficient cubic whose three roots,
with multiplicity, belong to \(\mathcal A\).  Its coefficient point is
therefore \(\mathbf F_{125}\)-rational.  Since the plane sextic has
delta at most one, these give at least 63 or 60 distinct rational plane
points.  Two distinct sextics meet in at most 36 points, so the coefficient
sextic, its normalization \(B\), and the universal spectral incidence
descend to \(\mathbf F_{125}\).  This descent and (78.23) are genuine
new restrictions, but their point counts remain well below the Weil bounds
for genera 9, 10, 25, and 28.

## 6. Plane sections of the cubic discriminant surface

The exact slack above shows why contact counting stops.  The cubic Galois
structure supplies a stronger surface on which the coefficient curve must
lie.

Let

\[
 \mathscr D\subset\mathbf P(\operatorname{Sym}^3k^2)=\mathbf P^3
\]

be the discriminant surface of binary cubics.  In coordinates

\[
 f=aX^3+bX^2Y+cXY^2+dY^3,
\]

its equation is

\[
 \operatorname{disc}(f)
  =b^2c^2-4ac^3-4b^3d-27a^2d^2+18abcd.               \tag{78.27}
\]

For a plane \(\Pi\subset\mathbf P^3\), write \(S_\Pi\) for the double
plane

\[
                S_\Pi:\quad w^2=\operatorname{disc}|_\Pi.
\tag{78.28}
\]

### Lemma 78.8 (all discriminant-plane types in characteristic five)

Over an algebraically closed field of characteristic five, every plane
\(\Pi\) is, under the natural \(\operatorname{PGL}_2\)-action, of exactly
one of the following three types.

1. The dual binary cubic has three distinct roots.  One may take
   \(\Pi:(b+c=0)\).  The branch section is an irreducible quartic with
   three ordinary cusps.  The double plane has three rational double
   points of type \(A_2\).
2. The dual cubic has a double and a simple root.  One may take
   \(\Pi:(b=0)\), where
   \[
       \operatorname{disc}|_\Pi=-a(4c^3+27ad^2).       \tag{78.29}
   \]
   The branch is a line and a cuspidal cubic.  The cubic has one cusp,
   and the line meets it at its other smooth point with multiplicity
   three.  The double plane has rational double points of types \(A_2\)
   and \(A_5\).
3. The dual cubic has a triple root.  One may take \(\Pi:(a=0)\), where
   \[
       \operatorname{disc}|_\Pi=b^2(c^2-4bd).          \tag{78.30}
   \]
   The double plane is nonnormal.  Its normalization is the smooth double
   cover of \(\mathbf P^2\) branched along the conic
   \(c^2-4bd=0\), hence is a smooth quadric surface.

#### Proof

Because \(5>3\), the apolar pairing identifies the projective dual of
binary cubics with binary cubics equivariantly under
\(\operatorname{PGL}_2\).  Its three hyperplane orbits are classified by
the root multiplicities of the dual cubic.  The displayed planes are
representatives: their intersections with the twisted cubic of triple-root
cubics have respectively type \(1+1+1,2+1,3\).

Substitution in (78.27) gives (78.29)--(78.30) and, in the first case,

\[
 b^4+4ab^3-4b^3d-27a^2d^2-18ab^2d.                  \tag{78.31}
\]

Direct factorization and differentiation show that (78.31) is irreducible
and has exactly three cusps, at the three points of its intersection with
the twisted cubic.  For (78.29), the cubic has one ordinary cusp and its intersection
with the line is concentrated with multiplicity three at a smooth point.

A double cover at a branch cusp has local equation
\(uv=x^3\), hence an \(A_2\) singularity.  At two smooth branch components
with contact order three, completing the square gives \(uv=x^6\), hence
an \(A_5\) singularity.  These prove the first two surface statements.
In the last case, dividing the double-cover coordinate by \(b\) in the
function field gives the normalization

\[
                         (w/b)^2=c^2-4bd,
\]

which is a smooth quadric. \(\square\)

### Lemma 78.9 (genus bound for a split plane curve)

Let \(\Gamma\subset\Pi\) be an integral plane curve of even degree \(n\),
not contained in \(\mathscr D\).  Suppose the discriminant restricts to a
square in \(k(\Gamma)^*\).  If \(\Pi\) is of type 1 or 2 in Lemma 78.8,
then the normalization of \(\Gamma\) has genus at most

\[
                       \frac{n^2}{4}-\frac n2+1.       \tag{78.32}
\]

If \(\Pi\) is of type 3, the stronger bound is

\[
                       \frac{n^2}{4}-n+1.              \tag{78.33}
\]

#### Proof

The square root in \(k(\Gamma)\) gives a rational lift of the normalization
of \(\Gamma\) to the appropriate normalization of \(S_\Pi\).  Properness
extends it across every point.  Its image \(D\) maps birationally to
\(\Gamma\), because the composite with the double-plane projection is the
normalization map of \(\Gamma\).

In types 1 and 2, let \(\widetilde S\to S_\Pi\) be the minimal resolution.
All singularities in Lemma 78.8 are Du Val, so the resolution is crepant.
If \(H\) denotes the pullback of a line, then

\[
                   H^2=2,\qquad K_{\widetilde S}=-H.  \tag{78.34}
\]

For the strict transform, still denoted \(D\), one has \(H\cdot D=n\).
Hodge index for the nef and big class \(H\) gives

\[
                         D^2\leq\frac{n^2}{2}.         \tag{78.35}
\]

Adjunction on the smooth surface, followed by normalization of \(D\),
therefore gives

\[
 g(\Gamma^\nu)
  \leq p_a(D)
  =1+\frac{D^2+K_{\widetilde S}\cdot D}{2}
  \leq1+\frac{n^2/2-n}{2},
\]

which is (78.32).

In type 3, use the smooth normalized double plane from Lemma 78.8.  It
has

\[
                         H^2=2,\qquad K=-2H.
\]

The same Hodge and adjunction calculation gives (78.33). \(\square\)

## 7. Elimination of degree six

### Theorem 78.10 (no degree-six order-three diamond)

For the explicit pair in file 76, a common finite-etale cover cannot
produce an order-three diamond of degree \(M=6\).  Combined with
Theorem 76.4, every prime-ratio diamond has

\[
                              M\geq7.                  \tag{78.36}
\]

#### Proof

By Theorem 78.1, there are only the birational and quadratic plane rows.
In the birational row, the cubic extension \(k(V)/k(C)\) is the given
cyclic \(C_3\)-torsor.  Its cubic discriminant is therefore a square in
\(k(C)\).  The degree-12 coefficient curve lifts to \(S_\Pi\).  Lemma
78.9 bounds its normalization genus by

\[
             \frac{12^2}{4}-\frac{12}{2}+1=31
\]

in types 1 and 2, and by 25 in type 3.  This contradicts \(g(C)=49\).

In the quadratic row, Proposition 78.5 already excludes the \(S_3\)
closure.  In the remaining cyclic \(C_6\) closure, the cubic extension
\(E/B\) is Galois of group \(C_3\), so its discriminant is a square in
\(k(B)\).  The plane sextic therefore lifts to \(S_\Pi\).  Lemma 78.9
bounds the genus of its normalization by seven in types 1 and 2, and by
four in type 3.  This contradicts \(g(B)\in\{9,10\}\).

Both residual rows are impossible. \(\square\)

## 8. What the contact analysis contributes

The 52-line calculation remains useful even though the discriminant double
plane is decisive.  It shows rigorously that a direct Pluecker count cannot
be made contradictory merely by ignoring positive-characteristic Gauss-map
issues: the numerical deficits 48 and 24 are exactly twice the conductor
delta of the spectral incidence.  The successful extra input is not a
sharper tangency estimate; it is the square root of the cubic discriminant,
which forces the coefficient curve onto a degree-two del Pezzo surface (or,
in the nonnormal exceptional plane, onto its quadric normalization).
