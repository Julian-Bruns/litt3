# Proof: companion cancellation and the refined local spectrum

All maps are the actual maps on the same curve in the
[simultaneous quotient theorem](../../Theorems/cartier_and_spin/klein_four_simultaneous_quotients.md).
The received proof and exact local arithmetic are preserved at
`../../../litt3-computation-data/overnight_three_replies_20260926/klein/klein_four_further/`.
No action on the cubic reconstruction is introduced.

## The minors and their zeros

The degree bounds imply d_i>=0, deg T_i<=d_i, and
\[
\ell_i=e-7+d_i,\qquad\sum_i d_i=27+2j-g.
\]
Exact identities give
\[
U_jV_k-U_kV_j=E M_i,\qquad
\epsilon t^7M_i=V_jT_k-V_kT_j.
\]
The first is nonzero by primitive secants. The second bounds its
degree by e-14+d_j+d_k.

At a parameter value c with exactly one triple common pole and
inertia sigma_i, the other point p' of the t-fiber is regular for
both u and w=v-epsilon*t^4*u. Choose t-c=s^2 and sigma_i(s)=-s.
The j and k components are odd. Their s^-3 polar terms in u are
nonzero and opposite, and their s^-1 terms in w are nonzero and
opposite. This follows directly by applying the actual character
projectors to the unique pole in the other point of the same fiber;
the two polar contributions add for an odd character. Even components
cannot cancel an odd negative power.

Since w_a=T_a*z_a/(t^3*C_a) and u_a/w_a=t^3*U_a/(E*T_a),
all four U_j(c),U_k(c),T_j(c),T_k(c) are nonzero, and cancellation
forces U_j(c)/T_j(c)=U_k(c)/T_k(c). Therefore every such c is a
zero of M_i. The squarefree product J_i^(1) divides M_i.
Summing their degree bounds gives
\[
j_1\le3e-42+2(27+2j-g)=3e+12+4j-2g.
\]

For g=n+1 the preceding theorem already forces e=14, a=s, j2=0
and n=26+2j1. Then sum d_i=0, so every d_i=0 and each M_i is
a nonzero constant. Divisibility forces j1=0 and n=26.

## Exact consequences at n=91

The grid theorem gives g=79,s=a=1,j1=26,j2=0,e=27. Write c_* for
the simple common-pole value and J_i for the product of the q_i
triple-pole values with inertia sigma_i. Then
\[
E=(t-c_*)J_1J_2J_3,\quad\sum q_i=26,\quad
C_i=J_jJ_k,\quad h_i=36-q_i.
\]
Each d_i=0, hence T_i=lambda_i is a nonzero constant. Divide
E=t^7H+R, with deg H=20 and deg R<=6. The actual numerator
degree bounds force
\[
U_i=\lambda_i(\nu_i-\epsilon^{-1}H),\quad
V_i=\lambda_i(\epsilon t^7\nu_i+R),\quad\deg\nu_i\le13.
\]
The nu_i are pairwise distinct. The minor divisibility becomes
\[
\nu_j-\nu_k=J_iL_i\ne0,\quad\deg L_i\le13-q_i.
\]
Thus q_i<=13 and g_i=35-q_i lies in22..35.

Write the inertia polynomials D_i=J_iH_i. They are squarefree and
pairwise coprime, with deg H_i=10+q_i and gcd(H_i,E)=1. Leading
regular-companion cancellation for w gives
\[
A_j-\lambda_k^2H_jJ_k=J_iK_i,\quad
A_j=\lambda_j^2H_kJ_j,\quad\deg K_i\le36-2q_i.
\]
Put eta_i=nu_i-epsilon^-1 H. At each root of J_i the two relevant
U components are units, so gcd(J_i,eta_j*eta_k)=1. The odd function
u_j+u_k is regular at the companion point, whereas u_j-u_k has
pole order3. Therefore u_j^2-u_k^2 has order at least-2 there,
or at least-1 in the base parameter. Directly
\[
u_j^2-u_k^2=
\frac{H_i(A_j\eta_j^2-\lambda_k^2H_jJ_k\eta_k^2)}
 {E^2J_iJ_jJ_k}.
\]
The denominator has base order3 at each root of J_i, proving
\[
J_i^2\mid A_j\eta_j^2-\lambda_k^2H_jJ_k\eta_k^2.
\]
Using eta_j-eta_k=J_iL_i and the unit eta_k, this is equivalent to
\[
J_i\mid K_i\eta_k+2A_jL_i.
\]
These are simultaneous polynomial conditions on the actual quotients,
not a construction of them.

## Diagonal branch incidence

At cubic/tetragonal branch incidence both endpoint values are finite
P-roots and both endpoint indices are1. Eliminating t gives
\[
(dv/du)^{39}P(u)^{26}A(v)^{48}
=\epsilon^{-29}A(u)^{48}P(v)^{26}. \tag{1}
\]
If both labels equal alpha, the A-identity and ord(t-t(p))=2 give
v=alpha+s+B*s^2+O(s^3), u=alpha+s, B!=0. The constant in(1)
forces epsilon^29=1. At first order, dv/du=1+2Bs+..., P(v)/P(u)
=1+Bs+..., and A(v)/A(u)=1+O(s^2). The coefficient in(1) is
(39*2-26)B=2B, a contradiction.

For the exhaustive finite local calculation put
\[
K_*(\alpha)=P'(\alpha)^{26}A'(\alpha)^{13}/A(\alpha)^{61}.
\]
The ten values are distinct; their90 off-diagonal ordered ratios are
distinct and different from1. The degree90 product of (Z-ratio)
is squarefree and has nonzero values at0,1. The retained local
incidence equations require epsilon^29 to be one of these ratios.
For each such value the ordered root pair and the possible t-value
are unique. Direct exact arithmetic also gives t(p)^29!=1 and
epsilon*t(p)^4!=1. A ramified V4 fiber has two points, proving the
support and cardinality assertions.

All ten geometric roots of P and all100 ordered pairs are covered
by the verified splitting-field calculation; this is not a field-size
search for actual curves. The new second-jet invariant has ten
distinct values, so it excludes only the diagonal, not the90 other
pairs. All eleven archive verification commands passed locally.

The scalar spectrum applies only to nonempty incidence. None of
these arguments imposes a finite epsilon list in the disjoint case.
