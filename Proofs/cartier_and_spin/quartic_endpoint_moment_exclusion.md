# Proof: complete quartic endpoint determinant exclusion

[Statement](../../Theorems/cartier_and_spin/quartic_endpoint_moment_exclusion.md).
This integrates the completed Pro result. Its
[complete report](../../../litt3-computation-data/quartic_complete_partial_replies_20260927/extracted/quartic/REPORT.md),
[original archive and hashes](../../../litt3-computation-data/quartic_complete_partial_replies_20260927/manifest.json)
and [byte-identical source copies](../../scripts/arithmetic/pro_quartic_complete_partials_20260927/quartic/)
are retained. Earlier partial reports inside the archive are historical;
the final proof is in REPORT.md and full/.

## Algebraic elimination, including every boundary

Use S=F_(5^7), K=S[beta], and F=K[theta], where
\[
h=(4,4,2,3,3,2,2,1),\quad S=\mathbf F_5[t]/h,
\quad\theta^4=[20],\quad
\alpha=[7]+[21]\theta^2+4\theta^3.
\]
The exact bridge zeta=U(t)+beta V(t), with
U=(2,2,3,2,1,0,2), V=(1,2,4,1,3,0,1), satisfies
t=zeta+zeta^-1. The source checks the specified alpha and zeta
polynomials, irreducibility, root order and original coefficient rows.
In this basis
\[
c(\alpha)=[20]+\theta+[7]\theta^2+[19]\theta^3,
\qquad e(\alpha)=[8]+\theta+[15]\theta^2.
\]
Bar acts only on K: bar(a+beta b)=a+b-beta b, and
N(a+beta b)=a^2+ab+2b^2. It is not applied to F.

Set A=E_Q/eta, B=C_Q/eta, C=C_H/eta, D=E_H/eta, W=AD-BC.
The necessary determinant is
\[
W-Ax-D\bar x+B\bar y+Cy+N(x)-N(y)=0.\tag{1}
\]
Subscripts below mean theta coefficients. Since A3=D3=0, put
\[
d_x=N(A_1)-N(D_1),\quad d_y=N(C_3)-N(B_3),\quad d=d_xd_y.
\]
When d!=0, the theta3 and theta1 equations and their K-conjugates
uniquely determine the two moments. Explicitly,
\[
Y=B_3\bar W_3-\bar C_3W_3,\qquad
R=d_yW_1+B_1\bar Y+C_1Y,\qquad
X=\bar A_1R-D_1\bar R,
\]
and y=Y/d_y, x=X/d. The remaining equations are Z=T=0, where
\[
Z=dW_2-A_2X-D_2\bar X+d_x(B_2\bar Y+C_2Y),
\]
\[
S_0=dW_0-A_0X-D_0\bar X+d_x(B_0\bar Y+C_0Y),
\qquad T=dS_0+N(X)-d_x^2N(Y).
\]
These are polynomial identities after clearing only d, which is
explicitly nonzero in this branch. On d=0 the calculation instead
uses x=x0+beta x1, y=y0+beta y1 with coordinates in S. Seven
nonscalar coordinates of(1) give an affine linear system in four
variables. Its scalar coordinate is one additional quadric. Full
coefficient and augmented ranks are retained, without dividing by
any selected pivot.

## Exhaustive coverage and the accelerated identity

There are7,940,751 four-label multisets. Removing1015 one-phase
and1711 half-turn-invariant multisets, adding back their87-element
intersection, leaves7,938,112 endpoints. The group
\[
(i,j)\longmapsto(i+a,25^u j+b),
\quad a\in\mathbf Z/4,\ u\in\mathbf Z/7,\ b\in\mathbf Z/29
\]
has order812 and acts freely on this set. A nonidentity phase
translation has29-cycles; a nontrivial phase multiplier has one fixed
phase and7-cycles elsewhere. Four occurrences cannot support either
except in the excluded one-phase case. A nontrivial type rotation
implies the excluded half-turn invariance. Hence there are9776 orbits.
The canonicalization normalizes an actual occurrence to(0,0), and
enumerates all266916 remaining sorted triples, retaining multiplicity.
It returns266840 allowed triples and9776 canonical minima.

