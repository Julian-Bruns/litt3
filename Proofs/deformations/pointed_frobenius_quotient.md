# Proof: the finite two-torsion quotient and its true domains

[Statement](../../Theorems/deformations/pointed_frobenius_quotient.md).
The geometric Frobenius input is the audited
[Prym reconstruction](../../Theorems/deformations/genus_two_prym_quintics.md).
We distinguish the intrinsic unstable scheme from a chosen
homogeneous presentation of the descended rational map.

## 1. The fixed quotient

The five displayed quartics are invariant under the sixteen
projective translations and signs. They have no common zero:
P=0 makes one coordinate zero; then A=B=C=0 force at most one
coordinate to be nonzero; finally S=0 rules out that coordinate.
They therefore define a morphism pi with pullback of O(1) equal
to O(4). This pullback is ample, so pi is finite onto its image.

Substitution verifies (1). For an elementary derivation, put
\(u_i=x_i^2\); A,B,C are the three pair-partitions of four
variables, and \(P^2=\prod u_i\). Expanding the cubic resolvent
identity gives (1) with \(S=\sum u_i^2\).

Regarded as a quadratic polynomial in S, the discriminant of (1) is
\[
(A^2-4P^2)(B^2-4P^2)(C^2-4P^2).
\tag{3}
\]
The six linear factors are distinct in characteristic five. Hence
this discriminant is not a square in k(P,A,B,C), so (1) is
irreducible. The three-dimensional image of pi is therefore all
of the quartic Q. Intersection with three hyperplanes gives
\(\deg(\pi)\deg Q=4^3\), and consequently \(\deg\pi=16\).
The sixteen group elements are distinct automorphisms of the
function field over k(Q). Thus k(Q) is exactly the invariant field.

Q is normal. On P nonzero, completing the square in S gives a
double cover branched over the six distinct planes in (3).
It is smooth away from their pairwise intersections; the remaining
singular set has dimension at most one. At P=0, a singular point
must satisfy \(ABC=0\), from the derivative in S. Equation (1)
then forces at least two of A,B,C to vanish. This again leaves
at most a one-dimensional set. A hypersurface is Cohen--Macaulay,
and here it is regular in codimension one. Serre's criterion
therefore proves normality. The normal finite quotient
\(\mathbf P^3/G\) maps finitely and birationally onto Q, and
normality identifies the two.

The invariant sections of O(4r) consequently identify with
\(H^0(Q,\mathcal O_Q(r))\), with the linearization supplied by
the five invariant quartics. This follows either from the quotient
construction or from projection formula and
\((\pi_*\mathcal O_{\mathbf P^3})^G=\mathcal O_Q\).

## 2. Descending the map without changing indeterminacy

The relative Frobenius map is equivariant for two-torsion. In the
chosen theta frame the projective group matrices have coefficients
in F5, so they are unchanged in the source coefficient twist.
Its quintic presentation has the Heisenberg covariance recorded
in the reconstruction theorem. Therefore S(V),P(V),A(V),B(V),C(V)
are invariant degree-twenty polynomials. By Section1 they descend
to sections of O_Q(5), represented by five quintics modulo (1).
This gives (2) as an identity of rational maps.

