# Proof: the unit-root centralizer has multiplicity one

## 1. The pro-p cover model retains only etale p-torsion

The pointed pro-primary argument in
[the Frobenius theorem](pro_primary_frobenius_exclusion.md), Sections1-2,
also applies to the geometric maximal pro-p fundamental group in
characteristic p. It is finitely generated; its Frattini quotient is
dual to H1_et(C,Fp), of dimension equal to the p-rank. The kernel of
its automorphism action on this quotient is pro-p by the same finite
Burnside-basis argument. This statement concerns the etale fundamental
group and does not require a connected p-torsion trivialization.

After making J(C)[p](bar Fq) rational over degree m and obtaining a
rational base point over a further p-power field, Frobenius acts
through this pro-p kernel. An actual open subgroup and then its
Frattini quotient are fixed over a p-power extension. As in that
proof, its full pro-p fundamental group is the subgroup: a p-group
cover above a p-group-monodromy cover still has p-group Galois closure.
This constructs T and makes J(T)[p](bar Fq) rational over exactly
the required type of field F_(q^(m*p^s)).

The [Artin--Schreier sequence](https://stacks.math.columbia.edu/tag/0A3J)
identifies H1_et(C,Fp) with the F=1 vectors in H1(C,O_C).
The standard semilinear Fitting decomposition shows that tensoring
those vectors with the algebraic closure gives its stable-F part.
In particular the dimension is finite. The pro-p fundamental group
is in fact free of that rank; only finite generation was needed above.

## 2. The geometric-factor argument works for unit roots

Let B/FQ have rational etale p-torsion. Every UNIT p-adic Frobenius
eigenvalue of B then reduces to1, since these are exactly the
eigenvalues of Frobenius on the etale p-adic Tate module. No such
claim is made about its positive-slope eigenvalues, which reduce to0.

Suppose A0/FQ is a geometric factor and choose a unit eigenvalue pi.
After a finite field extension on which the factor maps are defined,
some eigenvalue alpha of B satisfies alpha^s=pi^s. Thus alpha=pi*zeta
for a root of unity. Fix the p-adic embedding, and a number field
K containing pi. For EVERY automorphism sigma fixing K,
sigma(alpha)=pi*sigma(zeta) is still a UNIT eigenvalue of B. Therefore
\[
\overline{\sigma(\zeta)/\zeta}=1.
\]
Reduction is injective on roots of unity of order prime to p. The
prime-to-p part of zeta is consequently fixed by all such sigma and
belongs to K. This proves pi_bar in mu(K)_bar. Applied over the
field of Section1, and removing its p-power exponent by the bijective
p-power map on residual units, it proves(2) of the statement.

For X the Weil polynomial modulo5 is
\[
T^{12}(T+1)^2(T^4+T^3+3T^2+3).
\]
The last quartic is irreducible and a root has exact order624.
The established fixed-X endomorphism field has roots of unity mu6.
Thus (2) for Frobenius25 raised to c gives624 dividing6cm, or
104 dividing cm. In particular13 must divide c or m.

## 3. The actual abelian quotient has a controlled field

Let W be the ORIGINAL Y-leg Galois closure and C=W/P. Its map to
Y is the actual abelian A-cover. A rational point of Y exists over
F_(25^b), since q+1-4*sqrt(q)>0. It gives a splitting of arithmetic
fundamental groups. The quotient factors through the exponent-n
character module of Y. Killing Frobenius on that module descends
its actual subgroup and makes every A-deck map defined.

For each prime power lambda^r dividing n, lambda is not5. The
four-dimensional Tate module has Frobenius in GSp4(Z/lambda^r),
whose reduction kernel is a lambda-group and whose residual order is
\[
\lambda^4(\lambda-1)(\lambda^2-1)(\lambda^4-1).
\]
It is prime to13 under the prime condition(1): the fourth roots of
unity modulo13 are exactly1,-1,5,-5. The reduction kernel is also
prime to13. Chinese remaindering therefore gives a field
F_(25^c),13 not dividing c, over which C/Y and its deck action are
defined. No unspecified field of definition of W or its X-map is used.

## 4. At most one etale five-character per coherent character

Over the algebraic closure, the prime-to-five abelian etale cover has
\[
q_*\mathcal O_C=\bigoplus_{\chi\in\widehat A}L_\chi,
\]
where nontrivial characters give nontrivial degree-zero torsion lines.
Since g(Y)=2, Riemann--Roch gives h1(Y,L_chi)=1 for chi nontrivial,
and h1(Y,O_Y)=2. Thus each nontrivial character has multiplicity ONE
in H1(C,O_C). Artin--Schreier and the stable-part inclusion from
Section1 imply multiplicity AT MOST ONE in
H1_et(C,F5) tensor k. This does not assert that C is ordinary.

A simple F5[A]-module of character order d has endomorphism field
F_(5^f), with f=ord_d(5). Its multiplicity in etale cohomology is
zero or one. The trivial summand has dimension the p-rank of Y,
at most two; invariants descend because |A| is invertible in F5.

Arithmetic Frobenius commutes with the now constant A-action.
Its order on this cohomology, hence on the dual etale Jacobian
five-torsion, divides the order of a product of GL2(F5) and the
groups F_(5^f)^times corresponding to the present characters.
Since ord_13(5)=4, condition4 not dividing ord_n(5) excludes13
from every one of these groups. Thus the actual torsion order m
is prime to13, independently of the genus of C or the order of A.

Now W/C has five-group monodromy. Sections1-2 exclude JX as a
geometric factor of JW. But the composed original map W->Z->X
is etale and supplies exactly that factor. This contradiction
proves the theorem with both original maps retained.

For the listed quotient primes, the orders of5 modulo3,7,11,19,23
are2,6,5,9,22. Passing to higher prime powers multiplies each order
only by powers of its odd prime. None gains a factor4. Also
ord_8(5)=2, while ord_16(5)=4; this is the stated two-primary limit.
All six allowed primes avoid the five forbidden residues modulo13.

## 5. The actual hyperelliptic lift halves certain character fields

Make one Weierstrass point of Y rational over a field extension of
degree at most6, hence prime to13. Choose it as the base point for
the ACTUAL quotient construction in Section3, so that a point of C
above it is rational. The hyperelliptic involution iota fixes the
base point and acts by minus one on the abelian fundamental group,
as it does on the Jacobian with this Weierstrass origin.

The defining subgroup of the abelian cover is consequently invariant.
There is a unique lift j of iota fixing the chosen point of C. It
satisfies j^2=1, conjugates every deck element a to a^(-1), and is
defined over the chosen field by uniqueness. Arithmetic Frobenius on
H1_et(C,F5) therefore commutes with BOTH A and this actual involution.
No action on an abstract character list is substituted for j.

For a present character of order d, its simple F5 field is F_(5^f),
f=ord_d(5), and its multiplicity is one. If d>2 and inversion is
inside its five-Frobenius orbit, then f is even and inversion is
5^(f/2) modulo d. The lift j acts semilinearly for the nontrivial
involution of F_(5^f)/F_(5^(f/2)). A scalar Frobenius multiplier
commuting with j must belong to the fixed field F_(5^(f/2)).
If inversion exchanges two different character orbits it only links
their multipliers and no field reduction is inferred. This proves
exactly the refined f_+(d) criterion in the statement.

For37,41,89 the orders of5 are36,20,44, each with two-adic valuation
exactly two. This remains so at all powers of these odd primes.
For every odd d supported on them, all component orders have the
same two-adic valuation. Their least common multiple f therefore
has valuation two and f/2 is congruent to half of EACH component
order modulo that order. Thus5^(f/2)=-1 modulo d. Adjoining a factor
two changes neither assertion. The fixed-field degree f/2 has only
one factor two, so its multiplicative group has order prime to13.
All three primes also satisfy the model-field residue condition.

An elementary two-quotient of rank3 or4 exists on either genus-two
endpoint. Combining it with arbitrary cyclic37,41,89 quotients and
the five-group P of Section7 gives genuine additional cover families.
An order8 character cannot be substituted here: minus one modulo8
does not lie in the subgroup generated by5. This is why the refined
condition is stated for every character order, not just the total
odd exponent.

## 6. A conditional nonabelian quotient test

For any prime-to-five free deck group A, the coherent free-cover
character gives H1(O_C)=k plus k[A] when the base has genus two.
Equivalently a nontrivial simple character of degree e occurs e
times. This follows from the tame fixed-point-free Lefschetz
character, or the usual etale Chevalley--Weil formula. The stable
part therefore contains at most e copies. For a simple algebra
factor M_e(F_(5^f)), the etale centralizer is GL_r(F_(5^f)), r<=e.
It has order prime to13 if4/gcd(4,f)>e. This proves the stated
conditional extension once its actual constant-deck model has
already been obtained over a prime-to13 field. It is not asserted
for an arbitrary nonabelian quotient without that model condition.

For a group G of order8*5^a, Sylow's theorem already makes its
Sylow five-group normal: no divisor of8 other than1 is1 modulo5.
The actual quotient A has order8. The pointed pro-two cover-model
argument makes this quotient and its deck action constant over a
prime-to13 field: first kill the action on Y[2], whose order divides
|Sp4(F2)|=720, then use a two-power extension in the Frattini kernel.
For A=C8, the simple fields have degrees1 or2 over F5 and e=1.
For A=C4 x C2 or C2^3 all have f=e=1. For A=D8 or Q8 the only
nonlinear factor has e=2 and f=1; the quaternion representation
splits over F5, which contains a square root of minus one.
Each factor satisfies4/gcd(4,f)>e. The criterion therefore excludes
every such closure group, with no bound on a and no assumption
on the original leg's Galois property.

## 7. Actual new groups, and the limit of the argument

Let P=C5 wreath C25=(C5)^25 semidirect C25, with cyclic permutation
of the25 coordinates. A shift and one coordinate generator generate
P. Its order is5^27 and its derived subgroup is the augmentation
hyperplane in (C5)^25, of order5^24. Inducing a single-coordinate
character of the base gives a faithful irreducible representation
of degree25 over Q(zeta5): its25 weights are distinct and permuted
transitively, and their intersection of kernels is trivial.

Both selected Y are ordinary of p-rank two. Their geometric maximal
pro-five fundamental groups are free on two generators, so P occurs
as an actual etale cover group; see the original proof in
[Crew, Theorem1.9](https://www.numdam.org/item/CM_1984__52_1_31_0.pdf).
They also admit cyclic etale covers of degree8*3^c. Coprime degrees
make their fiber product connected, with actual group P x C_(8*3^c).
The present theorem excludes a second map from any such cover to X.
The old packet inequality allows its degree25 character; its derived
subgroup is far beyond the low-degree norm cases. The arbitrary
nonabelian quotient of the pro-two theorem also fails its small
centralizer test on this character, so this family verifies new scope.

The [independent finite-algebra checker](../../../scripts/arithmetic/verify_unit_root_frobenius.py)
verifies the exact mod-five factorization, quartic irreducibility,
root order624, the six quotient-prime checks, and the exponent8/16
boundary. Its [executed output](../../../../litt3-computation-data/pro_primary_frobenius_20260921/unit_root_check.txt)
passes. A separate Sage calculation gave the same irreducible quartic
and multiplicative order624.

No assertion makes the unit-root representation regular for arbitrary
prime-to-five A, or ordinary when C is nonordinary. Only the coherent
multiplicity upper bound is used. Character degree divisible by four,
or a larger nonabelian multiplicity, can introduce13. General mixed
monodromy and both unrestricted common-cover problems remain open.
