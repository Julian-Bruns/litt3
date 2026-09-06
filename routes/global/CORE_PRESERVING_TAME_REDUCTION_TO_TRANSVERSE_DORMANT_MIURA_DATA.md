# Core-preserving tame reduction to everywhere-transverse dormant data

Date: 2026-09-05. Author: /root. Independent audit: PASS, 2026-09-05,
by /root/core_preserving_transverse_reduction_audit. Its two nonbreaking
proof clarifications are incorporated below. The
[audit record](audits/CORE_PRESERVING_TRANSVERSE_DORMANT_REDUCTION_AUDIT_2026_09_05.md)
is for investigating doubts, not routine context loading. No common-cover
counterexample is proved here.

This is a conditional, all-degree structural reduction. It retains both
actual finite etale legs AND corelessness. It uses no lifting. Unlike
the [degree-four regularization](TAME_DOUBLE_REGULARIZATION_OF_SHARED_CARTIER_ZERO_EQUATIONS.md),
its endpoint-cover degrees are not bounded by four. No earlier special
case is deleted.

The reduction is valid, but its output is not a contradiction:
the [additive singleton construction](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md)
now realizes an actual coreless projective etale span with even a
shared exact one-form and a unique compatible Tango structure.
Do not use this theorem as a universal nonexistence obstruction.

## Theorem

Let k be algebraically closed of characteristic five and let

    X <-f- Z -g-> Y

be a coreless finite etale span of smooth connected projective curves
of genus at least two. Put a=deg(f), b=deg(g). Suppose there are shared
nonzero holomorphic d-pluriforms

    f*s_X = g*s_Y = s_Z,       5 does not divide d,

whose endpoint divisors are e S_X and e S_Y, for the same e>0 and
nonempty reduced divisors S_X,S_Y. Assume generalized Cartier zero:
if 1<=r<=4, rd=5h+1, then C_h(s_X^r)=C_h(s_Y^r)=0.

The uniform multiplicity hypothesis applies in particular to the
primitive generator of a nontrivial canonical-ring intersection of a
coreless span: see the [intersection theorem](../../Theorems/Thm_canonical_intersection.md).

There are finite Galois maps pi_C:R_C->C for C=X,Y and a smooth
connected projective curve W giving a commuting diagram

    R_X <- W -> R_Y
     |     |     |
     X  <- Z  -> Y

with the following properties.

1. The upper two maps are finite etale and their function-field
   intersection is k. Thus the new actual span is again coreless.
2. The pulled-back pluriforms remain shared and Cartier zero. Their
   zero multiplicities are all divisible by five.
3. Their associated projective connections are regular dormant
   PGL2-opers. The distinguished horizontal Borel reduction is shared
   and everywhere transverse to the oper Borel: it has no collisions.
4. One may choose an integer n>=2 with

       n(e+d)=d modulo 5,       gcd(n,5ab)=1.

   Each pi_C is ramified exactly with index n above S_C and nowhere
   else. Its degree q_C satisfies

       n^2 divides q_C,       q_C divides n^(n+1).

   In particular its degree is coprime to 5ab. The genus is given by

       g(R_C)-1 = q_C(g(C)-1) + q_C(n-1)|S_C|/(2n),

   and necessarily 5 divides g(R_C)-1.

The original endpoint curves are changed. This is a reduction of a
putative configuration to a structured configuration, not an excluded
degree or an obstruction on the fixed proposed pair.

## 1. Choosing the ramification index

Write E=e/d in F5. Cartier zero excludes E=4, by the leading-term
Cartier test in the [explicit equation theorem](EXPLICIT_SECOND_ORDER_EQUATION_FOR_CARTIER_ZERO_PLURIFORMS.md).
Thus e+d is nonzero modulo five. Choose n congruent to d/(e+d)
modulo five and congruent to 1 modulo the prime-to-five part of ab.
The Chinese remainder theorem gives such integers, and adding its
modulus makes n>=2. Then gcd(n,5ab)=1. No assertion about primes in
arithmetic progressions is required.

## 2. Galois endpoint covers with controlled prime factors

Fix C and S=S_C. Choose an exact-order-n line bundle in Pic^0(C).
It defines a connected cyclic etale cover T->C of degree n, since
5 does not divide n. The reduced divisor D over S has degree n|S|.
It has an nth root L in Pic(T): choose a line bundle of degree |S|
and adjust it by a degree-zero line bundle, using the surjectivity of
multiplication by n on Pic^0(T).

The cyclic cover P->T defined by the canonical section of L^n=O(D)
is connected, smooth, and totally ramified with index n over D,
and etale elsewhere. At a point of D its defining polynomial is
Eisenstein, so the generic extension has degree n even when n is
composite. Locally it has equation w^n=t times a unit. The composite
P->C therefore has degree n^2 and index n over every point of S.

Let R_C->C be its connected Galois closure. Since T->C is cyclic
Galois and P->T is cyclic of degree n, the Galois closure over T
is contained in the compositum of its n cyclic conjugate extensions.
Its group over T is a subgroup of (C_n)^n, and the group over C
is an extension of that subgroup by C_n. Equivalently it embeds
in the corresponding wreath product. Its order q_C therefore divides
n^(n+1), and n^2 divides q_C because it contains k(P).

