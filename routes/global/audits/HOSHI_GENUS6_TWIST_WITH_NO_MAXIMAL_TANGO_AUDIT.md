# Focused audit: the genus-six twist has no maximal Tango structure

**Verdict: PASS. No breaking objection.**  
**Auditor:** `/root/gluing_cohomology_rigidity`  
**Date:** 2026-09-05  
**Target:** [the integrated theorem](../HOSHI_GENUS6_TWIST_WITH_NO_MAXIMAL_TANGO.md).  
**Environment:** SageMath 10.9, `sage -python`.

This audit checks the new global-to-finite proof that the displayed
genus-six twist has no maximal Tango structure, and the actual auxiliary
étale square used in the consequence. The author supplied the final
certificate; the auditor separately derived the divisor and local
connection checks, checked the semilinear completeness argument, and
reran the frozen final certificate. The earlier identification of the
original Hoshi curve and its exact ten-Tango count remain explicitly
cited inputs, not blanket independent re-audits of those older notes.

## Global bridge

All equations are interpreted on their smooth projective normalizations.
Put \(e=A+B_0v\). The stated divisors of \(e\) and \(q\) give the following
orders on the twist:

| Points on the twist | \(dt/v\) | \(h_X\) | \(q^3\) | \(q^3dt/(vh_X)\) |
|---|---:|---:|---:|---:|
| Two above \(Q_0=(0,2)\) | 0 | 5 | 0 | -5 |
| Four above the selected Weierstrass points | 0 | 1 | 6 | 5 |
| Six ramification points above the \(R_i\) | 1 | 1 | 0 | 0 |
| Four points at infinity | 1 | -5 | -6 | 0 |

There are no further zeros or poles. Thus the rational differential

\[
                     \xi=q^3\frac{dt}{vh_X}
\]

has a divisor divisible by five. Declaring it horizontal defines a
regular canonical connection at every point, including the points where
the displayed affine equation is singular: locally its coefficient is
minus the logarithmic derivative of a unit after removing a fifth power
of a uniformizer. Its rational horizontal generator gives zero
p-curvature.

Every regular dormant connection on the fixed canonical line is this
origin plus a Cartier-fixed regular differential. Conversely every such
translate is regular and dormant. A maximal Tango line, with
\(F_X^*L\simeq\omega_X\), gives one of these connections. Its Cartier
composite \(L\to\omega_{X^{(1)}}\) vanishes exactly for a maximal Tango
structure; this is the exact maximum, not a floor/pre-Tango condition.

## Geometric completeness, not a finite-constant-field sample

The four anti-invariant holomorphic forms are complete. The polynomial
degree bounds, divisibility by \(q\), and five conditions at \(Q_0\)
are necessary and sufficient for regularity, and scalar elimination
verifies their dimension and every Cartier image. The invariant part
contributes precisely the Cartier-fixed form \(t\,dt/v\).

For the displayed anti-invariant matrix \(M\), Cartier acts on a
geometric coefficient vector \(z\) by \(M z^{1/5}\). Therefore its fixed
equation is

\[
                 z^5=M^{(5)}z,\qquad z^{25}=Nz,
                 \qquad N=M M^{(5)}.
\]

The auditor independently multiplied scalar matrices and checked that
\(N\) has exact order 60. Since \(N\) has entries in \(\mathbf F_{25}\),
every geometric solution satisfies \(z^{25^{60}}=z\). Thus
\(\mathbf F_{5^{120}}\) contains **every** geometric solution. The final
certificate also checks the order, records an irreducible modulus and
the exact embedding of \(r\), and expands the equation into 480 linear
coordinates over \(\mathbf F_5\).

Each of the four resulting vectors is checked against the original
field equation and reconstructed from its prime-field coordinates.
The auditor additionally verified their independence by direct
integer-modulo-five elimination. This agrees with the anti-invariant
Cartier-bijective dimension four. Including \(t\,dt/v\) gives all
\(5^5=3125\) geometric dormant connections, not 125 connections and not
only the connections defined over \(\mathbf F_{25}\).

