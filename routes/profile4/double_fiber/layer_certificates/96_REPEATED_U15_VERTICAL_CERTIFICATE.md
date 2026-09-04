# Repeated-\(u^{15}\) vertical rank reduction

## Referee status

The determinant implication and the degree-separation argument are
**proved-text conditional on the displayed response formulas**.  The key
scalar formula \(\operatorname{coeff}_{s^2}(u15_3/p)=4\) is only
**certificate-transcript**: its cited symbolic verifier is absent.  This
file therefore does not independently certify the repeated-\(u^{15}\)
layer.

## Computational premises

Work over \(k=\overline{\mathbb F}_5\) and use the étale cubic algebra of
[file 80](80_REPEATED_BRANCH_LINEAR_ALGEBRA.md).  Normalize by the common
unit \(p\).  Assume the old identities

\[
\operatorname{coeff}_{s^2}(U_I)=4,\qquad
\operatorname{coeff}_{s^2}(U_L)=0,\qquad U_M-U_L=s.
\tag{96.1}
\]

For a new tail perturbation

\[
\delta F=u(u-1)u^a w^b v,
\]

the recorded repeated-\(u^{15}\) response formula is

\[
\operatorname{Raw}_{15}(a,b)
=\ell^{-1}[u^{25-a-b}]Q^{b-2}T^{-1}.
\]

After the simple-\(u^{15}\) correction, it reports

\[
\begin{aligned}
u13_3/p&=1,&
u12_1/p&=U_L,\\
u14_3/p&=U_L+3s,&
\operatorname{coeff}_{s^2}(u15_3/p)&=4.
\end{aligned}
\tag{96.2}
\]

The last identity was output by a missing symbolic program; the recorded
finite samples do not prove it over \(k\).

## Conditional determinant proof

Write \(U_L=a+ds\), and let \(\nu=N_{A/k}(p)\).  As in file 92,

\[
\rho_3=\nu d,\qquad \rho_4=\nu(d+1).
\]

Using (96.2) and coordinates in the basis \(1,s,s^2\),

\[
[u15_3,u13_3,u12_1]=4\rho_3.
\]

On the fallback stratum \(\rho_3=0\), one has \(d=0\) and
\(\rho_4=\nu\), while \(u14_3/p=U_L+3s\).  Hence

\[
[u15_3,u14_3,u13_3]=3\rho_4.
\]

Thus the new-tail coefficient matrix has row rank \(3\) on
\(D(\rho_3)\) and on \(V(\rho_3)\cap D(\rho_4)\).  Conditional on the
premises, the repeated-\(u^{15}\) affine equations are solvable in the new
tail variables for every fixed older point.  Their solution set is an affine
space of codimension \(3\) in the full new-tail variable space.  The former
claim that it is specifically three-dimensional requires an explicit count
of all new variables, which this file does not provide.

## Dependence on older free coordinates

Only \(Q\bmod u^3\) and \(T\bmod u^3\) enter (96.2).  A perturbation in a
coefficient \(F_a\) with \(a\ge11\) begins in the repeated branch equation
in degree at least \(12\), so it cannot alter the branch coefficients that
determine \(Q\bmod u^3\).  Its \(w\)-derivative likewise begins too late to
alter \(T\bmod u^3\).  The fixed \(F_8,F_9,F_{10}\) layer also starts too
late: \(F_8w^8\) begins in degree \(9\), and its derivative affects
\(u^5T\) only from degree \(8\), i.e. \(T\) from degree \(3\).

Consequently, once (96.2) is proved on the low branch data, the same
determinant identities hold fiberwise over the earlier solved graph.  This
degree argument does not itself prove the missing scalar identity.
