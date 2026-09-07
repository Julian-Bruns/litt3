# Rank-one Cartier crystals do not close the restricted-theta gap

Bounded author proof/literature test2026-09-06 by
/root/birational_rank_one_cartier_crystal_test. This identifies a failed
proof step, NOT a counterexample to GENERIC restricted-theta properness.

For a smooth projective curve C in characteristic5, let a:C→A be
unramified and birational onto its image, with birational translated
tangent map. The question is whether H⁰(B_C⊗a^(1)*L)=0 for general
L∈Pic⁰(A^(1)). A simple minimal rank-one Cartier crystal on that image
does NOT supply the missing full-rank global-section map.

## 1. The determinant still needed

Put N=a^(1)*L. The twisted Cartier exact sequence gives

    c_N:H⁰(C,ω_C⊗F_C^*N)→H⁰(C^(1),ω_C^(1)⊗N),
    h⁰(B_C⊗N)=g(C)−1−rank(c_N) generically.

Both spaces have dimension g(C)−1 by Riemann–Roch: pullback from A has
positive-dimensional image since a is nonconstant, and Frobenius
pullback has finite kernel, so both N and F_C^*N are generically
nontrivial. Thus the question is generic det(c_N)≠0.
Rank one on the SUPPORT does not mean rank one of these section spaces.

For M=a_*ω_C, the surjection c:F_A*M→M has generic coherent ranks
5→1 on the support. Its rank-four kernel K has ZERO Cartier structure:
the structure on F_A*M is F_A*c, which kills F_A*K. Thus c is already
an isomorphism of Cartier crystals, whatever the global rank deficit.
Locally Cartier kills dt,t dt,t²dt,t³dt and sends t⁴dt to dt;
the crystal quotient discards those four coherent directions.

## 2. Minimal representatives and generic vanishing do not repair it

[Blickle–Böckle, Definition3.7, Lemma3.8, Theorems3.10–3.12](https://arxiv.org/pdf/0909.2531)
give canonical minimal representatives and their full correspondence
with crystal morphisms. A crystal CAN recover its minimal coherent
representative. But F_*ω_C is not minimal: B_C⊂F_*ω_C is nonzero
with zero Cartier structure. Replacing it by the minimal representative
changes the coherent source of c_N. The theorem upgrading a
nil-isomorphism BETWEEN MINIMAL objects to an isomorphism does not
apply here; global cohomology preserves neither minimality nor simplicity.

Indeed ω_C is simple as a coherent Cartier module: a nonzero submodule
is ω_C(−D), and Cartier sends local multiplicity m to floor(m/5).
Stability forces every m=0. Yet its global action can be nilpotent.

For P=a_*F_5[1], proper projection gives
H⁰(A_et,P⊗E)=H¹(C_et,a^*E). This is the degree LEFT UNRESTRICTED
by perverse generic vanishing. Baudin's Theorem6.3.2 controls the other
degrees; equation(6.3.2.f) concerns inverse limits of Cartier cohomology,
not dimension g(C)−1 in this degree:
[Section6.3](https://arxiv.org/html/2306.05378v2#S6.SS3).
Hacon–Patakfalvi's Theorem1.1 likewise controls Frobenius-stable
cohomology; Remark1.3 distinguishes ordinary cohomology from an inverse
limit killed by nilpotence:
[primary paper, p.3](https://arxiv.org/pdf/2009.12041).
Adding simplicity does not change those degrees or recover the determinant.

## 3. A concrete pointwise counterexample to the upgrade

Take the smooth plane sextic C:x^6+y^6+z^6=0 and its Abel–Jacobi
embedding a:C→J(C). It has genus10 and ω_C=O_C(3); its canonical
map is an embedding and equals the translated tangent map.
The canonical Cartier module is simple and minimal, also after this
closed immersion. Nevertheless Frobenius on H¹(O_C) is ZERO.

Here is a direct check, without a superspecial classification.
The plane equation identifies H¹(O_C) with H²(P²,O(−6)), having
Cech basis x^(−a)y^(−b)z^(−c), a,b,c≥1, a+b+c=6.
For f=x^6+y^6+z^6, Frobenius is u↦f^4u^5.
A monomial x^(6i)y^(6j)z^(6k) of f^4 has i+j+k=4.
For its product with u^5 to survive, every exponent must be negative.
Since1≤a,b,c≤4, this requires i≤a−1,j≤b−1,k≤c−1, giving
4≤a+b+c−3=3, impossible. Cartier is therefore zero on all ten
global canonical forms and h⁰(B_C)=10.

This refutes only the POINTWISE promotion from simplicity/minimality
and embedded Gauss geometry to full Cartier rank. The example uses
the FULL Jacobian, where Raynaud's theorem DOES give generic vanishing.
Any proof on a parameter abelian subvariety must use variation in L
to exclude a persistent deficit; the cited crystal results do not do so.
