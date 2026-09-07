# Proof: fixed points, etale fibers, and Hermitian monodromy

[Statement](../Theorems/Thm_hermitian_monodromy_genus_sieve.md).
Write s=g(C)-1. All group actions are by the indicated finite constant
groups; group orders divisible by the characteristic are allowed.

## 1. The elementary divisibility mechanism

The stabilizer G_d acts on the geometric fiber over d, which has exactly
m points because W -> D is finite etale. The action on W is free, hence
so is its action on this fiber. Thus |G_d| divides m. Riemann--Hurwitz
for W -> C and W -> D gives the genus formula in the statement.

For an atlas C -> [D/P], its pullback W_total -> C is a P-torsor and
W_total -> D is finite etale. P acts transitively on the connected
components: equivalently, the components of a finite etale torsor are
the orbits of its geometric monodromy subgroup on P. A chosen component
W has stabilizer G, W -> C is a connected G-torsor, and W -> D is still
finite etale. This justifies applying the mechanism to an atlas without
assuming its full P-torsor is connected. The atlas lifts through a normal
subgroup P0 exactly when its monodromy lies in P0.

## 2. Every outer element of order three fixes the Hermitian curve

Let sigma in PGU_3(q) have order3 and lie outside PSU_3(q). Choose a
unitary matrix A over F_(q^2) representing sigma. Then A^3=mu I with
mu in the group mu_(q+1) of norm-one scalars. Since the characteristic
is not3, A is diagonalizable over k.

Put e=(q+1)/3. If mu^e !=1, every eigenvalue lambda of A satisfies
lambda^(q+1)=mu^e !=1. The Hermitian polynomial h obeys h(Av)=h(v).
For an eigenvector v this gives

    h(v)=lambda^(q+1) h(v),

so h(v)=0. Its eigenline is a fixed point on H_q.

Otherwise mu is a cube in the cyclic group mu_(q+1). Rescale A by a
norm-one scalar so that A^3=I. If its three eigenvalues are distinct,
they are 1,zeta,zeta^2 and det A=1. Its projective class is then in
PSU, contrary to the hypothesis. Otherwise A has an eigenspace of
dimension at least2; its projective line meets H_q over k, giving a
fixed point. (A scalar would represent the identity.)

Notice that an outer order-three element need not be a homology: the
first case includes three fixed isotropic eigenlines. Only existence
of a geometric fixed point is used.

## 3. Extracting the order-three element and the genus bound

The order of PGU_3(q) is q^3(q^3+1)(q^2-1). Under v_3(q+1)=1 its
3-adic valuation is3. The projective monomial subgroup consisting of
diagonal cube roots of unity and the coordinate3-cycle has order27.
Every element has cube equal to the identity projectively: in a
non-diagonal coset the cube of its matrix is the product of the three
diagonal entries times I. Thus it is a Sylow3 subgroup of exponent3.
All Sylow3 subgroups have this property.

If G is not contained in P0, its map to P/P0=C3 is onto. A Sylow3
subgroup of G maps onto C3: its intersection with the index-three
normal kernel is Sylow in that kernel. Hence it contains sigma outside
P0, and sigma has order3 by the preceding exponent calculation.

Section2 gives a point of H_q fixed by sigma. Section1 therefore forces
3|m. Since g(H_q)-1=(q+1)(q-2)/2, Riemann--Hurwitz yields

    v_3(m)=v_3(|G|)+v_3(s)-1-v_3(q-2) >=1.

This proves (2); using v_3(|G|)<=3 gives its genus-only consequence.

## 4. The characteristic-five maximal-subgroup reduction

For q=5, 3 not dividing s forces v_3(|G|)=3. The maximal-subgroup
classification gives, for PGU_3(5), groups of orders

    3000, 720, 216, 63, 126000, 216.

