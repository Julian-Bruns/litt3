# Cyclic towers: new ordinarity and the fixed-support boundary

Author proofs and bounded primary-source comparison, 2026-09-05;
not independently audited. These results do not change the fixed curves.

## 1. Existence at a level does not prescribe a tower

[Tamagawa, Lemma1.9, p.145](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/1992BA14A2D63FA076DB39A34EC45E83/S0010437X97000614a.pdf/grothendieck_conjecture_for_affine_curves.pdf)
gives, for genus g≥2 and a prime ℓ≠p, a connected cyclic degree-ℓ^m
étale cover C_m/C with ordinary last new Jacobian factor whenever

    ℓ^m > ((ℓ^(2g)−ℓ^(2g−1))/(ℓ^(2g)−1))(p−1)g.

It neither prescribes lower levels nor ensures compatible choices
for different m. The OWR2023-42 quotation,p.2467, has the same quantifier.
[Raynaud, Theorem4.3.1 and Lemma4.3.5, pp.123–125](https://www.numdam.org/item/10.24033/bsmf.1955.pdf)
similarly selects a degree-ℓ cover with ordinary new part if
ℓ+1≥(p−1)g; it does not assert this for every cover.

The Nakajima/Zhang all-abelian-cover theorem concerns a geometric
generic curve, not an arbitrary fixed ordinary curve over Fbar_p.
See the [prior-art comparison](BOUNDED_ABELIAN_ORDINARITY_PRIOR_ART_AND_SOLVABLE_BOUNDARY.md).
An infinite intersection of finite-level open conditions need not
have an Fbar_5 point.

## 2. The exact criterion for a specified compatible cyclic tower

Put A=J(C^(1)), B_C=F_*O_C/O_(C^(1)) and D=Θ_(B_C)≡(p−1)Θ.
A compatible Z_ℓ-tower corresponds to nested cyclic subgroups

    G_m⊂A[ℓ^m](k), |G_m|=ℓ^m, G_(m−1)=ℓG_m.

The equivalence of étale sites under relative Frobenius transports
these to actual covers of C. The last new Jacobian factor is ordinary
exactly when

    D(k)∩(G_m∖G_(m−1))=∅.                                  (1)

Indeed, the twisted direct image of O is the sum of character lines.
The primitive characters form the new summand, preserved by semilinear
Frobenius, which permutes them by pth powers. Étale base change for B
and projection formula identify its Frobenius kernel with

    ⊕_(L∈G_m∖G_(m−1)) H⁰(C^(1),B_C⊗L).

Injectivity is bijectivity here, equivalent to ordinarity of that factor.
No k-linear identification with relative Frobenius is imposed.

For Δ(C)=g(C)−f(C), isogeny additivity gives
Δ(C_m)−Δ(C_(m−1))=Δ(new factor)≥0. Thus the following are equivalent:
bounded Δ(C_m); eventual ordinarity of every last new factor;
finiteness of D(k)∩⋃_mG_m.
Ordinarity of C says only0∉D, not this avoidance condition.

## 3. Almost every compatible tower is eventually new-ordinary

For every fixed C and ℓ≠p, Haar-almost every compatible cyclic
Z_ℓ-tower satisfies(1) eventually, even after any prescribed finite
initial tower. This is an elementary consequence, not Tamagawa's
stated theorem.

Choose H=3Θ very ample and K=D·H^(g−1)=(p−1)3^(g−1)g!.
For n prime to p,

    #(D(k)∩A[n](k))≤K n^(2g−2).                             (2)

The divisor[n]_*D has numerical class n^(2g−2)D, and its multiplicity
at0 is at least the number of D-points above0, since[n] is étale.
Intersecting with g−1 general H-divisors through0 bounds that
multiplicity by K n^(2g−2). This also handles nonreduced D.

The number of cyclic subgroups of exact orderℓ^m is

    c_m=ℓ^((2g−1)(m−1))(ℓ^(2g)−1)/(ℓ−1).

Each primitive point belongs to exactly one such group. By (2) the
probability that a uniformly chosen group fails(1) is at most

    K(ℓ−1)ℓ^(2g−1)/(ℓ^(2g)−1) · ℓ^(-m).                     (3)

Put normalized Haar measure on primitive vectors of T_ℓA≅Z_ℓ^(2g).
Reduction is uniform on primitive vectors, hence on these cyclic groups.
The probabilities(3) are summable, so the first Borel–Cantelli lemma
(no independence needed) gives only finitely many failures.
A fixed finite prefix is a positive-measure cylinder and retains
the measure-zero exceptional set.

For p=5,g=2, K=24. The eventual Δ depends on the tower: no uniform
bound or zero-defect conclusion is proved. These are geometric towers,
not necessarily an infinite tower over one fixed finite constant field.

## 4. Actual unbounded defect with fixed finite prime support

The no-theta construction in
[the audited cofinal-saturation proof, §1](../../Solutions/Sol_raynaud_cofinal_saturation.md)
supplies an actual prime-to-p solvable G-cover W/C and an irreducible
representation ρ of dimension r with

    H⁰(C^(1),B_C⊗E_ρ⊗L)≠0 for every L∈J(C^(1))(k).           (4)

Choose ℓ∤p|G| and any compatible connected cyclic Z_ℓ-tower C_m/C.
Then W_m=W×_C C_m is connected, since the two Galois degrees are
coprime. It is smooth projective étale over C, with group G×C_(ℓ^m),
and W_(m+1)→W_m is cyclic étale of degreeℓ.

Each ρ⊗χ occurs r times in its regular representation. Formula(4)
covers allℓ^m character lines. Projection formula therefore gives

    Δ(W_m)≥h⁰(W_m^(1),B_(W_m))≥rℓ^m.                        (5)

The first inequality is kernel dimension≤total Frobenius-nilpotent
dimension; its relative and semilinear descriptions agree.

For any fixed ℓ≠p, coprimality with |G| is unnecessary. The full fiber
product has c_m≤|G| connected components, all isomorphic over C.
The same direct-image calculation applies to their disjoint union.
Choose compatible components V_m; then
Δ(V_m)≥rℓ^m/c_m≥rℓ^m/|G|.
The fields k(W)∩k(C_m) stabilize inside the finite Galois extension
k(W)/k(C), so eventually V_(m+1)→V_m has degreeℓ.
Their monodromies lie in subgroups of G×C_(ℓ^m).
The disconnected fiber product is never treated as a connected cover.

Hence even a fixed ordinary genus-two curve over Fbar_5 admits a
bounded-step prime-to-five tower with fixed finite prime support and
unbounded defect. It has an initial G-cover; it is NOT a pure pro-ℓ
tower over the ordinary base. Its pro-ℓ tail starts over nonordinary W.
All monodromies remain in the subgroup/quotient/product/extension closure
of the two fixed groups G,C_ℓ. No second fixed target is constructed.

For p=5,g=2, Raynaud's proof permits prime support{2,3}: use an
auxiliary cyclic degree8 cover (genus9), then Heisenberg parameter n=9.
Its requirement g′/n=1≤(g′−1)/(p−1)=2 holds. The Heisenberg group
is a3-group; its normal closure embeds in its wreath product with C_8.
Taking ℓ=2 or3 and the component argument preserves this prime support.
This specialization is author prose, not an independently audited
reproof of Raynaud's Heisenberg/Brill–Noether theorem.

## 5. What remains open

The almost-everywhere result does not settle a particular tower selected
by iterating an actual correspondence. For nonabelian pro-ℓ towers,
character lines no longer exhaust the new representation blocks.
Neither bounded steps, finite prime support nor ordinary base alone
controls those blocks. No universal bound for EVERY pure pro-ℓ tower
over an ordinary genus-two curve, or counterexample within that precise
scope, is asserted here. Additional two-leg geometry remains essential.
