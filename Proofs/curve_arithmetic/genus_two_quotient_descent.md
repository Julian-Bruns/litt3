# Proof: isolated canonical pencils and descent of the original span

This proves [Version1](../../Theorems/curve_arithmetic/genus_two_quotient_descent.md).
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

Every genus-two curve in odd characteristic admits a Rosenhain model
\[
Y_{\mathbf t}:v^2=u(u-1)(u-t_1)(u-t_2)(u-t_3),
\]
where 0,1,t1,t2,t3,infinity are distinct. Choose a basis of H0(C,omega_C).
The coordinates of a,b and the three parameters give 2G+3 affine
variables. Impose, coefficient by coefficient in H0(C,omega_C^6),
\[
\{a,b\}^2=ab(b-a)(b-t_1a)(b-t_2a)(b-t_3a).
\]
Every equation has total degree at most nine: the right side has
degree six in a,b and degree at most three in the parameters. Take
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

The three labelled branch parameters have injective Kodaira--Spencer
map. Indeed, the genus-two canonical double cover and its six branch
sections are intrinsic and deform with the curve. The involution has
order two, invertible in k. In a trivial first-order deformation of
the curve, its quotient P1 and labelled branch sections are trivial.
A marked identification cannot permute the six distinct reductions.
A projective automorphism fixing the three labelled points 0,1,infinity
is the identity, so each ti has zero first-order variation. Equivalently,
the usual ordered-branch presentation of the genus-two stack is étale
locally a three-dimensional parameter space with only the finite
étale hyperelliptic stabilizer.

Fixed-source rigidity now forces dti=0. The map to this fixed target
has no infinitesimal deformation, so da=db=0 as well. Consequently
every point of U has zero Zariski tangent space. U is a finite-type
scheme over k, hence it is a finite reduced zero-dimensional scheme.
Each of its points is an isolated reduced point of the full affine
polynomial system, because U is open in that system.

## An elementary degree bound for these reduced isolated points

We use the following form of Bézout: reduced isolated solutions of
polynomials of degree at most d in N variables, whose Jacobian has
rank N there, number at most d^N. Here is a way to avoid any assumption
on other components. There are finitely many isolated solutions.
Choose N generic constant linear combinations F1,...,FN of the
equations whose Jacobian is invertible at every one of the specified
points. This is possible because each imposes a nonempty open
condition on the choices and k is infinite.

Perturb these N equations to Fi+s xi^d. Over k((s)), their degree-d
leading forms have no common projective zero: their resultant as a
polynomial in s has nonzero leading coefficient, the resultant of
x1^d,...,xN^d. Thus the affine generic intersection is finite of
length d^N by the complete-intersection Bézout theorem (or its graded
Hilbert-series proof). Every original point lifts uniquely over
k[[s]] by its invertible Jacobian. Distinct specializations give
distinct generic points. Their number is therefore at most d^N.
Positive-dimensional unwanted components of the original system
do not enter this argument.

Taking N=2G+3 and d=9 gives #U(k)<=9^(2G+3). Each actual genus-two
étale quotient subfield admits at least one Rosenhain presentation
over k, so this bounds the number of actual quotient subfields too.
We do not divide by automorphism counts or assume they are constant.

In characteristic five, restrict instead to the family with four
fixed finite branch points 0,1,2,3. There are 2G+1 variables and the
sextic equations have degree at most seven. The same rigidity and
degree argument yields at most 7^(2G+1) triples (a,b,t). Restricting
the labelled-branch Kodaira--Spencer map to this parameter line
remains injective.

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
e\le9^{2G+3}=9^{2n(h-1)+5}.
\]
It is therefore stable under Gal(k/F_(q^(ae))). The restrictions of
the existing action on k(Z) give an actual continuous descent datum
on that subfield, with its cocycle automatically satisfied. Descent
of the smooth projective function-field model and the inclusion
descends g itself, up to target isomorphism. Étaleness is preserved
and can be checked after scalar extension. Both original maps now
exist on the same original source over F_(q^(ae)). This proves the
stated arithmetic bound, without requiring any Jacobian hypothesis.

