# Audit: impossibility of the cyclic genus-one coarsening

**Verdict:** **PASS.** No breaking mathematical or finite-arithmetic
objection found.

**Auditor and date:** `/root/x_elliptic_quotient_maps`, 2026-09-04.

## Checks performed

- If the translated-pair map factors through \(u:E\to D\), its generic
  degree divides nine. The extension is separable because it is intermediate
  in the separable extension defined by \(t\), and Riemann--Hurwitz gives
  \(g(D)\leq1\). If \(D\) is rational, the two coordinate pencils pull back
  to \(L\) and \(\tau^*L\), forcing a nonzero point of \(E[7]\) into
  \(\ker\phi_L=E[9]\), which is impossible.
- In the remaining \(e=3,\ g(D)=1\) case, \(u\) is an etale degree-three
  isogeny after origins are chosen. Its translation kernel \(H\simeq C_3\)
  fixes \(t\), commutes with the order-seven translation \(\tau\), and
  therefore fixes every root \(t\tau^i\) and every ordinary coefficient of
  their norm polynomial. The induced action on
  \(B=E/\langle\tau\rangle\) is nontrivial because the order-three and
  order-seven kernels intersect trivially. This contradicts Proposition
  47.1, which says those coefficients generate \(k(B)\). The \(e=9\)
  case would give a degree-one map from a genus-one curve to
  \(\mathbf P^1\). Thus the translated pair is birational.
- A bidegree-\((9,9)\) integral curve in
  \(\mathbf P^1\times\mathbf P^1\) has arithmetic genus 64. Since its
  normalization is \(E\), its total delta is 63. Applying
  \(r_z-1\leq\delta_z\) to the 252 points of \(S\) gives at least
  \(252-63=189\) distinct grid images in
  \(\mathcal A\times\mathcal A\).
- Since \(31\mid124\), every member of
  \(\mathcal A=\mu_{31}\cup\{\infty\}\) is
  \(\mathbf F_{125}\)-rational. The translated-pair image and its
  125-Frobenius conjugate therefore share at least 189 distinct geometric
  points. Distinct bidegree-\((9,9)\) curves have intersection number 162,
  so they must coincide. Stability of the embedded curve descends it; the
  normalization and the two ambient coordinate functions descend
  functorially as well.
- The Weil lower bound gives an \(\mathbf F_{125}\)-point on the descended
  genus-one curve, so it can be used as origin. For
  \(D_0=t^{-1}(\infty)\) and
  \(D_1=(t\tau)^{-1}(\infty)=T_{-Q}D_0\), one has
  \([D_1-D_0]=-[9]Q\). Both divisors are rational, hence
  \([9](FQ-Q)=0\); since \(Q,FQ\in E[7]\), coprimality forces \(FQ=Q\).
  Thus \(Q,\tau\), the quotient \(\pi\), and the intrinsic divisor \(S\)
  descend, as does its quotient \(\Delta\).
- The descended coefficient image \(B'\subset\mathbf P^7\) is integral,
  nondegenerate, and degree nine. Castelnuovo gives
  \(p_a(B')\leq2\), hence total delta at most one because its normalization
  \(B\) has genus one. For every \(b\in\Delta\), the seven homogeneous
  roots of its coefficient form lie in the rational projective set
  \(\mathcal A\), so the coefficient point \(\chi(b)\) is rational even
  when a root is infinity. A nonrational Frobenius orbit in the
  normalization over this rational point costs at least one delta. The
  bound therefore permits only one orbit of length two, so at most two of
  the 36 geometric points of \(\Delta\) are nonrational.
- The spectral image in \(B\times\mathbf P^1\) is birational with
  projection degrees seven and nine. Adjunction gives arithmetic genus 55
  and total delta 54. A constant-labelled fiber gives seven distinct smooth
  graph branches through one point. The standard branch formula gives local
  delta at least \(\binom72=21\), so there can be at most two such fibers.
- Once \(Q\) is rational, a rational fiber of \(\pi\) is a torsor under the
  constant group \(C_7\). Frobenius acts on it as \(\tau^j\). Since every
  \(t(\tau^iP)\) belongs to the rational set \(\mathcal A\), nonzero \(j\)
  cyclically forces all seven labels to be equal. Thus every rational
  nonconstant-labelled fiber splits completely.
- The finite arithmetic was rerun independently:

  \[
  189>162,\qquad
  3\binom72=63>54,\qquad
  (36-2-2)\cdot7=224,
  \]

  while

  \[
  125+1+2\sqrt{125}=148.360\ldots,
  \]

  so the integer Weil upper bound is 148. The final contradiction is
  therefore valid with a margin of 76 points.

## Non-breaking suggestions and objections

- In Lemma 63.2, one could explicitly say that origins on \(E,D,B\) are
  chosen compatibly. This makes it immediate that both the degree-three
  deck group and \(\tau\) consist of translations and commute.
- In Proposition 63.5, it would be useful to state that Frobenius stability
  of the embedded reduced curve gives effective descent of its defining
  ideal, while normalization over the perfect finite field commutes with
  base change. This makes the simultaneous descent of \(E,t,t\tau\)
  completely formal.
- In Lemma 63.6, “at most two members of \(\Delta\)” counts geometric
  points. The only possible nonrational contribution is one Frobenius orbit
  of length two; making this explicit would help avoid confusion with
  closed-point degree.
- The proof correctly uses homogeneous binary forms and therefore includes
  infinity in both the grid descent and coefficient-point rationality
  arguments.

**Audited revision SHA-256:**
`6f13846bf8b48c0a64b31b1d3ff63c1c2b8120b86ccec09ae63ed1a0ce1f976e`.
