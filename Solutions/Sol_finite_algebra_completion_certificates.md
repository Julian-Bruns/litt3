# Proof: exact finite-algebra certificates

Canonical [statement](../Theorems/Thm_finite_algebra_completion_certificates.md).
These are general algebra facts assembled for our computation, not a claim
of new general Groebner or Frobenius theory.

## Stop from a known colength

Let M=(LM(g):g in G). Derived membership gives M subset in(I), so

    dim_K R/M >= dim_K R/in(I) = dim_K R/I = D.

If the left side is at most D, equality holds. The exact sequence with
kernel in(I)/M then gives in(I)=M. Polynomial division by G leaves an
I-element with no monomial in in(I), which must be zero. Hence G generates
I and is its Groebner basis; unfinished S-pairs contain no missing information.

The direction of membership matters. Merely reducing the original
generators to zero gives I subset (G), not G subset I. For example
I=(x^2,y), D=2 and G={x^2,y,x^2-1} satisfy that weaker test and the apparent
leading-monomial count2, but (G) is the unit ideal. Thus an early-stop
implementation must retain the invariant that every derived row lies in I.
The existing full exporter uses a different valid test: it first computes
an actual Groebner basis of J, then proves I subset J and dim R/J=D.

For the border version, a multiplication-stable subspace containing1
contains every monomial by induction. It therefore equals A. D spanning
elements in a D-dimensional space are a basis. Relations in a proposed
abstract algebra are insufficient unless they are certified in this A.

## Frobenius isolates the reduced part

Since A is Artinian, its nilradical N is its Jacobson radical. Until zero,
the chain A superset N superset N^2 superset ... is strictly decreasing:
N^r=NN^r forces N^r=0 by Nakayama. Dimension D consequently gives N^D=0.

The q-power map F is an F_q-linear algebra endomorphism. If q^e>=D, then
N subset ker F^e; the reverse inclusion holds because an element killed by
a power is nilpotent. Put B=im F^e. If F^e(a) belongs to N, then a is
nilpotent, so F^e(a)=0. Hence B intersects N trivially. On the product of
finite fields A/N, Frobenius is bijective, so B maps onto A/N. Its quotient
map is therefore an isomorphism, giving a reduced subalgebra of A. Notice
that F^e itself induces Frobenius on A/N, not necessarily its identity.

For the adaptive test, consecutive images are nested. Equal dimensions
give im F^e=im F^(e+1), so F is bijective on B=im F^e. A nonzero nilpotent
would eventually be killed by an iterate of this injective F, a contradiction.
Thus B is reduced. The image of a nilpotent of A is nilpotent in B and is
zero, giving ker F^e=N. The preceding quotient-isomorphism argument applies.

The resulting subalgebra is canonical: for every sufficiently large e the
image equals the stable image of F. No root choices or numerical tolerances
are involved. Over F25, use the 25-power map for F25-linear matrices; do not
mistake the fifth-power semilinear operator for such a matrix.

## Recover every multiplicity

The reduced algebra B is a product of finite fields. Its primitive
idempotents split A into its local factors A_i=e_i A, with residue field
e_i B=F_(q^d_i). A composition series of A_i as an A_i-module has ell_i
copies of this residue field. Therefore dim_Fq A_i=d_i*ell_i.
Discarding A and retaining only B would lose this information.

Do not assume one primitive element distinguishes all factors: F_q^(q+1)
is not monogenic, since a tuple of q+1 entries in F_q has two equal entries.
Successive decompositions using several coordinate elements remain valid.

The same local decomposition proves D=sum_P d_P*ell_P. All terms are
positive, so equality for verified distinct points certifies completeness.
If certified lower bounds already sum to D, none can be strict and no
unlisted point can remain. Geometric points must not be multiplied by a
residue degree a second time.

For a Noetherian local ring (C,m), exact equality of the finite lengths of
C/m^r and C/m^(r+1) gives m^r/m^(r+1)=0. Nakayama applied to the finitely
generated module m^r gives m^r=0. Thus the truncation is the whole ring.
This is why the saved consecutive local lengths4,7,8,8 establish length8
at the55 known points, rather than merely suggesting convergence.

## Fixed-X bounds and implementation boundary

The normalized algebra has F25-dimension9645 by the cubic-quotient theorem.
Hence N^9645=0 and (a->a^25)^3 kills exactly N. The F5 encoding contains the
coefficient field F25 and is the same algebra with scalars restricted, so
six fifth-power applications suffice as well. If only its F5-dimension
19290 were known, the coarser generic bound would instead be seven.

None of these facts means the present F4 run already has an adequate
leading-monomial set. Nor do they eliminate the cost of constructing exact
multiplication or Frobenius matrices. They specify checkable stopping and
postprocessing conditions while preserving all roots and multiplicities.
