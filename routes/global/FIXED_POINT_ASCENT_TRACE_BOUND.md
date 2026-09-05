# A fixed-point ascent bound through a non-lifted involution

## Status and purpose

**Status: proved; self-check complete; independent audit pending.**

Let \(C\to D\) be an etale cover and let \(\delta\) be a ramified
involution of \(D\), not assumed to lift to \(C\).  The normalized twisted
fiber product

\[
                         C\times_{D,\delta}C
\]

has a swapping involution.  Its swap-stable components collect exactly
all lifts of the fixed points of \(\delta\).  Applying the nonscalar
cross-image trace bound component by component, and then summing with the
correct component degrees, causes no further blowup beyond the upstairs
degree \(M=\deg(C/X)\).

There is nevertheless a genuine relative-degree loss.  If
\(M=mN\), where \(m=\deg(C/D)\), the resulting estimate is
\(O(M)=O(mN)\), not \(O(N)\).  The final section proves that component
bookkeeping alone cannot remove this factor and shows that descent of
\(C\to X\) through \(D\) is one sufficient hypothesis which recovers
the lower-scale bound.

Throughout, \(k\) is algebraically closed of characteristic different
from two.

## 1. Exact component and fixed-point accounting

Let

\[
 e:C\longrightarrow D
\]

be a connected finite etale cover of degree \(m\), and let
\(\delta\in\operatorname{Aut}(D)\) be an involution with nonempty fixed
locus.  Write

\[
                         R_D=\#\operatorname{Fix}(\delta).
\]

Define

\[
 {\mathcal Z}
   =\{(P,Q)\in C\times C:e(Q)=\delta(e(P))\}.           \tag{A.1}
\]

Its two projections are denoted \(p_1,p_2\), and

\[
                         \iota(P,Q)=(Q,P).              \tag{A.2}
\]

### Proposition A.1 (all fixed points lie on stable components)

The curve \({\mathcal Z}\) is smooth, possibly disconnected; each
projection

\[
                         p_i:{\mathcal Z}\longrightarrow C
\]

is finite etale of total degree \(m\), and \(\iota\) is an involution
interchanging the two projections.

Let \(Z_1,\ldots,Z_t\) be the connected components which are stable under
\(\iota\) and contain a fixed point.  Put

\[
 a_j=\deg(p_1|_{Z_j})=\deg(p_2|_{Z_j}),\qquad
 R_j=\#\operatorname{Fix}(\iota|_{Z_j}).               \tag{A.3}
\]

Then

\[
                         \sum_{j=1}^tR_j=mR_D,\qquad
                         \sum_{j=1}^ta_j\leq m.         \tag{A.4}
\]

Every \(\iota|_{Z_j}\) is a ramified nontrivial involution, and its
ramification divisor has degree \(R_j\).

#### Proof

The first projection in (A.1) is the base change of \(e:C\to D\) along
\(\delta e:C\to D\); the same holds with the projections reversed.
Thus \({\mathcal Z}\) is smooth and both projections are etale of degree
\(m\).  Applying \(\delta\) to the defining equality in (A.1) shows that
the swap (A.2) preserves \({\mathcal Z}\).

A point of \({\mathcal Z}\) is fixed by \(\iota\) exactly when it is
\((P,P)\) with

\[
                              e(P)=\delta(e(P)).
\]

Every fixed point of \(\delta\) has exactly \(m\) inverse images under
the etale map \(e\).  Hence

\[
                         \#\operatorname{Fix}(\iota)=mR_D.          \tag{A.5}
\]

This equality also holds scheme-theoretically.  At a fixed point of
\(\delta\), choose a parameter \(t\) for which
\(\delta^*t=-t\).  The etale map \(e\) identifies completed parameters
near each lift.  Locally (A.1) is \(t_2=-t_1\), and swapping acts by
\(t_1\mapsto-t_1\), so its fixed divisor has length one.

A component containing a fixed point is necessarily stable under
\(\iota\).  Conversely every fixed point occurs on one of the listed
components, proving the first equality in (A.4).  Since \(\iota\)
interchanges \(p_1,p_2\), their degrees agree on a stable component.
The sum of the \(p_1\)-degrees over all components of \({\mathcal Z}\)
is \(m\), proving the inequality in (A.4).

In characteristic different from two, a nonidentity involution on a
smooth curve has a simple fixed divisor.  The restriction to \(Z_j\)
cannot be the identity because the fixed locus in (A.5) is finite.
Thus its quotient is ramified exactly at the \(R_j\) listed points.
\(\square\)

## 2. Summing the cross-image trace bound

Let \(X\) be a smooth projective curve of genus

\[
                              g=s+1\geq2,
\]

and suppose in addition that

\[
                         h:C\longrightarrow X
\]

is finite etale of degree \(M\).  On each component \(Z_j\) of
Proposition A.1 put

