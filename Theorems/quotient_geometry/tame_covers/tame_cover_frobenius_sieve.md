# Tame specialization, Frobenius sieves and (3,4,4) elliptic quotients

Version2. The specialization input is Wewers, Corollary3.1.3 and
Proposition4.3.3; the finite census and quotient deductions below are
author-checked.

Let k be algebraically closed of characteristic p>0, and fix distinct
ordered branch points D on P1_k and a complete tame degree-n profile.
The classes of connected covers of (P1_k,D) inject into the complex
branch-cycle classes with that profile. This preserves the permutation
monodromy group, its centralizer, inertia cycle types and block systems.
Only the inertia orders must be prime to p.

If k=bar(F_q) and the ordered branch points are F_q-rational, partition
the cover classes by geometric invariants preserved by q-Frobenius and
tame lifting. A part containing a cover of C has at least f elements,
where f is the q-Frobenius orbit length of the geometric isomorphism
class of C. Thus a complete complex census with fewer than f classes
in that part excludes it in characteristic p.

A functorial finite decoration can strengthen this bound. Suppose C
has a model over F_(q^s), its moduli q-Frobenius orbit has length s,
and a cover supplies d in an intrinsic finite set D(C). Let h be the
orbit length of [d] in D(C)/Aut(C) under q^s-Frobenius. Then the cover's
q-Frobenius orbit length is divisible by sh. Thus a Frobenius-stable
census part of size less than sh is excluded. This allows automorphisms
to act nontrivially on D(C).

For every prime p>=5, let C/bar(F_p) have genus two and moduli Frobenius
orbit length at least three. Every finite separable tame map C->P1 with
precisely the uniform branch indices (3,4,4) has degree12 and factors
through an actual degree-two map C->E with g(E)=1. Consequently
|Aut(C)|>=4 and J(C) has an elliptic isogeny factor.

In particular this profile is impossible if Aut(C)=C2 or J(C) is
geometrically simple. It is excluded for the characteristic-five
[backup curve](../../../Definitions/backup_genus_two_curve.md) by its
branch-set rigidity alone.

[Proof, sources and exact census](../../../Proofs/quotient_geometry/tame_covers/tame_cover_frobenius_sieve.md).
