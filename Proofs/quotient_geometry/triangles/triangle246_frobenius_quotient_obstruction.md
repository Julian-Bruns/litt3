# Proof: complete small census and actual intermediate quotients

Version1, 2026-09-09. The user supplied Pro's successful degree-24 proof
and Python source. /root read the whole source, executed it, added direct
checks of all four degree-12 inner fibers, and independently implemented
an UNPRUNED C++ enumeration. The final four cases reuse our stronger
integral theorem rather than duplicate Pro's rational character proof.

## 1. Complete census and its geometric scope

The source-checked [one-cover tame-lifting argument](triangle344_frobenius_obstruction.md#1-complete-finite-census-and-its-characteristic-five-use)
injects characteristic-five cover classes into the characteristic-zero
classes with the same labeled inertia. Only inertia, not the whole group,
must have order prime to5. This does NOT lift two unrelated etale maps.

Fix b=(0,1,2,3)...(20,21,22,23). The finite problem enumerates transitive
pairs (a,b), modulo simultaneous conjugacy, where a is a fixed-point-free
involution and ba has type6^4. Label the b-cycles in first-encounter order,
starting at a chosen sheet. Match the least unpaired encountered sheet;
try every unmatched encountered partner and the first sheet of a fresh
b-cycle. All other choices of a fresh cycle are relabelings. If the whole
encountered component is paired before all cycles are reached, it cannot
be connected. This proves completeness of the rooted construction.
Re-rooting at all24 sheets and taking the least code gives exactly the
simultaneous-conjugacy classes, with neither mirror nor branch-label
identifications imposed.

The [Python implementation](../../../scripts/orbifolds/verify_triangle246_monodromy.py)
only prunes a partial ba component when it is already a wrong-length
cycle or has six edges without closing. Neither can extend to a six-cycle.
It reaches339 valid rooted records and40 unrooted classes. Our separately
written [unpruned C++ cross-check](../../../scripts/orbifolds/verify_triangle246_unpruned.cpp)
performs NO partial-cycle pruning:6,130,324 partial matchings,2,450,304
completed matchings. It produces the SAME40 canonical arrays, individually
compared, not just the same count.

A commuting permutation is determined by its image of sheet0. Propagating
all24 possible images under a,b gives the complete deck group. A nontrivial
deck transformation fixes no unramified point. On a branch fiber, its
fixed points are precisely the inertia cycles it preserves setwise.
Thus the following fixed-point counts are actual geometric invariants.

| Deck group / fixed profile (nu0,nu1,nuinf) | Classes | Disposition |
|---|---:|---|
| order greater than2 |23| Aut(C)=C2 |
| C2 with total fixed count2 |6| not the hyperelliptic involution |
| trivial |1| Frobenius orbit |
| C2, (4,0,2) |2| Frobenius orbit |
| C2, (2,2,2) |4| elliptic quotient below |
| C2, (4,2,0) |4| degree-12 factor below |

The checksum sum(24/deck_order)=339 is independently verified. Frobenius
preserves each displayed part, since the branch labels are0,1,infinity.
A cover above a curve of moduli orbit at least3 must have at least3
distinct Frobenius-conjugate covers. Hence parts of size1 or2 cannot
contain our C. This excludes32 classes without Jacobian arithmetic.

## 2. The four (2,2,2) cases: a branch-parity elliptic quotient

The deck involution has six fixed points and is hyperelliptic. For EACH
of the four representatives, the checker quotients by its pair orbits,
then verifies a preserved partition into three blocks of four. They are
actual monodromy block systems of the assumed cover and therefore give
actual intermediate fields:

           C --2--> P1_x --q,4--> P1_s --phi,3--> P1_t.

The middle curve has genus zero since it is a separable quotient of P1_x.
The complete checked fiber data are, at five distinct s-points,

       phi*(0)=a+2e,   phi*(1)=d+2b,   phi*(infinity)=3c;

q has type(2,1,1) over a,b,c, type(4) over d, and type(1,1,1,1)
over e. These statements are obtained by dividing each inner inertia
cycle length by its outer cycle length; every cycle is checked.

Multiplication of ramification indices forces the six simple points in
the fibers over a,b,c to be precisely the Weierstrass points of C.
The double points and the unique point over d are not Weierstrass.
Put d=infinity and its unique q-preimage at x=infinity. Then q is a
degree-four polynomial. For H(s)=(s-a)(s-b)(s-c), the function H(q(x))
has odd valuation exactly at the six Weierstrass points; all other zeros
have even order, and its pole has order12.

Two quadratic extensions of k(x) with the same branch divisor coincide:
the ratio of defining functions has even divisor, which is a square
since Pic0(P1)=0 and k is algebraically closed. Therefore

             k(C)=k(x,sqrt(H(q(x)))).

This contains k(s,sqrt(H(s))), the function field of a smooth genus-one
curve E. The extension has degree4, since [k(C):k(s)]=8 and
[k(E):k(s)]=2. Thus C has the asserted actual degree-four elliptic map.

## 3. The four (4,2,0) cases reduce to an existing theorem

In each of these cases the checker constructs a coloring of the24 sheets
with two blocks of size12. The generator a preserves the blocks; b
interchanges them. Thus the actual map factors as

                     C --g,12--> P1_s --rho,2--> P1_t,

where rho is branched exactly at1,infinity. The checker directly verifies
the four complete branch fibers of g: a on BOTH blocks gives2^6;
b² on one block gives2^6; (ba)² on that block gives3^4. There is no
other ramification, since the original cover has none. Therefore g has
precisely the uniform four-point profile(2^6,2^6,2^6,3^4).

Apply [quadrangular_genus_two_hecke_obstruction](../../../Theorems/quotient_geometry/triangles/quadrangular_genus_two_hecke_obstruction.md).
It already proves that this ACTUAL map gives an INTEGRAL, Rosati-symmetric
T in End(J(C)) with T²=[5], from an actual degree-five bi-etale self-span.
We need neither a new character calculation nor division by5 here.
The supplied Pro proof alternatively constructs (1+sqrt5)/2 in End0;
our existing integral correspondence result is stronger and shorter.

For C_alpha the [arithmetic theorem](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md) gives End0(J(C_alpha))
a quartic CM field with Rosati-fixed part Q(sqrt21). This cannot contain sqrt5.
Its geometric simplicity also excludes the elliptic quotient in Section2.
Hence all40 cases are excluded, over the full algebraic closure.

## Reproduction and exact scope

```sh
c++ -std=c++17 -O2 scripts/orbifolds/verify_triangle246_unpruned.cpp -o /tmp/triangle246
python3 scripts/orbifolds/verify_triangle246_monodromy.py --native /tmp/triangle246
```

The [saved execution](../../../Research/computations/triangle246_verification.txt)
took0.472 seconds for BOTH enumerations and all quotient checks; the
unpruned portion alone took0.113 seconds. Omitting --native performs the
complete pruned enumeration in about0.08 seconds. No coefficient-field
sampling, group database, or generic polynomial solver is used.

This supplies the degree24 row of the
[complete backup cored theorem](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_cored_span_exclusion.md).
The census has been replayed; no independent whole-proof audit is claimed.
