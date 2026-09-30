# Proof: rank-four theta bundles in odd characteristic

[Statement](../../../Theorems/jacobians/theta_divisors/genus_two_rank_four_theta.md).

[Pauly, *Rank four vector bundles without theta divisor over a curve
of genus two*, Theorem1.1 and Proposition2.6](https://arxiv.org/pdf/0804.3001)
give the complex classification. We extend the needed bundle conclusion
using his explicit extension, a lift preserving the no-theta condition,
and specialization of the Raynaud model. We use his notation
E, E'=E^*K, L, E_L, kappa and R_kappa.

## 1. Evaluation reconstructs the extension

First twist E by a degree-zero line to arrange det E=O; multiplication
by4 on J(C) is surjective. Stability gives h⁰(E')=4 and h¹(E')=0.
The no-theta condition gives h⁰(E'(-x))>0 for every x.

For a globally generated rank-s bundle G with h⁰(G^*)=0,
h⁰(det G)>=s+1: choose s+1 generating sections and dualize their
evaluation sequence. A general such choice generates on a curve
because the failure locus has codimension two.
A globally generated line subsheaf of the stable slope-two E' has
degree at most1 and is therefore trivial. A globally generated
rank-two subsheaf has degree at most3; the displayed bound excludes
h⁰(G^*)=0, and a nonzero map G→O splits off a trivial summand.
Its complementary line is trivial too. Thus it has at most two sections.

It follows that I=im(H⁰(E')⊗O→E') has rank three and h⁰(I^*)=0:
a map to O would split off one of its four sections and leave the
excluded rank-two subsheaf. Put L=det I. The same bound gives
deg L>=5, while stability gives deg I<=5. Hence I is saturated,
deg L=5, and complete evaluation identifies I with

    0 → E_L^* → H⁰(L)⊗O → L → 0.

The quotient is K^4L^-1, so

    0 → E_L → E' → K^4L^-1 → 0.                          (2)

The evaluation bundle E_L is stable in any characteristic: its
locally free quotients are globally generated with no dual sections.
The bound above gives degrees at least2 and4 for rank-one and
rank-two quotients, respectively, strictly above its slope5/3.
The extension (2) is nonzero, since a degree-three direct summand
would destabilize E'.

Put A_L=E_L^*K^5L^-1. Riemann–Roch and stability give h⁰(A_L)=7
and h⁰(A_L(-x))=4. The pencil calculation of Pauly's Lemma2.2
gives h⁰(A_L(-x-y))=1 for general x,y; call its projective point
mu_(x,y). The no-theta condition on (2) says that its nonzero
extension functional e annihilates every mu_(x,y).

## 2. The rank drops are simple

Here is the multiplicity check needed in Pauly's Proposition2.3.
Suppose L²!=K^5. For general x write

    K^4L^-1(-x)=O(p_1+p_2),  N=K(p_1+p_2),  A=A_L(-x).

The points p_1,p_2 are distinct and not hyperelliptic conjugates.
The degree-three pencil involved is separable, also in characteristic3:
an inseparable degree-three map C→P¹ would make C^(3) rational.
The pencil trick gives

    H⁰(A(-y))=ker[H⁰(L)⊗H⁰(N(-y))→H⁰(LN(-y))].

Its dimension is two exactly at p_1,p_2 and one elsewhere for general x.
Indeed a base point of N(-y) gives y=p_i; otherwise the kernel is
H⁰(L²K^-5(x+y)). The exceptional degree-two line K^6L^-2 is not K,
so its unique effective divisor, if any, is avoided by general x.
This is the calculation of Pauly's Lemma2.2(1).

Choose a,b spanning H⁰(K), s vanishing at p_1+p_2, and complete
sa,sb to sa,sb,t spanning H⁰(N). In A⊂H⁰(L)⊗N, the evaluation image
at p_1 is H⁰(L(-p_1-p_2)): the t-coefficient of any multiplication
relation vanishes at both points, and every such coefficient occurs
because H⁰(L)⊗H⁰(K)→H⁰(LK) is surjective by the canonical pencil trick.

Choose c∈H⁰(LK^-1) nonzero at p_2. The relation
(bc)⊗(sa)−(ac)⊗(sb) vanishes at p_1 and has first coefficient
proportional to a(p_1)bc−b(p_1)ac. Its value at p_2 is nonzero.
It therefore leaves the evaluation image to first order, proving a
simple maximal-minor zero. The argument at p_2 is identical.
The choice of c fails only at a base point z of LK^-1. Then
L=K²(z), p_1+p_2=iota(z)+iota(x), and L²!=K^5 makes z non-Weierstrass,
so general x avoids that failure.

Thus the image of evaluation of A has degree5 and no dual section
(a map to O would leave a rank-two degree-five subsheaf of stable A).
Its complete determinant series shows that y↦mu_(x,y) spans PH⁰(A).
Two general x give four-dimensional spaces meeting in dimension one;
they span H⁰(A_L). This contradicts the nonzero annihilator e.
Therefore L²=K^5, so L=K²kappa with kappa²=K.

Now H⁰(A_L)=ker[H⁰(L)⊗H⁰(L)→H⁰(L²)] has dimension seven.
Pauly's Proposition2.4 identifies mu_(x,y) with
P wedge²H⁰(L(-x-y)); these span wedge²H⁰(L), of dimension six.
Its proof is the pencil trick followed by the six complementary pairs
of four independent point evaluations, valid here in odd characteristic.
Hence e is the unique projective annihilator of this exterior square.

## 3. Lift that extension and specialize Raynaud's model

Lift C over a complete mixed-characteristic DVR by lifting its six
distinct hyperelliptic branch points. Lift kappa through the étale
square-root torsor, and form the relative L=K²kappa and E_L.
The section modules above have constant ranks four and seven and
commute with base change by their H¹ vanishings. The exterior-square
inclusion is a direct summand since2 is invertible; its annihilator
is a free line. A generator lifts (2) and E.

The generic fiber is stable by openness and remains without theta:
the same exterior-square annihilator gives sections for general
degree-one twists, and semicontinuity makes their theta locus closed.
Pauly's complex classification applies to this generic fiber after
descent to a finitely generated field and an embedding into C.

His algebraic Raynaud construction in Section2.2 extends over the DVR.
The theta-group central scalars cancel on
O_J(2Theta)⊗H⁰(2Theta)^*, giving descent under [2] to M; restrict by
gamma_kappa and twist by kappa^-1 to obtain R_kappa.
Every fiber becomes four equal degree-zero lines on a finite étale
cover, hence is semistable. After a finite DVR extension a generic
isomorphism R_kappa≅E extends primitively and has nonzero special fiber.
Its image cannot have intermediate rank: a quotient of semistable
degree zero has nonnegative degree, but a proper subsheaf of stable
degree zero has negative degree. Equal full ranks and degrees make
it an isomorphism. This proves the claimed odd-characteristic
classification consequence and strong semistability.

## 4. A general multiplicity and cyclic-cover bound

Let F satisfy the second part of the statement. Its theta section is
even in |4Theta| under normalized inversion. For the characteristic-zero
identity see [Hitching, Section1, Lemma2](https://arxiv.org/pdf/math/0604637);
the algebraic normalization is in
[Kopeliovich–Pauly–Serman, Sections1–2](https://math.univ-cotedazur.fr/~pauly/theta.pdf).
To obtain it in odd characteristic, lift the underlying symplectic
bundle and a theta characteristic. The symplectic torsor has H²=0 on
a curve, and a lifted acyclic twist keeps its theta section nonzero.
Formal GAGA algebraizes. The normalized involution eigenvalue
specializes unchanged because2 is invertible.

The [sharp theta-jet bound and equality case](genus_two_theta_jet_bound.md)
with r=4 give mult_0(D_F)<=6. If this multiplicity is at least5,
parity makes it6, and the equality case forces D_F=B_0, the doubled
Abel curve. Translation by tau would stabilize B_0 and act freely
on its genus-two normalization, impossible by etale Hurwitz.
Therefore mult_0(D_F)<=4.
Since h⁰(F)=1, m is positive and even, hence2 or4.

Assume J(C) ordinary and p>=5. The p+1 subgroups mu_p⊂ker(F_J)=mu_p²
have the p+1 distinct F_p-rational tangent lines. The degree-m initial
theta term is nonzero on at least p+1−m of them. On each, the theta
equation has order exactly m<p in k[epsilon]/(epsilon^p).
Since h⁰(F)=h¹(F)=1, the minimal local determinant complex has one
entry, so its kernel and cokernel have length m. Pushing the Poincare
line over this whole character subgroup gives h_*O_T for the
corresponding constant Z/p torsor. Projection formula yields
h⁰(T,h^*F)=m. This proves (1).

## 5. Active tangent bundles in characteristic five

For a connected canonical double, the
[actual tangent-bundle theorem](../../projective_connections/tangent_bundle_cyclic_refinements.md)
gives stable rank-four E_r with a perfect omega-valued alternating
pairing and determinant omega².
Apply the first part to E_r⊗kappa^-1 for a theta characteristic kappa.
If its theta were not proper, E_r would be strongly semistable.
But on the canonical double, F^*E_r splits into two copies of
J¹(omega²), with destabilizing subline omega³. Étale pullback
preserves semistability, giving a contradiction. For a split double,
E_r is a sum of two stable rank-two dormant tangent bundles, whose
proper theta divisors are supplied by
[the tangent-bundle theorem](../../projective_connections/tangent_bundle_cyclic_refinements.md).

In the connected case E_r⊗tau≅E_r for the nonzero line defining the
double. If J(C) is ordinary and h⁰(E_r)=1, Section4 supplies at least
two cyclic-five covers with h⁰(E_(h^*r))=2 or4. The identification
uses the natural Frobenius transport of the actual cover. The
[p-cover obstruction theorem](../../deformations/etale_p_witt_obstruction.md)
then kills every obstruction in the one-dimensional source cokernel;
its map-preserving nonrepair assertion applies unchanged.
