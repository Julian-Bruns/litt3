# Proof: normal paired abelian subgroups of the actual coefficient image

Version2. [Statement](../../Theorems/cartier_and_spin/canonical_ten_normal_abelian_coefficient_reduction.md). The complete scoped argument passed [root whole review](../../Research/audits/CANONICAL_TEN_AFFINE_AND_NORMAL_ABELLAN_AUDIT_2026_10_03.md). Both actual endpoint maps remain upstairs. The actual R is a quotient of the faithful canonical source group and therefore has NO nontrivial prime-to-FIVE quotient.

## One restriction type and its nondegenerate pairing

Realize the coefficient representation in the finite determinant-one central extension of R by μ₄. The FIVE-primary subgroup of A is characteristic in A and normal in R. Its inverse image splits uniquely over μ₄: the central extension and its homomorphisms to μ₄ vanish by coprime cohomology. Its unique FIVE-complement is normal in the entire lift. A finite normal FIVE-group has a nonzero fixed vector in characteristic FIVE, and irreducibility makes its fixed subspace the whole module. Faithfulness of the projective image therefore kills this subgroup. Thus A has order prime to FIVE.

Restriction to its central lift is semisimple. Its distinct irreducible types are transitively permuted by R, and the permutation has degree at most FOUR. Its image is prime to FIVE and hence trivial by the actual quotient theorem. There is ONE type, of dimension r and multiplicity m, with rm=FOUR.

Let b:A×A→μ₄ be the commutator pairing of coefficient lifts. The twisted group algebra of A has simple modules of dimension r with
\[
r^2=|A/\operatorname{rad}(b)|.
\]
Its radical is represented by commuting central elements, acting by one scalar on the unique restricted simple type and therefore on all its copies. The projective inclusion A⊂R is faithful, so its radical is trivial. Consequently |A|=r² and the pairing is nondegenerate. Since b takes values in μ₄, A has exponent dividing FOUR. Finite nondegenerate alternating paired groups of these orders have only the following possibilities:
\[
r=1:\ A=1;\qquad r=2:\ A=C_2^2;\qquad
r=4:\ A=C_4^2\text{ or }C_2^4.
\]
For example the order-FOUR factors must occur in pairs under a nondegenerate alternating pairing, which rules out mixed C₄×C₂².

## The smaller normalizers are impossible

Aut(C₂²) has order SIX; Aut(C₄²) has order NINETY SIX, from reduction to GL₂(F₂) with kernel of order SIXTEEN. Both are prime to FIVE. In either case conjugation R→Aut(A) is trivial. For a fixed finite lift h of an element of A, projective centrality gives
\[
M_g hM_g^{-1}=c_h(g)h.
\]
These scalar commutators define a genuine character of R, with finite image dividing the TWO-power order of h. They must all be trivial. But the nondegenerate pairing b gives some pair of elements of A with NONTRIVIAL commutator, contradiction. Thus neither C₂² nor C₄² is possible. The only nontrivial A is C₂⁴, and its restriction on V is irreducible of dimension FOUR.

## Its exact bounded symplectic quotient

The projective centralizer of A is exactly A. Indeed a projective centralizer lift defines a character of A by its scalar commutators. Nondegeneracy realizes that character uniquely as b(a₀,−) for a₀∈A. After multiplying by the inverse lift of a₀, it commutes genuinely with the irreducible A-module, hence is scalar by Schur's lemma. This proves the assertion.

Conjugation preserves b, so
\[
R/A\hookrightarrow\operatorname{Sp}_4(\mathbf F_2).
\]
The symplectic group has order720 and is S₆ via its action on the SIX odd quadratic refinements of b. This action is faithful: the differences between these six refinements span A∨. In standard parameters (a₁,a₂;b₁,b₂) with Arf value a₁b₁+a₂b₂, the six odd choices are
\[
(10;10),(10;11),(01;01),(01;11),(11;10),(11;01);
\]
their differences exhibit all four coordinate directions. Order counting then gives the stated S₆ identification. Its sign character restricts to a prime-to-FIVE quotient of R and must be trivial. Therefore R/A embeds in A₆, and |R|≤16·360=5760.

## The solvable quotient is impossible

