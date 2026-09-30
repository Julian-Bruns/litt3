# Integral oper comparison and finite-precision stability

Version2, 2026-09-15. This is local algebra on chosen whole inputs.
It assumes no curve genus, ordinariness, cover rank, symmetry or
vanishing of cohomology. It does not construct compatible prefixes.

Let p be odd. Work in a separated, p-adically complete, p-torsion-free
differential algebra, with integral continuous derivations and a fixed
continuous Frobenius lift F0 fixing p. All charts, twists and coefficient
transport are fixed. The inverses below are of units on the chosen
overlap. Put X=pY, with Y an integral derivation, and suppose
fuz-F0(z) is divisible by p. Use the actual rank-two presentation

    S=exp(pY), delta=(S(fuz)-F0(S(z)))/p,
    D=g^(-1)*partial_z, Az=S(g)*(S(z))'/g, qz=z*sqrt(Az),
    Jtilde=F0([[qz^(-1),0],[-p*D(qz)/Az,qz]]),
    A_P=[[0,-g],[-p²*P*g,0]],
    K0=Id, K_(j+1)=p*K_j'+A_P*K_j,
    G=Jtilde*sum_j F0(S(K_j/j!))*delta^j,
    M=I_O^(-1)*G*S(I_U).

Here P is the genuine preceding potential. The current frames I_U,I_O
are normalized in their actual current connections; these are distinct
inputs. Whole signed graph changes are normalized by negative covariant
differentiation and determinant normalization in that current connection.
Square roots have their fixed residue choices.

The complete matrix M, including these graph changes, is an integral
convergent expression in Y, the frames, current connections, whole graph
coefficients and their derivatives and fixed Frobenius transforms. The
displayed division by p and all Taylor factorials cause no hidden loss
of input precision. In particular

    v_p(K_j/j!) >= j-1-v_p(j!)  (j>=1).

The direct dependence of G on P has an additional gain

    c_p=2 if p>=5,   c_3=1:
    G(P)-G(0)=p^(c_p)*Gsharp(P),

where Gsharp is again integral. Thus a change of P in p^a changes G
in p^(a+c_p). The same holds for a current connection supplied through
an integral expression in p^(c_p)P, with the other inputs fixed.
The gain at p=3 cannot in general be replaced by two.

Here is the finite-precision consequence, for any integer b>=1.
The chart data z,fuz,g,F0 and hence (fuz-F0(z))/p are FIXED across
comparisons. The ordinary variable inputs are Y, the frames, current
connections and whole graph coefficients. Compare them at possibly
different r>=b: their backgrounds agree modulo p^b, and their changes
are p^r times common inputs modulo p^b. For Y this means original source precision p^(r+b+1)
and background X modulo p^(b+1). The preceding potentials and their
normalized changes need agree only modulo p^max(b-c_p,0); their changes
are required to lie in p^r. Then

    Delta M=p^r*C modulo p^(r+b),

with the same C modulo p^b for all r. This is a full matrix identity.
The first variation is additive and commutes with multiplication by p;
it need not be linear over the residue field.

For b=3, comparison with r=2 has the same linear part and at most
one extra term p^4*B, quadratic in the residue primary increments.
If residue operations preserve a multiplicative filtration F_d,
residue background factors have degree zero, and those increments
lie in F_d, then B lies in F_(2d). A projection killing F_(2d)
removes this exception after whole division. A delayed increment of
weight p^(r+1) cannot multiply a primary increment at this precision;
no degree bound on a whole delayed repair is needed.

The proof also records exact graph normalization over any differential
ring with 2 invertible, including a changing current connection. These
identities apply before any primary quotient. Passing to an obstruction
requires actual divisibility of the whole repaired numerator, complete
primary preimages, and whole regular primitives.

There is also a quadratic polarization consequence. Write F for the
whole normal numerator as an integral function of its coupled inputs,
with reference v0 whose first divided obstruction E(0) is defined.
Use primary direction tuples h,k, including their
whole regular graphs, and require its complete first variations
L(h),L(k) to lie in p times the normal cochain module. Let Q be the
projected residue quadratic term of this SAME integral function, and
let E(h) be its first divided obstruction, at v0+p*h. Terminal
source directions and regular boundaries are killed in the quotient.
Then at a reached background congruent to v0+p*h modulo p²,
a new input p^r*k, r>=2, has complete relative class

    A(k)+2Q(h,k), where A(k)=E(k)-E(0)-Q(k)

and 2Q(h,k)=Q(h+k)-Q(h)-Q(k). The identity only uses the actual
quadratic coefficient and complete primary repair. It assumes neither
that Q vanishes nor that the additive term A is field-linear. Higher
allowed input sections change only the stated terminal quotient terms.

[Human-readable proof](../../Proofs/deformations/integral_oper_calculus.md).
