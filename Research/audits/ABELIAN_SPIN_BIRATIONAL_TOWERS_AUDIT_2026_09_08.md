# Bounded audit: abelian spin birational towers

Verdict: PASS (prose audit, not formal verification).
Auditor: /root/audit_abelian_spin_tower.
Date: 2026-09-08.
Scope: version 1 of [the theorem](../../Theorems/Thm_abelian_spin_birational_towers.md)
and its [complete proof](../../Solutions/Sol_abelian_spin_birational_towers.md).
No mathematical objections found. No computation or subagents used.

The group-algebra construction is valid: for an abelian torsor, the
transition permutations of its regular module are multiplication by
group elements, so q_*O is an invertible O_C tensor k[G] module.
Augmentation reduction is O_C, and its first-order transition terms are
the Artin--Schreier classes of the mod-p characters. The large-divisor
complex is finite free in degrees 0 and 1. After cancelling unit entries,
the residual dimensions h0(A)=h1(A)=1 give exactly R -> R. The cup-product
description of its linear term follows by lifting the unique section.
Frobenius-fixed cohomology and Serre duality identify the failure of an
Fp-direction pairing with precisely the excluded Cartier eigenline.

The exact lengths are correct. An invertible formal coordinate change
preserves (z_1^N,z_2^N) because N is a p-power. In the asymmetric quotient,
both linear coefficients remain nonzero after any integral group basis
change: its mod-p matrix is invertible. Solving for the variable truncated
at N/p gives a unit times z^(N/p), hence length N/p. The cyclic first layer
has length 1. Descent of invariant sections does not require exactness of
the invariants functor. These lengths prove linear and projective
faithfulness for every n.

The geometric steps also check. A nonzero invariant fixed divisor would
leave a line of nonpositive degree and at most one section. An inseparable
complete series would supply a G-invariant regular dormant connection,
descending to the impossible degree-one dormant line on C. For the
separable map to the normalized image, the invariant different has degree
an integral multiple of N^2. Rational and elliptic images are excluded as
stated; for a hyperbolic image the remaining positive integer value 1
contradicts the odd degree of M. Thus the map is etale.

Equality of both complete pulled-back section spaces establishes the
claimed compatible spin: matching one nonzero section of M with one of
omega_S/M produces a rational isomorphism whose pullback is the fixed
regular isomorphism, so its divisor is zero. The two descended canonical
forms then recover the endpoint field, including its hyperelliptic
generator via dx/beta. Finally every intermediate extension of the
abelian Galois extension T/C is Galois, and the faithful action on the
section field forces T=S. In the equal-ratio argument, multiplication by
a rational function preserving the finite-dimensional nonzero complete
section space forces that function to be a constant; hence no extra
kernel is overlooked.

The family specialization uses only the six displayed non-eigenline
identities in family_small_torsion_specialization, Section 4, and the
Cartier determinant 3(t+1)^4. Both are nonzero on t^5-t != 0. Older
torsion-specialization arguments were not re-audited or imported here.

Limitation: these are one-leg covers only. This verdict asserts neither a
second endpoint map nor an exclusion or solution of the unmarked
common-cover problem. The theorem and library were left unchanged.