For the one-parameter family and a prime parameter orbit ell, one
also has the sharper alternative
\[
\ell\le\max\{n(n!)^{17},7^{16n+3}\}
\]
when X has genus nine over F25. If ell divides a, use ell<=a.
Otherwise its ell coefficient conjugates under Frobenius^(a) are
distinct and give ell target parameters from this fixed source;
apply the one-parameter count.

## Consequence for the selected main pair

Use the constants B,D,G_star,L_star,K in the statement. The established
branch-set calculation gives the selected Y moduli orbit ell>K.
Suppose n<=D^2. Since D=B!<=B^B<=3^(B^2), the general bound gives
\[
r_{25}(Y)\le n(n!)^{17}9^{16n+5}
\le3^{B^2(34D^2+2)+32D^2+10}.
\]
Here n(n!)^17<=n^(17n+1)<=D^(34D^2+2). The difference between
4(B+1)^2(8D+1)^2 and the exponent on the right is
\[
(222B^2+512B+224)D^2+64(B+1)^2D+2B^2+8B-6>0.
\]
Thus r25(Y)<3^(4G_star^2 L_star)<K, a contradiction. Every witness
has n>D^2. This comparison is a symbolic inequality; computing the
astronomical factorials is unnecessary.

The general bound grows with n. It gives no reduction of an arbitrary
span to bounded degree and no exclusion of an isolated nonliftable
span with sufficiently large n.

## Intrinsic recovery from the actual norm endomorphism

Here retain an actual finite étale u:C->Y with g(Y)=2 and d=deg u=G-1.
The following independent lemma from returned report08 is useful even
without the counting argument. Define the base-point-free canonical map
\[
b_C(z)=[O_C((2G-2)z)\otimes\omega_C^{-1}]\in J(C).
\]
The norm formula and étaleness give
\[
T_u b_C=u^*[d]b_Y\circ u,\qquad
b_Y(y)=[O_Y(2y)\otimes\omega_Y^{-1}].
\]
Let D be the normalization of the reduced image of T_u b_C. The
resulting C->D factors through Y. After choosing an Abel--Jacobi
embedding j:Y->J(Y), the map Y->D is, up to translation, the
restriction of u*[2d], an isogeny onto its image with finite kernel.

No nonzero torsion translation preserves j(Y). Otherwise its finite
cyclic group would act freely on Y, giving a finite étale quotient
of degree N>1. Riemann--Hurwitz would give 1=N(g(Y/H)-1), impossible.
If the restriction of u*[2d] to j(Y) had separable degree greater
than one, its generic fiber would contain two points differing by
one of the finitely many nonzero geometric kernel points. The
finitely many intersections j(Y) intersect (j(Y)+t) would then cover
a dense open of j(Y); one translation would preserve j(Y), contrary
to the preceding argument. Thus Y->D is purely inseparable.

Write M for the subfield pulled back from D under T_u b_C. Then
\[
u^*k(Y)=\{z\in k(C):z^{p^s}\in M\text{ for some }s\ge0\}.
\]
One inclusion is pure inseparability of Y->D. For the other, an
element of the right side is purely inseparable over u*k(Y), whereas
k(C)/u*k(Y) is separable. This proves equality and recovers the
actual embedded quotient field from T_u.

If C is defined over a finite field E and T_u is E-rational, then
b_C, its image subfield, and this purely inseparable closure are
Galois-stable. Restriction of the action on the fixed source supplies
the descent cocycle, so u descends over E up to target isomorphism.
Conversely a descended morphism has a descended pullback and norm,
hence a descended T_u. This is a statement about the quotient map,
not merely an isogeny class of its Jacobian. It permits nonreduced
kernels and p-divisible d.

The fundamental-group inputs are SGA1, proper specialization and the
arithmetic exact sequence; the deformation step is the nilpotent
invariance of finite étale covers. The canonical-pencil equivalence
is proved in the linked local proof. No unproved uniform finiteness
of all partners of X is used.
