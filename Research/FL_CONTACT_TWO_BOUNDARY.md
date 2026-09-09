# Contact two survives the original Frobenius-lifting connection

Author proof, 2026-09-09. This closes the local test recorded in STATE;
it constructs FORMAL germs, not projective curves or an actual span.
It strengthens the warning in Section4b of
[the pointed tangent proof](../Solutions/Sol_joint_tangent_clump_dormancy.md).
The first-Witt theorem and its audits are unchanged.

## Exact model at every positive height

Let k be perfect of characteristic5, n>=1, Q=5^n, P=5Q, and c in k*.
On k[[z]] take the pointed bundle E with frames e,v and connection

    nabla(e)=0,  nabla(v)=-z^4 e dz,

where v projects to the quotient frame(dz)^5. Its p-curvature sends v
to e, since -D^4(z^4)=1. On F^n E use the canonical connection and the
transverse line N=O(e+zv). Projection of N has a simple zero at z=0.

There exist a in c+z k[[z]] and a formal automorphism phi with

    phi=z+c^Q z^2+...,  A=phi',

such that B=[[1,a],[0,A^5]] identifies phi*E with E as pointed bundles
WITH THE ORIGINAL CONNECTION, while B^[Q] preserves N. In particular,
retaining this connection does not raise contact beyond two.

### Construction and convergence

For any a with a(0)=c, put H=A^P-z a^Q and solve

    A^(P-1)=H^2,  A(0)=1.                                  (1)

The implicit derivative in A at z=0 is -1, so there is a unique solution.
Equivalently iterate A -> A^P/(A^P-z a^Q)^2, starting from1; Frobenius
makes this a z-adic contraction. Set phi=z/H. Differentiation gives
phi'=A^P/H^2=A because derivatives of P-th and Q-th powers vanish.

The connection identity dB+Gamma B=B phi*Gamma is exactly

    a'=R(a):=z^4 A^5-phi^4 A.                               (2)

The differential R(a)dz has Cartier zero for EVERY a: its two terms
have Cartier images A dz and dphi=A dz. Let I be the primitive operator
on such series whose coefficients at z^(5j), including the constant,
are zero. It is defined by termwise integration at the remaining powers.
Solve

    a=c+I(R(a)).                                            (3)

This is again a contraction, not a merely recursive consistency claim.
If ord(a-b)>=N>=1, implicit uniqueness in(1) gives
ord(A_a-A_b)>=QN+1 and ord(phi_a-phi_b)>=QN+2. Consequently
ord(R(a)-R(b))>=QN+5, so their normalized primitives differ in order
at least QN+6>N. Starting from a=c therefore converges to the unique
fixed point in c+z k[[z]]. Its first correction has order6.

### All required identities

Equation(2) preserves the original connection. Moreover

    1+phi a^Q=A^P/H,  phi A^P=z A^P/H,

so B^[Q](e+phi v)=(A^P/H)(e+zv). Thus the Frobenius oper line is
preserved, with a unit factor. Its common tensor is also preserved:

    phi^2 (phi')^(P-1)=z^2.

Since A^P has no terms of degrees1,...,P-1 and a(0)=c, we have
H=1-c^Q z+O(z^2), hence phi=z+c^Q z^2+O(z^3). The contact is exactly2.
This retains the full original nonzero p-curvature as well as its
later canonical Frobenius connection. No global HN claim is needed or
asserted for this local model.

## Executed diagnostic and its precise scope

Run `sage scripts/verify_fl_contact_two.sage`. The 2026-09-09 execution
checked n=1,2,3 and all four nonzero constants in F5. All12 cases passed
the derivative, original-connection, Frobenius-line, tensor and contact
identities, respectively modulo z^69,z^269,z^1269. The correction orders
were[6,36],[6,156],[6,756]. Total arithmetic time was0.146846seconds on
one core, excluding Sage startup. The initial run passed the arithmetic
but encountered a JSON timing serialization error; the corrected full
run printed ALL_LOCAL_IDENTITIES_PASS.

The all-height proof is the contraction argument above, not finite-jet
testing. These germs are NOT counterexamples to a global common-cover
statement. They show that a successful improvement must use more than
the local FL connection and its pointed Frobenius oper line.
