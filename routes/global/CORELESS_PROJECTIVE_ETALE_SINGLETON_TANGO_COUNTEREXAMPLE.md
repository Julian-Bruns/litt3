# A projective etale coreless correspondence with a shared exact differential

Date: 2026-09-05. Author: /root, with the bounded construction and proof
tasks linked below. **This disproves the proposed singleton repair. It
does not disprove Litt's common-cover conjecture.**

Independent checks: the endpoint realization **PASS**,
/root/a9_local_realization_independent_audit, 2026-09-05
([record](audits/A9_EXACT_LOCAL_REALIZATION_AUDIT_2026_09_05.md)); the
corrected global construction **PASS**,
/root/additive_projective_counter_global_audit, 2026-09-05
([record](audits/ADDITIVE_PROJECTIVE_COUNTER_GLOBAL_AUDIT_2026_09_05.md)).
The latter originally caught a fatal sign mismatch: the x-endpoint
MUST use the sign twist specified below. It also corrected one bound
in the seed proof. Both corrections are incorporated. Read the audit
records only to investigate these points or another concrete doubt.

## Theorem

Over k=Fbar_5 there are smooth connected projective curves X,Y,Z,
of genus at least two, and finite etale maps f:Z to X, g:Z to Y,
with the following properties:

1. The actual endpoint fields in k(Z) intersect in k.
2. There are nonzero regular exact differentials alpha_X, alpha_Y
   with f*alpha_X=g*alpha_Y. Each endpoint differential has order
   exactly 15 at every zero and no poles.
3. There is exactly ONE pair of compatible Tango structures.

The endpoints may be chosen isomorphic, although their displayed
rational functions have opposite signs. In particular a shared
Cartier-zero positive tensor, even a shared exact one-form with
five-divisible zero divisor, does not force a core.

## 1. Two proved ingredients

The [additive seed theorem](ADDITIVE_BIDEGREE_FIVE_CORELESS_EXACT_TEST.md)
gives a genus-four curve C with

\[
 M=k(C)=k(x,y),\qquad x-y=(xy)^5,\qquad k(x)\cap k(y)=k.
\]

Both rational legs have degree five. Its three distinguished points
have divisors

\[
 (x)=O+4Q-5P,\quad (y)=O+4P-5Q,
 \quad (dx)=(dy)=3P+3Q.
\]

The rational legs are ramified; they are not the final etale maps.

The [exact local realization theorem](A9_TWO_POINT_COVER_WITH_EXACT_WILD_LOCAL_FIELD.md)
gives a connected Galois cover r:R to P1, of degree q, branched
only at zero and infinity. At zero it is tame of index 16. Its
completed extension at infinity is exactly

\[
 r=t^4,\qquad v^5-v=-t^9,                         \tag{1}
\]