Here is the general domain argument, useful beyond this example.
Let U be normal and let v:U dashrightarrow T be rational, with T
projective. If a finite morphism j:T->T' makes jv regular near a
point u, the graph closure of v over that neighborhood maps to
\(U\times_{T'}T\). It is therefore finite over U. It is also
birational to U; normality makes it isomorphic to U. Thus v was
regular near u. Composition with a finite target morphism cannot
remove genuine indeterminacy on a normal source.

Let B be the true base locus of V. It is G-invariant. On the
G-invariant open complement of B, pi V descends to a morphism on
the quotient open Q minus pi(B). Conversely, if W extended near
pi(b) for b in B, then W pi=pi V would extend near b. The finite
target argument would extend V there, a contradiction. This
proves equality of the true indeterminacy sets.

For an ordinary genus-two curve, the intrinsic Frobenius-unstable
scheme has length
\[
\frac{2p(p^2-1)}3=80\qquad(p=5),
\tag{4}
\]
by [Lange--Pauly, Theorem2](https://math.univ-cotedazur.fr/~pauly/frobeniusdestabilized.pdf).
The scheme is disjoint from every fixed line of a nontrivial
two-torsion element: those lines are the actual Prym lines, on
which V is the basepoint-free elliptic map. Hence G acts freely
on B. Since its order sixteen is invertible in k, the quotient
\(B\to B/G\) is an étale torsor, and (4) gives length five.
The same conclusion follows from the sixteen theta-characteristic
pieces in the cited theorem. No reducedness is assumed here.

The five descended quintics are quartic functions of the original
four quintics. Their ideal can therefore thicken the intrinsic
base scheme. Equality of true indeterminacy sets is what the
iteration criterion uses; length five refers specifically to B/G.

## 3. The single pointed surface

The sixteen trope planes form a free transitive G-orbit. The
product of their sixteen linear equations is invariant: with
the translation-and-sign representatives, translation permutes
the factors and each sign accumulated in doing so occurs an
even number of times. It is a degree-sixteen invariant, so it
descends to a quartic section of Q.

Its zero set is the image D of any one plane H. Away from the
finite union of intersections of H with its other translates,
a G-orbit meets H in exactly one point. The finite morphism
H->D is therefore generically one-to-one; on the locus of free
G-orbits it is also étale onto its image, so is birational.
H is normal, making it the normalization of D.

The descended quartic has multiplicity one at the generic point
of D. Indeed pi is étale at a generic point of H, where precisely
one linear factor vanishes simply. This proves the assertion
about the reduced pullback. Intersecting the quartic section
with Q gives degree sixteen, also obtained from
\((\mathcal O_H(4))^2=16\) and the birational map H->D.

The usual theta hyperplane description identifies the pointed
extensions with H; the strictly semistable Kummer boundary is
strongly semistable and creates no omitted failure. Tensoring
by two-torsion commutes with Frobenius, so all sixteen planes
have the same survival property. Apply (2) and the equality of
true indeterminacy sets at each successive coefficient twist.
Induction gives the stated equivalence at every finite height.
It does not replace geometric points by points of one finite field.

## 4. Corrected exact construction at the cubic endpoint

The [source](../../scripts/deformations/probe_frobenius_heisenberg_quotient.py)
now uses the corrected dual node from the actual curve dictionary.
The [branch-conic certificate](../../../litt3-computation-data/theta_dictionary_correction_20260916/canonical_dictionary_check.json)
is independent of the quintic identities. The old lowercase node
was a Richelot neighbor; its raw evidence remains externally preserved.

All corrected Hudson coefficients lie in F125. The invariant
expansion matrices have ranks121 out of126 in degree five and69
out of70 in degree four; their kernels are the corresponding
multiples of the quartic relation. Full polynomial substitution
checks the five descended quintics and the norm of all sixteen
pointed planes, including every coefficient.

The complete projective base scheme is contained in x0 nonzero:
all three boundary charts are empty. Its affine algebra has
dimension80, and the source Kummer equation is a unit in it.
Normalize the five invariant quartics by that equation. Their
algebra has dimension five and is generated by S/K^(5). The
minimal polynomial is separable and IRREDUCIBLE of degree five
over F125. Thus the actual unstable quotient is one reduced
closed point of degree five. The first twisted pointed equation
is a unit in this algebra.

The [corrected receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/corrected_heisenberg_quotient.json)
records the exact polynomial, invariant coordinates, field embedding,
and hashes of both the constructor and theta builder. Its factor
degree five replaces the old neighbor's1,2,2; the latter is not
backup evidence. No later geometric height verdict follows here.
