# Repeated-\(u^{25}\) two-minor reduction

## Referee status

This is a doubly conditional result:

1. the incoming repeated-\(u^{20}\) step (note 100) is missing; and
2. the repeated-\(u^{25}\) response and scalar identities are supported only
   by transcripts from absent programs.

The determinant algebra below is **proved-text conditional on those
premises**.  It does not clear the retained tower through \(u^{25}\).

## Computational premises

Work over \(k=\overline{\mathbb F}_5\) and use the étale cubic algebra of
[file 80](80_REPEATED_BRANCH_LINEAR_ALGEBRA.md).  Suppose an incoming
solution has genuinely been carried through repeated \(u^{20}\) and the
simple-\(u^{25}\) solve in file 101.

Normalize by the common unit \(p\), and assume

\[
\operatorname{coeff}_{s^2}(U_I)=4,\qquad
\operatorname{coeff}_{s^2}(U_L)=0,\qquad U_M-U_L=s.
\tag{104.1}
\]

The recorded repeated-\(u^{25}\) response, including the simple-layer Schur
correction, is

\[
\begin{aligned}
u0_0/p&=1,&
u2_1/p&=U_L,&
u1_0/p&=U_L+s,\\
u5_3/p&=\operatorname{coeff}_{u^2}
             ((Q^{28}+Q^{31})T^{-1}),&
\operatorname{coeff}_{s^2}(u5_3/p)&=4.
\end{aligned}
\tag{104.2}
\]

The reductions \(Q^{31}\equiv Q\), \(Q^{32}\equiv Q^2\), and
\(Q^{28}\equiv Q^3\pmod{u^5}\) follow from
\(Q^5\equiv1\pmod{u^5}\) in characteristic \(5\).  They do not, by
themselves, prove the last scalar identity in (104.2); that identity and the
Schur-corrected response formula still need a retained exact proof.

## Conditional determinant proof

Write \(U_L=a+ds\), and let \(\nu=N_{A/k}(p)\).  Then

\[
\rho_3=\nu d,\qquad \rho_4=\nu(d+1).
\]

Coordinates in the basis \(1,s,s^2\) give

\[
[u5_3,u0_0,u2_1]=4\rho_3.
\]

On the fallback stratum \(\rho_3=0\), one has \(d=0\),
\(\rho_4=\nu\), and \(u1_0/p=U_L+s\).  Hence

\[
[u5_3,u1_0,u0_0]=\rho_4.
\]

Conditional on (104.1)--(104.2) and the incoming tower, these minors have
nonzero determinant on \(D(\rho_3)\) and
\(V(\rho_3)\cap D(\rho_4)\), respectively.  The repeated-\(u^{25}\)
three-row affine system is then surjective in its new variables and imposes
no equation on the older variables.

As in file 96, the selected columns use only \(Q\bmod u^3\) and
\(T\bmod u^3\), so the same degree-separation argument would make a proved
identity fiberwise over the preceding solved graph.  The missing
repeated-\(u^{20}\) theorem cannot be supplied by this observation or by
analogy with the \(u^{15}\) layer.

## Honest consequence

Within the assumed double-fiber normal form, if note 100 is recovered and
all transcript-only scalar identities in files 81, 92, 96, and this file are
independently proved, then the formal local chain reaches repeated
\(u^{25}\). This does not supply the upstream specialization \(c=d=2\) or
any further normalization used to construct that normal form. Only under
all those hypotheses is the next frontier the tail-exhausted
simple-\(u^{30}\) layer.
