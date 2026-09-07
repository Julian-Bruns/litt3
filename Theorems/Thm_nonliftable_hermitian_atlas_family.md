# Actual nonliftable Hermitian atlases in genus two and unbounded genus

In characteristic five, put

    H: X^6+Y^6+Z^6=0,
    C: v^2=u^6+u^3+1,
    Q: z^2=1-w^6,
    G=(C3 x C3) semidirect C3 <= PGU_3(5),

where G is generated projectively by diag(zeta,1,1),
diag(1,zeta,1), and cyclic permutation of the three coordinates.
Here zeta is a primitive cube root of unity.

There is an ACTUAL connected smooth projective curve T of genus28 and
finite etale maps

    T -> C of degree27 with Galois group G,
    T -> H of degree3 with Galois group C3,
    T -> Q of degree27 with Galois group (C3)^3.

Both C and Q have genus2. The curve C is ordinary, while every regular
differential on Q and on H is Cartier-zero. These endpoints ALREADY
occur in `cubic_genus_two_common_covers`, which gives them a smaller
degree-three common cover. The new information here is the explicit
Hermitian presentation and its nontrivial cubic character, not the
existence of an ordinary/superspecial common-cover example.

The G-equivariant map T->H gives an actual atlas C->[H/PGU_3(5)] with
full geometric monodromy G. It DOES NOT lift to [H/PSU_3(5)]: its cubic
character line tau is nontrivial. This does NOT claim that C has no
OTHER atlas to [H/PSU_3(5)].

More generally, pull this atlas back along any connected finite etale
cover C'->C of degree d prime to3. The resulting atlas still has full
monodromy G and nontrivial tau, and g(C')=d+1. Such covers exist for
every d=2^r. Thus nonliftable atlases exist in genus9 and in unbounded
genus with3 not dividing g-1. ALL these examples have nonsimple
Jacobians: C has an elliptic quotient, which pulls back through C'->C.
Thus they do not meet the absolute-simplicity condition on the fixed X,
and do not refute a theorem that genuinely uses that additional condition.

The construction uses the SAME tame root stack in both legs:

    [H/G] = P1(3,3,3,3), branch points {0,infinity,1,-1}.

The two cyclic degree-three atlases are explicitly

    C: u^3=t(t-1)/(t+1),
    Q: w^3=t/(t^2-1).

Their smooth projective models are the equations above. T is the
normalization of H x_(P1) C, equivalently the fiber product over this
root stack. Connectedness and etaleness are proved, not inferred only
from equal genera or numerical ramification profiles.

Version2, author proof,2026-09-07; no independent audit claimed. The
known smaller common-cover example is referenced instead of re-promoted.
[Proof](../Solutions/Sol_nonliftable_hermitian_atlas_family.md).
