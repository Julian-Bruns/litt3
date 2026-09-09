# Audit: first-instability oper is the intrinsic connection

Verdict: PASS for the new Section4a, the strengthened Section5, and the
corresponding version3 claims of `joint_tangent_clump_dormancy`.

Auditor: /root/audit_intrinsic_oper_identification. Date:2026-09-09.
Fresh bounded prose audit; not Lean verification. No blocking objections.
No theorem, proof, or registry was changed by this auditor.

## Scope and inputs

Audited [Section4a and Section5](../../Solutions/Sol_joint_tangent_clump_dormancy.md)
and the [version3 statement](../../Theorems/Thm_joint_tangent_clump_dormancy.md).
The already audited Sections1--4 were taken as inputs: the compatible
pointed extensions on both endpoints; the common first instability index
n>=1; the canonical zero-p-curvature connections; and the everywhere
invertible second fundamental maps beta:N→Q tensor omega. The canonical
intersection theorem and exact common-connection spectrum were read in
their canonical statements; the spectrum proof and projective-connection
conventions were consulted to check signs and the active-midpoint scope.
This is not a fresh audit of those dependencies or the earlier lifting
theorems.

## Checks

1. Put m=5^n. The determinant identification is specified by the pointed
   extension, not merely by its degree. The canonical determinant map
   N tensor Q→det(E^(n)), composed with beta^(-1) tensor identity, gives
   Q² tensor omega→omega^m. Thus Q²→omega^(m-1) is a specified global
   isomorphism. Projecting the distinguished section gives a nonzero
   section q of Q: if it vanished identically, the nowhere-vanishing e
   would trivialize the positive-degree subbundle N. The maps represented
   by n wedge e and projection of n to the original omega^m quotient
   differ only by the fixed wedge sign. Their zero divisors agree, so
   div(q²)=2Delta. A wedge convention could multiply the resulting tensor
   by a constant sign; that would not change the logarithmic-derivative
   connection and cannot select a different member of a pencil.

2. All ingredients in this isomorphism, including determinant orientation,
   e, the canonical Frobenius connection, and beta, commute with the two
   actual etale pullbacks. Consequently sigma_X and sigma_Y are equal on
   the actual Z under differential pullback. Independently chosen theta
   characteristics are not used to assert this equality. There is no
   simultaneous Galois-closure assumption or one-leg replacement.

3. The local frame normalization is valid. First arrange
   n0 wedge n1=(dx)^m. If beta(n0)=b*n1*dx, then b is a unit, and the
   determinant-preserving change (n0,n1)→(t*n0,t^(-1)*n1), with
   t²=b^(-1), normalizes beta after an etale square-root extension.
   The determinant frame is horizontal for the canonical connection,
   because m is divisible by5. Its trace is therefore zero, including
   after this determinant-preserving change. This gives exactly the
   matrix recorded in Section4a.

4. For e=v*n0+u*n1, horizontality gives
   v'+Av+Cu=0 and u'+v-Au=0. Substitution of v=Au-u' yields
   u''=(A'+A²+C)u, with the displayed plus sign on C. One can also shear
   n1 to n1+A*n0: then nabla(n0)=n1_new*dx and
   nabla(n1_new)=(A'+A²+C)*n0*dx, directly identifying this as the
   convention u''=r*u. Twisting by the inverse horizontal determinant
   half, obtained locally from theta^m=F*(theta^(5^(n-1))), preserves
   these equations and the quotient coefficient u. After that twist
   the quotient frame squares to (dx)^(-1), as required for the scalar
   oper convention. Thus no missing determinant term changes r.

5. In the normalized frame the beta-induced isomorphism sends
   the square of the quotient frame to (dx)^(m-1), giving precisely
   sigma=u²*(dx)^(m-1). Writing sigma=c*s^j with s=a*(dx)^d gives
   dj=m-1, so d and j are nonzero modulo5 and j=-1/d in k. On the
   nonvanishing locus, differentiating u²=c*a^j gives

       u''/u=(j/2)*a''/a+(j/2)*(j/2-1)*(a'/a)²
             =-a''/(2d*a)+(2d+1)*(a'/a)²/(4d²).

   These identities are valid in an etale local field extension and
   descend as an equality of rational projective connections. The
   constructed oper is already globally regular and dormant, so the
   identity also proves those properties for r_s. Zeros of u do not
   require division in a local regular ring or introduce a gap.

6. The exact spectrum makes the strengthened active conclusion valid.
   When a common active nilpotent point exists, r_s is itself active:
   it is the unique point for primitive weight>2, or the active midpoint
   in the nonzero-Cartier weight2/weight1 pencil. In the latter pencils
   the dormant points are the two other points. The new calculation
   selects r_s itself and makes it dormant, giving the required
   contradiction even when both canonical doubles split. This is
   strictly more than producing some common dormant companion.
   For the fixed pair, the retained spectrum then places a possibly
   nonrigid positive-generator span in its regular dormant branch of
   primitive weight>2. The existing ring/lifting consequences extend to
   all active spans once their common curve tangent is zero; no new
   lifting assertion is needed for that extension.

## Objections and limits

Blocking objections: none. Nonblocking corrections required: none.
The discussion of tensoring the distinguished section by the horizontal
determinant half is understood etale locally, exactly as the proof's
frame calculation states; it does not claim a matching global linear
theta twist on the two endpoints.

The conclusion concerns the intersection of curve-deformation tangent
spaces. It neither sets source oper defects to zero nor excludes the
remaining positive-clump dormant spans. A finite Witt height has no
proved upper bound here, and this audit does not solve the unmarked
common-cover problem.
