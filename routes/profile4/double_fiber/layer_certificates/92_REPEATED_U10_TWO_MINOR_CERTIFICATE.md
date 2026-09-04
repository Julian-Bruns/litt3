# Repeated-\(u^{10}\) two-minor reduction

## Referee status

The determinant calculation is **proved-text conditional on the displayed
response identities**.  Those identities are supported here only by
transcripts from absent symbolic programs.  Thus the repeated-\(u^{10}\)
solve is not independently certified by this checkout.

## Setup and computational premises

Work over \(k=\overline{\mathbb F}_5\), and use the étale cubic algebra of
[file 80](80_REPEATED_BRANCH_LINEAR_ALGEBRA.md).  Normalize the old response
columns by the common unit \(p\):

\[
U_I=I/p,\qquad U_L=L/p,\qquad U_M=M/p.
\]

The incoming atlas and the missing scalar calculations assert

\[
\operatorname{coeff}_{s^2}(U_I)=4,\qquad
\operatorname{coeff}_{s^2}(U_L)=0,\qquad U_M-U_L=s.
\tag{92.1}
\]

The reported repeated-\(u^{10}\) response, after the simple-\(u^{10}\)
Schur correction, is

\[
\begin{aligned}
u18_3/p&=1,&u17_1/p&=U_L,\\
u19_2/p&=F=\operatorname{coeff}_{u^2}
                ((Q^{14}+4Q^{16})T^{-1}),&
u19_3/p&=G=\operatorname{coeff}_{u}(Q^{14}T^{-1}),
\end{aligned}
\]

with

\[
\operatorname{coeff}_{s^2}(F)=2,\qquad G=U_L+3s.
\tag{92.2}
\]

The equality for \(G\) follows formally from the closed response formula:
in characteristic \(5\), \(Q^5\equiv1\pmod{u^5}\), so its degree-one
coefficient may be compared with that of \(Q^{11}T^{-1}\).  The scalar
identities \(\operatorname{coeff}_{s^2}(U_L)=0\) and
\(\operatorname{coeff}_{s^2}(F)=2\), as well as the required closed
response formula, still need a retained exact proof.

## Conditional determinant proof

Write \(U_L=a+ds\).  From (92.1), in the basis \(1,s,s^2\),

\[
[U_I,U_L,1]=d,\qquad [U_I,U_M,1]=d+1.
\]

Let \(\nu=N_{A/k}(p)\ne0\).  Therefore

\[
\rho_3=[I,L,p]=\nu d,\qquad
\rho_4=[I,M,p]=\nu(d+1).
\tag{92.3}
\]

Using (92.2),

\[
[F,1,U_L]=2d,
\]

and hence

\[
[u19_2,u18_3,u17_1]=2\rho_3.
\tag{92.4}
\]

On the preferred fallback stratum \(\rho_3=0\), equation (92.3) gives
\(d=0\) and \(\rho_4=\nu\).  Since \(G=U_L+3s\),

\[
[F,G,1]=4,
\]

so

\[
[u19_2,u19_3,u18_3]=4\rho_4.
\tag{92.5}
\]

Thus (92.4) has nonzero determinant on \(D(\rho_3)\), while (92.5) has
nonzero determinant on \(V(\rho_3)\cap D(\rho_4)\).  Assuming the response
identities and the conditional atlas in file 83, these two locally closed
strata cover the clean branch and the new three-row affine system is
surjective in its new variables.  It consequently imposes no equation on
the older variables.

The old notation dividing determinants by \(p^3\) has been removed: the
correct common factor is the norm \(\nu\), which cancels in the determinant
ratios.
