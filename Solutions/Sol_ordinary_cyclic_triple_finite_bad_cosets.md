# Proof record: Finite bad cosets for ordinary cyclic etale triples of genus-two curves

Canonical statement: [`ordinary_cyclic_triple_finite_bad_cosets`](../Theorems/Thm_ordinary_cyclic_triple_finite_bad_cosets.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Elliptic torsion grids and finite bad fibers for ordinary cyclic triples

Date: 2026-09-05. Author: `/root`.
Status: focused independent audit of the combined theorem: PASS,
`/root/ordinary_triple_finite_bad_fibers_check`, 2026-09-05.
[Verdict and nonbreaking clarifications](../routes/global/audits/ORDINARY_CYCLIC_TRIPLE_FINITE_BAD_FIBERS_AUDIT.md).
The elementary grid bounds also received a separate focused check from
the fresh agent `/root/elliptic_grid_divisor_bound` on this date. This is a
finite-exception theorem, NOT vanishing for every character and NOT a
solution of Litt 3. No existing special case is deleted.

## 1. The reusable finite-grid obstruction

Let E be an elliptic curve over an algebraically closed field, S a
finite subset of E(k) with n elements, and G=S times S. Use coordinates
(x,y), vertical fibers V_x={x} times E, and horizontal fibers H_y=E
times {y}. A divisor with product-polarization Hermitian matrix

    [[a,b],[b^dagger,c]]

has intersection degrees a with H_y and c with V_x. The off-diagonal
entry is an actual elliptic-curve homomorphism. No assumption on the
endomorphism ring is made.

### Lemma 1.1

(a) If an effective divisor D contains no vertical fiber through a
point of S, then |supp(D) intersect G| <= nc.

(b) If a=c=2 and b is nonzero, then

    |supp(D) intersect G| <= 3n-2,                 n>=2.

(c) If D is an irreducible nonelliptic curve with a=c=2, its grid
intersection has at most 2n points.

### Proof

For (a), intersect D with each of the n vertical fibers. The degree
of the proper intersection is c; it bounds the number of distinct
grid points in that fiber, regardless of tangencies or multiplicity.

For (b), D contains at most one vertical fiber, counted with total
divisor multiplicity. Otherwise removing two vertical fibers leaves
an effective divisor with horizontal intersection zero and the same
nonzero off-diagonal entry. But every irreducible component of an
effective divisor of horizontal intersection zero is a horizontal
fiber: its projection to the y-coordinate is constant. Such a divisor
has off-diagonal entry zero, a contradiction. If one grid column is
contained, it contributes n points, and the other columns contribute
at most 2 each. If none is contained, the bound 2n is stronger.
Part (c) follows from (a), since an irreducible nonelliptic curve is
not a vertical fiber. QED.

In particular, if n>=5 and u:G -> G is any bijection, the inverse
image under u of a grid zero set as in (c), together with a zero set
as in (b), cannot contain G minus one point. Indeed

    2n+(3n-2)=5n-2 < n^2-1.

The [general sharp grid bound](../routes/global/SHARP_ELLIPTIC_GRID_DIVISOR_INTERSECTION_BOUNDS.md)
treats arbitrary positive coordinate degrees, with sharp examples.
This is a counting obstruction for divisors under different finite-grid
parameterizations. It is not an assertion that a low-degree divisor
avoids all torsion. The bound in (b) is sharp: the two coordinate
fibers through zero and the diagonal give 3n-2 points when S is a
subgroup.

## 2. An actual geometric application

Let k=Fbar_5, let Y be ordinary of genus two, and let

                     q:U -> Y

be a connected finite etale cyclic cover of degree three. Assume U
is ordinary. On scalar Frobenius twists put

    J=J(U^(1)),  A=im(q^(1)*),  P=(ker Nm_q^(1))^0,
    Q=J/A,      pi:J -> Q.

Define the bad-fiber locus

    B={z in Q : pi^(-1)(z) is contained in Theta_U},

where Theta_U is the Raynaud divisor of B_U. These are actual fibers
of the one fixed Jacobian quotient, not arbitrary Jacobian factors.

### Theorem 2.1

B is a finite closed subset of Q and does not contain zero.
Equivalently, only finitely many cosets of A can be contained in
Theta_U. Every other coset has a nonempty open good locus.

The finiteness includes all geometric points, with no restriction on
torsion order. It does NOT prove B empty or eliminate isolated bad
fibers. The ordinary-U hypothesis is additional to ordinary Y.

## 3. Polarization data and the whole divisorial bad locus

The exact algebraic Prym calculation in
[the cyclic-triple note](../routes/global/CYCLIC_TRIPLE_GENUS_TWO_PRYM_AND_BAD_AXIS_COMPONENT_BOUNDARY.md),
Section 1, gives an ordinary elliptic curve E and identifications

    P=E^2,       Q=E^2,
    L_P = H = [[2,-1],[-1,2]],
    L_Q = H# = [[2,1],[1,2]],
    psi=pi|P = H,      deg(psi)=9.

Here E denotes the scalar-twisted elliptic curve. Its ordinarity is
equivalent to that of U when Y is ordinary, since J(U) is isogenous
to J(Y) times E^2. The generator of C3 acts on Q by

    R=[[-1,-1],[1,0]].

The source note proves these statements by algebraic pullback and norm
identities in characteristic five, not a characteristic-zero lift.

The locus B is closed: its complement is the image of
J minus Theta_U under the smooth map pi, hence is open. The zero
fiber A is good by the C3 character decomposition and Raynaud's theta
theorem for Y. Since U is ordinary, zero is not in Theta_U, so the
restriction Theta_U|P is an effective divisor of class 4H.

Suppose B has a curve component. For each such component D, pi^(-1)D
is an irreducible divisor component of Theta_U; take its actual
multiplicity. Let D_Q be their sum with these multiplicities. It is
a nonzero effective divisor on Q, invariant under R and inversion,
and it avoids zero. We have an effective residual divisor on P:

    D_P = Theta_U|P - psi^*D_Q.                       (1)

Write the Hermitian class of D_Q as M. Invariance R^dagger M R=M
gives

    M=[[a,b],[b^dagger,a]],       b+b^dagger=[a].       (2)

Here a is a positive integer; an effective nonzero divisor cannot
have both coordinate degrees zero. On an abelian variety every
effective divisor is nef. Therefore M and

    N=4H-HMH
     =[[8-3a, 3a-4-3b],
       [3a-4-3b^dagger, 8-3a]]                      (3)

are positive semidefinite Hermitian matrices. In particular a=1 or2.
These numerical computations remain valid for arbitrary End(E).

If a=1, (2) and nefness give 0<deg b<=1, hence deg b=1 and
b^2-b+1=0. Thus E has an automorphism of order three. In characteristic
five its short Weierstrass model then has the form y^2=x^3+c, whose
Hasse invariant is zero. This contradicts ordinarity of E.

If a=2, set u=b-1. Then u+u^dagger=0 and (3) becomes

    N=[[2,-1-3u],[-1-3u^dagger,2]].

The norm of its off-diagonal entry is 1+9 deg(u). Nefness gives

    1+9 deg(u)<=4.

Degree is a nonnegative integer and vanishes only for the zero
endomorphism. Hence u=0. We have proved the exact numerical classes

                    D_Q equivalent L_Q,
                    D_P equivalent L_P.                    (4)

This uses the entire invariant divisorial bad locus at once, not a
dimension-specific enumeration of covering degrees or endomorphism
rings.

## 4. The remaining effective configurations

For any irreducible curve C in Q, L_Q.C>=2. For an elliptic translate,
write L_Q as the sum of the two coordinate elliptic curves and the
anti-diagonal. Its degree is the sum of degrees of x,y,x+y on its
underlying elliptic subgroup. If any is zero, the subgroup is one of
these three directions and the sum is two. If none is zero the sum
is at least three. Thus equality two singles out these three
directions, with no restriction on End(E).

For a nonelliptic curve, C^2>=2; the Hodge index theorem and L_Q^2=6
give (L_Q.C)^2>=12, so L_Q.C>=4. There are no rational curves in Q.
There is no R-stable elliptic translate: its underlying subgroup
would carry a nontrivial order-three automorphism and be isogenous
to the ordinary E, contradicting the preceding Hasse argument.

Since L_Q.D_Q=6 by (4), there are just two possibilities needed here:

* D_Q is one irreducible nonelliptic curve of multiplicity one; or
* D_Q consists of a single R-orbit of three elliptic translates,
  each of L_Q-degree two and multiplicity one.

Indeed, a nonelliptic component in an orbit of length three would
already cost at least twelve. An invariant such component has degree
divisible by three by (2), hence costs at least six. All elliptic
orbits have length three and cost at least six.

In the second case inversion fixes each orbit member: its permutation
commutes with the transitive three-cycle and has order at most two.
Each coordinate or anti-diagonal translate is therefore given by a
nonzero two-torsion coordinate constant. The constant is nonzero
because D_Q avoids zero.

## 5. The forced five-torsion zeros contradict (4)

Let S=E[5](k), a subgroup of order five, and let G=S^2. On the
already scalar-twisted ordinary elliptic curve, these are exactly
the geometric points of the relevant Verschiebung kernel. With the
identifications above, the same grid is used in P and Q, and psi=H
permutes it because det(H)=3 is invertible modulo five.

Every nonidentity alpha in G, regarded as a line bundle on U^(1),
satisfies F_U^*alpha=O_U. Tensoring the Frobenius exact sequence by
alpha gives an injection

    k=H^0(U,O_U) -> H^0(U^(1),B_U tensor alpha).

Consequently Theta_U|P contains all 24 nonidentity grid points.

In the first case of Section 4, Lemma 1.1(c) bounds D_Q intersect G
by ten points; in the second case its grid intersection is empty,
since nonzero two-torsion constants cannot be five-torsion.
By (4), D_P has diagonal degrees two and off-diagonal entry -1,
so Lemma 1.1(b) bounds D_P intersect G by thirteen points.

Equation (1) and bijectivity of psi on G would therefore put the 24
mandatory points in a union of at most 10+13=23 points. Contradiction.
There is no curve component of B. A proper closed subset of the
projective surface Q with no curve component is finite. This proves
Theorem 2.1. QED.

## 6. A parameterized consequence in unbounded abelian degree

For alpha in P(k), let

    delta_alpha = generic_L h^0(U^(1),
                         B_U tensor alpha tensor q^(1)*L).

It is positive exactly when psi(alpha) belongs to B. Theorem 2.1 and
finiteness of psi imply that the set of such alpha is finite.

Restrict to prime-to-five torsion alpha, and let Lambda_0 be the
finite subgroup they generate. For every finite prime-to-five
character subgroup Lambda of P(k), construct its connected abelian
etale character cover first on U^(1), and untwist to obtain
W_Lambda -> U. Character decomposition on the scalar twists gives

    generic_L h^0(W_Lambda^(1),
           B_WLambda tensor (q b_Lambda)^(1)*L)
       = sum_(alpha in Lambda) delta_alpha.                 (5)

The generic locus is a finite intersection for each Lambda, so no
single point good for infinitely many covers is assumed. Equation
(5) is uniformly bounded in Lambda and becomes constant whenever
Lambda contains Lambda_0, with no bound on its degree or prime support.
The constant is allowed to be positive. If Lambda meets the finite
exceptional set trivially, (5) is zero, since the zero character is
good.

This is bounded generic defect along the actual Y-parameter family.
It is NOT a uniform a-number bound for W_Lambda, NOT ordinarity of its
relative Prym, and NOT vanishing for every abelian cover. Those
stronger conclusions do not follow from the generic parameter test.
If an actual second etale map from W_Lambda exists, it is preserved;
no second map is constructed by this argument.

## 7. Sources and remaining boundary

Prym and polarization inputs are proved algebraically and compared
with Lange--Ortega and Agostini in the linked source note. Raynaud's
class, symmetry, and Frobenius exact sequence are recorded in
[Tong, Sections 1.2.1 and 1.2.3](https://arxiv.org/pdf/0712.2046).
Only the ordinary case is used here; no claim for supersingular E
is made. The finite-grid lemma is elementary and parameterized.

The remaining obstruction is now a finite set of isolated cosets
for this whole cyclic-triple family. Proving that set empty would
require additional input. Arbitrary covering groups and the separate
cofinal-correspondence-tower bridge remain outside the theorem.
