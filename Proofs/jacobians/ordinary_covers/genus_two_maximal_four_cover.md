# Proof: effective four-torsion specialization on the prescribed family

Author /root,2026-09-09. No independent audit or Lean verification claimed.
The only genus-two theta input is the canonical raynaud_genus_two_determinant
theorem, whose global SUPPORT statement includes all Mumford boundaries.
Here every exact-order-four point will in fact be on its open chart.

## 1. The one-leg ordinary-cover condition

For any smooth genus-two C in characteristic5 its maximal abelian
exponent-four etale cover q:C_4→C has character line bundles ALL of
J(C^(1))[4] after Frobenius twisting. It is connected, degree256, genus257;
Kummer theory gives both construction and maximality. Etale base change
and the projection formula give

    a(C_4)=sum_(L in J(C^(1))[4]) h0(C^(1),B_C tensor L).

Thus it is ordinary precisely when all256 summands vanish. The preceding
maximal-two theorem proves vanishing for all16 order-dividing-two classes
in our family whenever t is outside F25. It remains to test240 classes.

## 2. A degree16 parameter field carries every four-torsion point

First let t be indeterminate and put tau=t^5, alpha=(0,1,2,3,tau).
All torsion computations below are ON C_t^(1), with equation

    v1²=F1(u)=product_i(u-alpha_i).

Work over K=F25(t)(rho_0,rho_1,rho_2,rho_3), where
rho_i²=i-t^5. This extension has degree16: the four square classes have
independent odd valuations at t=0,1,2,3. The constants contain the square
roots of all nonzero F5-elements. The associated smooth projective
parameter curve has degree16 over P1_t (and genus5).

Here is an explicit way to obtain four generators H_i of J[4]. For each
i=0,1,2,3 choose r_j²=alpha_i-alpha_j, with r_i=0 and the only
nonconstant r_j equal to rho_i. Let s_j be the elementary symmetric
functions in these five roots. Set

    U_i=(alpha_i-u)^2+s_2(alpha_i-u)+s_4,
    V_i=(s_3-s_1*s_2)(alpha_i-u)-s_1*s_4.

