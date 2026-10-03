# Proof: isolated canonical pencils and descent of the original span

This proves [Version2](../../Theorems/curve_arithmetic/genus_two_quotient_descent.md).
The original audits cover Version1. Version2 uses linear branch
coefficients and multihomogeneous intersection degree, extends norm
recovery to every hyperbolic target, and applies the later integral
period argument on the Rosati-symmetric lattice.
All curves are smooth, projective and geometrically connected. We first
work over an algebraically closed field k of characteristic different
from two. The bracket convention is
\[
\{a(z)dz,b(z)dz\}=(ba'-ab')(dz)^3.
\]
The [canonical-pencil proof](../quotient_geometry/genus_two_etale_pencils.md)
shows that a basepoint-free pair of regular differentials a,b satisfying
\{a,b\}^2=H(a,b), for a squarefree binary sextic H, reconstructs an
actual finite étale map by u=b/a, v=-\{a,b\}/a^3. Conversely every such
map supplies exactly this pair. We retain this actual morphism, not
only its Jacobian image.

## Fixed-source rigidity in arbitrary étale degree

If q:C->Y is finite étale and L is a negative-degree line bundle on Y,
then H1(Y,L)->H1(C,q*L) is injective. Indeed, set E=q_*O_C/O_Y.
On a finite étale Galois closure E becomes a trivial vector bundle:
it is associated with the permutation representation modulo its
diagonal line. Therefore H0(Y,E tensor L)=0, since pullback injects
this space into a direct sum of section spaces of a negative line
bundle. The cohomology sequence proves injectivity. This argument
does not divide by deg q.

Apply this to L=T_Y. A first-order deformation of q with C fixed has
target class xi in H1(Y,T_Y) whose pullback is zero. This follows also
from the equivalence of finite étale categories under a nilpotent
thickening: deforming Y determines its marked cover, whose source
deformation has class q*xi. Hence xi=0. With both curves fixed, a
deformation of q is a section of q*T_Y=T_C, which has no sections.
Thus every first-order deformation of the actual quotient with its
source fixed is trivial, up to the unique marked target identification.

## All genus-two targets in one finite polynomial system

Every genus-two curve in odd characteristic admits a model
\[
Y_{\boldsymbol\sigma}:v^2=u(u-1)(u^3-\sigma_1u^2+\sigma_2u-\sigma_3),
\]
where the cubic has distinct roots avoiding 0 and1. Choose a basis
of H0(C,omega_C). The coordinates of a,b and sigma give 2G+3 affine
variables. Impose, coefficient by coefficient in H0(C,omega_C^6),
\[
\{a,b\}^2=ab(b-a)(b^3-\sigma_1ab^2+\sigma_2a^2b-\sigma_3a^3).
\]
Every equation has degree at most six in a,b and at most one in
the three parameters COLLECTIVELY. Take
the open locus U where the branch parameters are distinct and a,b
have no common zero. The latter is open because the incidence of a
common zero is closed over the proper curve C. Its k-points are
exactly the actual maps to these models with the stated pulled-back
canonical basis.

The reconstruction holds over dual numbers too. A basepoint-free
pair gives a morphism to P1 and identifies its pulled-back O(1)
with omega_C. The section -\{a,b\} of omega_C^3 and the sextic
identity give a morphism to the double-cover model over P1. This
is the global construction of the formulas u=b/a and v=-\{a,b\}/a^3.
Over the dual numbers both curves are smooth over the base, and the
relative differential of the morphism is an isomorphism on the
special fiber. Nakayama makes it an isomorphism everywhere; the
relative Jacobian criterion for smooth curves makes the morphism
étale. Properness then makes this quasi-finite morphism finite.
Thus a tangent vector to U gives a deformation of the actual
quotient considered above.

These three parameters have injective Kodaira--Spencer map. For
ordered roots t1,t2,t3, the six branch sections are intrinsic in
the canonical double cover. A trivial curve deformation gives a
trivial labelled branch deformation; a projective automorphism fixing
0,1,infinity is the identity. Passing to elementary symmetric
coefficients is etale, with Vandermonde Jacobian a unit on this open
locus. Thus the same injectivity holds for sigma.

Fixed-source rigidity now forces dsigma=0. The map to this fixed target
has no infinitesimal deformation, so da=db=0 as well. Consequently
every point of U has zero Zariski tangent space. U is a finite-type
scheme over k, hence it is a finite reduced zero-dimensional scheme.
Each of its points is an isolated reduced point of the full affine
polynomial system, because U is open in that system.

## The multihomogeneous degree bound

