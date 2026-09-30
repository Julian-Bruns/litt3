# Proof: the new-line comparison and theta recognition

This integrates the returned new-line Pro reply. The supplied
[Cartier verifier](../../scripts/arithmetic/pro_theta_cartier_recognition.py)
was executed successfully; its
[output](../../../litt3-computation-data/comparison_residuals_20260923/theta_cartier_local_output.txt)
checks the explicit rows below. The geometric implications are reviewed
here separately from the coefficient certificate.

Equality of the actual saturated lines is equivalent at the generic
point to f_2=u^5 f_1+b^5. The intrinsic tensor construction gives
proportional tau. Conversely, tensor proportionality gives
rho^13=c(A_2/A_1)^10 for rho=df_2/df_1. Logarithmic differentiation
in characteristic five gives d rho=0. Thus rho=u^5 and
f_2-u^5 f_1=b^5. Equality of generic lines gives equality of their
saturations in the fixed bundle.

The fifth power of u^13(A_1/A_2)^2 is constant, so this expression
itself is a constant kappa. Set z=u^6 A_1/A_2. Direct substitution
gives u=kappa z^-2 and all three normal-form identities. It also gives
\[
z^{10}f_2-\kappa^5f_1=(z^2b)^5.
\]
The divisor of theta_i is16h_i^*O, so the last identity involving
theta gives div z=h_2^*O-h_1^*O. Tensor divisors give equality of
the R-pullbacks. The O-pullbacks are reduced, of the same degree n
by Hurwitz. A nonconstant z therefore has a simple pole, cannot be
a fifth power, and has degree n-deg min(h_1^*O,h_2^*O).

We supply the field-generation step in the returned theta argument.
Write phi_j=C^(2j)theta, using absolute Cartier with all coefficient
fifth roots retained. The checked rows are
\[
\begin{aligned}
\phi_1&=(13,8,12,20,19,20)\theta,\\
\phi_2&=(6,0,12,12,16,11)\theta,\\
\phi_3&=(0,2,11,12,17,2)\theta,\\
\phi_4&=[13]\phi_1+[24]\phi_2+[10]\phi_3.
\end{aligned}
\]
The first three phi_j are linearly independent. If theta_2=c theta_1,
Cartier naturality gives h_2^*phi_j=c^(25^-j)h_1^*phi_j. Comparing
the two versions of the displayed relation, whose three coefficients
are nonzero, forces c^(25^-4)=c^(25^-3), hence c^25=c. Therefore
all three phi_j have the same proportionality constant c as theta.
The checked combinations are
\[
[11]\phi_1+[21]\phi_3=q_5(x)\theta,\quad q_5=(10,11,24,0,0,1),
\]
\[
[21]\phi_1+[4]\phi_2+[9]\phi_3=q_4(x)\theta,\quad q_4=(6,23,14,0,1).
\]
Now k(q_4,q_5)=k(x): the degree of k(x) over this intermediate
field divides both [k(x):k(q_4)]=4 and [k(x):k(q_5)]=5.
Thus the two x-pullbacks agree. Their y-pullbacks differ by a
constant cube root of unity, proving theta recognition.

Equal O-divisors make theta_2/theta_1 a global unit, hence a constant.
Conversely equal embedded X-fields identify the maps up to an
automorphism of X, and its C3 fixes O. For n=2 a nonconstant z
would give a degree-two map from T to P1. The hyperelliptic
involution is central, commutes with the free deck involution of
T->X, and is different from it. It would descend to a nontrivial
involution of X, contrary to Aut(X)=C3. Degree one is immediate.

Finally set s=u^2 A_1/A_2 and t=u^3 A_1/A_2. In the relative
quotient vectors, transported after Frobenius,
\[
l_2=s^5l_1,\quad r_2=t^5r_1+3b^5s^5l_1,\quad
e_i=r_i-3f_i l_i,\quad e_2=t^5e_1.
\]
The normal form yields the factors stated in the theorem. Since
d(s^5)=d(t^5)=0 and (t/s)^5 df_1=df_2, the equations
nabla e_i=-3df_i l_i agree exactly. Horizontal rational factors
need not be constant or units in a fixed integral frame.
On the ramified cover w^13=A, the tensor root w^16 theta is
d(f/w^10), hence exact. It is not the nonexact theta to which
the above Cartier-recognition calculation applies.
