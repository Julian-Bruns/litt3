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

## 4. The intrinsic quotient in the selected family

Over a perfect field K, the
[intrinsic correspondence](frobenius_residue_escape.md#1a-converse-when-a-theta-characteristic-is-rational)
identifies unstable classes for \(F:C\to C^{(1)}\) with pairs
\((r,\kappa)\): a dormant projective connection on C and a theta
characteristic. Tensoring the bundle by two-torsion fixes r and tensors
kappa by its Frobenius pullback. Thus G acts freely and transitively
on the sixteen choices of kappa, and the correspondence is
Galois-equivariant.

The [universal quintic](../projective_connections/genus_two_dormant_quintic.md)
has resultant \(-[a(a-1)(a-2)(a-3)]^2\ne0\) on the smooth selected
family. Its five connections give eighty distinct unstable points.
For ordinary members, Section2 gives total length eighty; all geometric
local lengths are therefore one. Consequently B and B/G are finite
étale. The Galois-equivariant bijection
\((B/G)(\bar K)\cong\operatorname{Dorm}(C)(\bar K)\) identifies
the finite étale K-schemes, by the equivalence with finite Galois sets.

At the backup, the corrected theta frame and Hudson coefficients are
over F125 by the [Prym reconstruction](genus_two_prym_quintics.md) and
its [branch-conic certificate](../../../litt3-computation-data/theta_dictionary_correction_20260916/canonical_dictionary_check.json).
Sections1--3 therefore define W and D over F125. The
[intrinsic residue calculation](frobenius_residue_escape.md#2-the-backups-five-dormant-connections)
gives \(B/G\cong\operatorname{Spec}\mathbf F_{125^5}\). The
[polynomial first-height test](pointed_extensions_frobenius.md#5-exact-first-height-classification-and-cubic-transfer)
excludes all unstable classes from the theta-normalized pointed planes,
hence B/G from the first twisted D.

The original [corrected quotient receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/corrected_heisenberg_quotient.json)
is an independent historical coordinate check. The proof now uses the
intrinsic quintic and polynomial first-height test.
