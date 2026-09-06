# Explicit scalar Hermitian data on the fixed genus-nine curve

ID: `scalar_hermitian_data`. Use the fixed curve C=X, y^3=F(x), in
`fixed_pair`. This record concerns a FIXED GEOMETRIC dormant oper r,
not a universal construction over its possibly nonreduced parameter scheme.
In the coordinates of `fixed_x_dormant_equations`, write its polynomials
as A(x), B(x), C_0(x), to distinguish C_0 from the curve C.

Put U=C-{O}, Acal=k[x,y]/(y^3-F), t=x^3/y, Rcal=k[[t]],
delta=y^2 d/dx, and L(m)=H0(C,O_C(mO)). A basis of L(m) consists of
x^i y^j with i>=0, 0<=j<=2, and 3i+10j<=m. The gaps at O are

    Gamma={1,2,4,5,7,8,11,14,17}.

The leading coefficients of these monomials in t are one. To compute
Laurent expansions, solve z=t^3 Ftilde(z), where z=1/x and
Ftilde(z)=z^10 F(1/z); then x=z^-1 and y=x^3/t.

Fix kappa=t^-17 and the transition matrix

    G_K = [1, t^-1; 0, t^16]

for K, where the local frame at O equals the U frame times G_K.
For a finite-principal-part Laurent series w, subtract affine monomials
in decreasing nongap pole order, and then its constant coefficient.
Call the affine polynomial aff(w) and the remainder rem(w).
The latter has only gap negative exponents and has constant coefficient zero.

For n=32,48 let P_n have basis t^-g (g in Gamma), followed by
t,t^2,...,t^(n-1). Write rho_n for the corresponding truncation of rem,
and c_48(w) for the t^48 coefficient of rem(w). Define

    Q(w1,w2)=(rho_32(w1)-c_48(w2)t^31, rho_48(w2)).

Its target has dimension 40+56=96. The symbol lambda in the scalar
Hermitian theorem denotes an element of P_32; it is NOT the cubic
quotient coordinate of `fixed_x_oper_cubic_quotient`.

The fixed differential map Dbar:P_48 -> P_32 is

    Dbar(w)=-rho_32(delta w).

For rational z, Q(-delta z,z)=(Dbar rho_48(z),rho_48(z)). Consequently
the invertible target change (q1,q2) -> (q1-Dbar q2,q2) turns Q(z1,z2)
into (rho_32(z1+delta z2),rho_48(z2)). Differentiation is rational, or
must be done with enough Laurent precision; it is not safe to truncate
all factors first and then differentiate.
