# Proof: tame specialization, Frobenius orbits and elliptic quotients

## 1. Tame specialization

In Wewers's notation, let (X,D) be a smooth marked curve over a complete
Noetherian local ring R, with special fiber (bar X,bar D). Reduction
of tame covers Y->(X,D) to bar Y->(bar X,bar D) is an equivalence of
categories:
[Wewers, Deformation of tame admissible covers of curves,
Corollary3.1.3, p265](https://www.uvm.edu/~cvincen1/files/teaching/wewers.pdf#page=29).
For a mixed-characteristic DVR, his
[Proposition4.3.3, p277](https://www.uvm.edu/~cvincen1/files/teaching/wewers.pdf#page=41)
gives the surjection from the geometric generic tame fundamental group
to that of the special fiber.

Apply this to X=P1_W(k) and a fixed lift of the ordered branch points.
Pulling finite permutation representations back along that surjection
is fully faithful: their images and intertwining maps are unchanged.
Tame local parameters preserve inertia orders and cycle types. The
characteristic-zero branch-cycle description therefore gives the stated
injection and preserves centralizers and block systems. The monodromy
group itself may have order divisible by p. This is a statement about
covers of one fixed marked target.

Over an arbitrary characteristic-zero field, each finite collection
of covers descends to a finitely generated field that embeds in C;
the complex census bounds are therefore unchanged.

If the marks are F_q-rational, q-Frobenius permutes the finite set of
characteristic-p cover classes. Forgetting the map is equivariant,
so every cover orbit above C has length divisible by the moduli orbit
length of C. In a Frobenius-stable part the latter is therefore at most
the complex census bound. No Frobenius-equivariant choice of complex
lifts is required.

For the decorated bound, an isomorphism f^(q^j)~f first forces s|j.
Write j=sl. The displayed F_(q^s) model identifies the sources, so the
cover isomorphism is an automorphism of C carrying d^(q^(sl)) to d.
Hence q^(sl)-Frobenius fixes [d] in D(C)/Aut(C), and h|l. The orbit
bound is sh. Passing to automorphism orbits removes any need to assume
that source automorphisms fix the individual decorations.

## 2. Complete (3,4,4) census

Hurwitz gives degree12. Normalize the ordered branch values to
(0,1,infinity), with the index-three value first. The complex classes
are transitive permutation triples of types (3^4,4^3,4^3), product1,
up to simultaneous conjugacy.

| Monodromy order | Cover classes | Deck group order |
|---:|---:|---:|
|12|1|12|
|24|1|2|
|36|1|6|
|96|1|2|
|576|3|2|
|1320|1|1|
|15552|2|1|

The [native verifier](../../../scripts/orbifolds/verify_triangle344_monodromy.cpp)
fixes a=(123)(456)(789)(10,11,12), generates all
12!/(4^3*3!)=1,247,400 permutations b of type4^3, and retains the11,178
with ab of type4^3 and transitive <a,b>. Fixing the least unused letter
in each four-cycle and enumerating all orientations visits each b once.
It then takes orbits under the full centralizer C3 wr S4 of a, generated
by the four cycle rotations and adjacent block swaps. Its order is1944.
Orbit-stabilizer gives the deck orders; closure under a,b gives the
monodromy orders.

Since p>=5, this is an upper bound for the tame characteristic-p
classes in each monodromy-order part. Section1 and a moduli orbit of
length at least three leave only the part of order576.

## 3. The surviving classes have elliptic double quotients

For each of the three order576 representatives, the verifier finds
a preserved partition into six pairs. It tries {1,j}, 2<=j<=12, and
closes its images under a,b; success means six disjoint pairs. Its
emitted representatives preserve

    {1,5}, {2,6}, {3,4}, {7,11}, {8,12}, {9,10}.

On these blocks the inertia cycle types are (3,3), (4,2), (4,2).
For the actual Galois closure W of the assumed cover, let H be a sheet
stabilizer and J its pair-block stabilizer. Then H<=J, [J:H]=2, and
the invariant fields give

    C=W/H -> E=W/J -> P1,    degrees 2 and 6.

The quotient cycles and tame Hurwitz give
2g(E)-2=-12+4+4+4=0. The involution of C->E is nonhyperelliptic;
together with the central hyperelliptic involution it gives |Aut(C)|>=4.
Norm and pullback give the elliptic factor of J(C).

The [backup branch-set argument](../../curve_arithmetic/backup_curve_arithmetic.md#2-branch-set-rigidity)
gives Aut(C_alpha)=C2 and moduli Frobenius orbit3, so it excludes this
profile without Jacobian arithmetic.

## Reproduction

```sh
c++ -std=c++17 -O2 scripts/orbifolds/verify_triangle344_monodromy.cpp -o /tmp/triangle344
/tmp/triangle344
```

This regenerates the complete census and verifies all three pair-block
quotients. The [backup cored theorem](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_cored_span_exclusion.md)
uses this profile exclusion.