No additional ramification appears off S. Above S, every local
conjugate extension is the same tame extension k((t^(1/n))) inside
a separable closure of k((t)). Indeed the residue field is algebraically
closed and every unit of k[[t]] has an nth root. Their compositum
still has ramification index n. Thus R_C->C has exactly the asserted
ramification, even after taking its Galois closure. Riemann--Hurwitz
gives the displayed genus formula.

## 3. The actual new span remains etale

Put K=k(X), L=k(Y), M=k(Z), with the actual given inclusions.
Choose the Galois endpoint extensions K'=k(R_X) and L'=k(R_Y)
inside a separable closure of M, and set

    M'=M K' L'.

Let W be the smooth projective curve with function field M'. The
field inclusions give the asserted finite surjective maps and diagram.

The supports match on Z: f*S_X=g*S_Y as reduced divisors, because
the actual pluriform pullbacks agree and both original maps are etale.
At a point of this common support, the completed local fields of X,
Y and Z identify with k((t)). Each selected endpoint extension is
the same unique tame extension k((t^(1/n))). Their compositum is
still that field. Thus W has ramification index one over either
R_X or R_Y. Off the support all the endpoint extensions are locally
unramified, hence split on completion. Again the relative index is
one. All residue fields are k, and the maps are separable, so the
upper two finite maps of smooth curves are etale.

This uses normalization of the chosen compositum, not the possibly
singular unnormalized fiber product. W is one actual common source.

## 4. Why corelessness is preserved

This is the point of controlling all prime factors of the endpoint
Galois covers. Since q_X is coprime to [M:K]=a, the Galois extension
K'/K is linearly disjoint from M/K. Similarly L'/L is linearly
disjoint from M/L. Explicitly, [MK':K] is divisible by both a and
q_X and at most a q_X; coprimality forces equality. The argument
for L is identical.

The extension M'/M is finite Galois. Put G=Gal(M'/M). It preserves
K' and L', since those extensions are normal over K and L. Its
restriction to each endpoint is surjective onto that endpoint's full
Galois group: linear disjointness gives this for MK'/M and ML'/M,
and restriction from their Galois compositum remains surjective.
Consequently

    (K')^G=K,       (L')^G=L.

For E'=K' intersection L', the finite group G acts on E', and

    (E')^G = K intersection L = k.

Every element of E' is algebraic over its finite-group invariant
field, by its orbit polynomial. Since k is algebraically closed,
E'=k. This proves corelessness of the new span. Arbitrary compatible
endpoint covers would not justify this argument: coprimality and the
Galois construction are essential here.

## 5. Removing both singularities and horizontal collisions

At a point over S_C the order of the pulled-back pluriform is

    e'=n e+d(n-1)=n(e+d)-d.

It is positive and divisible by five by construction. Away from
the preimage of S_C its order is zero. Generalized Cartier zero
commutes with rational separable pullback, so it remains true on
R_X,R_Y,W. The equality of the two pulled-back pluriforms is retained
by the actual commuting diagram.

In a local parameter u, write the new form as A(du)^d. Its projective
connection is

    ell=A'/(d A),       Q=ell'-ell^2/2,
    y''+(Q/2)y=0.

At every point A=u^(5m)V with V a unit and m>=0. Hence ell=V'/(dV)
is regular and Q is regular. Choose j with 2dj=-1 modulo five.
The distinguished horizontal solution jet factors as

    (A^j,(A^j)')=u^(5mj)(V^j,(V^j)').

Dividing by the horizontal factor u^(5mj) gives the jet of V^j, whose
value is a unit. Therefore its saturated horizontal line projects
isomorphically to the quotient by the oper line. The two Borel
reductions never meet. This is the promised everywhere-transverse
condition, not merely generic transversality away from a divisor.

Cartier zero supplies the explicit second independent rational
solution proved in the equation note. Thus the regular projective
connection has zero p-curvature and is dormant. The distinguished
line, its saturation, and the projective connection are intrinsic
under the actual pullback identifications, so both endpoint objects
agree on W.

Finally deg(div(pi_C*s_C))=d(2g(R_C)-2) is divisible by five,
and d is prime to five. This proves 5 divides g(R_C)-1, consistent
with the necessary degree condition for the transverse structure.

## Retained information and the failed final implication

The universal nonexistence claim formerly proposed here is false, by
the [checked singleton example](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md).
The proof above still gives the specified commuting diagram over the
ORIGINAL endpoints, with controlled solvable Galois groups and inertia.
It does not give a contradiction after those original maps are forgotten.

One can also preserve the original primitive weight by taking n prime
to d; see the [degree-drop theorem](PRIMITIVE_CANONICAL_WEIGHT_UNDER_ENDPOINT_COVERS.md).
This is retained information, not a proof that higher weight is impossible.

Any further obstruction must be proved for the actual output, including
its descent to the fixed targets. Applying this very reduction to a known
counterexample already supplies its abstract solvable-tower properties
over other targets, so those properties alone do not repair the claim.
The no-positive-invariant and nonzero-Cartier branches remain separate.