Put Q=R/A. It also has no nontrivial prime-to-FIVE quotient. If its order is prime to FIVE, it is trivial. Otherwise suppose Q is solvable. Its action on the SIX quadratic refinements cannot be transitive: a primitive solvable permutation group has prime-power degree, so a solvable transitive degree-SIX group is imprimitive. Its nontrivial block systems have sizes TWO orTHREE, whose wreath-product groups have order prime to FIVE. They cannot contain the required element of order FIVE.

Therefore Q is intransitive. An element of order FIVE has a five-element orbit and a fixed point; those force a Q-orbit of size FIVE and one fixed point. Hence Q embeds in the point stabilizer A₅ and acts transitively on FIVE letters. A solvable transitive group of prime degree has a normal regular C₅ and lies in its affine normalizer. Inside A₅ that normalizer is D₁₀. The only possibilities containing FIVE are C₅ and D₁₀; the latter has a forbidden quotient C₂. Thus Q=C₅.

The trivial case R=A already has multiplier order TWO. In the remaining case [R:A]=FIVE, restriction to A detects the TWO-primary part of H²(R,k*): transfer composed with restriction is multiplication by FIVE, invertible on that part. The actual coefficient class has order FOUR, whereas its restriction has order TWO because the nondegenerate elementary-TWO pairing has exponent TWO. Applying restriction to twice that class gives zero; injectivity forces twice the class itself to vanish, contradiction. Therefore Q cannot be solvable.

## The proper nonsolvable quotient would be A5

It remains to inspect a nonsolvable subgroup Q⊂A₆. Its order is divisible by FIVE, since otherwise Q itself would be a forbidden prime-to-FIVE quotient. The divisors of360 divisible by FIVE are
\[
5,10,15,20,30,40,45,60,90,120,180,360.
\]
Orders90,120,180 would give subgroups of index FOUR,THREE,TWO in the simple group A₆. Its coset action would be faithful and embed A₆ in S₄,S₃,S₂, impossible. Among the remaining proper orders, those other than30 and60 involve at most TWO distinct prime divisors, and Burnside's two-prime theorem makes their groups solvable. A group of order30 is solvable too: if neither its Sylow-FIVE nor its Sylow-THREE subgroup were normal, their numbers would be SIX andTEN, yielding24+20 nonidentity elements, more than its order. A normal one gives a solvable cyclic normal subgroup and quotient of order SIX orTEN.

Consequently a proper nonsolvable Q has orderSIXTY. The elementary small-order theorem that every nonsolvable group of orderSIXTY is A₅ now identifies Q with A₅. One formulation of that theorem first observes that every proper normal subgroup and quotient has smaller order and is solvable, so the nonsolvable group is simple, and then applies the standard Sylow proof of uniqueness of the simple group of orderSIXTY. This is an abstract small-order fact, not a classification of finite projective representations.

But Q is an ACTUAL quotient of G. The [whole A₅ quotient exclusion](canonical_degree_ten_no_a5_quotient.md) rules it out. Hence Q=A₆ and |R|=5760 exactly.

## Exact normalizer and actual bounded targets

The full projective normalizer of A maps onto Sp₄(F₂): each automorphism preserving b preserves the twisted irreducible module up to isomorphism, after rescaling a cocycle by a coboundary. An intertwining operator therefore realizes it projectively. The kernel is the already proved projective centralizer A. Thus its even preimage has order16·360. Since R lies in this preimage and has the same order, it is the whole preimage. In particular no semidirect splitting has been assumed.

Apply the actual quotient portion of the A₅ exclusion theorem to R and to R/A=A₆. Both orders exceed FIVE, so their kernels in G act freely on Γ. We obtain actual étale targets Γ_R and Γ_{A₆}, with the original completed weak-five/tame-two inertia retained. Their genera are
\[
g(\Gamma_R)=5760/20+1=289,
\qquad g(\Gamma_{A_6})=360/20+1=19.
\]
The intermediate map Γ_R→Γ_{A₆} is the actual A-Galois étale cover of degreeSIXTEEN. These are target quotients only. The two original source maps remain on T, and no X-field descent is inferred.

A restriction pairing of order TWO alone does not kill an order-FOUR multiplier across this even-index quotient. No unsupported full Clifford-normalizer exponent assertion or source-degree bound is made.
