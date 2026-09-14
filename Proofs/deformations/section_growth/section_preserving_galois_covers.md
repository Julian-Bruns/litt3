# Proof: duality, Cartan–Leray and a characteristic subgroup chain

[Statement](../../../Theorems/deformations/section_growth/section_preserving_galois_covers.md).

Write V=H^0(C,E)=H^0(T,q^*E); the deck action on V is trivial.
Riemann–Roch gives χ(q^*E)=deg(q)χ(E)=0, so both H^1 spaces have
dimension r. By Serre duality, H^0(E^∨ω_C) and H^0(q^*(E^∨ω_C))
also have dimension r; their injective pullback is an isomorphism.
Trace on these inherited sections is multiplication by deg(q).
Its Serre dual is pullback on H^1, proving the stated zero/isomorphism
alternative.

The five-term sequence of
[Milne, Lectures on Étale Cohomology, Theorem14.9](https://www.jmilne.org/math/CourseNotes/LEC.pdf#page=96)
gives

    ker[H^1(C,E)→H^1(T,q^*E)]
       =H^1(G,V)=Hom(G,V_add).                              (1)

Coherent and étale cohomology agree by
[Stacks, Theorem59.22.4](https://stacks.math.columbia.edu/tag/03OY).
Thus the kernel has
dimension r·d(G), where d(G)=dim_Fp Hom(G,Fp). Since r>0, duality
gives d(G)=1 if p divides |G| and0 otherwise.

For H≤G, the pullbacks through T/H sandwich its section space between
the same two r-dimensional spaces. Euler characteristic remains zero.
Apply (1) to T→T/H to obtain the formula for every subgroup H.

If p divides |G|, its one-dimensional character space has a unique
normal index-p kernel G₁, characteristic in G. Repeat this construction
while p divides the subgroup order. It ends at a characteristic
prime-to-p subgroup N. The quotient P=G/N is a p-group with
d(P)=d(G)=1, hence cyclic by the Burnside basis theorem. A Sylow
p-subgroup maps isomorphically onto P.

Every index-p subgroup H contains N: [N:N∩H] divides both |N| and p.
The cyclic quotient therefore has a unique such subgroup, giving the
unique U. Its sections are still V, so the same trace argument kills
H^1(C,E) on U.

For the spin corollary, apply this on the scalar Frobenius twist with
E=A₁. The natural primitive boundary lies in H^1(C^(1),A₁), so it
vanishes on U. For prime-to-p degree its pullback is injective.
The spin-series reduction supplies actual Galois covers retaining all
the inherited sections, exactly the required hypotheses.
