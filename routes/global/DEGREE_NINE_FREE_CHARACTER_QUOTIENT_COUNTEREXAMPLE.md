# A free order-nine character quotient with primitive canonical weight nine

Date: 2026-09-06. Author: `/root/degree_nine_character_quotient_stress_test`.
Independent audit: **PASS**, 2026-09-06,
`/root/degree_nine_counterexample_independent_audit`. No breaking objections.
Nonbreaking suggestions make the different-base tensor-product lift and
Cartesian quotient squares explicit; both are incorporated below.
[Audit record](audits/DEGREE_NINE_FREE_CHARACTER_QUOTIENT_AUDIT_2026_09_06.md).

## Claim

Over an algebraically closed field of characteristic five, there exists a
coreless span of finite etale maps between smooth connected projective curves
of genus at least two, carrying compatible regular Tango structures, whose
common canonical ring is a polynomial ring on a generator of degree NINE.
Thus those conditions do not force primitive weight one.

The extra ingredient is a connected auxiliary etale cover which makes the
order-nine character action free. Merely quotienting the existing endpoints
by their order-nine symmetry does not accomplish this.

## 1. Make the existing construction equivariant

Use the seed and exact two-point endpoint construction in
[the singleton counterexample](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md)
and [the A9 local realization](A9_TWO_POINT_COVER_WITH_EXACT_WILD_LOCAL_FIELD.md).
Write M=k(x,y), x-y=(xy)^5, and let lambda be a primitive ninth root.
The automorphism s of M sends (x,y) to (lambda*x,lambda*y).

In the A9 construction, its splitting field K is already Galois over k(r^9).
When adjoining the cyclic-sixteen augmentation, take the compositum of its
conjugates under the FULL group Gal(K/k(r^9)), not just Gal(K/k(r)).
This is a finite Galois extension R of k(r^9). Over K its group is still
an abelian 2-group of exponent dividing sixteen. At zero all conjugates have
the same unique tame local extension of degree sixteen. Elsewhere their
extensions over K are locally trivial. Thus the exact infinity completion,
the two-point branch locus, and the absence of an F20 quotient over k(r)
are all preserved.

Take the endpoint fields A and B with the required coordinates x=-r and y=r,
and let N=MAB. All the original proofs apply: A intersect B=k, the curve Z
of N maps etale to the curves X,Y of A,B, and the common exact form
alpha=dx=dy has order fifteen at every zero on both endpoints.

Moreover N is Galois over M^{<s>}. Indeed any embedding over that field
restricts on M to a power of s and preserves A,B, because those fields are
normal over k(x^9), k(y^9). At the seed point O, M/M^{<s>} has tame index
nine. The completion of N/M at any point over O is the unique tame extension
of degree sixteen. Hence the decomposition group of N/M^{<s>} there is
cyclic of order 144. Its order-nine subgroup maps isomorphically to <s>.
Choose a generator sigma whose restriction to M is s.

We have therefore obtained a simultaneous order-nine action on X,Y,Z,
compatible with both etale maps, and sigma^*alpha=lambda*alpha.

## 2. The quotient endpoints have ample genus

Put X0=X/<sigma>, Y0=Y/<sigma>. A fixed point of any nonidentity power of
sigma on X or Y lies over zero or infinity, since the rational coordinate
is multiplied by a nontrivial ninth root.

For either endpoint of degree q over its rational base, the number of such
possible points is at most

    B0=q/16+q/20=9q/80,

and 2g(X)-2=27q/16. Tame Riemann--Hurwitz consequently gives

    9(2g(X0)-2) >= 27q/16 - 8*(9q/80) = 63q/80.

The same holds for Y0. In particular their genera are at least three
(already q>=|A9|=181440).

## 3. Connected free-action device, with disjointness built in

There are arbitrarily large pairwise nonisomorphic nonabelian simple groups
H=PSL2(2^n), with n=6m+3, of order prime to five and containing an element of
order nine. Indeed |H|=Q(Q-1)(Q+1), Q=2^n; Q is 2 or 3 modulo five and is
-1 modulo nine. The nonsplit torus has order Q+1.

These groups have a generating set of size three: an upper unipotent U(1),
the diagonal matrix diag(a,a^-1) for a generator a of F_Q^*, and the matrix
interchanging the two coordinate lines. Conjugating U(1) by the diagonal
matrix gives U(a^{2j}); these generate all upper unipotents, and interchange
gives all lower unipotents, which generate SL2(F_Q)=PSL2(F_Q).

