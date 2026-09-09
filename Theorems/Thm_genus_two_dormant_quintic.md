# Universal genus-two dormant quintic and the two-leg matching test

In characteristic five let Y be v²=F(u), with F monic squarefree of
degree5, coefficients a0,...,a4. Set

    W(T)=T²+3a4 T+3a3, V(T)=-a2+(a4+2T)W(T),
    Psi(T)=2a0-2a1 T+a2 W(T)-V(T)W(T).

The scheme of regular dormant projective connections on Y is exactly
k[T]/(Psi), of length5, through

    r_T=2(F'/F)²-F''/F+(2u³+T u²+W(T)u+V(T))/F.

For the selected family F=u(u-1)(u-2)(u-3)(u-t), put
G(t)=t(t-1)(t-2)(t-3). The exact polynomial identity is

    Res_T(Psi,Psi')=-G(t)².

Thus EVERY smooth member of this family, including t=4, has five
distinct reduced dormant points. This asserts ordinary DORMANT opers,
not ordinarity of its Jacobian or of arbitrary etale pullbacks.

For an actual coreless no-clump span, let A=k(X), B=k(Y), M=AB, choose
separating x in A, put b=du/dx and s=-{u,x}/2. In an A-basis
1,e1,... of M expand s+b²r_T=h0(T)+sum e_j h_j(T).
All h_j have degree<=3. Then

    gcd(Psi,h1,h2,...) is 1 or T-lambda (lambda in k).

It is nonconstant iff a common regular projective connection exists.
In that case the connections are h0(lambda), r_lambda. If the gcd is1,
there is a Bezout certificate U Psi+sum V_j h_j=1 with deg U<=2,
deg V_j<=4. No bound on poles of these A-valued coefficients is asserted.

The last test REQUIRES the actual joint field. It neither enumerates
all spans nor proves existence. The five-candidate count was already
known; the explicit universal parametrization and the family resultant
are the additional usable information.

Version1,2026-09-08. Author prose and exact universal polynomial checks;
no independent audit. [Proof](../Solutions/Sol_genus_two_dormant_quintic.md).
