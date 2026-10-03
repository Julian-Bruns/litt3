# Proof: quotient different parity and uniform-fiber recognition

[Statement](../../Theorems/cartier_and_spin/actual_spin_ramified_parity_and_mixed_fibers.md).
No new computation. Keep both original actual maps onT. The accepted
[spin table](../../Theorems/cartier_and_spin/actual_spin_image_etale_factorization.md)
and the completed elliptic-image exclusions leave, in the higher-genus
ramified case, exactly one full q-fiber with tame index2. All other
points ofφ are unramified.

## The inertia order divides the actual normalization degree

Put G=Gal(T/Y), H=G/K, and B=Γ/H. The mapT→Γ is G-equivariant and
G acts freely onT. For z∈Γ, its inverse-image fiber has total weighted
multiplicity κ. The stabilizer G_z acts freely on its geometric points
and preserves their local φ indices. Every orbit therefore contributes
its cardinality |G_z| times an integer to κ. Hence |G_z| dividesκ.
The inertia group I_z ofΓ→B is G_z/K; its order also dividesκ.

Degrees in the ACTUAL field tower give deg(Y→B)=κ/k. The mapY→B is
separating; no simultaneous Galois closure is used in this tower.

## Odd degree contradicts the parity of the global different

Suppose κ odd. Every I_z has odd order, so all its ramification
subgroups have odd order. The local Galois different formula
δ_(Γ/B)=Σ_j(|I_j|−1) is therefore EVEN, including wild inertia.

For t∈T, write y=q(t), z=φ(t), b∈B. Because q is étale over the
algebraically closed ground field, completed local fields ofT andY
at t,y are isomorphic. The tower throughΓ consequently gives
δ_(Y/B)(y)=δ_φ(t)+e_φ(t)δ_(Γ/B)(z).
At y=P this integer is odd: δ_φ=1 and e_φ=2. At every other point
ofY it is even: δ_φ=0 and e_φ=1. Thus the global different ofY→B
has odd degree. Hurwitz gives its degree as
2g(Y)−2−deg(Y/B)(2g(B)−2), an EVEN integer. Contradiction.

Therefore κ is even. This argument does not assume that the faithful
deck action onΓ is tame.

## A uniformly ramified target fiber is impossible here

First suppose ALL target fibers containing ramification are uniformly
ramified: every point in such a fiber has index2. Let π:Z→T be the
geometric Galois closure ofφ. Tame local extensions over an
algebraically closed residue field are cyclic and determined by their
index. Uniform index2 makes the closure's local inertia order2 at each
branch value and gives local index1 forπ at every point. Away from
branch valuesπ is unramified too. Hence π is an ACTUAL finite étale
cover ofT.

Choose any original h:T→X and its infinity section u onM. Its divisor
satisfies h*O=φ*div(u). OnZ the pullback θ=h*θ_X has divisor
16π*h*O; because π is étale and u descends toΓ, this divisor is
invariant under every deck automorphism σ ofZ→Γ. Therefore σ*θ/θ
is a global unit on the proper connectedZ, hence a constant.

The accepted actual theta-recognition theorem gives
hπσ=γ hπ, γ∈Aut(X)=C3. For a nonidentity branch inertia elementσ
of order2, applying the equation twice makes γ²=1; thus γ=1.
It follows thatσ is an automorphism overX of the ACTUAL étale map
hπ:Z→X. An automorphism of a connected finite étale cover fixing a
point is the identity. But branch inertiaσ fixes a point and is
nonidentity. Contradiction.

The ramification set q*P is one G-orbit. Its target image is therefore
one H-orbit, and all target branch fibers have the same weighted
ramification profile. Thus if ONE branch fiber were uniform, ALL
would be uniform and the preceding contradiction applies. Every
branch fiber must instead contain an unramified sheet. In degree2
that is impossible, so κ≥4. This also shows that the actual Galois
closure π is ramified over an unramified sheet of such a mixed fiber.

## The first surviving degree gives two actual quartic profiles

For κ=4, k|κ and k=1or3 give k=1. A mixed fiber with some index2
has the unique profile(2,1,1). Its stabilizer G_z fixes the unique
ramified point, and freeness onT makes that stabilizer trivial.
Consequently Γ→B is unramified at every image of the ramification
orbit. The corresponding fiber ofY→B has profile(2,1,1), and is
the ONLY such branch fiber because q*P lies over one pointP ofY.

At every other z, φ has four unramified points. Its stabilizer acts
freely on them and has order dividing4. Thus the remaining branch
fibers ofY→B have profile(2,2) or(4); no wild inertia occurs here.
Hurwitz with g(Y)=2 and degree4 gives g(B)≤1. Genus1 would supply
a degree4 elliptic map fromY, excluded for MAIN by the accepted
small-map theorem and for BACKUP by its accepted simple Jacobian.
Therefore B=P1 and the total different is10.

Writing A for the number of(2,2) fibers and C for the number of(4)
fibers gives 1+2A+3C=10. Its nonnegative integer solutions are
(A,C)=(3,1) or(0,3), exactly the two stated profiles.

No rational-function realization of either profile is asserted. The
entire original same-source problem remains open.
