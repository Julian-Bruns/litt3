# Restricted Raynaud corank is bounded by the quotient a-number

Version1. Independently audited.

Let C be a smooth projective connected curve of genus G>=2 over an
algebraically closed field of characteristic p>0. Let A be ANY abelian
subvariety of J=J(C), and put Q=J/A. Use scalar Frobenius twists and
B_C=F_(C/k)*O_C/O_(C^(1)). Define

    delta_A=generic_(L in A^(1)) h0(C^(1),B_C tensor L).

Then

    delta_A <= a(Q),

where a(Q)=dim ker(dV_Q:Lie Q^(1)->Lie Q). No prime-to-p splitting,
polarization-degree, ordinariness or field-of-definition hypothesis
is needed. In particular an ordinary quotient Q forces proper
restriction of Raynaud theta to A^(1).

The proof retains the actual one-step Frobenius comparison. After
invertible elimination its generic remaining corank is that of an
a(Q) by a(Q) matrix over the fraction field of the completed local
ring of A^(1) at0. This matrix is not asserted to be invertible.

The identical finite-height statement holds for every e>=1: put
B_(e,C)=coker(O_(C^(e))->F_(C/k)^e_*O_C),
a_e(Q)=dim ker(dV_Q^[e]) for the twisted composite
V_Q^[e]=V_Q V_(Q^(1)) ... V_(Q^(e-1)):Q^(e)->Q,
and take the generic parameter in A^(e). Then delta_(e,A)<=a_e(Q),
with an exact a_e(Q)-square Schur complement. This is a finite
cohomology statement, not an inverse-limit or crystal assertion.

## Consequence for both actual maps

For ANY actual finite bi-etale span X<-f-Z-g->Y put
A=im(J(X) x J(Y)->J(Z))_red^0, using f^*+g^*. The generic mixed
defect equals delta_A and is bounded by a(J(Z)/A), in arbitrary
cover degrees. Both original maps remain on the SAME Z.

If Hom(JX,JY)=0 and p divides neither n=deg f nor m=deg g, then

    delta_A <= a(Z)-a(X)-a(Y).

Equivalently the bound is the dimension of the Cartier kernel on
the simultaneous trace-zero subspace of H0(Z,omega_Z). If Y is
ordinary this becomes delta_A<=a(Z)-a(X), and equality of these
two a-numbers forces generic vanishing. This consequence uses no
joint minimality, nonhyperellipticity or genus-two assumption.

At finite height e the same prime-to-p splitting gives
delta_(e,A)<=a_e(Z)-a_e(X)-a_e(Y), where a_e(C) is the kernel
dimension of the actual e-th Frobenius on H1(C,O_C).

Neither vanishing nor positive corank excludes the characteristic-p
span. An a-number difference is not asserted in p-divisible degrees.

[Proof](../../../Proofs/jacobians/theta_divisors/restricted_raynaud_complement_rank.md).
