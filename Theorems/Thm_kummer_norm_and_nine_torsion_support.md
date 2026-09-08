# Binomial Kummer norms and the remaining fixed-X nine-torsion support

Version 2, 2026-09-08. Status: proved, author prose with an independently
replayed exact finite calculation; no independent whole-proof audit.

Let k be algebraically closed, let ell be an odd prime different from
char(k), and let C have function field k(x,y), y^ell=F(x), of degree ell
over k(x). Write H_ell for the smooth Fermat curve U^ell+V^ell=1.

1. If Hom(J(C),J(H_ell))=0, there are no A,B,H in k(x), with B,H nonzero,
   and j prime to ell such that

       Norm_(k(C)/k(x))(A+B y^j)=H^ell.

   In particular this holds if J(C) is absolutely simple and
   g(C)>g(H_ell)=(ell-1)(ell-2)/2. For ell=3 it only requires that C
   have no elliptic quotient. No separability of the induced map to
   H_ell needs to be assumed.

For the fixed genus-nine X, with O, rho and pi as in the definitions:

2. W_2(X,O) intersect J[3^infinity] equals W_2(X,O) intersect J[3].
   It consists of exactly 66 classes, represented by the multisets of
   two of the eleven ramification points, including O.

3. An exact-order-nine class in W_3(X,O), if one exists, has a unique
   effective representative D=P+Q+R with THREE DISTINCT points.
   All support points are finite and nonbranch, and distinct support
   points have distinct x-coordinates. A certificate
   div(f)=9D-27O necessarily has the form

       f=A(x)+B(x)y+C(x)y^2,
       deg A=9, deg B<=5, deg C<=2, B!=0, C!=0.

4. Let U be the locus of classes represented by finite, branch-free
   effective degree-three divisors having at most one support point
   per x-fiber, with multiplicities allowed. Such representatives are
   unique. The endomorphism lambda=1-rho is injective on U. For every
   gamma=rho^i pi^j, i in Z and j>=0, and xi in U,

       (gamma-1)^2 xi=0 implies (gamma-1)xi=0.

The three-distinct-point support type in (3) is NOT excluded. Images under lambda need
not lie in U or W_3, so (4) cannot be iterated to remove higher torsion.
This theorem neither excludes a PGU twist nor solves the common-cover
problem. The 276 known W_3 classes killed by three remain unchanged.

Dependencies: [fixed-pair arithmetic](Thm_fixed_pair_arithmetic.md)
(author prose), and [low Abel torsion](Thm_cyclic_cubic_low_abel_torsion.md)
(audited version 4). The shared-fiber calculation is the returned Pro
certificate, replayed by /root on 2026-09-08, not a new independent audit.
Version 2 additionally excludes 2P+Q by an everywhere-rank-eight Hasse
matrix and two coprime norm-coefficient equations, with explicit Bezout
certificates. This new exclusion needs no finite-field bound or Jacobian
simplicity; it rules out div(f)=18P+9Q-27O whenever P is finite nonbranch,
Q is finite, and their abscissas differ. No whole-proof audit is claimed.

[Proof and replay instructions](../Solutions/Sol_kummer_norm_and_nine_torsion_support.md).
