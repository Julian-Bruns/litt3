# Prime-avoiding bad characters force unbounded cyclic etale towers

Original ordinary-genus-two characteristic5 theorem:
author /root/x_elliptic_quotient_maps,2026-09-05, literature-derived.
Version2,2026-09-07 states its parameterized mechanism in all
characteristics, with the generating-component hypothesis explicit.
Author proof, not independently audited. The old case remains below.

## 1. General mechanism and its genus-two specialization

Let C/bar(F_p) be smooth projective connected of genus≥2, and suppose
its Raynaud divisor Θ_C⊂A=J(C^(1)) has an irreducible component T
which GENERATES A: it is contained in no translate of a proper
abelian subvariety. Given ANY finite prime set S₀ containing p,
there is an actual connected cyclic etale cover W/C of degree>1
coprime to S₀ with a(W)≥a(C)+1.

More strongly, there is a nested tower C_j/C with cyclic composites
and pairwise coprime successive degrees>1, all prime to S₀, such that

    a(C_j)≥a(C)+j,            Δ(C_j)=g(C_j)−f(C_j)≥a(C)+j. (1)

This applies to EVERY ordinary genus-two curve, including split
Jacobians and in particular the original characteristic5 case.
Indeed [Tong, Corollary4.2.3.3](https://arxiv.org/pdf/0712.2046) makes
each theta component ample. On an abelian surface, a component
contained in a proper abelian translate would be an elliptic translate
of square0, contradicting ampleness. The [finite-support record,
Section3](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
retains the source's principal/nonprincipal-component proof distinction.
No automatic generating-component assertion for every curve is made.

## 2. Prime avoidance uses the complementary prime set

For every nonempty open U⊂T, removing0 if necessary, the closure T
shows that U still generates A. Descend A,U to a finite field.
[Poonen, *Multiples of subvarieties in algebraic groups over finite
fields*, Lemma6.6 and proof of Theorem1.8](https://math.mit.edu/~poonen/papers/multiples.pdf)
gives a set R of primes DISJOINT from S₀ with

    U(k)+A(k){R}=A(k),

where braces mean R-primary torsion. Apply this equality to0:
0=x+y with x∈U and y supported on R. Then x=−y has nonzero
order coprime to S₀. This uses Poonen's allowance of locally closed
subvarieties; his Theorem1.8 itself states a surjective projection
onto a prime set CONTAINING S₀. Confusing these two sets would
reverse the required conclusion. The lemma/proof were read directly.

A bad L∈U of exact order n>1 defines a connected cyclic etale
Kummer cover of C^(1), because n is prime to p. Transport through
the etale Frobenius equivalence gives an ACTUAL cover W/C.
The exact character formula is

    a(W)=Σ_(L'∈⟨L⟩)h⁰(C^(1),B_C⊗L'), B_C=F_*O_C/O_C^(1). (2)

The identity character contributes a(C); L contributes at least1.
This proves the first assertion, not merely a Jacobian condition.

## 3. A nested cyclic tower, not a fixed-prime tower

Inductively enlarge S₀ by the prime divisors of all earlier chosen
orders. Section2 gives bad characters L_j of pairwise coprime
orders n_j>1, avoiding the original S₀. Their group is

    G_j=⟨L₁,...,L_j⟩≅∏_(i≤j)C_(n_i)≅C_(N_j),
    N_j=∏_(i≤j)n_i.

The actual character covers for G_j are connected cyclic of degree
N_j; compatible basepoints give quotient maps C_j→C_(j−1)
of degree n_j. All L_i and0 are DISTINCT character labels.
Summing(2) gives a(C_j)≥a(C)+j. The first Frobenius kernel
has dimension at most the eventual nilpotent part, so a≤g−f,
proving(1).

Every finite composite is cyclic, but the union of degree prime
supports is INFINITE. This is neither a pure pro-ℓ tower nor a
tower on one fixed finite prime set. It supplies no second fixed
target curve or common-cover exclusion. It is the genuine boundary
to finite-support stabilization: at every step a new prime support
escapes that theorem's fixed exceptional character set.