\[
 h_j=hp_1:Z_j\longrightarrow X,\qquad
 h_j\iota=hp_2:Z_j\longrightarrow X.                  \tag{A.6}
\]

Both maps have degree

\[
                              A_j=Ma_j.                \tag{A.7}
\]

Let \(f_j\) be the generic degree of

\[
                  (h_j,h_j\iota):Z_j\longrightarrow X\times X
\]

onto its reduced image, and put

\[
                              q_j={A_j\over f_j}.       \tag{A.8}
\]

Thus \(q_j\) is the degree of either projection from the normalization
of the reduced cross-image to \(X\).

### Theorem A.2 (component-summed ascent of the trace bound)

With this notation one has the exact weighted inequality

\[
\boxed{
 mR_D\leq
 2M\sum_{j=1}^t a_j
       \left(1+\sqrt{\,g\left(1+{s\over q_j}\right)\,}\right).
}                                                       \tag{A.9}
\]

Consequently, if \(q_j\geq q_0\) for every \(j\), then

\[
\boxed{
 R_D\leq
 2M\left(1+\sqrt{\,g\left(1+{s\over q_0}\right)\,}\right).
}                                                       \tag{A.10}
\]

More precisely, if

\[
                         \theta={1\over m}\sum_{j=1}^ta_j\leq1,
\]

then the right side of (A.10) may be multiplied by \(\theta\).

#### Proof

Apply Theorem 80.1 of
80_NONSCALAR_CROSS_IMAGE_TRACE_SIEVE.md to the etale map \(h_j\) and
the ramified involution \(\iota|_{Z_j}\).  In the notation there, the
cover degree is \(A_j\), the generic image degree is \(f_j\), and the
reduced projection degree is \(q_j=A_j/f_j\).  Its inequality reads

\[
\begin{aligned}
 R_j
 &\leq2A_j+2\sqrt{gA_j(A_j+sf_j)}\\
 &=2Ma_j\left(1+\sqrt{\,g\left(1+{s\over q_j}\right)\,}\right).
                                                               \tag{A.11}
\end{aligned}
\]

Sum (A.11) and use both identities in (A.4).  This proves (A.9).
If all \(q_j\geq q_0\), the square-root factor is at most the one in
(A.10); using \(\sum a_j/m=\theta\leq1\) proves the remaining claims.
\(\square\)

### Corollary A.3 (the uniform simple-Jacobian bound)

Assume that \(X\) is nonhyperelliptic and \(J(X)\) is simple.  Then

\[
                              q_j\geq3
\]

for every component in Proposition A.1, and hence

\[
\boxed{
 R_D\leq
 2M\left(1+\sqrt{\,g\left(1+{s\over3}\right)\,}\right).
}                                                       \tag{A.12}
\]

#### Proof

Every \(\iota|_{Z_j}\) is ramified.  The graph argument of Lemma 80.2
excludes \(q_j=1\) when \(X\) is nonhyperelliptic with simple Jacobian.
The bidegree-two theorem in
SIMPLE_JACOBIAN_FORBIDS_BIDEGREE_TWO_BIETALE_SELF_CORRESPONDENCES.md
excludes \(q_j=2\).  Apply Theorem A.2 with \(q_0=3\). \(\square\)

## 3. The exact remaining loss

The enlargement degree \(m\) occurs on both sides before summation:
there are exactly \(mR_D\) lifted fixed points, while the sum of the
degrees of all swap-stable components is at most \(m\).  These factors
cancel relative to the upstairs degree \(M\).  However, if the natural
lower degree is

\[
                              N={M\over m},
\]

then (A.12) reads

\[
 R_D\leq
 2mN\left(1+\sqrt{\,g\left(1+{s\over3}\right)\,}\right).           \tag{A.13}
\]

Thus it still has an \(m\)-loss relative to \(N\).  The only bookkeeping
slack is

\[
                         \theta={\sum a_j\over m}\leq1,
\]

coming from components which are exchanged in pairs or are stable but
fixed-point-free.  To improve (A.13) to \(O(N)\) by component summation,
one would need

\[
                         \sum a_j=O(1),
\]

equivalently \(\theta=O(1/m)\).  This is false for general twisted
fiber products.

### Lemma A.4 (the stable-degree fraction can equal one)

Let \(\ell\ne2,\operatorname{char}k\) be a prime.  Suppose the action of
\(\delta\) on \(H^1_{\mathrm{et}}(D,\mathbf F_\ell)\) has nonzero
\((+1)\)- and \((-1)\)-eigenspaces.  Then there is a connected etale
\(C_\ell\)-cover \(e:C\to D\) for which the twisted product
\({\mathcal Z}\) in (A.1) is connected.  For this cover

\[
                         m=\ell,\qquad t=1,\qquad
                         a_1=m,\qquad\theta=1.          \tag{A.14}
\]

#### Proof