The only orders divisible by27 are the two216 cases, respectively the
self-polar triangle stabilizer and the Hessian group. There is no proper
subfield case because5 is prime. Thus a proper G lies in one of these
two maximal subgroups. The classification used is Theorem3.1 of
[Montanucci--Zini, Quotients of the Hermitian curve from subgroups of
PGU(3,q) without fixed points or triangles](https://arxiv.org/pdf/1804.03398),
published in J. Algebraic Combinatorics52 (2020),339--368,
[DOI](https://doi.org/10.1007/s10801-019-00905-7). Its Section3 proves the
classification, including the Hessian extension and the exclusions of
other extensions outside PSU; no automorphism-extension conjecture is
being substituted for it.

Reduction of the frame torsor from P to M gives an actual factorization
C -> [H_5/M] -> [H_5/P]. Its first arrow is finite etale (equivalently,
form the intermediate quotient of the pulled-back torsor); its degree
is (2g(C)-2)/(18/216)=24s.

Since5 does not divide216, these quotients are tame. Their canonical
degree is1/12. If their coarse genus were at least1, a nonzero stacky
contribution would be at least1/2, and a zero contribution would give
either0 or a number at least2. Both contradict1/12. The coarse curve
is therefore P1. Four or more tame branch points likewise give either
degree0 (four points all of order2) or degree at least1/6. Thus there
are exactly three points. Sorting their orders a<=b<=c, the equation

    1/a+1/b+1/c=11/12

has precisely the solutions (2,3,12),(2,4,6),(3,3,4): a<=3, and direct
substitution for a=2,3 bounds b and gives this list.

## 5. Identify the two tame quotients without equations for the maps

Every involution of PGU_3(5) fixes exactly six geometric points of H_5.
Here is a matrix check. A unitary representative has A^2=mu I. If mu is
not a square in mu_6, each eigenvalue has sixth power -1. The at-least-
two-dimensional eigenspace would then be totally isotropic over F25,
contrary to the Witt index one of a nondegenerate three-dimensional
Hermitian space. (The eigenvalues lie in F25, since their orders divide12.)
Thus rescaling by a norm-one scalar gives eigenvalues1,-1. Their
eigenspaces are orthogonal and nondegenerate, with dimensions1 and2.
The fixed point off the axis is not on H, and the axis meets H in the
six distinct points of a nondegenerate Hermitian line.

The projective monomial group (C6 x C6) semidirect S3 has21 involutions:
three diagonal ones, and six above each of the three transpositions.
For the latter count, represent its diagonal part by (a,b,1), with
a,b in mu_6; above the transposition of the first two coordinates the
square is scalar precisely when ab=1. Conjugacy of the transpositions
gives the other twelve.

The Hessian group is (C3)^2 semidirect SL2(F3), with its natural action;
see Proposition4.1 and its generator proof in
[Artebani--Dolgachev, The Hesse pencil of plane cubic curves](https://sites.lsa.umich.edu/idolga/wp-content/uploads/sites/1334/2024/08/hesse09.pdf).
Its involutions are precisely (v,-I), one for each v in F3^2, hence nine.
Indeed -I is the only order-two matrix in SL2(F3), while a nonzero
translation has order3. Their squares are (v-v,I).

Count pairs consisting of an involution and one of its fixed points.
For a tame signature (a,b,c), each point above a branch of even order e
has a cyclic stabilizer containing exactly one involution. The number
of such pairs is therefore sum_(e even)216/e. The three possible
signatures give respectively126,198,54. The two groups give6*21=126
and6*9=54, proving (3). Effective tame stack curves over P1 with three
specified inertia orders are precisely these root stacks: local tame
cyclic charts and the unstacky complement determine them, and three
distinct coarse points can be moved to0,1,infinity.

As an independent small arithmetic check, direct enumeration of the216
affine transformations (v,A) with det A=1 over F3 gives nine involutions;
enumeration of the216 projective monomial pairs gives21. The proof does
not depend on that enumeration.

## 6. The lower-genus atlas for the Hessian target

The Fermat quartic F maps by fourth powers to the line u+v+w=0. Its
diagonal C4 x C4 quotient is the root stack P1(4,4,4): ramification
has order4 exactly at the three coordinate-zero points, and nowhere
else. The coordinate3-cycle permutes these points. On the coarse P1
it has two fixed points, neither among those three. Quotienting the
stack by this C3 therefore gives P1(3,3,4). Equivalently,

    [F/((C4 x C4) semidirect C3)] = P1(3,3,4).

All groups in this paragraph are prime to5. Pulling this atlas back
along C -> P1(3,3,4) and choosing a component gives an actual G'-torsor
R -> C with G'<=A48, and an actual finite etale map R -> F. Section1
and g(F)=3 give the displayed degree formulas. R need not be the
component of the original H-torsor; both constructions are actual
fiber products over the SAME quotient stack.

Finally `hermitian_atlas_extension_criterion` identifies the obstruction
to a PSU lift with the torsion line tau. A18, only when explicitly
assumed, removes the trivial-tau case. It does not remove the remaining
three alternatives and it does not constrain a separate Y-factorization.
