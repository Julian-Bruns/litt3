# Proof: the double-zero contacts and pencil

This integrates the second manually returned quadratic-flag reply.
Use the notation of the statement and the already established exact
unsaturated trace j(H)=A+E(-P1), where H=A^2 Sym^2(V) omega_C^-1.

## Canonical endpoint plane

Adjunction gives F_Y^*A=omega_Y(-2P_*). Norm under the relative
Frobenius gives A^5=omega_C(-2P1), with coefficients transported.
The canonical sequence for V consequently becomes
0->A^2(P1)->V->A^3(P1)->0. Twisting gives the sequence for W;
substitution into H gives H=A Sym^2 W.

The preimage Pi of A^2(P1) in E is Lagrangian and has degree one.
Its determinant is A^3(P1), so its canonical line is
(det Pi)^2 omega_C^-1=A. Away from P_* evaluation of A is a unit.
At P_* use f=z^3 and tau=z^5. The regular plane Pi has primitives
z^3,z, with evaluations 3z^2 dz,dz. Its evaluation is surjective
and its Wronskian has one simple zero. Taking determinants yields
the displayed evaluation sequence. This produces an endpoint
plane, not a new map from a cover of Y to X.

## Divisors from the unsaturated lattice

The quotient H=A Sym^2 W -> A^3 restricts to each Veronese
lambda_i with zero divisor 2E_i'. There is no common D-term:
this quotient is taken before replacing j(H) by E. Thus
lambda_i=A_S^3(-2E_i'). Since lambda_i=O(-2O_i), this proves
the first contact identity. On the other hand
det P_i=O(7O_i) and P_i/A_S has contact E_i' with the quotient
pi^*A^3(P1). This proves O(E_i')=A_S^4 O(D-7O_i).
Combining this with A_S^5=O(16O_i-2D) proves the identity with
5E_i'+3D. The quotient E/(P_i+pi^*Pi) is precisely the target
pi^*A^3(P1) restricted to E_i'.

Raise the actual maps lambda_i->A_S^3 to the eighth power.
Since lambda_i^-8=omega_S, obtain sections b_i of
omega_S A_S^24 with divisor16E_i'. For a fixed index0,
div(b_i/b_0)=16(E_i'-E_0'). Adjoin sixteenth roots of all these
finitely many rational functions and take a connected component.
The resulting normalization is finite etale: locally every valuation
is divisible by16, and every remaining unit has a sixteenth root
over a strictly henselian local ring, since16 is invertible.
The degree is a power of two. On the refinement the pulled-back
E_i' are linearly equivalent. Their sections still have no common
zero. Over the infinite field, two suitable linear combinations
give a base-point-free pencil. Its degree is rd and etale Hurwitz
gives g(S')-1=8rd. No separability claim about this pencil is needed.

## The quadratic form and norms

The discriminant on H is A^4-valued. Transport through j and
clear its order-two pole at P1. This gives a regular form valued
in A^4(2P1), with local formula2y^2-tau*x*z. Substituting
j(s,t)=(2s^2,tau*s*t,tau*t^2) gives zero; this is checked in
the focused algebra certificate. Its two isotropic lines on P_i
are A_S and lambda_i. Their contacts with ell_i therefore give
S_i'+Delta_i. No scalar zero occurs over D: saturation of lambda_i
in E forces s to be a unit there, so the quadratic restriction
to P_i is nonzero on that fiber. Away from D, j is invertible and
the conic is nonsingular. This proves the exact divisor identity.

The reverse Jacobian Hom vanishes by duality. Therefore
Nm_(h_i)(pi^*A)=O_X. Norm the contact identity and A_S^5=
omega_S(-2D), using omega_S=h_i^*omega_X, to obtain both
norm identities. In particular, if h_{i*}D=sum m_r r on R_X,
then0<=m_r<=d, sum m_r=8d and2 sum m_r[r-O]=0 in J(X).
These constraints alone do not bound d: for13|d, the uniform
m_r=8d/13 obeys them because R_X is linearly equivalent to13O.

## Scope of the gonality consequence

A standalone gonality lower bound cannot finish the argument.
For any curve C over an algebraic closure of a finite field,
pulling its Abel-Jacobi embedding back by [n], n prime to5,
gives connected etale covers of degree n^(2g). A fixed globally
generated ample bundle on the Jacobian restricts to degree
O(n^(2g-2)) and supplies a pencil, so normalized gonality tends
to zero. Here the specific divisors and the quadratic form carry
the extra information; no descent of either has been proved.