Every such group occurs as the group of a connected etale Galois cover of
any smooth projective curve of genus at least three in characteristic five.
This uses the standard prime-to-characteristic presentation of the etale
fundamental group: send three a-generators of the surface group to the
displayed generators of H and all b-generators to the identity. The surface
relation is then satisfied. The exact realization statement is
[SGA1, Expose XIII, Corollaire 2.12](https://arxiv.org/pdf/math/0206203#page=306),
printed pp. 290–291. Its statement and proof were checked in the primary
source by the auditor and root. This uses existence of individual auxiliary
covers, not a simultaneous lifting of the two original maps.

Choose two nonisomorphic such simple groups Hx,Hy, with |Hx| greater than
the degree of a Galois closure of N/k(X0), and |Hy| greater than the degree
of a Galois closure of N/k(Y0). Choose connected etale Galois covers

    Vx -> X0, with group Hx;       Vy -> Y0, with group Hy.

Their fields are linearly disjoint from N over their respective base fields.
For example, intersect k(Vx) with a Galois closure T of N/k(X0). This
intersection is Galois over k(X0), hence gives a quotient of simple Hx.
It is either the base or all of k(Vx); the latter contradicts |Hx|>[T:k(X0)].
Both extensions are Galois, so a trivial intersection gives linear
disjointness. The argument for Vy is identical.

After base change to N, the two extensions have groups Hx and Hy. Their
intersection is Galois over N and would give a common quotient of these
nonisomorphic simple groups; therefore it is N. Consequently

    U=N k(Vx) k(Vy),       Gal(U/N)=Hx x Hy,

is a FIELD. Define endpoint fields

    A1=A k(Vx),            B1=B k(Vy).

Their smooth projective curves X1,Y1, and the curve Z1 of U, are connected.
All the auxiliary base changes are etale, and Z1 -> X1,Y1 are etale:
each is a composition of base changes of the original etale leg and the
other auxiliary etale cover.

## 4. Corelessness survives before and after taking quotients

The group G=Gal(U/N)=Hx x Hy preserves A1 and B1, acts on A1 through Hx
and on B1 through Hy, and has invariants

    (A1)^G=A,       (B1)^G=B.

For E=A1 intersect B1, therefore E^G=A intersect B=k. Every element of E
is algebraic over E^G by its finite orbit polynomial. Since k is
algebraically closed, E=k. This proves corelessness of the enlarged span
on its actual connected source.

Since k(Vx) is linearly disjoint from N over k(X0), sigma extends to
N k(Vx) by acting trivially on k(Vx); similarly for Vy. The independence
just proved extends these prescriptions to one order-nine automorphism
sigma_tilde of U. It commutes with Hx x Hy and preserves A1,B1.
Explicitly the proved disjointness identifies U with the field

    k(Vx) tensor_{k(X0)} N tensor_{k(Y0)} k(Vy).

The lift is identity tensor sigma tensor identity; sigma fixes both
displayed base fields. This justifies the lift over the different bases.

Choose elements hx in Hx and hy in Hy of order nine and set

    delta=sigma_tilde * hx * hy.

It has order nine. On X1 it acts through (sigma,hx), and on Y1 through
(sigma,hy). Every nonidentity power is fixed-point-free on X1 because its
projection to Vx is the corresponding nonidentity deck transformation hx^j
of an etale Galois cover. The same argument applies to Y1 and Z1. This is
an actual proof of freeness for every stabilizer, not just at generic points.

Take the free quotients X2=X1/<delta>, Y2=Y1/<delta>, Z2=Z1/<delta>.
The induced maps Z2 -> X2,Y2 are finite etale, by etale descent (equivalently,
all the stabilizers on source and endpoints are trivial). Their endpoint
fields are subfields of A1,B1, hence still intersect in k in k(Z2).
Their genera are at least two by etale Riemann--Hurwitz.
For each leg its quotient square is Cartesian: Z1 is the pullback of
Z2 along the endpoint C9-torsor. Thus finite etaleness really descends.

## 5. Primitive weight nine and regular Tango descent

Pull alpha to X1,Y1,Z1. It is still regular and exact, all its zero orders
are fifteen, and delta^*alpha=lambda*alpha. On the enlarged coreless span,
every shared regular tensor of degree m is a scalar multiple of alpha^m:
divide by alpha^m in both endpoint fields and use A1 intersect B1=k.
Thus its common canonical ring is k[alpha].

Since all quotient maps are etale, shared canonical tensors on the quotient
span correspond exactly to delta-invariant shared tensors upstairs. Therefore

    common canonical ring of X2 <- Z2 -> Y2
      = k[alpha]^{<delta>} = k[alpha^9].

The generator alpha^9 descends to regular ninth canonical tensors on both
endpoints, and there is no nonzero common positive-degree tensor in any
degree less than nine. The primitive weight is exactly nine, not merely
a displayed ninth power of a smaller common invariant.

Upstairs declare alpha horizontal. Because its orders are fifteen, this
defines the existing regular dormant Tango connection on each endpoint.
Multiplication of alpha by the constant lambda preserves that connection,
so the connections are delta-invariant. They descend through the finite
etale quotients to regular dormant connections on omega_X2 and omega_Y2.
The Tango condition is etale-local: Cartier vanishing of horizontal forms
can be tested after the etale pullback, where the forms are fifth-power
multiples of the exact form alpha. Compatibility descends as well.

This proves the claim.

There is exactly one compatible Tango pair: two distinct pairs would give
a nonzero shared one-form by the
[zero/one/p-minus-one theorem](COMPATIBLE_TANGO_STRUCTURES_SINGLETON_OR_QUARTET.md),
whereas this common ring has no degree-one component. If desired, replace
Z2 by the normalization in the compositum of its two endpoint fields.
The maps to both endpoints remain etale, and the same common ring and
compatible structures remain. Thus joint-image minimality does not repair
the refuted assertion either.

## 6. Why the auxiliary free cover matters

For the original simultaneous action chosen at O, both endpoints have
fixed points of order nine. At such a point alpha has order fifteen. If
alpha^9 is descended as a rational ninth differential through the ramified
quotient, its order downstairs is

    (9*15 - 9*(9-1))/9 = 7.

For a stabilizer of order three the analogous order is 39. Neither is
divisible by five. Therefore the horizontal regular Tango connection used
upstairs cannot descend regularly through those ramified quotient points:
a horizontal rational section of omega^9 for a regular connection must
have five-divisible order. The free-action construction removes precisely
this local obstruction. It also checks connectedness and preserves
corelessness explicitly, rather than relying on a disconnected product of
nine sheets or an unverified lift of a character action.

## Scope

This disproves the proposed implication from corelessness, projective
etale legs, compatible regular Tango, and nontrivial canonical intersection
to primitive weight one. It makes no assertion that these new endpoint
curves are ordinary, or that an arbitrary fixed original ordinary endpoint
can be retained. It does not settle the common-cover conjecture.
