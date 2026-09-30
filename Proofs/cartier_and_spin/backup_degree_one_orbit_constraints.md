# Proof: refinements of the actual degree-one orbit

[Statement](../../Theorems/cartier_and_spin/backup_degree_one_orbit_constraints.md).
23September2026. The two returned degree-one replies are integrated
after a focused author check and replay of their new certificate.
Retain the [four-plane classification](../../Theorems/cartier_and_spin/backup_degree_one_cartier_planes.md)
and the [fixed-X Frobenius sequence](../../Theorems/cartier_and_spin/cartier_generated_frobenius_hn.md).
All divisors and maps refer to the same proper étale source.

Write \(M_Y=E^\perp\). The four-plane table puts the simple zero of
the restricted pairing on \(E\) at \(y=F_Y(P)\), distinct from its
first-Frobenius branch point \(z\). Each radical
\(\ell_i\subset q^{(1)*}E\) gives
\(q^{(1)*}M_Y\subset\ell_i^\perp=h_i^{(1)*}U\).
After quotienting by \(\ell_i\), this maps to
\(h_i^{(1)*}N_X\), where
\(N_X=\mathcal O(6O)\oplus\mathcal O(10O)\).
Away from \(S'=q^{(1)*}y\), the planes \(E,M_Y\) are complementary,
so the map is an isomorphism. At \(S'\) they coincide and the
map's determinant is the restricted pairing on \(E\), up to a unit
in local symplectic frames. Its simple zero makes the quotient invertible
on \(\mathcal O_{S'}\). This is the actual elementary modification
used below, on the same source as every \(h_i\).

## Logarithmic form and the section condition

For M_Y=E-perp the determinant and Frobenius sequence give
F^*det M_Y=omega_Y^3(-z)=omega_Y^5(-5P). Thus
O(5P-z)=omega_Y^2=O(4z), so delta_P=O(P-z) has order five.
It is nontrivial because P differs from z on a curve of positive genus.

In the four-plane formulas div(r)=z+4O_Y-5P_+. Therefore
b=(u-alpha)^2 r has div(b)=5z-5P_+. Differentiation and the two
quadratic-function-field coefficient identities give
\[
d\log b=(3\alpha^2+4)(u+1)\,du/v.
\]
The hyperelliptic involution changes its sign. If a finite étale
pullback trivialized delta_P, b upstairs would be a fifth power
times a constant, contradicting separability and this nonzero form.
No X-descent of this form follows.

Put O_i=h_i^*O, Z=q^*z, Theta=O_T(Z), and
epsilon_i=Theta O_T(-8O_i). Both Theta and O(8O_i) are theta
characteristics, so epsilon_i^2=O. The common upper line is
\[
A_T=q^*\omega_Y^2(-z)=O_T(24O_i)\epsilon_i.
\]
Its actual saturated inclusion in h_i^*H_X gives
epsilon_i->h_i^*K_X. A connected component of the product of the
quadratic torsors trivializes all epsilon_i. Saturation is preserved,
and det K_X=O_X(O), proving the required exact sequences.
The original projection A_T->O(30O_i) gives
O(C_i)=O(6O_i)epsilon_i=O(Z-2O_i).

## Separating the modification direction

On T^(1) let M=q^*M_Y and N_i=h_i^*(O(6O)+O(10O)).
The map M->N_i is an elementary modification along S'=q^*y.
Project it to O(6O_i'). Its image is O(6O_i'-B_i'), for a
reduced B_i' contained in S'; it has no other image defect.
Its saturated kernel L_i has
\[
L_i=O(10O_i'-S'+B_i'),\qquad \deg L_i=2d+\deg B_i'.
\]
Pulling back by Frobenius yields quotient O(30O_i)(-5B_i).
Compare this exact sequence with the evaluation sequence
0->A_T->F^*M->omega_T->0. The determinants of the two saturated
lines give identical zero divisors in their respective quotients.
Restoring the final inclusion in O(30O_i) gives
\[
C_i=5B_i+D(L_i).
\]
A horizontal primitive line in a plane with evaluation orders (0,1)
can vanish only to order1. At the simple branching locus, where
the orders are (0,2), it can vanish only to order2. Coefficients
are fifth powers and a unit coefficient cannot cancel these first
terms. Hence D(L_i)=Delta_i+2Z_i, with the stated reduced supports.
Degrees give 5deg B_i+deg Delta_i+2deg Z_i=6d.

For joint minimality, let J=Gal(T/Z) and let H stabilize the
embedded X-field. Restriction H->Aut(X)=C3 has kernel J, so
e=[H:J] is1 or3 and N=8deg(f)/e is divisible by8.
The B_i' form a full orbit, so sum B_i'=q^*(b_0y).
Their common degree and the last inequality imply
8d b_0<=N(6d/5), hence b_0<=floor(3N/20).
This is the exact number of exceptional indices over any point of S'.

The Wronskian of A_T in F^*N_i has divisor 5q^*P+q^*z.
All these Wronskians span the same pulled-back tricanonical line.
Their defining maps contain A_T, which has not descended through h_i;
they are not thereby X-descended sections.

## The certified further Frobenius sequence

Use absolute Frobenius, including fifth powers of all coefficients.
In the rational frame of the three original sections, H_X is the
kernel of evaluation sum q_i c_i. At a finite root b of P the
lattice of F_X^*U is O^3+O v_b/y^5, where v_b spans the common
kernel of q(b),q'(b). Their Wronskian with q'' is coprime to P.
At infinity, with t=x^3/y, its lattice is
t^-10 O e_0+t^-5 O e_1+O e_2.

Consequently F_abs^*H_X is the kernel of sum q_i^5 c_i in the
lattices O^3+O v_b^5/y^25 and
t^-50 O e_0+t^-25 O e_1+O e_2.
Writing a cubic-character component as c_i=y^j a_i(x)/y^25
reduces global sections of the twist by -nO to exact polynomial
syzygies and rootwise congruences. The degree bounds are
floor((300-n-10j)/3), floor((275-n-10j)/3),
floor((250-n-10j)/3).

The [supplied reconstruction](../../scripts/arithmetic/pro_cartier_hx_frobenius.py)
gives no sections at n=119,120,123,126, and one at n=118.
The latter has c_i=a_i/P^8 with degrees55,49,40. Their gcd is1;
the next branch residual is (13,5,20,0,23,14,0,18,4), coprime to P.
Its coefficient orders in the infinity lattice are125,118,120.
Thus the section of F_abs^*H_X(-118O) is nowhere zero. Its quotient
is O(127O), since deg F_abs^*H_X=245.
The rebuilt JSON agrees with the supplied JSON exactly. Neither
this section calculation nor its uniqueness asserts a full HN census.

## The second actual divisor family

Pull A_T into F_abs^*h_i^*H_X. Its fifth power is
O(120O_i)epsilon_i, since epsilon_i has order2.
It cannot map into O(118O_i), so projection to O(127O_i)
is nonzero and has a divisor C_i^[1] with
O(C_i^[1])=O(7O_i)epsilon_i.
Subtracting the previous line-bundle identity gives the statement.
Uniqueness of the section at -118O makes its line and quotient
equivariant under Aut(X), so the full deck group permutes this
family. Its sum descends with degree7N/8.
An invariant nonempty common support would contain an entire
q-fiber of degree8d, exceeding7d. Thus the common support is empty.

The original files and rebuilt output are in the external
[manifest](../../../litt3-computation-data/radical_orbit_replies_20260923/manifest.json).
The [focused integration receipt](../../../litt3-computation-data/radical_orbit_replies_20260923/integration_check.json)
also checks the logarithmic identity. No generic or local object has
been promoted to a proper common cover.
