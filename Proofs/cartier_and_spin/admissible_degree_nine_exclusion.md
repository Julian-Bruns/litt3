# Proof: the complete degree-nine discriminant boundary

24 September 2026. Preserve an actual connected etale h:S->X of
degree nine and the primitive q=f+b^5 from reconstruction. The
[unrestricted norm theorem](uniform_admissible_norm.md) forces
h_*E=5B. Every positive coefficient of B is at most one, so all
twelve finite marked points cannot occur. The previous low-degree
and support reduction therefore applies: B is one of the four sums
of three complete cubic fibers over roots of A, and B~9O.

The full returned proof and its prior reduction are respectively
[REPORT](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/originals/boundary/degree9_cartier_boundary_resolved/REPORT.md)
and [prior-stage REPORT](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/originals/boundary/degree9_cartier_boundary_resolved/prior_stage/REPORT.md).
The following outlines the retained equations and exhaustive boundary
argument. It does not replace the actual cover by a solution of a
necessary polynomial system.

Let b_3 be the monic polynomial of the three selected base roots.
Then h_*G~9O, and its section lies in the polynomial pencil
\[
v=\lambda p_0+\mu p_1,\quad
p_0=(1,0,18,20),\quad p_1=(0,1,15,11).
\]
The primitive has degree nine over k(X); otherwise its intermediate
etale quotient inherits the primitive divisor conditions and violates
the earlier lower-degree norm/support bounds. Its polynomial can be
written
\[
F_b(B)=(B^5+f)H_4(B)+\kappa b_3^3/v,\qquad\kappa\ne0.
\]
With N_i=y^i v a_i for coefficients a_i of H_4, local regularity
puts N_i in L((9+12i)O), with N_0=v. The finite-pole equations have
rank100 on128 coefficients and leave28 dimensions.

Put L=(18,20,20,15), so Q-L^5 is divisible by A^3. At a selected
root the five actual local branches of b have the required triple
primitive zero. After Z=yb, their collision imposes
\[
D(N_4-LN_3+L^2N_2-L^3N_1+L^4v)+\kappa P^3=0\pmod {b_3^2},
\]
\[
N_3-2LN_2+3L^2N_1-4L^3v=0\pmod {b_3},\qquad
D=(Q-L^5)/b_3^3.
\]
This linear system has rank26 on29 coordinates. Normalize the
nonzero kappa by common polynomial scaling. The remaining geometric
parameters are s and rho=nu^3; cubing is surjective over k.

For the resulting F_Z=(Z^5+Q)J_4(Z)+kappa b_3^3P^3, remove the
forced factor P^24 b_3^20 from its discriminant. The quotient is an
actual regular function delta on X, with pole bound108O. An actual
etale cover makes its divisor even. Its norm to k(x) is therefore a
square polynomial N(x;s,rho). This argument uses the rational base:
it does not assert that an even divisor on X itself is principal.

The certificate rebuilds N exactly with degree_x<=108 and weighted
parameter degree<=33, and verifies those bounds symbolically. Its
leading coefficient is ell(s)^3, where ell has degree11 and is
squarefree. For ell!=0, three necessary square-root equations have
bidegrees (902,27),(924,28),(935,28). Their two resultants have
degrees47936 and48233. After removing only the certified leading
factor ell^756, the residual polynomials have an explicit Bezout
identity equal to one. Thus this open set is empty over k.

When ell=0 and rho=0 the norm has odd degree105. When ell=0 and
rho!=0 it has degree106; separate resultant identities, with gcd
one against ell, exclude every geometric root. These cases exhaust
the boundary, including vanished leading coefficients. All four
support choices are included by the checked arithmetic conjugation.

The [verifier](../../scripts/arithmetic/pro_cubic_returns_boundary_20260924/boundary/degree9_cartier_boundary_resolved/verify.py)
regenerated the norm, square equations, resultants, Bezout identity,
exceptional cases and prior-stage checks. The independent Python
cross-checks also passed; see the
[executed log](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/logs/boundary_replay.log).
On this Mac only a standard-header and GMP compiler wrapper was used;
the arithmetic and proof algorithms were unchanged.

This excludes degree nine without a prime-to-five monodromy assumption.
The earlier degree-seven trace and degree-eight support proofs exclude
lower remaining degrees. The new uniform norm proof removes their
former missed-finite-point qualification, completing all n<=9.
