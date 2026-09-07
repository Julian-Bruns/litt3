# Extension pencil: bounded literature check

2026-09-07. Reference/research note, not a registered theorem or exclusion.
Inventory searches for Bertram and extension were made before this check.
The unmarked common-cover problem remains unsolved; no conclusion here
replaces either actual finite etale map from the same source.

## Closest exact precedent: Thaddeus's fixed-bundle fibre

[Michael Thaddeus, *Stable pairs, linear systems and the Verlinde formula*,
arXiv:alg-geom/9210007](https://arxiv.org/pdf/alg-geom/9210007),
§3, especially (3.20), and §5, (5.1)–(5.5).
The paper assumes a smooth projective **complex** curve of genus at least2,
fixed determinant Lambda of positive degree d. Its last stable-pair space
has fibre P H0(E) over a stable bundle E. The first space is
P H1(Lambda^-1); the intervening modifications resolve the relationship
with extensions. In (5.1), O1(m,n)=O((m+n)H-nE1), so (m,n)=(1,0)
is the extension-space hyperplane. Formula (5.5)(iii) restricts the
corresponding line bundle to O(m(d-2)-2n) on the fixed-bundle fibre.

The proof was read: the universal pair restricts to E(1), its determinant
at a point is O(2), and its determinant of cohomology is O(d+2-2g).
Substitution in (5.4) gives the formula. Thus d=48 gives exactly46.
This is a close established precedent for our expected polynomial degree,
not merely a dimension analogy. The global complex moduli-space results
cannot be cited unchanged in characteristic5; our elementary algebraic
kernel/resultant proof should supply that transfer and primitiveness.

## Resultant and boundary strata

[Roger Bielawski, *Nonnegative polynomials from vector bundles on real
curves*, arXiv:1208.6456](https://arxiv.org/pdf/1208.6456), introduction,
§2.1 and Proposition2.6. The complex preliminaries call the hypersurface
of sections vanishing somewhere the E-resultant. For a very ample rank2
bundle E of degree d it has degree d. Proposition2.6 assumes also a
section with exactly two zeros and gives degree
d(d-3)/2+1-g for the locus V^[2](E) of sections having at least two zeros.
Its proof was read: form the rank4 tautological bundle E^[2] on Sym²C,
use its evaluation incidence and generic degree1, then compute c2(E^[2]).
For d48,g9 the degrees are48 and1072.

These are useful boundary checks, not Frobenius obstructions. The paper's
base field is C; positivity and real nonnegativity play no role for us.
For E=W L in our range, the required separation of length2 schemes follows
directly from stability and H1(E(-D))=0. Characteristic5 incidence/Chern
arguments still require explicit formulation rather than importing the
paper's complex hypothesis silently.

Independent elementary observation (not attributed to that paper): if a
section u has zero divisor D, its saturated line is O(D) in E. The kernel
of H0(E omega) -> H0(L² omega), v |-> u wedge v, is
u_sat H0(omega(D)). For D=x, its dimension remains g, so rank remains55;
the image is H0(L² omega(-x)). Consequently the extension rational map
extends at a section with one simple zero and takes the embedded point x
in P H1(L^-2). The degree48 resultant divisor is therefore **not** the
base divisor of the extension rational map. For degD=k>0 the rank is
56-k in the present dimensions. At k>=2 the kernel-line construction
loses uniqueness; the two-zero stratum is the natural indeterminacy
candidate. Scheme structure of the primitive-coordinate base ideal has
not been proved here.

## What ordinary Frobenius extension theory does, and does not, say

[Hiroshi Tango, *On the behavior of extensions of vector bundles under
the Frobenius map*, Nagoya Math. J.48 (1972),73–89](https://doi.org/10.1017/S0027763000015099),
Theorem15 and its proof via Theorem5 and the locally exact differential
sheaf B1. Over an algebraically closed field of characteristic p>0,
if degA>n(C), then F*:H1(A^-1)->H1(A^-p) is injective;
n(C)<=floor((2g-2)/p). The proof bounds line subbundles in B1 and
identifies the kernel using 0->O->F_*O->B1->0.
For A=L², g9,p5, degree48>3, so the raw pullback extension map is
injective. This is already an elementary useful check, but it neither
identifies nor controls the additional u-dependent projection/retraction
R_u. Injectivity before that projection cannot exclude a preserved
extension line after it. In particular this does not resurrect a
universal Tango obstruction to common covers.

[Lange–Pauly, *On Frobenius-destabilized rank-2 vector bundles over
curves*, arXiv:math/0309456](https://arxiv.org/pdf/math/0309456),
Theorem1 and Proposition3.1: the general theorem constructs destabilized
stable bundles using subbundles of F_*L, whereas the detailed
one-dimensional Hom and finite determinantal base-locus descriptions
in §3 onward impose **ordinary genus2**, p>2. The relevant adjunction
proof of Proposition3.1 was read. Those genus2 conclusions cannot be
used for our fixed genus9 extension-pencil preservation condition.

## Practical conclusion

The degree46 mechanism has a near-exact published predecessor, and
resultant48 versus indeterminacy in codimension2 is established geometry
worth exploiting. This bounded search found no theorem excluding
R_u-preserved extension lines on the admissible fixed-bundle fibre.
That absence is a search result, not a claim of novelty or impossibility.
Bertram's secant resolution is identified in Thaddeus §8 and bibliography
(J. Differential Geom.35 (1992),429–469); its proof was not independently
retrieved, so no stronger Bertram theorem is imported here.
