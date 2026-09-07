# Finite bad characters force one finite etale descent level

Author proof/root/canonical_trace_algebra,2026-09-05; consolidated2026-09-07.
Uses the independently checked whole-Jacobian non-Galois descent theorem.
The finite-support torsion input has its separately scoped check;
the combined target theorem is not independently audited.
Version2,2026-09-07 integrates the earlier translate-free corollary
and Tong's ordinary-genus-two application, without a new audit claim.
No novelty or common-cover exclusion claimed.

## 1. General finite-character theorem

Let k be algebraically closed of characteristic p>0, U smooth projective
connected of genus≥2, B_U=F_(U/k)*O_U/O_(U^(1)), and Θ_U its Raynaud
divisor. Let Γ be ANY subgroup of J(U^(1))(k) of prime-to-p torsion.
Assume ONLY

    S_bad=Θ_U(k)∩Γ is finite.

No fixed prime support, divisibility, ambient abelian subvariety or
ordinarity of U is imposed. For finite Λ⊂Γ, form the actual connected
abelian etale character cover W_Λ→U on the scalar twist, then
transport it by etale Frobenius base change. Compatible basepoints
put all covers in one separable closure. Set

    Λ₀=⟨S_bad⟩, W₀=W_Λ₀.

The generated group is finite even if Γ uses infinitely many primes.
For EVERY finite Λ⊃Λ₀, W_Λ/W₀ has ordinary Prym and
Δ(W_Λ)=Δ(W₀), where Δ=g−f. For arbitrary finite Λ⊂Γ,
Δ(W_Λ)≤Δ(W₀). Every cofinal nested sequence is eventually
new-ordinary, for successive and composite Pryms.

Proof. Etale functoriality and character decomposition give

    a(W_Λ)=Σ_(L∈Λ)h⁰(U^(1),B_U⊗L).                        (1)

Up to harmless label inversion, these are exactly the relative
Frobenius kernel summands. Absolute Frobenius on coherent H¹ is
semilinear and permutes characters by[p]. Every finite prime-to-p
subgroup, including Λ₀, is stable under[p] and its inverse.
Thus the old Λ₀ block and its complementary new block are invariant.
All first-kernel summands in the latter vanish by the definition of
S_bad, so Frobenius is injective, hence bijective there. Equivalently
the old block is the averaging projector for the prime-to-p group
Gal(W_Λ/W₀). The new block is the Prym's coherent H¹, proving it
ordinary and the defect equality by isogeny additivity.

This controls ALL Frobenius iterates: the last nonzero image of a
nilpotent vector lies in a first-kernel block, whose complete[p]-orbit
is contained in Λ₀. S_bad itself need not be[p]-stable.
Equation(1) is an a-number formula, NOT Δ=|S_bad| or Δ=a.
For arbitrary Λ dominate by Λ+Λ₀ and use nonnegative relative-Prym
defect. Cofinality eventually includes the finite group Λ₀.

## 2. All actual target maps and a bounded common quotient

Let T vary over ALL hyperbolic curves with NO ordinary simple
isogeny factor in J(T). This includes p-rank-zero Jacobians,
supersingular Jacobians and simple nonordinary positive-p-rank
Jacobians; it does not require the whole Jacobian to be simple.

Every morphism W_Λ→T, Λ⊃Λ₀, descends uniquely to W₀; if etale,
the descended map is etale. The ordinary Prym has no homomorphism
to J(T), so this is exactly
[TheoremA of non-Galois Jacobian descent](NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md).
Its Section7 proves that a fixed hyperbolic W₀ has finitely many
hyperbolic etale quotients: outgoing degree≤g(W₀)−1, bounded-degree
Galois closures over W₀, finite generation of proper π₁, and finite
automorphism groups. Therefore only finitely many such T occur
as etale targets anywhere in the directed family or from ACTUAL
etale quotients of its members. For arbitrary Λ first pull up to
W_(Λ+Λ₀); for a quotient first compose with its actual quotient map.

To preserve a specified SECOND leg, fix actual finite etale b:U→B
of degree e. Let Z be an actual intermediate of W_Λ→B and let
r:Z→T be finite etale. Inside k(W_(Λ+Λ₀)), target descent gives

    k(D)=k(B)r^*k(T)⊂k(Z)∩k(W₀),
    [k(D):k(B)]≤e|Λ₀|.                                    (2)

Normalize: Z→D→B and D→T are actual finite etale maps, with r
factoring through D. Each is an intermediate of the original etale
maps. Neither Z/B nor Z/T need be Galois; neither Z nor W_Λ is
assumed to contain W₀. The single level is uniform in T, its genus
and both original degrees.

