# Small-degree recognition and exact reconstruction of the pole-degree-three branch

Version 5, 24 September 2026. Use the fixed X, lambda, tau and comparison
normal form in [new_line_comparison_normal_form](new_line_comparison_normal_form.md).
Take two actual finite etale maps h_i:T->X of equal degree n, with
the same embedded lambda line, and replace T by the jointly minimal
source. If the endpoint fields are distinct, put
M=k(T), K_i=h_i^*k(X), D_i=h_i^*O, E=min(D_1,D_2), and
d=deg z=n-deg E for the canonical comparison function z. Then
\[
M=K_1(z)=K_2(z),\qquad
d\in\langle3,10\rangle\setminus\{0\},\qquad
d\le n\le d+29\lfloor d/2\rfloor.
\]
At every point P in E one has z(P)^29=kappa^18 and
ord_P(z-z(P))>=2. Both z and y_2/y_1 belong to k(x_1,x_2),
and [M:k(x_1,x_2)] is one or three.

If d<10, the latter degree is three. The simultaneous cubic quotient
S has maps r_i:S->P1 of degree n and z:S->P1 of degree m=d/3, with
\[
g(S)\le(m-1)(n-1)-3m(m-1)/2.
\]
Thus d=3 gives S=P1 and n<=32; d=6 gives g(S)<=n-4 and
n<=93; d=9 gives g(S)<=2n-11 and n<=125. Every r_i has indices
one or three and branches only above the roots of P and infinity.

Recognition holds for ALL covering degrees n<=5. The degree-four
step is an exhaustive geometric certificate of720 rational maps
with zero compatible pairs; degree five is excluded by a forced
degree-seven field of definition for a pole parameter.

The entire pole-degree-three branch d=3 is now EXCLUDED. The
following exact reconstruction systems, retained for their two-map
interpretation, have no geometric solution. For 7<=n<=26, let
D,F,G,B_1,B_2,J in k[s] have degrees n-3,n,n,n-2,n-2,7n+6,
with D monic dividing s^29-1. Write H_h for homogenization to
the degree of a polynomial H. The system is
\[
\begin{aligned}
sA_h(G,s^3D)&=\alpha A_h(F,D),\\
F'D-FD'&=m_1B_1^2,\\
sDG'-(3D+sD')G&=m_2B_2^2,\\
P_h(F,D)&=B_1^3J,\\
P_h(G,s^3D)&=cB_2^3J,
\end{aligned}
\]
where alpha,m_1,m_2,c are nonzero. Require D,B_1,B_2,J squarefree,
gcd(D,FG)=gcd(D,J)=gcd(DJ,B_1B_2)=1, and
D(0)G(0)J(0)B_1(0)B_2(0)!=0. A solution reconstructs the actual
smooth proper source and both etale maps:
\[
w^3=D^2J,\quad
(x_1,y_1)=(F/D,B_1w/D^4),\quad
(x_2,y_2)=(G/(s^3D),\rho B_2w/(s^{10}D^4)),\quad\rho^3=c.
\]
Conversely every jointly minimal counterexample with d=3 supplies
such a solution. In degrees 7..26 a complete certificate excludes
1,324,308 affine-symmetry pole layouts and 84,755,712 projective
comparison cases. The proof uses only the residue conditions from
the two derivative identities, the quartic's leading-term comparison,
and nonvanishing at common poles. It works for arbitrary quartic A
and does not use P or J. Scalar extension is unrestricted.
The degree-six system is now empty: all 70 dihedral pole layouts and
64 eighth-root choices per layout have exact unit-ideal certificates,
4,480 cases in total. Only the first three identities are needed;
the obstruction is independent of P and the coefficients of the
degree-four polynomial A. A separate residue/Vandermonde argument
excludes n=27..32. These results close d=3 in every possible covering
degree. This pole-degree-three argument does not exclude every rational
simultaneous quotient by itself. The separate
[degree-six model theorem](degree_six_new_line_models.md) now excludes
the entire d=n=6 case, in simultaneous quotient genus zero, one or two,
and consequently extends recognition through covering degree six.

Unrestricted coreless recognition and both unmarked common-cover
problems remain open.

[Proof and certificate scope](../../Proofs/cartier_and_spin/new_line_low_pole_reconstruction.md).