These are the genus-two specialization of Zarhin's division-by-two
formula; it gives 2H_i=[(alpha_i,0)-O], with H_i represented by (U_i,V_i).
The formula's proof separates the odd/even parts of product(z-r_j);
equivalently F1-(s_1 U_i+V_i)^2=(u-alpha_i)U_i^2, and the sheetwise
divisor gives the asserted doubling. See
[Zarhin, Theorem3.2 and Example3.7](https://arxiv.org/html/1809.03061v2).
Its preceding proof and the branch-point case were read directly.

The four displayed two-torsion points are independent: the only relation
among the five finite Weierstrass classes is their total sum. Therefore
the H_i generate a subgroup isomorphic to (Z/4)^4, hence all J[4].

For an explicit short addition chain, form the15 nonempty binary sums
H_b=sum b_i H_i, b_i in {0,1}. Every order-four point has a UNIQUE form

    H_b+T_c,  b!=0, c in {0,1}^4,

where T_c=sum c_i[(alpha_i,0)-O]. The16 T_c have their obvious reduced
branch-supported Mumford representatives: replace a subset of size3 or4
by its complement among all five branch points. Each H_b requires at
most three additions and its translation at most one more.

## 3. A small complete certificate and its genuine open chart

The verifier uses F5[a]/(a^6+a^4+4a^3+a^2+2), and t=a^126, of degree3
over F5. It constructs the preceding generators and checks their actual
doubling identities. It constructs all256 distinct classes, checks that
four times every class is zero, and tests all240 exact-order-four classes.

For each tested (U,V), it checks degU=2 and gcd(U,F1)=1. This open-chart
property is also intrinsic: a genus-two curve has no exact-order-four
point in its Abel image, as follows from L(4O)=span(1,u,u²); a function
with divisor4P-4O would have hyperelliptic-invariant zero divisor, forcing
P to be Weierstrass. If an order-four reduced degree-two representative
contained a Weierstrass point, subtracting that two-torsion class would
give such an order-four Abel point, again impossible.

For all240 classes the program evaluates BOTH the explicit Kummer
quadric Q_t and the original four-by-four Cartier matrix from
raynaud_genus_two_determinant. Every determinant is nonzero and the
two tests agree. The whole check takes approximately0.25 seconds after
Sage startup; no large atlas data or point search is used.

It also checks coprimality at every nontrivial addition used to form a
binary H_b. Translations by T_c are coprime because its support is
Weierstrass whereas that of H_b is not. This supplies specialization-
nonzero resultants for all the generic formulas in the next section;
we do not silently transfer a Euclidean algorithm's special degree drops.

## 4. Explicit height bound: why one specialization suffices

Use pole-divisor degree h on the projective parameter curve of K.
Then h(t)=16, h(rho_i)=40. The coefficients of F1 have height at most80;
the coefficients of the known quadric Q_t are polynomials of t-degree
at most14 and hence have height at most224. Constants have height0.
For nonzero rational functions,

    h(x+y),h(x*y) <= h(x)+h(y),  h(1/x)=h(x).

Thus a straight-line calculation starting from height<=224 and using s
field arithmetic operations has every intermediate height<=224*2^s.

We describe fixed generic addition formulas, so that this bound applies
also when intermediate specializations might otherwise change algorithms.
For coprime monic Mumford polynomials u1,u2, degrees at most2, solve the
Sylvester system of size at most4 for A*u1+B*u2=1 using Cramer's rule.
Put

    U=u1*u2, V=(A*u1*v2+B*u2*v1) mod U.

If degU>2, replace U by the monic quotient (F1-V²)/U, and V by -V
mod the new U. One such reduction suffices in genus2. The target here
always has exact order4 and therefore reduced degree2, so the required
leading coefficient is nonzero. Identities and zero classes are skipped.
All divisors being added are the coprime ones verified in Section3.

For clarity, a deliberately excessive operation bound is enough. A4x4
determinant has24 terms; the Sylvester solve needs at most five such
determinants. Polynomial degrees never exceed6; long divisions have at
most seven stages. Counting coefficient additions, multiplications and
inversions bounds ONE such addition by4096 field operations. Constructing
the four initial half points costs fewer than4096, as does evaluating
one Q_t. Four additions and these two computations cost at most24576,
less than32768. In particular the bound does not depend on the chosen
parameter, its degree, or the order of the cover group above C_4.

For each of240 labels retain its final Q_t value and the nonzero
denominators in this straight-line description. There are at most
240*(32768+1) such functions, each of height<=224*2^32768. They are
ALL nonzero functions: Section3 supplies one place where all are
defined, the requisite Sylvester resultants and leading coefficients
are nonzero, and all final Q_t values are nonzero.

For each function push forward its ZERO and POLE divisors SEPARATELY to
P1 over F25, discard infinity, and take the monic polynomial defining
their sum. Each of these effective divisors has degree at most the
height of that function. This construction is over F25, since K and the
functions are. Multiply these polynomials and t^25-t. This defines a
nonzero E in F25[t] with

    degE <=25+2*240*(32768+1)*224*2^32768 <2^100000.

Separating the positive divisors is essential: taking a reduced norm of
the rational function could cancel a zero at one place against a pole at
another over the same parameter. No such cancellation occurs here. The
effective pushforwards can equivalently be computed by norms of numerator
and denominator ideals on the normalized parameter curve, before cancellation.

If E(t0)!=0, all these formulas remain defined after every extension to
K, all240 Q_t values are nonzero, and t0 is outside F25. Thus all256
theta tests vanish, proving C_4 ordinary at t0. This argument neither
equates special and generic torsion coordinates nor assumes an unproved
generic-ordinarity theorem for this one-dimensional family.

Any algebraic parameter of degree>degE over F25 is not a root of E.
This proves the stated high-degree implication without expanding E.

## 5. Both original legs and the already selected parameter

If W→Y_t is a Galois cover with normal5-subgroup P and abelian exponent4
quotient, W/P is dominated by C_4 and is ordinary. The ordinary-p-cover
argument in genus_two_maximal_two_cover makes W ordinary, with no bound
on |P|. For an actual span X←Z→Y_t, take the genuine Galois closure of
the Y_t-leg. It still maps etale to X via Z, so nonordinary X contradicts
ordinary W. Neither original leg was assumed Galois.

Finally the selected pair uses B=336000 and its parameter degree r>K,
where K>=(B-1)!. Since (B-1)!>=2^(B-2)>2^100000, the ALREADY chosen r
suffices. No parameter replacement or extra avoidance hypothesis is made.

The exponent2 theorem is retained: it has a sharper COMPLETE exception
set and a-number formula and is not subsumed by this coarse high-degree
bound. Extending to exponent8 or nonabelian tame quotients would need
new actual-cover tests, not just the ordinary-p-group argument.
