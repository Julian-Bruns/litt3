# Proof: four modification directions leave only one pole parameter

[Statement](../../../Theorems/atlases/alternating_forms/hyperelliptic_modification_family.md).
Use the [canonical-divisor evaluation kernel](canonical_divisor_evaluation.md).

## 1. Determinant, acyclicity, and stability are checked geometrically

Write F=D R. The functions with at most simple poles at the branch points
in B and no other finite poles are exactly

    k[x] + k[x] z,             z=y/D,             z^2=R/D.

Indeed the invariant part is regular at the branch points, while the
anti-invariant part divided by z is regular everywhere finite. At O,
x has pole2 and z has pole1. No nonzero such function vanishes to
order3 at O. Hence H0(L)=0.

Twice B is
linearly equivalent to2g O; the four modification points form two
COMPLETE hyperelliptic fibers and sum to4O. Consequently

    det V=L^2(P_1+...+P_4)=O((2g-6+4)O)=omega.

The functions

    q_i=(z+z_i)/(x-x_i)

have their only additional pole at P_i, not at its conjugate. They are
allowed poles at B. With a parameter t at O satisfying x=t^-2, they
have expansions

    q_i=t+z_i t^2+O(t^3).

A rational section of V is therefore a polynomial vector in1,z plus
sum c_i a_i q_i. Vanishing to order3 at O first kills the polynomial
part, then says sum c_i a_i=0 and sum c_i z_i a_i=0. Assumption (1)
makes every c_i zero. Thus H0(V)=0; Riemann--Roch gives H1(V)=0.

For stability, let N be any saturated line subbundle of V. Its generic
direction in L+L gives a morphism h:C->P1 of degree d>=0. The saturated
core line is L tensor h^*O(-1), of degree n-2-d. Passing through the
four positive modifications can increase its degree only by one at
each point where h(P_i)=a_i. If this happens at r of them, then

    deg N=n-2-d+r.

If deg N>=n, then r>=d+2, so d<=2. For d=0 the four distinct directions
give r<=1. Degree1 is impossible on a positive-genus curve. A degree2
map on a hyperelliptic curve of genus>=2 is its hyperelliptic map up
to an automorphism of P1: otherwise two independent degree2 maps give
a birational image of bidegree(2,2) in P1xP1, whose arithmetic genus is1.
Such a map assigns the same value to conjugate points, while our four
directions are distinct, so r<=2<4. All possibilities are excluded.
Therefore every line has degree<n, proving stability over k.

## 2. A nowhere-zero section cannot have hyperelliptic-invariant direction

The core of E=V omega is (L omega)^2, and

    L omega=O(B+(2n-3)O),        deg(L omega)=3n-2.

Its sections are a(x)+b(x)z with deg a,deg b<=n-2. Let
p(x)=(x-x_1)(x-x_3), choosing one x value from each of the two fibers.
Thus every section u of E can be written

    u=u_0(x)+z u_1(x),

where each component of p u_0 and p u_1 is a polynomial of degree<=n.
Suppose det(u_0,u_1)=0. Then the direction of u is defined over k(x).
Choose a primitive pair of polynomial coordinates for this direction;
its degree d on P1 is at most n. Put H=O(2O), the hyperelliptic line.
The saturated core line is L H^(n-d), of degree3n-2-2d. A nowhere-zero
u would make its saturation in E a copy of O. If d<n, the core already
has degree at least n>0, which is impossible.

If d=n, the core is L. For g>=4 it has positive degree. For g=3 it
has degree zero and H0(L)=0; adding any modification gives positive
degree. For g=2 its degree is-1, so only L(P_i) could have degree zero.
But Riemann--Roch gives

    h0(L^-1)=h0(omega L)=h0(O(B-O))=0:

the polynomial-plus-z-polynomial description in Section1 contains no
nonzero function vanishing at O. Hence L(P_i) cannot be trivial.
All cases contradict the required copy of O, so det(u_0,u_1)!=0
for every g>=2. Negative polynomial-degree bounds here mean zero spaces.

## 3. All endomorphism-valued differentials have one residue parameter