of degree 20 and different exponent 55. Its global group Gamma has
a normal abelian 2-subgroup with quotient A9, so it has no quotient
F20=AGL_1(5). That theorem uses the explicit alternating cover of
[Muskat–Pries, Notation 4.7 and Theorem 4.9](https://arxiv.org/pdf/0908.2140),
an order-nine symmetry to determine its exact completion, and a
cyclic-sixteen cover over its full zero fiber. Matching only inertia
orders and jumps would not suffice here.

## 2. The actual endpoint fields and the necessary sign

Take X and Y to be copies of R. On X set x=-r; on Y set y=r.
Embed their Galois fields K'/k(x) and L'/k(y) in a separable closure
of M, and put

\[
 M'=M K' L',\qquad Z=\text{the smooth projective model of }M'.
\]

At the y-pole of the seed, (1) contains its local degree-five field
by y=t^4 and x=t^(-5)v. At the x-pole use instead

\[
 x=-t^4,\qquad y=-t^{-5}v,\qquad v^5-v=-t^9.    \tag{2}
\]

Substitution in each case gives x-y=(xy)^5. Without the x-sign
twist the local equation would be v^5+v=t^9, a different extension
over the fixed base. Thus (2) is essential, not a convention to omit.

The seed's global normal closures over either rational endpoint
have group F20. The same displayed substitutions give these
closures; adjoining t and the Artin–Schreier root has degree 20,
and the group acts faithfully as C5 semidirect C4 on the five roots.

## 3. Linear disjointness and corelessness

Each of M/k(x), M/k(y) has prime degree five. A normal base
extension such as K'/k(x) either leaves that degree-five extension
linearly disjoint or contains its full normal closure. To verify
this, take a common finite Galois closure: the normal subgroup
fixing K' has equal-sized orbits on the five embeddings of M.
They have size five or one. Size five is linear disjointness;
size one fixes every conjugate of M and puts its normal closure
inside K'. The latter would give an F20 quotient of Gamma, which
is impossible. The y-leg is identical.

Now M'/M is finite Galois. Its group G preserves K' and L', since
these fields are normal over the rational endpoint fields. By
the disjointness just proved its restrictions to both endpoint
Galois groups are surjective. Consequently, for E=K' intersect L',

\[
 E^G=(K')^G\cap(L')^G=k(x)\cap k(y)=k.
\]

Every element of E is algebraic over E^G, using its finite orbit
polynomial. Since k is algebraically closed, E=k. This proves
corelessness on the actual new source, not merely on the seed.

## 4. Both new maps are etale everywhere

Over P, the x-endpoint completion contains the seed's degree-five
completion, with relative tame degree four. The y-endpoint is
tame of degree sixteen over y=0, while the seed has tame degree
four there; its compositum over the seed also has degree four.
These are the SAME local extension: in a fixed separable closure
of k((u)), there is a unique tame extension of degree four.

The argument reverses at Q. At O both endpoint extensions induce
the unique tame degree-sixteen extension. Outside O,P,Q all
extensions in question are locally unramified. Thus their local
compositum adds no ramification over either endpoint completion.
All maps are separable and all residue fields are k. The finite
maps Z to X,Y are therefore etale. Connectedness and smooth
projectivity follow from constructing Z as the model of the field
M', rather than treating a disconnected product as a curve.

## 5. The shared exact form and uniqueness

Set alpha_X=dx=-dr on X and alpha_Y=dy=dr on Y. They agree on Z
because dx=dy in M. At an endpoint point over zero, the differential
has order 16-1=15. At infinity it has order 55-2*20=15, by the
different formula. Elsewhere its order is zero. It is nonzero and
exact, so Cartier kills it. In particular

\[
 2g(R)-2=15\left(q/16+q/20\right)=27q/16>0.
\]

Declaring alpha horizontal defines a regular dormant connection on
omega: locally alpha=u^(15m)a(u)du, with a a unit, and its connection
form is -dlog(a). All rational horizontal forms are fifth-power
multiples of alpha, hence exact. This is a Tango structure, and
the two pulled-back connections agree.

For uniqueness, the difference beta of two compatible regular
dormant connections is a shared holomorphic Cartier-fixed form.
The ratio beta/alpha lies in the intersection of the endpoint
fields, so beta=c alpha. But C(c alpha)=0 while C(beta)=beta.
Hence beta=0. The pair is unique, as asserted.

## Strategic consequence

Both the logarithmic quartet and the exact singleton are genuinely
realized by coreless projective etale correspondences. The
[zero/one/four classification](COMPATIBLE_TANGO_STRUCTURES_SINGLETON_OR_QUARTET.md)
remains correct; it cannot be used as a nonexistence argument.
The separable Cartier-type stability theorem also remains correct:
the new construction is not a separable domination of an Igusa
quartet through coreless etale spans. Its starting rational legs
are ramified and its type was already exact.

The former all-degree Tango reduction still preserves its stated
data, but that data is now proved insufficient to contradict
corelessness. A further universal strengthening should not be
proposed merely to exclude this example. Any renewed obstruction
must retain additional information from the actual candidate curves
and justify why that information survives the needed constructions.