Choose nonzero eigenvectors \(\chi_+,\chi_-\) and put
\(\chi=\chi_++\chi_-\).  The nonzero class \(\chi\) defines a connected
etale \(C_\ell\)-torsor \(C\to D\).  Its transform under \(\delta\) has
class

\[
                         \delta^*\chi=\chi_+-\chi_-.
\]

Because \(\ell\ne2\), the two classes are linearly independent.  The
fiber product of the corresponding torsors is therefore the connected
\(C_\ell^2\)-torsor associated with
\((\chi,\delta^*\chi)\).  This fiber product is precisely
\({\mathcal Z}\) viewed over \(D\).  Hence \({\mathcal Z}\) has one
component.  It is swap-stable and its degree over either copy of \(C\)
is \(\ell=m\), proving (A.14). \(\square\)

For a ramified involution with quotient of positive genus and nonzero
Prym, both eigenspaces in Lemma A.4 are nonzero for every odd
\(\ell\ne\operatorname{char}k\).  Thus \(\theta=1\) is not exceptional
from the viewpoint of the lower cover.

### Proposition A.5 (descent suffices to restore the lower scale)

Assume \(m\mid M\) and put \(N=M/m\).  If \(h:C\to X\) descends through
\(e\), so that

\[
                         h=\bar h e
\]

for a morphism \(\bar h:D\to X\), then \(\bar h\) is finite etale of
degree \(N\).  Under the hypotheses of Corollary A.3, applying the trace
bound directly on \(D\) gives

\[
\boxed{
 R_D\leq
 2N\left(1+\sqrt{\,g\left(1+{s\over3}\right)\,}\right).
}                                                       \tag{A.15}
\]

The exact descent condition is

\[
 h\operatorname{pr}_1=h\operatorname{pr}_2
       \quad\text{on }C\times_D C.                    \tag{A.16}
\]

Neither the genus identity nor minimality of a common cover forces
(A.16): minimality controls only quotients through which all maps to the
two fixed target curves descend.

#### Proof

The function fields form the intermediate tower

\[
                         k(X)\subset k(D)\subset k(C).
\]

Since \(C\to X\) is etale, separability and multiplicativity of
ramification indices make \(\bar h:D\to X\) etale.  Degrees give
\(\deg\bar h=M/m=N\).  Apply Corollary A.3 with \(C=D\), \(m=1\), and
the involution \(\delta\), proving (A.15).

Condition (A.16) is the fpqc descent criterion for the morphism \(h\)
along the finite etale cover \(e\).  The final assertion is the same
fixed-target distinction isolated in
MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md: a quotient is a smaller
common cover only when both target maps descend. \(\square\)

Therefore failure of \(\delta\) to lift causes no extra loss beyond
\(M\), but replacing \(M\) by the lower degree \(N\) requires genuinely
new input.  Descent supplies such input, but the argument does not claim
it is necessary: a different geometric mechanism could also prove an
\(O(N)\) estimate.  Raising only the componentwise lower bound on
\(q_j\) changes the constant in (A.13); it cannot remove the leading
factor \(m\).

Lemma A.4 concerns the twisted-cover geometry alone; it does not assert
that its example also carries a prescribed map to a particular
simple-Jacobian curve \(X\).  Thus application-specific geometry could
still force \(\theta<1\).  What the present argument proves is that
simplicity of \(J(X)\), as used here, only raises \(q_j\) to three and
does not by itself alter the \(m\)-scaling.

## 4. Translation to central signed inertia

In the notation of CUBIC_SIGNED_MONODROMY_J8_GENUS_IDENTITIES.md, let
\(u_{\mathrm{cen}}\) be the number of central-sign inertia values and
let \(h_6\) be the number of order-six inertia values.  For either signed
group containing the central involution, its action on the degree-eight
curve \(D^*\) has

\[
                   R_{D^*}=4u_{\mathrm{cen}}+2h_6.     \tag{A.17}
\]

Indeed, central-sign inertia fixes the four ramification points above
that branch value, while an order-six inertia fixes the two points
corresponding to its cycles of lengths six and two; the other allowed
inertia types contribute no fixed point of the central involution.
Equivalently, (A.17) follows by subtracting twice the
Riemann--Hurwitz formula for the antipodal-pair quotient from that for
\(D^*\).

Consequently, if an etale cover \(C\to D^*\) of degree \(m\) also has an
etale map \(C\to X\) of degree \(M=mN\), with \(X\) nonhyperelliptic and
\(J(X)\) simple, then (A.12) gives only

\[
 2u_{\mathrm{cen}}+h_6
 \leq mN\left(1+\sqrt{\,g\left(1+{s\over3}\right)\,}\right).       \tag{A.18}
\]

This is the precise limitation for the central \(j=8\) route: the trace
ascent controls central inertia at the upstairs scale \(M=mN\), but not
at the lower scale \(N\).  Proposition A.5 supplies a lower-scale
version when \(C\to X\) descends through \(D^*\); it does not rule out
other ways to obtain one.