Use theta=dx/y to trivialize omega rationally. A Higgs section of
End(E) omega is then a rational2-square matrix Phi. Away from the four
modification points its entries have no finite poles. They have pole
at most2n at O. The scalar core L omega cancels in End(E).

At P_i choose b_i complementing a_i. The modification lattice has
basis (a_i/t_i,b_i), where t_i is a local parameter. Preservation of
this lattice says that a possible simple-pole residue is a multiple of

    N_i=a_i(-r_i,1),

and that the regular part preserves the line a_i. These N_i are
trace-free, nilpotent, and kill a_i. Put

    k_i=(y+y_i)/(x-x_i).

Each has just the desired additional finite pole and leading pole
2n+1 at O with coefficient1. Consequently every Phi is uniquely of
the form

    Phi=P(x)+sum c_i N_i k_i,       deg P<=n,
    sum c_i N_i=0,                                             (2)

subject to four regular-part lattice conditions. Pairwise distinct
r_i make the N_i span the three-dimensional trace-free matrix space:
their coordinates are the degree-two Veronese vectors of r_i. The
relation space of the four N_i therefore has dimension one. Fix a
generator and write the pole part in (2) as c N(x,z).

This description is exhaustive. Subtracting the indicated pole parts
leaves an everywhere finite-regular matrix. An entry with pole<=2n at
O is a polynomial in x of degree<=n, since y has pole2n+3. Cancelling
the only excessive term of the pole part is exactly sum c_i N_i=0.
The four remaining lattice conditions are the ones already stated.

## 4. Work over the generic canonical divisor

Every canonical section is S(x)theta with deg S<=n. A basepoint-free
pencil has coprime polynomial generators and at least one generator
of degree n. Over its parameter field k(t), its generic S has degree n
and is coprime to every fixed nonzero rational numerator or denominator
appearing below. In particular it is coprime to p,D,R and det(u_0,u_1).

By the canonical-divisor radical formula, its radical consists exactly
of the Higgs sections satisfying

    Phi u=0 modulo S.                                      (3)

Work in the finite algebra k(t)[x]/(S). In its quadratic extension by
z, the elements1,z are a free basis, even when this algebra is not
geometrically reduced. Write N=N_0+z N_1 and q=R/D. Then (3) says

    Pbar u_0+c(N_0 u_0+q N_1 u_1)=0,
    Pbar u_1+c(N_0 u_1+N_1 u_0)=0.

The matrix [u_0 u_1] is invertible in this algebra by Section2. These
equations uniquely determine the degree<n remainder Pbar from the
single parameter c. Every polynomial matrix of degree<=n with that
remainder has the form

    P=Pbar(c)+S Q,                 Q a constant2-square matrix.

Thus all potential radical sections have at most five parameters: c
and the four entries of Q. The regular-part condition at P_i is now

    S(x_i) (-r_i,1) Q a_i+c d_i(t)=0.                     (4)

Each S(x_i) is a unit over k(t). The four functionals
Q |-> (-r_i,1) Q a_i have rank3, with the scalar matrices as kernel,
again by the degree-two Veronese calculation. Thus (4) cuts the
five-dimensional parameter space to dimension at most2.

The alternating radical has even dimension and contains the nonzero
common vector u. It therefore has dimension at least2. Equality follows.
This proves normal corank2 for every nowhere-zero u and every basepoint-
free canonical pencil in the family. 

## 5. A member of corank six

The [fixed witness replay](../../../scripts/atlases/verify_genus_four_corank.sage)
reconstructs a genus-four curve over F25, the four modification points,
a fixed section u, and the full24×13 Higgs evaluation matrix.
It verifies acyclicity (determinant3) and nowhere-vanishing on every
geometric point by local frames at the modified, branch and infinite
points and polynomial gcds elsewhere.

The evaluation ranks at theta, x³theta and (1+x³)theta are7,11,11,
and the rank over F25(t) is11. Hence the respective coranks are6,2,2
and the normal corank is2. The replay uses no section search; its full
matrix agrees with the original saved witness and can be exported
with `--output`. This example concerns the abstract bundle family.
