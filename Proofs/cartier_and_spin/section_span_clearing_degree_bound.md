# Proof of the section-span clearing bound

Version1,2 October2026.
[Statement](../../Theorems/cartier_and_spin/section_span_clearing_degree_bound.md).
The geometric argument is independent of the application certificates.

Suppose a fiber of psi has length greater than t+1. Nonconstancy on a
proper curve makes the fiber finite. Shortening its local multiplicities
produces a closed subscheme Z of length t+2. The degree hypothesis gives
$\deg L^d(-Z)\ge2g-1$, so $H^1(C,L^d(-Z))=0$. Consequently
restriction onto Z is surjective. The codimension-t space S_d therefore
has restriction image of dimension at least (t+2)-t=2.

But psi on Z factors through one projective point, including its
scheme structure. A nonvanishing coordinate trivializes L on Z, and
every degree-d coordinate monomial is a constant multiple of its dth
power there. The restriction of S_d has dimension at most one, a
contradiction. This proves the fiber bound, with all local lengths.

For the application, take a constant basis of V and its m by m+1
coefficient matrix M. At a rank-m point where the coefficient vector
of p vanishes, the constant vector [p] equals the kernel direction
psi. Choose a nonzero coordinate of p. The complementary m columns
form an invertible matrix at that point; after normalizing the matching
kernel coordinate, the vector Mp is that invertible matrix times the
projective-coordinate differences. Thus the ideal of its coefficients
is precisely the local ideal of the scheme fiber psi inverse([p]).

At a finite pole Q of c of order h, Gauss content gives vanishing of
every coefficient of p to at least order h. For completeness, in the
DVR at Q the coefficient content of T-c is -h. The content of a
polynomial product is the sum of contents: after clearing powers of
the uniformizer, this follows by nonvanishing of the product of two
nonzero polynomials over the residue field. Integrality of (T-c)p
therefore forces content(p) at least h.

The sum of pole orders is bounded by the length of the fiber of psi,
hence by t+1. If e_Q is the ramification index of x, the required
exponent of x-x(Q) is $\lceil h/e_Q\rceil$. The maximum over one
x fiber is no greater than the sum of its pole orders. Summing over
x values bounds the minimum clearing degree by t+1. This formula
retains ramified and repeated denominator roots; no root is inverted.

For a higher-dimensional coefficient kernel, the local ideal of a
fixed-section incidence fiber is still the coefficient ideal of p.
The same Gauss proof uses any independently established length bound
for that fiber. It does not infer such a bound from the incidence
projection having positive-dimensional source.

The m9 applications use the base divisors and ranks retained in the
[complete scoped proof](admissible_degree_ten_m9_zero_moment_denominator_exclusion.md).
At degree35, genus9, d=7, the complete section dimension is237 and
the monomial span has dimension236. The degree245 exceeds2g+1+1,
so every scheme fiber has length at most2. Selected rank-boundary
poles have their own complete strengthened-contact exclusion. The
remaining minimum clearing degree3 is impossible. No source is
constructed by this necessary-condition argument.
