# Proof: canonical norm, free stabilizers and residual torsion

[Statement](../../Theorems/cartier_and_spin/actual_spin_different_norm_residual_torsion.md).
Use the genuine G-linearization onN and invariant different section s,
as constructed in the [quartic trace proof](quartic_mixed_spin_normalization_exclusion.md).
Its construction uses the actual canonical isomorphism L¹⁶=ωT and the
equivariant differential map; it applies in every normalization degree.

## The one ramification orbit determines all multiplicities

The ramification points q^-1(P) form one FREE G-orbit. For a fixed
image z∈Γ, the ramification points over z therefore form one free
orbit of its stabilizer G_z. There are r=|G_z| of them, each of
φ-index2. The remaining points have index1, and the same stabilizer
acts freely on them. They form u free orbits, for some u≥1 by the
accepted mixed-fiber theorem. Hence κ=2r+ru. The group kernelK is
contained inG_z, so k|r. All ramified target fibers have this same
profile because their target points form one G/K-orbit.

Quotient the actual maps byG and its effective action onΓ. Over the
corresponding point ofB the ramified orbit gives the single Y-pointP.
The u other free stabilizer orbits give u distinct Y-pointsQj, none
equal toP. Since q is étale and Γ→B has local inertia r/k, the local
indices ofY→B are 2r/k atP and r/k at everyQj. Thus its scheme fiber
is (2r/k)P+(r/k)ΣQj. (When k=1 this is 2rP+rΣQj.)
No claim that Y→B is itself an étale atlas is made.

## A norm ratio descends as a function with an exact divisor

The norm of s is a section n=Norm_φ(s) of N^κ. Its divisor is
φ_*div(s): it has order r at each ramified target value and no other
zeros. This is the norm divisor formula for a finite flat map of
smooth curves; all residue degrees are one. It is a nonzero section
because the separating function-field norm of a nonzero element is
nonzero.

Both n and s are invariant for their genuine G-linearizations, so
\[
F=\frac{\varphi^*n}{s^\kappa}
\]
is an invariant rational function onT. It descends through the ACTUAL
G-torsor q to f∈k(Y). At a ramified point t its order is 2r−κ=−ru.
At an unramified companion over the same target value its order is r.
There are no other zeros or poles. Quotienting the preceding free
orbits by q gives exactly div(f)=rΣQj−ruP.

Mixedness gives u≥1, so this function is nonconstant. Its degree is
ru=κ−2r. The exact divisor supplies both the pointed nongap and the
claimed r-torsion class. This is not merely a norm line-bundle identity:
the ratio is formed from the original different section onT and
descends by its actual invariant G action.

## Degree six gives five tame coarse quotient profiles

At κ=6, the positive divisors r ofκ satisfying κ≥3r are r=1,2.
Consequently k=1. If r=2 then u=1 and div(f)=2Q1−2P. A genus-two
curve has a unique degree-two pencil, its hyperelliptic one. Both
fibers here are double points, so P,Q1 are distinct Weierstrass points.

The actual coarse quotient map Y→B has degree6. All Γ-action inertia
orders divide6, by the free weighted-fiber argument, so the action
is tame in characteristic five. Hurwitz gives g(B)≤1. The genus-one
case is excluded for MAIN by the accepted degree-at-most-six elliptic
map theorem and for BACKUP by geometric Jacobian simplicity. Thus
B=P1 and the total different is14.

The unique special fiber has type(2,1,1,1,1) whenr=1, and(4,2) when
r=2. Every other branched fiber is uniform, because φ is unramified
there and inertia acts freely on its six-point fiber. Their types are
(2,2,2), (3,3), or(6), with different contributions3,4,5.

For r=1 their counts A,C,D solve3A+4C+5D=13. The three solutions are
(3,1,0), (0,2,1), (1,0,2). For r=2 they solve3A+4C+5D=10 and give
(2,1,0), (0,0,2). These are the FIVE complete necessary profiles.
This bookkeeping does not decide any remaining degree-six source.

The actual T and both original endpoint maps are preserved throughout.
There is no computation and no unmarked common-cover conclusion.
