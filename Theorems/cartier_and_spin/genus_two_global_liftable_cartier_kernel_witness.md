# A global constant-first-jet Cartier kernel survives the degree-one gate

Version2, 3 October2026. The global witness and its descended-effectivity
extension passed [independent review](../../Research/audits/OCT03_GLOBAL_CARTIER_KERNEL_WITNESS_AUDIT_2026_10_03.md).
This is a Cartier-bundle existence statement, not an actual source construction.

Let k=bar(F5), α³+α+1=0, A=1+4α, B=2+4α, and let Y be the smooth
projective curve w²=A x⁵+B x⁴−1. Write P for its infinity and η=dx/w,
so divη=2P. Let F:Y→Y₁ be relative Frobenius and
B_Y=F_*O_Y/O_Y₁.

There is a saturated rank-three degree-one bundle K⊂B_Y for which
E=F*K has surjective Cartier evaluation E→ω_Y. Its kernel H contains
a saturated line O_Y(P). The composite
α₀:O_Y(−P)→O_Y(P)→H has zero divisor2P and is nonzero in the two
fibers over x=0. Its intrinsic first jet is a nonzero constant times
η² in the rational divisor frame, hence has divisor5P. The second
fundamental form of the saturated O(P) line vanishes at P.

For Q=K^⊥⊂B_Y, the adjunction divisor of F*Q→ω_Y consists of seven
simple points, one of which is P. Moreover F*Q is not isomorphic to
O_Y(−5P). Consequently detH is not O_Y(3P), and this example is not
the marked native extension ω_Y V_Y.

The DESCENDED inverse annihilator is ineffective: h0(Y₁,Q^-1)=h1(Y₁,Q^-1)=0. Every map Q→B_Y therefore lifts uniquely to F_*O_Y. Nevertheless H contains no line of degree at least THREE. This blocks extending the additionally marked bounded-primitive exclusion to every liftable annihilator. The construction is on the actual relative twist Y₁, with coefficients A⁵,B⁵; comparison with an original q-source model is an additional hypothesis.

The precise witness and reproducible exact checks are in the
[proof](../../Proofs/cartier_and_spin/genus_two_global_liftable_cartier_kernel_witness.md).
No irreducible eight-dimensional finite coefficient source, original
trace images, degree-ten Γ row, G action or pair of actual étale endpoint
maps is constructed. This statement does not decide the Gram-four
configuration or the unmarked common-cover problem.