On a pair, the valid actions are simultaneous type rotation,
compensated coefficient25-Frobenius, opposite phase translations,
and endpoint interchange. Under opposite phase translation by b,
x is multiplied by zeta^(-8b) and y by zeta^(5b); substitution
preserves(1). Interchange sends x,y to bar(x),bar(y). Therefore one
may order the two orbit indices q<=h and test all812 transforms of
the second representative. This covers all independent pairs and
has812*9776*9777/2=38,805,460,512 entries.

The necessary Z is a degree-six polynomial in28 formally independent
endpoint coordinates and their bars. It has184 monomials. Separating
the two endpoints gives a134-by-134 coefficient matrix of rank92,
and an exact identity Z=sum U_l(Q)V_l(H). The factorization and each
factor's phase/type weights are verified coefficientwise, not by
samples. Each F5 coordinate of Z is consequently an integer dot
product of1288 entries in0..4, reduced modulo5. The largest possible
sum is20608, so neither the portable nor vector implementation
overflows. All padded entries are zero. This is an exact sieve.

The norm-boundary computation separately indexes ALL7,938,112 second
endpoints by the two relevant norms. For each canonical first
endpoint, the union of matching buckets, with overlap removed,
is precisely d_xd_y=0. No independence or injectivity of norm
values is assumed.

## Complete results and final contradictions

Two complete generic runs, using different first coordinate tests,
agree on every one of the9776 retained rows and on all survivors.
They find1,418,240 zeros of Z:1,418,234 lie on the separately handled
norm boundary and six have d!=0. All six have a nonzero beta
coefficient in the remaining K-valued determinant; their S-code
pairs are
(37797,39432),(62,46629),(3160,6562),(76835,27017),
(34572,22578),(9861,61769).
Thus they fail even a remaining linear coordinate of(1).

The entire boundary has9,740,288 tested pairs. Coefficient ranks
2,3,4 occur288144,1436,9450708 times respectively. Only five
affine systems are consistent, all of rank4. Their scalar quadric
residuals, in the degree-seven field encoding, are1886,51635,39161,
60050,30912, all nonzero. No consistent lower-rank family remains.
Every one of these eleven decisive pairs is reconstructed directly
from its labels by independent polynomial arithmetic, using(1)
rather than the optimized factorization or logarithm tables.

These two branches exhaust the determinant locus. Consequently the
old trace pair has no solution on the endpoint domain in the statement.
Additional traces, orientations or integer weights cannot restore one.

## Local verification and its limits

The incoming compact verifier passed all123 manifest entries, complete
row accounting, universal polynomial identities and all eleven exact
survivors. Locally we additionally regenerated the ENTIRE singular
boundary, all9,740,288 pairs, and its five candidates; the counters
and candidates exactly match the received complete run. A portable
generic replay on orbit interval[3601,3602) tested2,924,824 pairs and
matched every counter and its one survivor. This interval is explicitly
a bounded implementation check, not the full generic enumeration.

The two supplied full38.8-billion runs are retained evidence; the
full generic rejected enumeration was not rerun locally. Source and
symmetry coverage were reviewed, and the universal factorization
and survivors independently checked. No statement equates these
checks with an independent third full run.

From the retained extracted archive run python3 -B full/src/verify.py.
Compile full/src/full_scan.cpp as C++17 with OpenMP and
-DPORTABLE_DOT for the portable path. The README contains complete
restartable regeneration commands. The boundary executable is
continuation/src/boundary_scan.cpp; run it with arguments0 9776,
then full/src/check_run.py boundary with its summary and candidate
files. Exact local commands, versions, outcomes and provenance are
in [the integration audit](../../Research/audits/QUARTIC_COMPLETE_PARTIALS_2026_09_27.md).
