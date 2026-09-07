# A stable acyclic hyperelliptic family has normal corank two

Let k be algebraically closed of characteristic different from2, g>=4,
n=g-1, and let C:y^2=F(x) be smooth hyperelliptic with F monic of
degree2g+1. Its point at infinity is O and omega=O(2n O).
Choose a monic degree-g divisor D of F, put z=y/D, and let B be the
sum of the g branch points selected by D. Set

    L=O(B-3O),          deg L=n-2,          H0(L)=0.

Choose two distinct nonbranch finite x values. Their two complete
hyperelliptic fibers give four points P_i=(x_i,y_i), and put z_i=y_i/D(x_i).
Choose four pairwise distinct directions a_i=(1,r_i) in k^2. Let V be
the positive elementary modification of L+L which allows a simple pole
in direction a_i at P_i. Assume the following matrix is invertible:

    [ 1     1     1     1    ]
    [ r_1   r_2   r_3   r_4  ]
    [ z_1   z_2   z_3   z_4  ].                          (1)
    [z_1r_1 z_2r_2 z_3r_3 z_4r_4]

Then V is stable, det V=omega, and H0(V)=H1(V)=0.

Set E=V omega. For EVERY nowhere-zero u in H0(E), use its actual
extension 0->O->E->omega^3->0 to form the alternating matrices A_s.
For EVERY basepoint-free canonical pencil, this alternating pencil has
normal corank EXACTLY2. This is not a generic-u assertion.

The mechanism is an explicit calculation over k(x). Every section has
the form u=u_0(x)+z u_1(x). Nowhere-zero forces
det(u_0,u_1)!=0. Every Higgs matrix is a polynomial matrix of degree<=n
plus ONE pole-residue parameter. Modulo a generic degree-n canonical
polynomial S, the radical condition determines the polynomial remainder
from that parameter. The constant quotient matrix has three independent
trace-free constraints. Thus the radical has dimension at most2; its
alternation and its nonzero common vector give equality.

Single pencil members need NOT have corank2. An explicit genus-four
member of this family over F25, with a nowhere-zero u, has corank6 at
s=dx/y and normal corank2. The complete small evaluation matrix and
reconstruction data are saved and checked by
`scripts/geometric_corank_genus_four.sage`.

Status: author proof,2026-09-07; no independent audit claimed. This is a
parameterized family of stable acyclic bundles. No dormant-oper
equations, atlas R equations, or Frobenius normalization are asserted for
this family. It neither proves normal corank2 for arbitrary stable
acyclic V nor produces a geometric example of higher NORMAL corank.
In particular it does not settle orbit0011 or the common-cover problem.
[Proof](../Solutions/Sol_hyperelliptic_modification_pencil_rank.md).
