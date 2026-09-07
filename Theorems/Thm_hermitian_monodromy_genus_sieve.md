# Fixed-point divisibility restricts nonliftable Hermitian atlases

Let k be algebraically closed. If a finite group G acts freely on a smooth
projective connected curve W and W -> D is G-equivariant and finite etale
of degree m, then

    |G_d| divides m                         for every geometric d in D. (1)

In particular every fixed-point subgroup of G has order dividing m.
If C=W/G and g(D)>1, then m=|G|(g(C)-1)/(g(D)-1).

Let q>2 be a prime power with v_3(q+1)=1, let

    H_q: X^(q+1)+Y^(q+1)+Z^(q+1)=0,
    P=PGU_3(q),                     P0=PSU_3(q).

For an actual representable finite etale atlas C -> [H_q/P], define G<=P
as the stabilizer of a connected component of its pulled-back P-torsor.
If this atlas does not lift to [H_q/P0], then

    v_3(|G|)+v_3(g(C)-1) >= 2+v_3(q-2).                  (2)

Consequently v_3(g(C)-1)>=v_3(q-2)-1. This is a necessary condition,
not existence. The component and BOTH resulting etale maps are retained.

For q=5 and 3 not dividing g(C)-1, (2) forces v_3(|G|)=3. There are only
the following possibilities for this nonliftable atlas:

- G=PGU_3(5); or
- G is contained in a self-polar triangle stabilizer of order216; or
- G is contained in a Hessian subgroup of order216.

In either proper-subgroup case C itself has an actual finite etale atlas
to the corresponding quotient [H_5/M216], of degree24(g(C)-1). These are
tame quotients of canonical degree1/12, respectively the root stacks

    P1(2,3,12),                 P1(3,3,4).               (3)

The second also has the presentation [F/A48], where

    F: X^4+Y^4+Z^4=0,           A48=(C4 x C4) semidirect C3.

Thus in the Hessian case one can instead use a connected common source
R with an actual G'-Galois etale map R -> C and an etale map R -> F,
where G'<=A48 and

    deg(R/C)=|G'|<=48,          deg(R/F)=|G'|(g(C)-1)/2.

This is an exact change of quotient presentation, not a replacement of
the etale condition by arbitrary maps to a lower-genus curve.

For the fixed genus-nine X, the two proper-subgroup targets therefore
require degree192 atlases. Under the explicit AXIOM A18 (all untwisted
atlas systems empty), these three alternatives exhaust PGU atlases of X.
Neither the axiom nor their emptiness is proved here.

Crucial scope: a factorization of X through a smaller quotient does NOT
assert the same factorization for the other curve Y. This result neither
eliminates the small cored common-cover cases nor bridges the coreless
gap. It does not replace the 3-torsion choices by three discrete atlases.

Version2, author proof,2026-09-07; no independent audit claimed. Version2
identifies both signatures and gives the smaller Fermat presentation.
[Proof](../Solutions/Sol_hermitian_monodromy_genus_sieve.md).
