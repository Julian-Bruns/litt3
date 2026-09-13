# Proof: one Witt digit per actual adjacent map

[Statement](../../../Theorems/deformations/cyclic_descent/neutral_dihedral_height_translation.md).
Author /root,2026-09-11. This is a direct finite-level corollary;
the returned scalar computation is not a dependency.

## Increasing the height

All adjacent maps T_(j+1)→T_j have degree5 and are defect-neutral,
by neutral_dihedral_towers. Given any compatible W_N extension
of T_j, lift the ORIGINAL adjacent finite etale cover over it.
Choose an arbitrary smooth next lower curve extension and lift
that cover. Its next upper obstruction class is a pullback of
the lower class and vanishes by the actual neutral-degree-five
obstruction theorem. A new upper curve digit kills its representative,
and the prescribed Hodge line then lifts uniquely with the full tuple.
Thus T_(j+1) has some compatible extension through W_(N+1).

Iterating gives H(T_a)>=H(T_1)+a-1, including the interpretation
of infinite supremum. The last repair may abandon the adjacent
map at the last digit; no simultaneous diagram is asserted there.

## Descending a given sufficiently long extension

Start with a GIVEN compatible W_N extension of T_a, N>=a+2.
Lift its original etale double W_a→T_a. It comes with the actual
involution tau at every available length. The original cyclic5
map W_a→W_(a-1) is defect-neutral, with defect2 on both sides.

Apply the finite version of neutral_galois_witt_descent successively
at n=2,...,N-2. At n=2 the given W4 source descends its given W3
truncation. Once its marked map is recovered, the next n uses the
next source digit to recover the next lower truncation. The result
is a compatible lower W_(a-1) tower through length N-1, together
with the original map from the GIVEN W_a truncation at that length.

The original cyclic deck action lifts along that etale map. It is
normalized by tau: tau*g*tau^(-1) and g^(-1) have the same special
fiber and hence are equal by uniqueness of lifts of automorphisms
on hyperbolic curves (negative tangent H0 vanishes). Therefore tau
descends to the lower quotient. Its tuple descends equivariantly
as well by the actual functoriality and unique prescribed Hodge/
graded identifications, retaining the original flat twist.

Repeat through the a-1 cyclic maps down to W_1. This loses exactly
one AVAILABLE digit at each step, giving W_1 through length N-a+1.
Its descended free involution tau gives the ORIGINAL T_1 through
the same length. Thus H(T_1)>=N-a+1 for every such N.

If H(T_1) is finite this proves H(T_a)<=H(T_1)+a-1; an infinite
H(T_a) forces infinite H(T_1). Together with the upward construction
it proves the formula. No inference from arbitrarily many finite
objects to a compatible inverse system is made.

The first source is already known to admit W3. If its returned
nonzero fourth obstruction is independently established, its exact
height is3 and the formula specializes to H(T_a)=a+2. This use
remains explicitly conditional until the scalar is certified.
