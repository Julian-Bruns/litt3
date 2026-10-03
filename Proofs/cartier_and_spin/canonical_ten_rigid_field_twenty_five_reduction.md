# Proof: cyclic lifting and rigidity reduce the coefficient field to F25

Version1,3 October2026. Whole-implication review PASS within the [independent positive-trace audit](../../Research/audits/CANONICAL_TEN_POSITIVE_FULL_TRACE_EXCLUSION_AUDIT_2026_10_03.md). See the [statement and actual-source scope](../../Theorems/cartier_and_spin/canonical_ten_rigid_field_twenty_five_reduction.md). No numerical computation is used.

## A three-point lift supplies the generators

Every cyclic extension of k[[t]] lifts smoothly to mixed characteristic. The local-global principle patches prescribed local smooth lifts into a smooth lift of the entire finite-group cover. Primary sources are Obus–Wewers, [*Cyclic extensions and the local lifting problem*, Annals180(2014),233–284](https://annals.math.princeton.edu/wp-content/uploads/annals-v180-n1-p05-p.pdf), introduction, and Pop, [*The Oort conjecture*, Annals180(2014),285–322](https://annals.math.princeton.edu/wp-content/uploads/annals-v180-n1-p06-p.pdf), Fact4.13(1). In our order-FIVE case the cyclic lifting theorem already applies without the higher-order cyclic cases.

Apply the local-global principle to Γ_R→P¹, lifting the tame C2 germ by its ordinary tame lift. The base has a smooth genus-ZERO lift. In the generic fiber, branches in the weak C5 formal neighborhood have inertia FIVE: the prescribed lifted local cover has group C5, and its translates form the local R-cover. The tame neighborhood supplies exactly ONE branch of inertia TWO. There are no generic branches outside those neighborhoods, since the patched cover is étale there.

Write s for the number of generic C5 branch values. Smooth proper lifting preserves genus and degree. Special-fiber Hurwitz gives
\[
\frac{2g(\Gamma_R)-2}{|R|}
=-2+\frac85+\frac12=\frac1{10}.
\]
Generic-fiber Hurwitz, now tame, gives −TWO+FOUR s/FIVE+ONE/TWO=ONE/TEN, hence s=TWO. Thus the generic cover is a connected R-cover of P¹ with precisely the signature (FIVE,FIVE,TWO).

Spread this characteristic-zero cover to a finitely generated field and embed that field into C. Ordinary branch-cycle monodromy gives elements a,b,c generating the SAME abstract finite group R, with abc=ONE and orders FIVE,FIVE,TWO. The third element belongs to the original tame inertia conjugacy class: we used its prescribed tame local lift. This argument lifts the group action and curve only. It neither lifts the coefficient representation nor replaces either original endpoint map.

## An elementary form of Scott's inequality

Let g1,g2,g3 act on a vector space W of dimension D over any field, with g1g2g3=I. Let d0 be the common fixed-space dimension and d0* the common fixed-space dimension on W*. Then
\[
\sum_{i=1}^3\dim W^{g_i}\le D+d_0+d_0^*.
\tag{1}
\]
Here is the linear-algebra proof. Put Ui=(gi−I)W and define
\[
\Psi:U_1\oplus U_2\oplus U_3\longrightarrow W,
\qquad (u_1,u_2,u_3)\longmapsto u_1+g_1u_2+g_1g_2u_3.
\]
Its image is the span of the generator commutator images, of dimension D−d0*. The map W→⊕Ui sending w to ((g1−I)w,(g2−I)w,(g3−I)w) has image of dimension D−d0, contained in ker Ψ by telescoping. Thus Σdim Ui≥TWO D−d0−d0*, equivalent to (1). This is the matrix form of Scott's inequality; see also Scott, [*Matrices and cohomology*, Annals105(1977),473–492](https://annals.math.princeton.edu/1977/105-3/p03).

## Both order-five matrices are regular

Each projective element of order FIVE has a unique scalar-normalized unipotent lift of order FIVE. Indeed its FIFTH power is scalar and k has a unique FIFTH root of every scalar; the normalized eigenvalues are all ONE. Choose these lifts A,B. Their determinants are ONE. Define C=(AB)⁻¹. Its projective image is c, so its two eigenspaces have dimensions THREE and ONE. Since det C=ONE, its eigenvalues can be written λ on the THREE-dimensional eigenspace and −λ on the remaining line, with λ⁴=−ONE.

The generated linear group is irreducible because its projective image R is irreducible. Apply (1) to End(V) under conjugation by A,B,C. Its common invariant space and dual invariant space each have dimension ONE: the former by Schur, the latter by the nondegenerate trace pairing, valid also in characteristic FIVE. Therefore the three centralizer dimensions have sum at most SIXTEEN+TWO=EIGHTEEN.

The centralizer of C has dimension THREE²+ONE²=TEN. Every FOUR-by-FOUR matrix has centralizer dimension at least FOUR. Thus both A and B have centralizer dimension exactly FOUR. A unipotent matrix has this minimum exactly when it has one Jordan block. Both A and B are therefore regular J4 blocks.

## Rigidity and twenty-fifth Frobenius

Let (A',B',C') be any irreducible triple with product I, in the respective conjugacy classes of (A,B,C). On Hom(V,V'), use the action T↦A'TA⁻¹ and likewise for B and C. The individual fixed-space dimensions are FOUR,FOUR,TEN. Applying (1), with D=SIXTEEN, gives
\[
\dim\operatorname{Hom}_{\langle A,B,C\rangle}(V,V')
+\dim\operatorname{Hom}_{\langle A,B,C\rangle}(V',V)\ge TWO.
\]
The dual is identified with the reverse Hom space by trace. At least one intertwiner is nonzero, and irreducibility makes it invertible. This proves simultaneous conjugacy of the triples.

Now take (A',B',C') to be the entrywise TWENTY-FIFTH Frobenius of (A,B,C). Regular unipotent blocks retain their conjugacy classes. Moreover λ⁴=−ONE implies λ⁸=ONE, and every EIGHTH root of unity belongs to F25. Hence C retains its precise eigenvalues and multiplicities under this Frobenius. The two triples are simultaneously conjugate.

Lang's theorem for GL₄ converts this simultaneous Frobenius conjugacy into a basis over F25: if the intertwiner expresses F25(Ai)=U Ai U⁻¹ for all three matrices, choose H with F25(H)=U H and conjugate by H. The conjugated matrices are Frobenius-fixed. Equivalently, the associated invertible semilinear TWENTY-FIFTH Frobenius has a basis of fixed vectors. Determinants remain ONE. Thus the genuine triple, and consequently its entire projective image R, are defined over F25.

## Applying the actual coefficient classification

The accepted defining-linear theorem gives the actual entire coefficient image R conjugate to PSL₄(F_(25^a)). The present argument also conjugates it into PGL₄(F25). Since R is perfect, the determinant-mod-FOURTH-powers quotient kills it, so this realization lies in PSL₄(F25). Its order forces a=ONE: the order of PSL₄(F_(25^a)) is strictly larger than that of PSL₄(F25) for a>ONE. At a=ONE the subgroup has the same order, so is ALL of PSL₄(F25).

The actual quotient Γ_R used here exists because the coefficient kernel acts freely on the original canonical target: every noncyclic quotient of order greater thanFIVE retains both its cyclic inertia groups. Its signature is therefore exactly the one used above. The original T, its two actual finite étale maps, original positive trace and coefficient representation have been kept throughout. The result is a single finite coefficient group; it does not construct a common-cover replacement or exclude this remaining group.
