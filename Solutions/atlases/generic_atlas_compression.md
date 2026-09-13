# Proof: rank condensation over an independent parameter

[Statement](../../Theorems/atlases/generic_atlas_compression.md).
This is an application of polynomial rank condensers, not a new general
rank-condensation method. Such constructions are discussed in Section4
of [Forbes, Shpilka and Volk](https://www.cs.tau.ac.il/~shpilka/publications/ForbesSV17.pdf).
The elementary variant and its atlas-specific completeness argument follow.

## 1. A single polynomial compressor preserves every fixed full rank

Let B be an m-by-n full-column-rank matrix over a field K. Choose
distinct c_j in K, let V_(i,j)=c_j^i for 0<=i<n, and let
C(t)=V diag(1,t,...,t^(m-1)). Then det(C(t)B) is nonzero in K[t].

To prove this, let r_1<...<r_n be the greedy independent row indices
of B, numbered from zero. Every row basis s_1<...<s_n satisfies
s_i>=r_i: the rows through index s_i already have rank at least i.
Consequently the greedy basis is the UNIQUE row basis minimizing the
sum of its indices. Cauchy--Binet expands the determinant as

    sum_(|S|=n) det(V_S) det(B_S) t^(sum S).

Every Vandermonde minor det(V_S) is nonzero. The coefficient at the
unique least exponent is therefore nonzero. The degree is at most
n(2m-n-1)/2. The argument is valid in characteristic five without
ordinary derivatives, random sampling or a generic-rank assumption.

The parameter must be independent of the entries of B. Specializing it
to an arbitrary finite-field value is NOT licensed by this argument.

## 2. Why the full intrinsic matrix is injective at every solution

At an actual normalized atlas, let eta be the corresponding extension
0->T->V->M->0. Projection of H(b)p to Ext1(V,T) has kernel k p,
by stability of V and the long exact Hom sequence used in
`intrinsic_atlas_incidence`. If H(b)q=0, then q=c p. But
H(b)p=I b is nonzero: I is injective and ell(p,b)=1 implies b!=0.
Hence c=0. This proves rank H(b)=n, including nonacyclic V.

Let R be the finite reduced coordinate algebra of the normalized atlas
scheme. Over an algebraic closure it is a product of copies of the
base field, one per geometric point. At EACH point the preceding
rank-condenser lemma makes det(C(t)H(b)) a nonzero polynomial in t.
It follows that d is a unit in R tensor K(t), since it is nonzero in
every field factor. This justifies a SINGLE inverse chart on the entire
base-changed scheme, not merely on a selected dense open of the b-space.
It also proves the assertion when R=0. Finiteness/reducedness here are
the proved intrinsic theorem, not heuristics from the number of equations.

## 3. Elimination and exact reconstruction

On d!=0, the compressed linear system A p=C I b has the unique
solution p=v/d. Substitution into ALL original rows is exactly
H v=d I b. The normalization is exactly ell(v,b)=d, since ell is
linear in p. These identities give inverse morphisms of affine schemes
over K(t), with the inverse of d included as one certificate variable
if a polynomial presentation is desired.

Every solution of the new system reconstructs a solution of the original
scheme. Conversely Section2 proves that every original geometric point
survives the localization after the faithfully flat field extension.
Thus emptiness is equivalent. No simultaneous Galois closure, change of
endpoints or replacement of etale maps by separable maps occurs.

## 4. Cost boundary and finite-field cautions

The degree in b of d is5n, that of v is5n-4, and that of H v and
d I b is at most5n+1. The normalization has terms of degrees5n-3 and
5n. For n=32 these are160,156,161 and157 respectively. The t-degree
bound with m=96 is2544. Taking a fifth power of any derived rational
expression MUST also replace t by t^5; t is not a Frobenius-fixed scalar.

These degree bounds explain why eliminating variables is not by itself
a speed claim. Expanding generic degree160 polynomials in32 variables
would be worse than retaining the matrix circuit. The theorem removes
the logical obstacle of exceptional inverse-minor strata; it does not
provide a small solution algebra, a bound on the required Macaulay degree,
or a fast algorithm for the remaining b equations.

An arbitrary fixed compressor over a finite field can miss solutions.
It needs a separate certificate on the excluded determinant locus, or a
proved specialization bound. The independent-parameter construction needs
neither but performs its algebra over K(t), not over the old finite field.

## Exact bounded implementation evidence

`scripts/atlases/test_generic_atlas_compression.sage` reconstructs all33 points
of the audited genus-two positive example from the compressed system,
checks all original rows and the predicted greedy leading coefficients,
and rejects33 rescaled points failing normalization. It also constructs
a full-rank matrix killed by C(1), but not by C(t), explicitly guarding
against unsafe specialization. The run took1.72 seconds on one core.
The source-bound report is external:
`/Users/julian/Documents/litt3-computation-data/atlas-generic-compression/genus_two_check.json`.
The first run completed its assertions but failed to serialize a Sage
integer; the serializer was fixed and the entire check rerun successfully.
No production input, solver state, or atlas certificate was changed.
