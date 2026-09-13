# Proof: defect-module base change and the explicit quadratic case

[Statement](../../../Theorems/deformations/abelian_covers/abelian_p_defect_node.md).
Let (C,r) be the explicit ordinary genus-two/F625 pair with defect one.
The argument identifies actual quotient-cover modules, computes their
quadratic term once, and applies the shared truncation length lemma.

## 1. Exact descent of the defect module to group quotients

Let P be any finite5-group acting as the deck group of an actual etale
cover T->C, let H be normal, and S=T/H. The audited theorem proves that
V_T=H1(T,T_T) is free over R=k[P], of rank3(g(C)-1). This freeness also
holds for the relative-Frobenius linearized source of Psi_T.

The H-norm N_H gives an isomorphism of k[P/H]-modules

    k[P/H] tensor_R V_T  -> V_T^H = V_S.

It is an isomorphism on a regular module by direct coset bases and hence
on every free module. Equivariance and etale naturality identify the
base change of the linearized Psi_T with Psi_S, on BOTH its source and
target. Right exactness therefore gives the actual cokernel identity

    k[P/H] tensor_R coker(Psi_T) = coker(Psi_S).             (2)

No trace divided by |H| is used. Invariants alone would not give this
right-exact identity; freeness and the norm identification are essential.

For cyclic P=Z/(5^a), R=k[e]/(e^(5^a)). Corank one downstairs gives
D_T=R/(e^l). Its degree-five intermediate cover has defect min(l,5).
All SIX actual degree-five covers have defect2 by the audited
certificate. Thus l=2, proving the cyclic assertion for EVERY a,
without any higher cover calculation or theta-properness hypothesis.

## 2. Three columns on the universal degree25 cover

The compositum of two independent geometric Artin--Schreier classes is
the unique maximal elementary abelian5-cover T_1->C, with group F5^2.
The existing six-cover computation explicitly gives a basis of ALL
classes in H1_et(C,Z/5). Its AS coordinates w1,w2 and their O-shifts
are therefore actual global etale covering data, not sampled equations.

The tangent cohomology basis is

    z^e w1^i w2^j, e=-3,-1,1, 0<=i,j<=4.

The two-variable triangular AS filtration and H0(T_C)=0 prove
completeness, dimension75. Put Delta_i=deck_i-1. The THREE vectors
z^e w1^4 w2^4 form a free basis over

    R_1=k[e1,e2]/(e1^5,e2^5),

because Delta_i^4(w_i^4)=4!=4. The constant change-of-basis matrix is
the tensor product of the two binomial difference matrices and I3.
The actual pre-cohomology operator is the audited

    Psi([v])=[(u-t)(u-(4t+3))^2 v^5/(4+4t)].

Its equivariance determines the entire75x75 map from its values on
these three free generators. Scalar semilinearity is retained by
linearizing the source; Delta_i has F5 coefficients.

The [generator](../../../scripts/deformations/cyclic/cyclic25_witt_module.sage) uses the audited
field, affine reducer and precision guard: descending from AS component
(i,j) requires absolute precision>3(i+j)+2. Full runs at precisions220
and260 agree. The [focused audit](../../../Research/audits/ABELIAN_P_DEFECT_NODE_AUDIT_2026_09_10.md)
independently checks the recorded field, finite relation, quadratic part,
six restrictions and colength9; its review of the three new Laurent
columns was by code, while the inherited six covers had an independent
replay.

The resulting3x3 R_1 matrix has constant matrix EXACTLY the audited
base3x3, of rank2. An invertible2x2 pivot gives by Schur complement

    D_(T_1) = R_1/(f_1).

The [receipt](../../../Research/computations/cyclic25_witt_module.json) records
the full relation. It has order2 and its quadratic part Q is NONDEGENERATE.
Its discriminant is nonzero, with minimal polynomial

    X^4+4X^3+4X^2+4X+1 over F5.

Moreover Q(1,c)!=0 for all c in F5 and Q(0,1)!=0. Both properties are
exact finite-field tests. The full source defect is9, independently
computed from the75x75 matrix and multiplication by f_1 on R_1.
Restriction along all six homomorphisms
e1->(1+s)^a-1, e2->(1+s)^b-1 reproduces six lengths2.

## 3. From that finite quadratic to every abelian5-group

Now let G=Z/(5^a)xZ/(5^b), a>=b>=1, and write

    R=k[s,t]/(s^A,t^B), A=5^a, B=5^b.

The quotient cover with group G/5G has rank2, so it is T_1: the induced
surjection H1_et(C,Z/5)^dual -> G/5G is an isomorphism. Changing its
two generators acts on the tangent variables by GL2(F5).

By(2), Psi_T modulo(s^5,t^5) is the computed Psi_(T_1), up to invertible
changes of source and target bases. Lift a2x2 unit pivot. Another Schur
complement therefore writes D_T=R/(f), where f reduces to a UNIT
multiple of f_1 after the corresponding change of group coordinates.
In particular f has order2, nondegenerate quadratic part, and that
part vanishes on none of the six F5 tangent lines. These assertions
are invariant under the permitted unit and GL2(F5) changes.

Lift f arbitrarily to k[[s,t]]. Its nondegenerate quadratic part and
nonzero coefficient along every F5 line survive all higher terms. The
[shared truncation lemma](frobenius_truncated_hypersurfaces.md)
therefore gives length 2A−1 when A=B and 2B when A>B. It preserves
exactly the ideal (s^A,t^B); no unrestricted formal coordinate change
is applied to unequal powers. Together with the cyclic case in Section1,
this proves the formula for every actual abelian cover.

## 4. Every nontrivial 5-group-monodromy cover kills the obstruction

This part needs no abelian hypothesis. Let h:T->C be a nontrivial
connected finite etale cover whose Galois closure L->C has finite
5-group P. Put H=Gal(L/T), a proper subgroup of P. Choose a maximal
subgroup M containing H. It is normal of index5 in P. The ACTUAL
factorization

    T=L/H -> L/M -> C

therefore contains one of the six geometric cyclic5 covers already
proved to kill epsilon(C,r). Naturality gives epsilon(T,h*r)=0.
This does not give a defect formula for nonabelian monodromy.

For every such h, no W3 source repair can preserve the original map
to ANY C3 above the canonical C2. Indeed every rho_C(C3) represents
the nonzero epsilon(C,r), so rho_C(C3) is nonzero. Negative-H1 pullback
is injective even when 5 divides the degree. A lifted map would force
rho_T(T3)=h*rho_C(C3)!=0, contrary to the defining property of a repair.
This uses the actual map and the original Hodge line.
