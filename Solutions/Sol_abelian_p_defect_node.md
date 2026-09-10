# Proof: one node determines every abelian 5-group cover of the test pair

[Statement](../Theorems/Thm_abelian_p_defect_node.md).
Version1,2026-09-10. Author /root; focused medium audit PASS,
/root/audit_p_cover_witt_repair. No blockers to the all-degree formula
or the separate non-Galois 5-group-closure corollary. This is audited
prose with exact computational evidence, not Lean verification.
No main endpoint is changed.

Let (C,r) be the explicit genus2/F625 corank-one pair of
`explicit_genus_two_witt_obstruction`. For every ACTUAL connected finite
etale Galois cover h:T->C with nontrivial abelian5-group G, write

    G = Z/(5^a) x Z/(5^b), a>=b>=0, a>=1.

Such a group has at most two generators because the ordinary genus2
curve has dim_F5 H1_et(C,Z/5)=2. The conclusion is

    corank(Psi_T) = 2*5^a-1  if a=b,
                   2*5^b    if a>b.                         (1)

In particular EVERY cyclic5-power cover has defect exactly2. Every
nontrivial abelian5-cover kills epsilon(C,r), but remains nonordinary;
NO repaired source W3 lift can preserve the original C-leg. The latter
two claims follow from the already audited free-summand criterion and
the negative-H1 injectivity argument. This is a uniform mechanism for
this laboratory, not an actual common-cover construction or exclusion.

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

The script [cyclic25_witt_module.sage](../scripts/cyclic25_witt_module.sage) reuses the audited
field, precision guard and affine reducer. Descending reduction of a
component (i,j) checks absolute precision>3(i+j)+2. This accounts for
every loss when a Laurent tail is moved to a lower component. At
precision220 the six inherited cases replayed in89.56s, and the new
three columns, full matrix rank and Schur reduction took46.41s, one core.
A second full replay at precision260 passed: the inherited cases took
106.62s and the new calculation56.32s. The focused auditor independently
reconstructed the recorded field and full finite relation, checked its
quadratic part and all six directions, and recomputed colength9. The
costly three Laurent columns were code-reviewed, not independently
re-executed in that audit; the inherited six-cover calculation already
had an independent replay. These evidence scopes are distinct.

The resulting3x3 R_1 matrix has constant matrix EXACTLY the audited
base3x3, of rank2. An invertible2x2 pivot gives by Schur complement

    D_(T_1) = R_1/(f_1).

The [receipt](../Research/computations/cyclic25_witt_module.json) records
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

Take any polynomial lift of f to k[[s,t]]. Since characteristic!=2,
the formal Morse lemma turns it, up to a unit, into UV by an invertible
formal coordinate change. This can be proved by removing homogeneous
terms successively using the invertible linear gradient of Q. No
division by a positive integer other than2 is required.

If A=B=q, the ideal(s^q,t^q)=m^[q] is intrinsic to the maximal ideal:
q is a power of the characteristic. It is carried to(U^q,V^q) by EVERY
formal coordinate change. Thus

    length R/(f) = length k[[U,V]]/(UV,U^q,V^q)=2q-1.

If A>B=q, the tangent line t=0 is NOT a branch tangent of f, because
Q is nonzero on F5 lines. In the node ring k[[U,V]]/(UV), write
t=A_0(U)+B_0(V), both with nonzero linear coefficient. Changing each
branch coordinate separately makes t=U+V. Then

    t^q=U^q+V^q,

and quotienting by this element kills U^(q+1) and V^(q+1). Every
element of the maximal ideal has A-th power zero there, since
A>=5q>=q+1. Thus the additional equation s^A adds nothing, and

    length R/(f) = length k[[U,V]]/(UV,U^q+V^q)=2q.

This proves(1), with the cyclic case already covered separately.
The trivial cover has defect1; no special formula for it is needed.

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

## 5. What information this actually adds

The calculations have stopped being a degree-by-degree experiment:
one elementary-abelian cover and its quadratic Schur term control
ALL finite abelian5-group covers of this pair. No higher-degree AS-Witt
solver and no general rank-four theta classification is required.

For every nontrivial such cover the formula is strictly smaller than
|G|, so the audited corank-one survival theorem kills the original
epsilon. Repair still loses the C-leg. This neither creates an ordinary
second endpoint nor realizes an actual counterexample to common-cover
nonexistence. The numerical defect formula does not cover nonabelian
monodromy; the vanishing and lost-leg statement in Section4 does.

The independent [proper-theta theorem](Sol_genus_two_active_theta.md)
is now also proved. It gives obstruction-removing covers for OTHER
corank-one genus-two pairs, whereas the finite-node calculation here
gives an exact all-abelian-degree formula for this particular pair.
Neither result produces a second endpoint or synchronizes two maps.
