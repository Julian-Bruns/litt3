# Exact Cartier coefficient criteria on etale covers

Author proof /root/nongalois_twisted_cartier_simple_factors2026-09-05
for p=5, weight2. Version2,2026-09-07: the same exact-functor argument
now covers every characteristic p and weight m≥2; broader scope is
AUTHOR-only, not independently audited. The original characteristic-five
indigenous application retains its additional hypotheses.

## 1. General coefficient operator and exactness

Let k be algebraically closed of characteristic p, C smooth projective
connected of genus h≥2, m≥2, and fix

    A∈H⁰(C,ω_C^((p−1)(m−1))),
    T_A(t)=C_(m−1)(At),   t∈H⁰(C,ω_C^m).

Here generalized Cartier C_(m−1) sends weight p(m−1)+1 to weight m;
indeed At has precisely that weight. The operator is additive and
inverse-Frobenius-semilinear. No zero-divisor or eigenform condition
on A is imposed.

Fix actual connected finite etale Galois q:W→C with group G.
For a finite F_p[G]-module M, let E(M) be the associated etale bundle,
with locally constant transition matrices in GL(M,F_p) and its
canonical Frobenius structure. Apply T_A componentwise on etale
trivializations. Cartier functoriality and F_p-valued matrices make
these operations glue on

    Q_A(M)=H⁰(C,ω_C^m⊗E(M)).

Module homomorphisms give k-linear maps commuting with this operator.
The resulting functor is EXACT, with

    dim Q_A(M)=(2m−1)(h−1)dim_Fp M.                         (1)

Indeed etale torsor descent makes M↦E(M) exact, without exactness
of arbitrary modular invariants. Its degree is0 since q^*E(M) is
trivial. Serre duality gives
H¹(ω_C^m⊗E(M))^∨=H⁰(ω_C^(1−m)⊗E(M)^∨)=0:
pullback injects this last space into copies of a negative-degree
line on W. Cohomology exactness and Riemann–Roch prove(1).
Weight1 is excluded precisely because this vanishing can fail.

## 2. Exact simple-factor criterion for the specified cover

For an actual finite etale g:Z→C, take its Galois closure q and
write Z=W/H. With V=F_p[G/H], use the sheet action on functions;
delta functions identify it with the self-dual permutation module.
Thus E(V)=g_*O_Z, including Frobenius structures, and

    Q_A(V)=H⁰(Z,ω_Z^m)

intertwines T_(A,V) with T_(g^*A), as one sees on split etale sheets.
It follows that T_(g^*A) is bijective IFF T_(A,S) is bijective
for every simple F_p[G]-composition factor S of V.

Proof: apply exactness to a composition series. In a compatible exact
sequence of finite-dimensional semilinear spaces, bijectivity of the
two ends gives bijectivity in the middle by kernel/lifting arguments.
Conversely bijectivity in the middle makes the restriction injective,
hence surjective over perfect k; the quotient is then bijective.
Induct along the filtration. Multiplicities and extension classes
do not affect this YES/NO criterion, even when p divides |G|.

The simples must be over F_p, NOT silently replaced by absolutely
simple k[G]-modules. Inverse Frobenius can permute their conjugate
pieces; a non-F_p-valued tame character space need not be T-stable.

## 3. Consequences and the fixed characteristic-five application

For fixed(C,A,q), good coefficient modules form a Serre subcategory:
submodules, quotients and extensions preserve the criterion. No tensor
closure is claimed. The trivial module occurs in every nonempty
permutation module via constant functions. Therefore bijectivity
upstairs always implies it on C, including p-divisible degrees.

For a p-group G the trivial representation is the only simple, so
bijectivity is EQUIVALENT on C and every actual W/H. Iteration gives
invariance along any existing tower of Galois etale p-group covers,
with no degree bound. Mere degree p^a without that monodromy is
insufficient; existence of such towers is not supplied.

Likewise, if every simple of F_p[G/H] occurs in some F_p[G/H_j],
bijectivity on those actual quotients implies it on W/H, using the
SAME A and Galois cover.

For p=5,m=2 and A=s^(4/d), d=2 or4, the
[indigenous inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md)
applies only with its eigenform and reduced equimultiple-divisor
hypotheses. Those persist under etale pullback, so ordinary indigenous
data remain ordinary along the above Galois five-group towers.
This addresses the cover condition in the
[finite eigenform pool](FINITE_GENERALIZED_CARTIER_EIGENFORM_POOLS_AND_ETALE_COMPATIBILITY.md);
it does not produce such data or identify the two legs' monodromy.

Unlike the [stable Frobenius-defect theorem](PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md),
this proof uses exact global sections with finite F_p coefficients,
not projectivity of a kG nilpotent module. No twisted-Cartier kernel
projectivity, general source ordinarity, degree bound, or common source
is asserted.
