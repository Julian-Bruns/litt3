# Proof: the marked class forces the cubic leading coefficient to vanish

Version1,3 October2026. Independently accepted in the [whole degree-four audit](../../Research/audits/Q0_TENSOR_DEGREE_FOUR_WHOLE_RECOGNITION_AUDIT_2026_10_03.md). Both sign families are handled together by the coprime coefficient identities. No computation is used.

Scale D to ONE in the [accepted elliptic coprime normal form](actual_q0_tensor_degree_four_elliptic_hyperelliptic_form.md). Thus
\[
b=vz+w,\quad c=z+u,\quad L=L1z+L0,
\quad \Phi=z[L^2+(z-\omega^2)(z-a)],\quad \omega^2+\omega+1=0,
\]
\[
a=\omega^2w^2,\qquad 2u-v^2=-a-1-\omega,
\qquad u^2-2vw=a(1+\omega)+\omega.
\]
Write b_a=va+w,c_a=a+u, both nonzero, and p=L1²+ONE≠0. The constant coefficient r0=Φ′(0)=L0²+ω²a is nonzero. Let U,C,V,W and the large/small factors Gi,Fi be the derivative polynomials from the [trivial-class proof](actual_q0_tensor_degree_four_elliptic_trivial_class_exclusion.md). Their identities, independently of a trivial-class assumption, are
\[
F1G1=\Phi U^2,\quad F2G2=\Phi C^2,
\quad F1+G1=2V,\quad F2+G2=2W.
\]
The argument there that B2=vL1 cannot vanish uses only actual poles and the branch Sidon input. Hence v,L1≠0; both Gi have degree FOUR, with leading coefficients4vp and3p.

Suppose the common class is represented by Φ/z. Its two simple finite branch roots are the nonzero roots of Φ. Therefore
\[
G1=4v(\Phi/z)(z-h)^2,\qquad G2=3(\Phi/z)(z-j)^2.
\]
Their allocated linear factors divide U,C respectively: at a simple branch root of Φ a square factor must also occur in the derivative polynomial; at any other root it must come entirely from that polynomial. Thus C(j)=0 and the small factors are z times polynomial squares. This statement allows U to have degree ONE; no degree-TWO open on U has been imposed.

At ZERO, F1(0)=F2(0)=0. Direct derivative evaluation gives
\[
2V(0)=3aw r0,\qquad 2W(0)=-au r0.
\]
The factor sums imply
\[
h^2=2aw/v,\qquad j^2=3au.
\]
At a the actual norm squares vanish, and G1(a)=−b_aΦ(a),G2(a)=−c_aΦ(a). Hence
\[
(a-h)^2=a b_a/v,\qquad (a-j)^2=3a c_a.
\]
Subtracting the second zero-value equation from its a-value equation gives j=−a and u=2a. The first pair gives h=w/(2v) and av=2w. All canceled factors a,w,v,r0,Φ(a) are nonzero by actual poles and smoothness; u=0 was initially retained and is now excluded by u=2a.

Insert u=2a into the first coprime coefficient relation. It gives v²=ONE+ω=−ω². Since av=2w and a=ω²w², one also has vw=2ω. Squaring then gives w²=ONE and a=ω². Thus
\[
u=2a,\quad av=2w,\quad v^2=-a,\quad a=\omega^2.
\]
Now C=(bL)′(z−a)−bL. At j=−a its value is
\[
C(-a)=L1(3a^2v-aw)-L0(av+w)=-3wL0.
\]
Since C(j)=0 and w≠0, L0=ZERO. Consequently
\[
\Phi=(T+1)z^3-2az^2+a^2z,\qquad T=L1^2\ne0.
\]
Put q=−2a, the z2 coefficient of Φ. The z3 coefficient of2W is p u+2q. The large factor G2 contributes3q−p j. The small factor contributes (vL1)²/3=2v²T. Thus
\[
q=p(u+j)-2v^2T.
\]
Substituting u=2a,j=−a,v²=−a,q=3a gives3=p+2T=ONE+3T. Therefore T=FOUR, and p=T+ONE=ZERO. This contradicts the actual cubic degree of Φ.

No sign, ramification allocation or U degree-drop case was removed. Only the two nontrivial classes containing ZERO remain. Both original finite étale maps from the SAME source stay retained throughout.
