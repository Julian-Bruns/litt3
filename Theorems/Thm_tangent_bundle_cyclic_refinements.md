# Tangent bundles and controlled cyclic refinements

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of characteristic5. Use the
[connection conventions](../Definitions/Def_projective_connections.md).
An admissible active connection means that its nonzero nilpotent
p-curvature is nowhere zero; it need not be ordinary.

## 1. Bundles representing the actual tangent defects

For a regular dormant connection r there is a stable rank2 bundle V_r
on C^(1), of degree2g−2, with

    H^0(C^(1),V_r)=T_dorm(C,r).

Explicitly, V_r=ker(F_*Bol_r), where Bol_r(v)=v''−r v maps regular
quadratics to regular quartics. Its Frobenius pullback is the first-jet
bundle J^1(omega_C²) with its dormant scalar connection.

For an admissible active r let pi:C_s→C be its canonical double torsor,
INCLUDING the split torsor, and q its tautological quadratic. Set

    E_r=pi^(1)_* V_(pi^*r+q).

This is a rank4 bundle of degree4(g−1), with

    H^0(C^(1),E_r)=T_nil(C,r).

Both constructions commute with actual finite etale pullback, also
when a connected canonical double becomes split. In particular, for
an actual connected cyclic cover h:T→C of degree prime to5, let
Lambda⊂J(C^(1))(k) be the character lines of h^(1)_*O_(T^(1)). Then

    dim T_*(T,h^*r)=sum_(L in Lambda) h^0(C^(1),B_r tensor L), (1)

where B_r is V_r or E_r and * is dormant or nilpotent respectively.
No ordinary-pullback assumption or Galois closure of a two-leg span
enters this equality.

## 2. Explicitly bounded choices adding no new defects

Fix n_d dormant connections and n_a admissible active connections on C.
For each active r assume the bad-character locus
{L:h^0(E_r tensor L)>0} is PROPER; zero nilpotent defect on C suffices.
No such hypothesis is needed for dormant r: stability and Raynaud's
rank-two theorem make its theta locus proper automatically. Put R=2n_d+4n_a.
For EVERY prime ell!=5 with

    ell+1>gR,                                                (2)

there is a connected cyclic etale cover T→C of degree ell preserving
the EXACT tangent dimension of EVERY connection in the family.
In particular, zero defects remain zero when they were zero on C itself,
not just on an earlier endpoint below C. This does not assert that
every cyclic cover of that degree works. It holds over any
algebraically closed field of characteristic5, without simple Jacobians.

For the backup curve, the proved five-dormant/85-active saturation gives
R=350 and gR=700. Thus every prime ell>699 admits such a common good
choice for all90 connections, conditional only on that established
counting packet, not on the unfinished atlas certificates.

## 3. Arbitrarily large defects, with primes prescribed to be absent

Now assume k=bar(F_5) and J(C) geometrically simple. For ANY finite
family as in Section2, WITHOUT a zero-defect assumption, and any finite
set S of primes containing2 and5, there is a nested tower C_j→C with
cyclic composites and pairwise coprime successive degrees>1, all avoiding S,
such that each specified connection r satisfies

    dim T_*(C_j,r_j)>=dim T_*(C,r)+j.                        (3)

The degrees need not be prime, and their prime supports cannot be fixed
in advance. The assertion follows more generally whenever each relevant
bad-character locus is the whole Jacobian or has a positive-dimensional
irreducible component generating it; simplicity is a sufficient condition.

These opposite choices are consistent: (2) chooses good cyclic subgroups,
while (3) deliberately chooses subgroups containing bad characters.

## 4. Both actual legs survive the bad refinements

Given an ACTUAL bi-etale span X←Z→Y, with simple endpoint Jacobians over
bar(F_5), finite families on BOTH endpoints, a prescribed connected etale
refinement Z_0→Z and a finite avoided prime set, there is a nested tower
of connected CYCLIC etale refinements Z_j→Z_0, all avoiding that set,
on which every endpoint connection has tangent defect at least j.
Both maps from the SAME Z_j to X and Y remain finite etale.

The refined spans need not be jointly minimal or coreless. This is a
boundary to ordinary-source arguments, NOT a counterexample to an
ordinary-minimal-source assertion and NOT a common-cover exclusion.
Nothing here supplies compatible connections on two given endpoints.

Version2,2026-09-08: the good-choice conclusion preserves exact defects,
not only zero defects; for dormant objects the extra properness hypothesis
is eliminated by the rank-two theta theorem. Author proof; no audit claimed.
[Proof](../Solutions/Sol_tangent_bundle_cyclic_refinements.md).