No optimized extension-field matrix operation is used. The sole
optimized matrix is over the prime field; the known custom-
\(\mathbf F_{25}\) dense-matrix defect is avoided.

## Exact rejection and reproduced output

For a horizontal form \(u\,dt\), write \(u'=-au\). Direct differentiation
in characteristic five gives

\[
 \frac{u^{(4)}}u
 =a^4-a^2a'+3(a')^2+4aa''-a'''=P_4(a).
\]

The Cartier formula identifies its vanishing with the Tango condition.
At every test point the code verifies the two curve equations and
\(v h_X q e\ne0\). Consequently \(t-t_0\) is a local parameter and the
computed coefficients have no poles. Series precision five determines
the horizontal unit through order four and hence all four required
jets of its logarithmic derivative. The factorials in the jet conversion
are correct in characteristic five.

The frozen final run returned:

```text
ALL 3125 dormant connections tested at the explicit ordinary point.
SURVIVORS 3 [(0, 0, 0, 0, 1), (0, 0, 0, 0, 3), (3, 0, 0, 0, 4)]
POINT 2 survivors 1 [(0, 0, 0, 0, 1)]
POINT 9 survivors 0 []
EXACT GEOMETRIC TANGO COUNT 0 []
PASS: every geometric dormant canonical connection was rejected.
```

Points 3 through 8 retain the same sole survivor. At the final point
\((t,v,h_X)=(0,3,2)\), one has \(e=4\), \(q=1\), and \(F=4\): this is
the safe point above \(v=3\), **not** the point \(Q_0=(0,2)\) where the
chosen rational horizontal differential has poles. An independent
hand check gives

\[
 \begin{aligned}
 a_0&=-\partial_t\log\frac{q^3}{vh_X}
      =\frac{F'}{2F}+\frac{e'}{2e}
      =2t+2t^3+O(t^4),\\
 t/v&=2t+3t^3+O(t^4).
 \end{aligned}
\]

Thus the last survivor has jets \((0,4,0,0)\), giving \(P_4=3\ne0\).
The final code checks these values and asserts `survivors == []`.

Every candidate has a nonzero necessary local obstruction somewhere.
The conclusion uses neither interpolation nor any nine-zero bound.

## Actual-cover consequence and scope

The quadratic extension \(B(\sqrt q)/B\) is nontrivial and étale:
\(\operatorname{div}(q)\) is even, and neither \(q\) nor \(q/F\) is a
square in \(k(t)\). It is linearly disjoint from the ramified quadratic
extension \(Y_{\rm Hoshi}/B\). Their fiber product is therefore connected
and étale over \(Y_{\rm Hoshi}\); writing \(h_X=sh_Y\) identifies the
same smooth curve with the étale base change over \(X_{\rm twist}\).
Both actual degree-two maps are retained, so the existing Tango
structure on \(Y_{\rm Hoshi}\) pulls to this common source. Its map to
the Tango-free twist proves the stated failure of unrestricted étale
descent.

These auxiliary curves share the genus-two quotient \(B\). They do not
give a Jacobian-orthogonal fixed-pair construction, and no assertion
about file 76 or Litt's conjecture follows. The twist has p-rank five
and genus six; the script's phrase “ordinary point” means a regular
unramified affine chart, not that the curve is ordinary.

**Breaking objections:** none.  
**Non-breaking qualifications:** the scope exclusions above are essential;
the older exact ten-Tango count and original-model identification are
retained inputs. The exact count ten is unnecessary for the descent
counterexample: the previously exhibited maximal Tango structure with
horizontal differential \(dw\) already suffices.

## Checked certificate revisions

- `HOSHI_GENUS6_SINGLE_TWIST_TANGO_CERTIFICATE.py`:  
  `69d4a9b7b190730aaf21171cc4b6d3ec111d0c6b8280f3e4f33a43019c177dfe`.
- `HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE.py`:  
  `9a08f27bab65ca6f30673ca609ef47613a10fc36b808dea31f401184c4c35bf1`.

Only the new theorem's audit-status/link metadata was updated; no
pre-existing proof or certificate was edited by this audit.