Compactify the two variable blocks in
\(\mathbf P^{2G}\times\mathbf P^3\). Every equation homogenizes to
bidegree (6,1). Let H and K be the two hyperplane classes. The
[projective bundle formula](https://stacks.math.columbia.edu/tag/02TV)
gives the intersection number
\[
(6H+K)^{2G+3}
=\binom{2G+3}{3}6^{2G}
\quad\text{in top degree}.
\]
This counts the reduced isolated points even if the original equations
have unwanted components. Choose \(2G+3\) constant linear combinations
with invertible Jacobian at every point of U, and perturb them by
\(s\) times general sections of \(\mathcal O(6,1)\). Over k((s))
their projective intersection is zero-dimensional with the displayed
length. Each original point lifts uniquely by its invertible Jacobian,
so distinct points of U give distinct generic points. Thus
\[
\#U(k)\le N_G=\binom{2G+3}{3}6^{2G}.
\]
Every actual quotient field admits one of these presentations; the
reconstruction distinguishes the actual maps. No division by varying
target automorphism counts is needed.

For the selected one-parameter family the parameter block is instead
\(\mathbf P^1\), while the equations still have bidegree (6,1).
The same argument gives \((2G+1)6^{2G}\) triples (a,b,t). Its branch
Kodaira--Spencer map is the restriction of the preceding etale chart.

## Descent of the original first leg

Now take k=overline(F_q), with q odd, and let X/F_q have genus h>=2.
Its full geometric fundamental
group pi is generated by at most 2h elements, by smooth proper
specialization from a characteristic-zero lift of X. This is a
one-curve lift, not a lift of the correspondence. The number c_n
of connected degree-n covers of X_k up to X_k-isomorphism satisfies
\[
c_n\le(n!)^{2h}/(n-1)!=n(n!)^{2h-1}.
\]
Indeed, count homomorphisms pi->S_n and retain the transitive ones.
The centralizer of a transitive subgroup acts freely on the n letters,
so has order at most n and each conjugacy orbit has size at least
(n-1)!.

Let a be the coefficient-Frobenius-q orbit length of the original
cover f:Z->X. Then a<=c_n, and the cover descends over F_(q^a) with
degree unchanged. For precision, let Pi be the arithmetic fundamental
group and H the index-n subgroup of pi. The image of N_Pi(H) in
the arithmetic quotient Zhat is a Zhat. Choose gamma in the normalizer
mapping to a. The closure S of its cyclic subgroup maps isomorphically
to a Zhat: the map Zhat->S has composite multiplication by a in
Zhat, which is injective. In the arithmetic group over F_(q^a), HS
is open of index n and intersects pi in H. Its cover is the required
geometrically connected model of the original f. This explicitly
handles possible cover automorphisms.

## Descent of the original second quotient

Fix that model of Z over F_(q^a); its genus is G=1+n(h-1). Frobenius
acts on its finite set of actual genus-two étale quotient subfields.
The orbit of the subfield g*k(Y) has length
\[
e\le N_G=\binom{2G+3}{3}6^{2G}.
\]
It is therefore stable under Gal(k/F_(q^(ae))). The restrictions of
the existing action on k(Z) give an actual continuous descent datum
on that subfield, with its cocycle automatically satisfied. Descent
of the smooth projective function-field model and the inclusion
descends g itself, up to target isomorphism. Étaleness is preserved
and can be checked after scalar extension. Both original maps now
exist on the same original source over F_(q^(ae)). This proves the
stated arithmetic bound, without requiring any Jacobian hypothesis.

The norm-recovery and symmetric-lattice argument below also give
\(e\mid\mathcal M(G(2G-1))\). If the target's moduli orbit has
PRIME length ell, it divides ae. If ell divides a, use the cover
bound; otherwise it divides e and therefore satisfies
\(\ell-1\le G(2G-1)\) by the cyclotomic degree bound. Consequently
\[
\ell\le\max\{n(n!)^{2h-1},G(2G-1)+1\}.
\]
This does not need the one-parameter family or ordinariness.

## Consequence for the selected main pair

For h=9, \(G(2G-1)+1=128n^2+24n+2\le154n^2\).
For n>=2 this is at most \(n(n!)^{17}\): use
\(n!\ge2^{n-1}\) and the n=2 case, with the ratio increasing.
The n=1 case would give ell<=154, impossible for the selected partner.
Thus every witness satisfies \(\ell\le n(n!)^{17}\).

Now use B,D,G_star,L_star,K from the statement and the established
ell>K. If n<=D^2, then D=B!<=B^B<=3^(B^2) gives
\[
n(n!)^{17}\le n^{17n+1}\le D^{34D^2+2}
\le3^{B^2(34D^2+2)}
<3^{4(8D+1)^2(B+1)^2}<K<\ell.
\]
The strict exponent inequality follows already from
\(4(8D+1)^2(B+1)^2\ge256D^2(B+1)^2\) and D>=1.
This contradicts the sharper degree criterion, proving n>D^2
without evaluating any astronomical factorial.

The general bound grows with n. It gives no reduction of an arbitrary
span to bounded degree and no exclusion of an isolated nonliftable
span with sufficiently large n.

## Intrinsic recovery from the actual norm endomorphism

Here k may have ANY characteristic. Retain an actual finite etale
u:C->Y with h=g(Y)>=2 and d=deg u=(G-1)/(h-1).
The returned norm-recovery argument extends using the absence of
translation stabilizers for every hyperbolic Abel curve. Define the
canonical map, without choosing a base point,
\[
b_C(z)=[O_C((2G-2)z)\otimes\omega_C^{-1}]\in J(C).
\]
The norm formula and étaleness give
\[
T_u b_C=u^*[d]b_Y\circ u,\qquad
b_Y(y)=[O_Y((2h-2)y)\otimes\omega_Y^{-1}].
\]
Let D be the normalization of the reduced image of T_u b_C. The
resulting C->D factors through Y. After choosing an Abel--Jacobi
embedding j:Y->J(Y), the map Y->D is, up to translation, the
restriction of u*[d(2h-2)], an isogeny onto its image with finite kernel.

No nonzero torsion translation preserves j(Y). Such a translation
would induce a free cyclic action on Y and the IDENTITY action on
J(Y): differences of translated points are unchanged. All canonical
forms would therefore descend to its actual etale quotient Y/H,
giving g(Y/H)=h even in characteristic dividing |H|. Riemann--Hurwitz
would then give h-1=|H|(h-1), impossible for h>=2 and |H|>1.
If the restriction of u*[2d] to j(Y) had separable degree greater
than one, its generic fiber would contain two points differing by
one of the finitely many nonzero geometric kernel points. The
finitely many intersections j(Y) intersect (j(Y)+t) would then cover
a dense open of j(Y); one translation would preserve j(Y), contrary
to the preceding argument. Thus Y->D is purely inseparable.

Write M for the subfield pulled back from D under T_u b_C. In positive
characteristic p,
\[
u^*k(Y)=\{z\in k(C):z^{p^s}\in M\text{ for some }s\ge0\}.
\]
One inclusion is pure inseparability of Y->D. For the other, an
element of the right side is purely inseparable over u*k(Y), whereas
k(C)/u*k(Y) is separable. This proves equality and recovers the
actual embedded quotient field from T_u.
In characteristic zero the same argument gives u*k(Y)=M directly.

If C is defined over a finite field E and T_u is E-rational, then
b_C, its image subfield, and this purely inseparable closure are
Galois-stable. Restriction of the action on the fixed source supplies
the descent cocycle, so u descends over E up to target isomorphism.
Conversely a descended morphism has a descended pullback and norm,
hence a descended T_u. This is a statement about the quotient map,
not merely an isogeny class of its Jacobian. It permits nonreduced
kernels and p-divisible d.

## The Rosati-symmetric lattice gives the full descent period

Fix a model of C over a finite field E. The norm endomorphism
\(T_u=u^*u_*\) is self-adjoint for the canonical principal
polarization of J(C). Its Frobenius action therefore lies on the
integral lattice
\[
\Lambda^+=\{T\in\operatorname{End}(J(C)_k):T^\dagger=T\}.
\]
This lattice is free of finite rank. By
[Milne, Abelian Varieties, Theorem12.5 and Section17](https://www.jmilne.org/math/xnotes/AVs.pdf#page=21),
it injects on an auxiliary Tate module into the self-adjoint matrices
for the alternating polarization pairing. If J is that pairing matrix,
self-adjointness is \(JT=T^{\mathsf t}J\), so JT is skew-symmetric.
Thus
\[
\operatorname{rank}\Lambda^+\le\binom{2G}{2}=G(2G-1)=R_G.
\]
The polarization is E-rational, so Frobenius preserves the lattice.
Its generators are defined over a common finite extension, hence
Frobenius acts through a finite-order integral matrix. The
[integral period argument](../jacobians/isogeny_sieves/solvable_atlas_frobenius_periods.md#3-the-second-map-a-small-integral-hom-lattice)
gives order dividing \(\mathcal M(R_G)\): every eigenvalue order j
has cyclotomic degree \(\varphi(j)\le R_G\), and the full order
is their lcm. Recovery from T_u identifies its Frobenius stabilizer
with that of the ACTUAL quotient field. Therefore every such field's
orbit length divides \(\mathcal M(R_G)\), and all quotient maps
descend simultaneously over that extension of E. This argument
uses neither ordinariness nor simplicity.

The fundamental-group inputs are SGA1, proper specialization and the
arithmetic exact sequence; the deformation step is the nilpotent
invariance of finite étale covers. The canonical-pencil equivalence
is proved in the linked local proof. No unproved uniform finiteness
of all partners of X is used.