## 3. Finite prime support and the exact translate-free hypothesis

Now assume k=bar(F_p), C hyperbolic, S a fixed FINITE set of
primes≠p, and that Θ_C contains NO translate of a positive-dimensional
abelian subvariety. Its maximal exponent

    N_n=∏_(ℓ∈S)ℓ^n

abelian etale covers C_n/C have degree N_n^(2g(C)) and contain
every abelian cover with prime support S. The
[finite-support torsion-coset theorem, Section3](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md)
writes Θ_C∩J(C^(1))[S∞] as finitely many torsion cosets contained
in Θ_C. The hypothesis forces all their abelian directions to be zero.
Choose m containing this finite bad set. Sections1–2 give ordinary
Pryms C_n/C_m and uniform actual target descent, hence finitely many
allowed target isomorphism classes, whether or not C is ordinary.

The hypothesis holds for geometrically SIMPLE J(C), since Θ_C is
proper; the direct simple-ambient proof and its focused evidence
remain in Section2 of the Boxall record. It ALSO holds for EVERY
ordinary genus-two C, including split Jacobians, in any characteristic:
[Tong, Corollary4.2.3.3](https://arxiv.org/pdf/0712.2046) makes each
irreducible theta component ample. An abelian translate contained in
a divisor on a surface would be an elliptic component, with square0,
contradicting ampleness. Tong's proof separately handles components
meeting p-torsion (Corollary4.2.2.1) and the remaining components
(Proposition4.2.3.2, using elliptic vector bundles); it depends on
genus two and does not extend this conclusion to arbitrary covers.

For ANY actual abelian S-cover W/C with etale r:W→T, embed W in
some C_n with n≥m. Its image field descends to C_m, and

    k(D)=k(C)r^*k(T)⊂k(W)∩k(C_m)

gives a bi-etale quotient with deg(D/C)≤deg(C_m/C), by(2).
The target leg need not be Galois. This retains the prior
finite-support theorem, not just a bound on its Jacobian data.

There is also the distinct conditional initial-cover case. Here
ASSUME J(C) geometrically simple. Fix actual etale a:Z→C, with
no Galois requirement, and suppose

    D_Z={L∈J(C^(1)):h⁰(Z^(1),B_Z⊗a^(1)*L)≠0}

is PROPER. It has finitely many S-primary points by the same
simple-ambient lemma. Apply Section1 directly to
Γ′=a^(1)*(J(C^(1))[S∞])⊂J(Z^(1)); its bad characters are finite.
The connected components of Z×_C C_n are character covers for
a^(1)*(J(C^(1))[N_n]), and these exhaust Γ′. Thus one fixed
component level controls all later ordinary Pryms and allowed
target maps. This also recovers the earlier component-stabilization
proof: the number of components is bounded and eventually constant.
Actual maps to BOTH Z and C_n remain. Properness of D_Z is NOT
automatic and fails in Raynaud's no-theta examples.

## 4. Other applications and nonimplications

For an ordinary genus-two base and an etale double U, its elliptic
Prym P has ordinary complementary quotient. The proper restriction
Θ_U|P is therefore finite, even with unrestricted prime support.
The [genus-two inversion theorem](GENUS_TWO_INVERSION_TOWERS_AND_FINITE_TARGETS.md)
gives the odd-kernel consequence and its separate H4 extension to
even/nonsplit kernels, including actual non-Galois intermediates.

Finiteness of bad CHARACTER points here is stronger than finiteness
of bad fibers in a quotient Jacobian. The latter only stabilizes
generic theta dimensions along a parameter family, as in
[the canonical Frobenius sieve](../../Theorems/Thm_frobenius_exception_sieve.md);
it does not imply our ordinary-Prym or actual-target conclusions.

This does not supersede the different arithmetic/genus hypotheses of
[abelian towers and endomorphism fields](95_ABELIAN_ETALE_TOWERS_AND_ENDOMORPHISM_FIELDS.md),
which can treat arbitrary nonconstant maps and characteristic-divisible
abelian groups. Here S is fixed and prime to p, and simplicity is a
BASE-Jacobian condition in that specialization. No finiteness follows
by taking the union over all finite S: the [prime-avoiding cyclic
tower construction](PRIME_AVOIDING_THETA_CHARACTERS_FORCE_UNBOUNDED_CYCLIC_TOWERS.md)
gives unbounded defect even on ordinary genus-two bases when new primes
are allowed. Fixed-support recursive core towers need not be abelian,
and proper theta in higher dimension need not have finite torsion
intersection without a proved extra hypothesis.
No cofinal arbitrary-cover or p-primary-character assertion is made.
