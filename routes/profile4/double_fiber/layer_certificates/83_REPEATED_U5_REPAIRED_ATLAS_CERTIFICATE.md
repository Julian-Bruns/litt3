# Repeated-\(u^5\) two-chart atlas

## Referee status

The linear-algebra implication in this file is **proved-text**.  The crucial
identity \(\operatorname{coeff}_{s^2}(I/p)=4\) is only
**certificate-transcript** in file 81,
because its symbolic source and a self-contained derivation are absent.
Accordingly, the atlas is presently a conditional theorem, not a
self-contained certificate in this checkout.

## Conditional proposition

Work over \(k=\overline{\mathbb F}_5\).  At every geometric point of the
clean repeated branch \(\Delta_0\ne0\), use the étale cubic algebra \(A\)
and determinant convention of
[file 80](80_REPEATED_BRANCH_LINEAR_ALGEBRA.md).  Let

\[
 I,\ L,\ M,\ p\in A,\qquad p\in A^\times,
\]

be the repeated-\(u^5\) response columns at that point, and put
\(U_I=I/p\), \(U_L=L/p\), and \(U_M=M/p\).  Assume

\[
 \operatorname{coeff}_{s^2}(U_I)=4,\qquad U_M-U_L=s.
\tag{83.1}
\]

Then

\[
 \rho_3=[I,L,p],\qquad \rho_4=[I,M,p]
\]

cannot vanish simultaneously.  Hence the principal opens
\(D(\rho_3)\) and \(D(\rho_4)\) cover the clean repeated-\(u^5\) locus.

## Proof

Fix a geometric point.  The first identity in (83.1) shows that
\(U_I\notin k\), so \(I,p\) are
linearly independent.  Moreover \(s\notin\operatorname{span}_k(1,U_I)\):
if \(s=a+bU_I\), comparison of \(s^2\)-coefficients gives \(4b=0\), hence
\(b=0\), and then \(s=a\), contrary to the independence of
\(1,s,s^2\).

If both \(\rho_3\) and \(\rho_4\) vanished, then \(L\) and \(M\) would both
belong to \(\operatorname{span}_k(I,p)\).  Division by the unit \(p\) would
put both \(U_L\) and \(U_M\) in
\(\operatorname{span}_k(U_I,1)\), and hence also
\(U_M-U_L=s\), a contradiction.  Thus at least one determinant is nonzero
at every geometric point, proving the claimed cover.

Notice that common-unit normalization is justified by

\[
[I,L,p]=N_{A/k}(p)[U_I,U_L,1],
\]

not by the formerly used expression \(p^3\).

## Exact missing premise

File 81 gives a written proof that the common column is
\(p=\ell^{-1}\).  It records, but does not independently prove, the two
identities (83.1).  Recovering their symbolic inputs or supplying a direct
derivation would promote this atlas from conditional to proved-text.
