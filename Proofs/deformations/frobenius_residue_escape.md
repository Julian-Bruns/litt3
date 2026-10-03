# Proof: the first unstable pullback is a dormant oper

[Statement](../../Theorems/deformations/frobenius_residue_escape.md).

## 1. An intrinsic genus-two argument

Suppose E has even degree and first becomes unstable after a positive
Frobenius power. Write H for the preceding semistable pullback and
V=F^*H for the first unstable one. These bundles and the canonical
flat connection on V are defined over K. Over a perfect field the
unique maximal Harder--Narasimhan line N descends to K. Put Q=V/N.

N is not horizontal: otherwise Cartier descent would give a line
destabilizing H. Therefore its second fundamental map
\[
\beta:N\longrightarrow Q\otimes\omega_C
\]
is nonzero. If deg(V)=2s, instability and genus two give
\[
0<\deg N-s\le g(C)-1=1.
\]
Thus deg(N)=s+1 and beta is an isomorphism. The projectivization
of (V,connection,N) is a regular rank-two oper over K. Its
p-curvature is zero because the whole canonical connection has
zero p-curvature. It is therefore a regular dormant projective
connection over K, a contradiction. This uses no determinant
normalization: projectivization removes the scalar connection.
Equivalently one can normalize a frame locally using an étale
square root, since the characteristic is odd; its scalar potentials
glue by the usual projective-connection rule over K.

