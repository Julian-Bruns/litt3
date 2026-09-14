# Proof: complete sections determine fields and line bundles

[Statement](../../Theorems/cartier_and_spin/complete_section_quotients.md).

## 1. Normal closure and the projective kernel

Put G=Gal(T/C), E=H0(T,q*A). Its ratio field K is G-stable under the
canonical deck linearization. If it contains k(Z), it contains every
G-conjugate of k(Z), hence their normal closure k(T). Global generation
persists under pullback and enlargement to the full section space.

An element of G fixes every ratio exactly when it acts scalarly on E.
Indeed, the generic vector of section values is then an eigenvector of
its constant matrix. The eigenvalue is algebraic over k, hence in k;
linear independence of the sections makes the entire matrix scalar.
When k(C)⊂K, G-stability makes K/k(C) normal. This also proves the
projective-kernel assertion. Iterating along actual normal closures
preserves both étale maps and the common section.

## 2. Global generation and separability

The fixed divisor of H0(T,q*A) is G-invariant, hence q*B for an effective
integral divisor B on C. If deg A=1 and B≠0, removing it leaves degree
at most zero and at most one section. Thus h0≥2 forces B=0.

In characteristic p, if the complete map were inseparable, all its
section ratios would be p-th powers. Declare each global section
horizontal. Global generation makes this a regular connection on q*A:
nonvanishing sections give local frames with horizontal transition
ratios. Its p-curvature is zero, and it is G-invariant because every
constant linear combination of sections is horizontal. Étale descent
gives a zero-p-curvature connection on A. By
[Katz, Nilpotent connections and the monodromy theorem, Theorem5.1 (Cartier)](https://www.numdam.org/item/PMIHES_1970__39__175_0.pdf#page=17),
A=F_C* A_1 for a line on C^(p). Thus p divides deg A, a contradiction.

## 3. Descent determined by complete sections

Choose 0≠u∈H0(S,N). Under φ*N≅φ*M its pullback equals φ*v for some
v∈H0(S,M). The rational isomorphism N→M sending u to v pulls back to
the specified global isomorphism. Its divisor pulls back to zero,
hence is zero. It therefore extends to a global isomorphism; uniqueness
follows from faithful pullback.

For the spin assertion set N=ω_S M^−1. Étaleness and L²=ω_T give
φ*N≅L=φ*M and deg M=g(S)−1. Riemann–Roch gives h0(N)=h0(M)>0.
The preceding argument identifies N with M. Compatibility with the
given squares follows after the faithfully flat pullback φ.
