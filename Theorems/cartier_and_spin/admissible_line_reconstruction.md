# Exact reconstruction and fixed-divisor obstructions for one admissible line

Version2,1 October2026. Work over k=bar(F5) on the fixed
X:y^3=P(x), O at infinity. Use A=(1,21,14,22,13), f=Q/y^5,
Q'=PA^2, theta=dx/y^2, R_X=O+x^*div_0A, and the saturated
lambda_X=[f] and P_X=<[f],[f^2]> in B_X. The plane has degree7,
lambda_X=O(-2O), and F_X^*P_X evaluates everywhere onto omega_X
with kernel O(19O) and reduced second-fundamental divisor R_X.

Let h:S->X be an ACTUAL connected finite etale cover of degree n,
H=h^*O, R=h^*R_X, C=S^(1), P=h^(1)*P_X. An admissible line
means a saturated nontrivial order-five line A_0 in P with
F_S^*A_0=O_S and adjunction divisor2Delta, where Delta<=R is
reduced of degree8n. Its determinant contact with lambda is
automatically Delta^(1)+G^(1), with G effective of degree n.
The rank-three power lattice remains automatic and adds no condition.

On this fixed cover an admissible line exists IF AND ONLY IF there
are beta in k(S), reduced E<=R of degree5n and effective G of
degree n such that
\[
q=f+\beta^5,\quad \operatorname{div}q=3E-5G-10H,
\quad T=E-G-4H,\quad 5T\sim0,\quad T\not\sim0.
\]
It is then exactly Sat[q^2]=O_C(T^(1)), with Delta=R-E. In
particular E and G are disjoint. Without the order-five conditions,
the divisor identity still holds for every saturated degree-zero
line with the stated adjunction.

Existence on SOME etale cover is equivalently existence, after at
most a quadratic etale refinement of any given witness, of
\[
\operatorname{div}z=E-5H,\quad
\operatorname{div}u=5(G-H),\quad
d(z^3/u)=df,\quad u\notin k(S)^5.
\]
Both z,u belong to H^0(S,O(5H)). One can use
g=z/u^2, Sat[g]=O_C((H-G)^(1)), adjunction differential
zeta=2df/z^2 and nonzero regular connection form nu=du/u.
Also w=z/u is separable of degree5n and zeta=dw-w nu.

There is an exact test which needs no quadratic refinement. Fix the
actual source divisor identity for q above, and let a be ANY nonzero
element of H^0(S,O(10H)). Then
\[
\operatorname{div}a=2E-10H
\quad\Longleftrightarrow\quad
\nu_a=4\,da/a-dq/q=-d\log(aq)
\text{ is regular on }S.
\]
When these equivalent conditions hold,5T is automatically principal,
and
\[
T\not\sim0\quad\Longleftrightarrow\quad\nu_a\ne0.
\]
Indeed div(aq)=5T. Thus nu_a retains the canonical character of the
admissible line, without an auxiliary divisor-class comparison.
After taking z^2=a in
the preceding quadratic construction it is exactly dlog(z^3/q).
The pole bound and affine integrality of a are essential: regularity
alone permits extra fifth-power zeros and poles. This test does not
construct an actual source or remove its critical denominator.

For a fixed reduced D=Delta^(1) of degree8n define
Q_D=lambda+P(-D), of degree -n. It has at most one degree-zero
line; such a line is automatically saturated in P with the exact
required adjunction. Its Frobenius pullback has
\[
0\to O_S(19H-3\Delta)\to F_S^*Q_D
\to M_D=\omega_S(-2\Delta)\to0.
\]
Let epsilon_D be its class in H^1(O_S(3H-Delta)), a13n-dimensional
space. If epsilon_D=0, its splitting is unique. The second
fundamental form of that splitting is
beta_D in H^0(O_S(19H-Delta)). A degree-zero line in Q_D exists
exactly when epsilon_D=beta_D=0. It is admissible exactly when,
in addition, M_D is trivial and its induced connection form is nonzero.

Nonzero epsilon_D or beta_D cannot be killed by further finite
etale pullback. More precisely, a fixed D acquires an admissible
line on some etale refinement iff its unique degree-zero line
already exists and its five-primary torsion component has exact
order five. A refinement can remove its prime-to-five torsion;
it cannot change the five-primary order.

The returned base and ten special cubic-cover exclusions are now
strengthened by [the trace obstruction](admissible_line_trace_obstruction.md):
every degree<=3 etale cover is excluded, even for twisted lines,
and every descending base selection is excluded on all covers.
New non-descending selections on arbitrary larger covers remain open.

[Proof and retained cubic verification](../../Proofs/cartier_and_spin/admissible_line_reconstruction.md).
