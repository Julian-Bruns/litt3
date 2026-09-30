# Proof of the endpoint first-jet genus bound

Retain every hypothesis of the [statement](../../Theorems/cartier_and_spin/klein_four_endpoint_jet_bound.md).
The companion theorem leaves g=n+1 only at n=26, with e=14,j=0 and
all three d_i=0. In the established actual numerator notation,
\[
V_i-\epsilon t^7U_i=E T_i,\qquad T_i=\lambda_i\in k^*,
\qquad \deg U_i,\deg V_i\le7.
\]
Divide E=t^7H+R, with deg H=7 and deg R<=6. Comparison of high
coefficients gives
\[
U_i=\lambda_i(\nu_i-\epsilon^{-1}H),\qquad
V_i=\lambda_i(\epsilon t^7\nu_i+R),\qquad \nu_i\in k.
\]
The primitive-secant theorem makes the three nu_i pairwise distinct.
For w=v-epsilon*t^4*u and its actual character components put
\[
K_i=\frac{u_i}{t^3w_i}=\frac{U_i}{E T_i}.
\]
Then E K_i=nu_i-epsilon^-1 H. In particular
\[
\det(1,K_i,K_i')_{i=1}^3=0. \tag{1}
\]

## The forced endpoint labels

At the four unramified branches over t=0 write
\[
u_l=\alpha_l+a_l t+O(t^2),\qquad
v_l=\epsilon t^{-3}(B_l+c_l t+O(t^2)).
\]
The previously proved endpoint formulas are
\[
A(\alpha_l)=0,\quad
B_l^{29}=3P(\alpha_l)^2A'(\alpha_l)^3/[13]^3,
\quad a_l=C_{\alpha_l}B_l^4,\quad c_l=L_{\alpha_l}B_l^5,
\]
where C_alpha=[13]/A'(alpha) and
L_alpha=C_alpha(P'/P-A''/A')(alpha). All four roots are simple and
all B_l are nonzero. Use the three Fourier sign rows
(1,1,-1,-1),(1,-1,1,-1),(1,-1,-1,1). Denote the corresponding
unnormalized sums by A_i,B_i,a_i,c_i respectively. Omitting the common
factor1/4 does not change the ratios below.

Because E,C_i,z_i are units at0 and T_i is a nonzero constant,
B_i is nonzero for every i. Moreover
\[
K_i(0)=\epsilon^{-1}A_i/B_i,\qquad
K_i'(0)=\epsilon^{-1}(a_iB_i-A_ic_i)/B_i^2.
\]
Distinct nu_i imply distinct A_i/B_i. Equation(1) therefore forces
\[
\det\begin{pmatrix}
B_1^2&A_1B_1&a_1B_1-A_1c_1\\
B_2^2&A_2B_2&a_2B_2-A_2c_2\\
B_3^2&A_3B_3&a_3B_3-A_3c_3
\end{pmatrix}=0. \tag{2}
\]
The exact certificate says this determinant never vanishes on that open
set of forced labels, giving the contradiction.

## Exhaustive coverage and checks

The four alpha roots lie in K0=F25[alpha]/A_monic, of degree4 over
F25. Since29 is coprime to25^4-1, each prescribed B^29 has a unique
root b_alpha in K0. Every geometric label is b_alpha*zeta^e, where
zeta is a primitive29th root, with degree7 minimal polynomial
(4,6,23,9,5,23,8,1) over F25. The degrees4 and7 are coprime, so their
compositum is a field of degree28, in which the exact computations run.

Permuting the four branches permutes the three Fourier coordinates
up to sign: S4 is the affine group of the four-point F2-plane. The
open conditions and determinant vanishing are therefore unchanged.
Coefficient Frobenius normalizes any repeated alpha root to alpha0.
The possible multiplicity patterns are four distinct roots,2+1+1,
3+1,2+2 and4. In the last two, at least two A_i are zero, which is
incompatible with distinct A_i/B_i when all B_i are nonzero. The
remaining representative root tuples are
\[
(0,1,2,3),\quad(0,0,1,2),(0,0,1,3),(0,0,2,3),
\quad(0,0,0,1),(0,0,0,2),(0,0,0,3).
\]
Multiplying all B_l by zeta makes (2) scale by zeta^8 and preserves
the open conditions. Normalize the first exponent to0 and enumerate
all29^3 remaining exponent triples in each of the seven cases.
There are170723 tested tuples,160805 open tuples, and zero solutions.

Source and reconstruction:

- [Polynomial constructor](../../scripts/arithmetic/klein_four_constant_character_jet.py).
- [Exact exhaustive evaluator](../../scripts/arithmetic/klein_four_constant_character_jet.cpp).
- [Independent direct-field check](../../scripts/arithmetic/check_klein_four_constant_character_jet.py).

The generated JSON/DAT, exhaustive log and84 independent direct checks
are retained under
[overnight_three_replies_20260926](../../../litt3-computation-data/overnight_three_replies_20260926/)
with prefix constant_character_first_jet. Regenerate the JSON using the
constructor's --output option, compile the evaluator with C++17, and
pass its generated DAT file. The independent checker takes that JSON
and an --output path. All three executed successfully. These are finite
checks of forced first jets, not a bounded search over actual curves.
