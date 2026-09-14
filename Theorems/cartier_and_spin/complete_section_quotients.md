# Complete sections: normal closures and descent

Version2,2026-09-14. All curves are smooth, projective and connected
over an algebraically closed field. Complete-section spaces and their
ratios use the specified maps of function fields.

## 1. Normal closure and the projective kernel

Let f:Z→C be finite separable, A a line bundle on C, and q:T→C the
normal closure of f with its specified embedding. If section ratios
of f*A generate k(Z), those of q*A generate k(T). Global generation
also persists. There is no genus, degree or characteristic restriction.

More generally, for Galois q:T→C the complete ratio field K is G-stable,
where G=Gal(T/C). The kernel of G acting on K is the kernel of its
projective action on H0(T,q*A). If k(C)⊂K, then K/k(C) is Galois.

Thus a base-point-free birational complete spin series remains so after
every alternating endpoint normal closure, retaining both actual étale
legs and the common section.

## 2. Global generation and separability

Let q:T→C be finite étale Galois. If deg A=1 and h0(T,q*A)≥2, then
q*A is globally generated.

In characteristic p>0, if q*A is globally generated and p∤deg A,
its complete section map is separable.

## 3. Descent determined by complete sections

Let φ:T→S be finite, with a specified isomorphism φ*N≅φ*M. If
h0(S,N)>0 and H0(S,M)→H0(T,φ*M) is surjective, that isomorphism
descends uniquely to N≅M.

In particular, suppose φ is étale, L=φ*M is a spin line, and
H0(S,M)=H0(T,L)≠0. Then M²≅ω_S compatibly with the given spin
isomorphism upstairs. This applies to every étale normalized image of
a base-point-free complete spin series.

[Proof](../../Proofs/cartier_and_spin/complete_section_quotients.md).
The elementary arguments consolidate the earlier section-field proof
and the descent lemmas already used in the audited spin reductions.
