# Proof: exact finite-algebra certificates

[Statement](../../../Theorems/atlases/finite_algebras/finite_algebra_completion_certificates.md).
The certificates below specialize standard ideal, étale-algebra and
length arguments.

## Stop from a known colength

For M=(LM(g):g in G), certified membership G subset I gives

    M subset in(I),     dim_K R/M >= dim_K R/in(I)=D.

An upper bound D forces equality and hence M=in(I). Division by G
leaves an I-element with no monomial in in(I), necessarily zero.
Thus G is a Gröbner basis of I. This uses membership of the derived
rows in I, not merely reduction of the input rows by G.

For the border criterion, a subspace of A containing1 and stable
under every variable contains every monomial. It is A; D such spanning
elements are consequently a basis.

## The canonical reduced part and its Frobenius certificate

Over a perfect field K, A/N is a product of finite separable extensions,
hence étale: [Milne, Fields and Galois Theory, Proposition8.6](https://www.jmilne.org/math/CourseNotes/FT.pdf#page=106).
The identity of A/N lifts uniquely to a K-algebra map A/N->A by
[formal étaleness, Stacks Lemma10.150.3](https://stacks.math.columbia.edu/tag/00UR),
using its [lifting definition](https://stacks.math.columbia.edu/tag/00UQ)
successively through the powers of N. Its image B is the canonical
reduced subalgebra; this statement also holds in characteristic zero.

In characteristic p let F_A(a)=a^q, q a power of p. Perfectness makes
each image a K-subspace. The chain of powers of N strictly decreases
until zero by [Nakayama, Lemma10.20.1(2)](https://stacks.math.columbia.edu/tag/00DV),
so N^D=0. If q^e>=D, F_A^e kills N and is bijective on B. The splitting
A=B direct-sum N therefore gives

    ker F_A^e=N,       im F_A^e=B.

For the adaptive version, equal consecutive image dimensions make
F_A bijective on im F_A^e. That image contains no nonzero nilpotent,
since some further Frobenius iterate would kill it. Its intersection
with N is zero, and its projection onto A/N is surjective because
Frobenius on A/N is bijective. Uniqueness of the étale section identifies
it with B. This includes e=0. Over F_q these are ordinary linear ranks;
over a larger perfect field they are semilinear ranks.

The power q must satisfy q>1. If q=1, the Frobenius map here is the
identity, so every algebra has a rank plateau. The dual-number algebra
K[z]/(z^2) has the nonzero nilpotent z, its identity kernel is zero,
and its identity image is nonreduced. Thus the adaptive conclusion
would be false without this hypothesis. Version4 makes the positive
power convention explicit; e=0 remains permitted.

## Multiplicities and completeness

The [Artinian decomposition, Stacks Lemma10.53.5](https://stacks.math.columbia.edu/tag/00JA)
gives A=product_P A_P. A composition series of A_P has ell_P factors
kappa(P), so

    dim_K A_P=d_P*ell_P,       D=sum_P d_P*ell_P.

All terms are positive. Verified distinct points whose certified lower
length bounds already sum to D therefore exhaust the spectrum, and
every bound is exact. Over a perfect field, the primitive idempotents
of B split these same factors of A and recover their multiplicities.
Retaining only B would retain the points but lose their local lengths.
There need not be one algebra generator: F_q^(q+1) is not monogenic,
since two coordinates of any proposed generator are equal.

Finally, for a Noetherian local ring (C,m), equality of the finite
lengths of C/m^r and C/m^(r+1) gives m^r/m^(r+1)=0. Nakayama gives
m^r=0, so the truncation is the whole ring. Exact consecutive truncations,
rather than sampled solver output, are the hypothesis.
