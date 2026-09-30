# Proof of middle-character correction rigidity

Use the [statement](../../Theorems/cartier_and_spin/middle_character_correction_rigidity.md).
The returned [report](../../../litt3-computation-data/remaining_structural_replies_20260925/extracted/character/middle_character/REPORT.md)
retains the original gluing equations, all coefficient conventions,
complete Hom spaces and exact data. The original archive has112
verified manifest entries. All14 source files are retained byte for
byte in [character](../../scripts/arithmetic/pro_remaining_structural_20260925/character/).

## Complete rather than restricted Hom equations

Put b=(a1^25,...,a5^25,b1^25,...,b5^25), c=(c1^25,...,c6^25).
These are independent geometric coordinates; they equal the original
coordinates only at the explicitly labelled F25 points. For maps to K,
eliminating the235 auxiliary coefficients by a fixed invertible row
transformation gives the full80-by-35 pencil T(b,c). The35 columns
are all23 lower f coefficients and all12 correction coefficients.
For maps to L the analogous full pencil Q(b,c) has size43-by-16.
Thus the Hom dimensions are35-rank(T) and16-rank(Q), without a
character restriction in either rank test.

Only after constructing these full pencils, restrict the specified
map vector to f=yp. A constant invertible row transformation reduces
its equations to67 independent rows. For
s=(p0,...,p7,A0,...,A6) and d=(d0,...,d3), they are
\[
H(b)s+\gamma E(c)=0\quad(30),\qquad
J(c)s+G(b)d=0\quad(23),\qquad
\gamma Sb+D(c)d=0\quad(14).
\]
All off-block coefficients vanish identically. The constant14-by-10
matrix S is injective. The f-only equations, obtained by annihilating
all correction columns, include B(p)b=0 and C(p)c=0 of sizes10 and6.
Their source column spaces are disjoint; no cancellation between
these conditions is assumed away.

## Removing the unmatched corrections

Multiplying each of the14 equations D(c)d=0 by each of the6 c-coordinates
gives84 equations on the84 monomials c_i*c_j*d_l, i<=j. Their constant
coefficient matrix has a retained exact two-sided inverse. Consequently
c nonzero and D(c)d=0 imply d=0 over every extension field.

Suppose gamma nonzero and b nonzero, and scale gamma to1. Invertible
constant row operations in the last14 equations express all10 b
coordinates bilinearly in c,d and leave4 further bilinear conditions.
Both c and d must then be nonzero. Combining these relations with
B(p)b=0 and C(p)c=0 produces a66-by-32 pencil N(c) annihilating
the nonzero vector p tensor d.

The returned certificates prove N(c) injective for EVERY c nonzero.
They cover the six disjoint projective strata whose first nonzero
coordinate is set to1. On each, explicit polynomial combinations of
the rows produce32 independent constant vectors. These identities
prove full rank after every geometric specialization, including all
rank-drop boundaries. The independent checker verifies membership
identities, not the correctness or completeness of a claimed Groebner
basis. This contradiction gives gamma=0 when b nonzero. If b=0,
the first group is gamma*E(c)=0; its30-by-6 coefficient matrix has
an explicit left inverse. Since the source is nonzero, c is nonzero,
and gamma=0 also here. No stability or Hom-dimension condition is
needed for this part.

If c is nonzero, the84-by-84 identity now forces d=0. If c=0 and
d were nonzero, the equations separate: the correction-only vector
(f=0,alpha=yd) is itself a full map-kernel vector. The auxiliary
reconstruction is unique, so this is a genuine global map, independent
of the given map with f nonzero. It contradicts the one-dimensional
Hom-to-K condition. This proves correction rigidity.

## The closed source boundary

With the correction reduced to A(x), H(b)s=0 is necessary. The
seven first-nonzero-coordinate strata of b with indices3 through9
cover exactly b nonzero with b0=b1=b2=0. The retained polynomial
membership identities produce15 independent constant rows on every
stratum. Hence s=0 there. This contradicts f nonzero. If b=0, the
previous pure-v theorem excludes the requested window separately.

The six N certificates and seven H certificates are complete. The
four other large membership lists in the archive are unfinished.
Their identities also replayed correctly, but they provide no
exclusion on the three remaining H strata and are never used above.

## Exact remaining incidence

After these reductions the middle-character window is exactly the
existence of a stable source and nonzero s with
\[
(b0,b1,b2)\ne0,\quad(p3,p4,p5,p6,p7)\ne0,\quad
H(b)s=0,\quad J(c)s=0,\quad
\operatorname{rank}T(b,c)=34,\quad\operatorname{rank}Q(b,c)=16.
\]
The first two equations have30 and23 rows. The tensors are in
data/residual_system.npz in the retained archive, and the report
reconstructs them from the actual Laurent transition. Stability is
the supplied exact fiber-generation test, not a test at finitely
many rational points. A rank drop of H alone would not establish
this remaining incidence or a strict Frobenius return.

## Local replay and a verifier packaging correction

The original default verifier failed at its final reconstructed JSON
comparison because that comparison was outside the TemporaryDirectory
context. Every earlier tensor comparison had passed. The
[local replay driver](../../scripts/arithmetic/replay_middle_character.py)
moves exactly that one check inside the context, in memory, leaving
the incoming source unchanged. No mathematical check is skipped or
weakened. It then runs the remaining original verifiers unchanged.

The corrected full replay, including all13 completed certificate
checks, diagnostic map reconstruction, unfinished-checkpoint membership
and the continuation bridge, passed. The logs are
[original failure](../../../litt3-computation-data/remaining_structural_replies_20260925/local_checks/character_proved.log)
and [complete corrected replay](../../../litt3-computation-data/remaining_structural_replies_20260925/local_checks/character_corrected_replay.log).
The diagnostic maps have Hom dimensions7 and4 and generic rank1;
they remain explicitly disqualified examples.