All Frobenius twists are handled over the same perfect field. In
relative notation H is replaced by its corresponding coefficient
twist on C^(1); Cartier descent and semistability are unchanged.
The argument is the rank-two genus-two case of the
[maximal-instability/oper correspondence](https://arxiv.org/abs/0912.3602),
and the displayed degree calculation proves the required case directly.

If all closed-point degrees of the dormant scheme are divisible by
ell, it has no F_(q^r)-point for ell not dividing r: a residue degree
d can acquire such a point only when d divides r. Apply the preceding
argument to obtain the all-height finite-field assertion. Nonreduced
structure, if present, would not alter this rational-point argument.

## 1a. Converse when a theta characteristic is rational

Let kappa be a theta characteristic over K. A regular projective
connection is equivalently a trace-free oper connection on
J^1(kappa^(-1)), with oper filtration
\[
0\longrightarrow\kappa\longrightarrow
 J^1(\kappa^{-1})\longrightarrow\kappa^{-1}\longrightarrow0.
\]
This is the half-density realization in our
[conventions](../../Definitions/projective_connections.md): local
horizontal equations are u''=r u, and their first jets glue in this
bundle. The determinant connection is trivial. If the projective
connection is dormant, its trace-free lift has zero p-curvature:
projective zero means scalar p-curvature, and trace zero makes
that scalar zero since two is invertible.

Cartier descent therefore supplies a degree-zero bundle H with
trivial determinant on C^(1), whose pullback is the displayed
unstable oper bundle. H is geometrically stable. Indeed, a saturated
line M in H with deg M>=0 would pull back to a horizontal saturated
line in the oper bundle. Its composite to kappa^(-1) is zero by
degree, so it must equal the saturated line kappa. That is impossible:
the oper second fundamental map of kappa is an isomorphism, so
kappa is not horizontal. This proves stability after any perfect
extension, hence geometric stability.

To get a bundle on C itself for absolute Frobenius, apply this
construction to the inverse coefficient twist C^(-1). Perfectness
transports both the dormant connection and kappa there, and its
relative Frobenius has target C. No field extension is introduced.

More precisely, over an algebraically closed field, these two
constructions are inverse bijections between first-destabilized
stable trivial-determinant bundles and pairs consisting of a
dormant projective connection and a theta characteristic on the
appropriate inverse Frobenius twist. Uniqueness of the maximal
line and of the canonical Cartier connection proves injectivity;
the first-instability calculation proves surjectivity. The
bijection is Galois-equivariant. We claim it here for geometric
classes, without a new scheme-theoretic moduli identification.

## 2. The backup's five dormant connections

The [universal quintic](../projective_connections/genus_two_dormant_quintic.md)
identifies the WHOLE regular dormant scheme, not just its geometric
points. For F=u^5+a4*u^4+...+a0, its parameters are
\[
W=T^2+3a_4T+3a_3,\qquad
V=-a_2+(a_4+2T)W,\qquad
\Psi=2a_0-2a_1T+a_2W-VW.
\]
The two highest curvature coefficients eliminate the other two
connection parameters with unit coefficients over every algebra.
The remaining identity is
\[
F^2(r_T''-3r_T^2)=\Psi(T)(u+T+3a_4).
\]
For our family, a4=-(alpha+1), a3=alpha+1, a2=-(alpha+1),
a1=alpha and a0=0. Multiplying Psi by its leading coefficient's
inverse gives the backup's monic polynomial
\[
\begin{split}
P(T)={}&T^5+(\alpha+1)T^4+(2\alpha^2+3)T^3+3\alpha^2T^2\\
 &+(3\alpha^2+\alpha+1)T+(2\alpha^2+2\alpha+3).
\end{split}
\]

The [small exact checker](../../scripts/genus_two/check_backup_dormant_residue.py)
verifies P and the three polynomial identities
\[
\gcd(P,P')=1,\qquad
\gcd(P,T^{125}-T)=1,\qquad
T^{125^5}=T\pmod P.
\]
Since five is prime, the last two prove irreducibility: every
irreducible factor degree divides five, and none has degree one.
It also records the complete five-cycle of the class of T.
The [receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/backup_dormant_residue.json)
contains coefficients, remainders and source hashes. The universal
symbolic checker proves the scheme identification independently of
this specialization. Hence Dorm(C_alpha)=Spec F_(125^5).

A nonsplit pointed extension 0->O->E->omega->0 on genus two is
semistable of degree two. A line of degree at least two would
project isomorphically onto omega and split E. Section1 therefore
applies directly, without twisting by a theta characteristic.

For sharpness, all sixteen theta characteristics of C_alpha are
already defined over F125: the rational Weierstrass point gives
one, and all two-torsion classes are rational because all six
branch points are rational. When 5 divides r, all five dormant
points are rational over F_(125^r). Section1a gives exactly
16*5=80 first-destabilized stable classes, each represented by an
actual bundle over that field. When 5 does not divide r, none can
exist. The separate pointed first-height theorem places all eighty
outside the theta-normalized pointed hyperplanes. Thus this sharpness statement
neither contradicts nor settles the remaining all-height pointed
problem.

### One residue certificate gives all sixty good cubic curves

The later [good-cubic classification](pointed_extensions_frobenius.md#5-exact-first-height-classification-and-cubic-transfer)
and [affine branch theorem](../curve_arithmetic/prime_field_branch_family.md)
give three coefficient-conjugate twenty-point orbits, all in F125.
For x=1/(u+1), a=1/(t+1), w=v x³, the actual curve equation is
\[
w^2=(t+1)(x^5-x)(x-a).
\]
An affine map a'=l a+b, with l∈F5* and b∈F5, lifts by
x'=l x+b, w'=l sqrt((t'+1)/(t+1)) w. Its scalar is in F125,
so the isomorphism exists over F_(125²). Every good cubic C_t is
therefore isomorphic over that field to a coefficient twist of the backup.

Dormant schemes commute with these actual isomorphisms and coefficient
twists. Their five-dimensional F125 algebras become fields after the
quadratic extension, by the backup's irreducible degree-five certificate.
An algebra whose scalar extension is a field was already a field;
etaleness also descends. Hence every whole dormant scheme is Spec F_(125^5).
No sixty specialized quintic calculations are needed.

All six branch points are F125-rational, so all sixteen theta
characteristics are rational there. The Galois-equivariant correspondence
in Section1a gives exactly eighty classes with the same sharp field
condition. Geometric isomorphism transports the pointed vanishing;
thus all eighty remain outside its theta-normalized pointed loci.

## 3. Both actual maps and the clump dichotomy

The [backup cored-span exclusion](../quotient_geometry/endpoint_exclusions/backup_cored_span_exclusion.md)
makes the assumed actual span coreless. Its joint tangent is the
kernel of a K-linear curve-cohomology map, and formation of that
kernel commutes with scalar extension. A nonzero geometric tangent
would therefore give a nonzero K-rational endpoint extension on
C_alpha. Section2 makes that bundle strongly semistable, contradicting
the [two-leg pointed-bundle principle](pointed_bundle_instability.md).
That principle uses the matching sections on the SAME source and
does not replace the span by endpoint data. Thus the tangent is zero.

The [canonical-intersection theorem](../shared_tensors/matched_section_rings.md)
leaves no clump or one positive clump. Singleton clumps are excluded
as follows, using direct geometric inputs. In the Cartier-zero branch,
[the family singleton exclusion](../jacobians/torsion/family_singleton_root_exclusion.md)
applies since alpha^5-alpha is nonzero. In the other branch the
[fixed-X profiles](../shared_tensors/fixed_x_nonzero_cartier_profiles.md)
give weight two or four, so a singleton P has 8[P-O]=0.
The [backup two-primary criterion](../curve_arithmetic/backup_curve_arithmetic.md)
then makes P Weierstrass, while the
[family eigenline calculation](../jacobians/torsion/family_small_torsion_specialization.md)
excludes the required Cartier eigenline there. The
[genus-two clump reduction](../shared_tensors/genus_two_clump_connection_reduction.md)
therefore supplies a regular nilpotent common connection for every
remaining positive clump. In the no-clump case the common connection space is
empty or one reduced dormant point. It is invariant under Gal(k/K),
so a unique point would descend to K. This contradicts Section2 on
the Y-endpoint. The spectrum is therefore empty; the existing
extension theorem gives the exact deformation ring k.

For a positive clump the intrinsic common regular connection is
defined over K. Indeed, the unique clump and each common weight
space are Galois-invariant; a primitive generator can be chosen
over K, and its intrinsic formula is independent of its scalar.
This connection is nilpotent. It cannot be dormant by Section2,
so it is active. The fixed-X nonzero-Cartier profiles and the
already excluded singleton leave
\[
r=4,\qquad (d,e)=(2,1)\text{ or }(4,2).
\]
Here d and e are primitive weight and common zero multiplicity.

For any regular active genus-two connection defined over K, its
normalized quartic s is defined over K. If its Hasse-root class
were geometrically trivial, s would have a quadratic square root
q over an extension of K of degree at most two. One way to see
the degree bound is that its two geometric roots form a two-element
Galois set. The canonical secant identity gives the two regular
dormant connections r+q and r-q over that extension. Explicitly,
writing q=b(dt)^2, Cartier normalization gives C_1(q^3)=q,
r=b''/b and E(r+q)=E(r-q)=0. This is the first part of the
[canonical-double proof](../projective_connections/etale_double_dormant_pairs.md).
Their existence contradicts Section2: an extension of degree at
most two still has degree prime to five over F125.

Thus this Hasse-root class is nontrivial. The weight-two common
profile would express s as a nonzero scalar times the square of
the common quadratic, making that class trivial. Hence only
(d,e)=(4,2) survives. The [connection-spectrum theorem](../projective_connections/coreless_connection_spectrum.md)
then makes the active connection unique. The
[extension-spectrum dichotomy](two_leg_negative_extensions.md),
with r=4 and e=2 and with tangent zero, supplies exactly the unique
simultaneous W2 lift. Its already proved zero-tangent normal form
gives W(k)/(5^e), 2<=e<=infinity, without bounding e.

For any good cubic endpoint, K=F_(5^(6r)) contains the quadratic
isomorphism field above. Use coefficient Frobenius25, which fixes the
F25-model of X and cycles all three good cubic orbits. Apply its
inverse, when needed, to the ENTIRE span: source and both morphisms.
Then compose its C_t-leg with the K-isomorphism to the backup. This
gives the actual backup span on the same twisted source. Transport
Section3 back along these invertible operations. Joint tangents,
clumps, intrinsic connections and the marked Witt lifting torsor all
transport, so every stated conclusion holds for the original span.
No endpoint-only field substitution or new source map is inferred.

## 4. The finite-moduli version, retained as a separate tool

Suppose a true Frobenius moduli map in a frame over Fq is
x -> V(x^[p]), and a finite quotient over Fq of its actual
indeterminacy has every residue degree divisible by ell. It has
no point over F_(q^r) for ell not dividing r. Neither does the
indeterminacy, since a rational point maps to a rational quotient
point. Coefficient Frobenius and V preserve F_(q^r), so induction
keeps every such initial point in the domain at every height.
A frame extension of degree prime to ell preserves the argument.

The corrected [actual theta quotient](pointed_frobenius_quotient.md)
has one degree-five point for this same backup. Its separate
[dictionary check](../../Research/audits/GENUS_TWO_THETA_DICTIONARY_CORRECTION_AUDIT_2026_09_16.md)
and [residue audit](../../Research/audits/FROBENIUS_RESIDUE_FAMILY_HEIGHT4_AUDIT_2026_09_16.md)
give an independent coordinate check of the arithmetic obstruction.
They are unnecessary for Sections1--3. The earlier Richelot-neighbor
prototype with factor degrees1,2,2 is not an input.

None of these arguments descends an arbitrary geometric span to an
extension of degree prime to five. A degree divisible by five can
make the dormant points rational; that remains a genuine open case.
