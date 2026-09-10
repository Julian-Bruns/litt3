# Focused audit: explicit genus-two higher Hodge obstruction

Verdict: PASS, scoped to the explicit pair and higher-obstruction calculation.
Auditor: /root/audit_explicit_w3_obstruction (fresh bounded medium audit).
Date: 2026-09-10. No blocking objection found. This is a prose and exact
computation audit, not Lean verification or a solution of the common-cover
problem.

## Evidence and scope

Read the exact request in ../PRO_SINGLE_OPER_W3_REQUEST.md, the entire returned
486-line Python attachment, and Sections 1--2 of
../../Solutions/Sol_forced_canonical_witt_endpoint.md. Accepted the established
finite-field admissibility and tangent inputs; did not re-audit their proofs.
Checked the construction against
[LSYZ Section 5](https://arxiv.org/html/1404.0538#S5), specifically the input
tuple after Definition 5.5, Taylor gluing, and Hodge projection, and
[LSZ Section 5](https://arxiv.org/pdf/1311.6424v2), pp.30--35, the local-lift
and weight-one cokernel constructions of the intermediate p-connection.

Independently replayed the attachment with --precision 500: all assertions
passed in 2.57 seconds wall time including startup. Certified rho precision
was 71. Parent owns the archived attachment and additional replay receipt.
The audit's substantive check is the geometric dictionary below, rather
than agreement with a hard-coded residue.

## Geometric checks

1. The first curve lift is identified through the FL flat extension, not
   by lifting the nilpotence equation. The affine Frobenius is regular
   on the whole affine curve: its corrections solve the curve equation
   using the coprimality of F and F'. The four-column cohomology solve
   has four pivots and gives mu=4+4t and the three Frobenius deformation
   coordinates. The coboundaries qU,qO identify its extension with the
   target extension. The additional identity
   mu*beta-dqU+zeta=0 checks the connection, not just its underlying
   bundle. Thus the deformation selected is the canonical first lift
   for the specified projective oper, with the consistent semilinear
   Frobenius convention. The coefficient ring's sigma is Hensel-lifted;
   it does not pretend that the chosen polynomial generator is Teichmuller.

2. The nonsplit double is retained. Both columns of SU are anti-invariant
   under w -> -w, as are the comparison matrices IU and IO. The actual
   first object is the jet realization tensored by kappa. Consequently
   the PREVIOUS object required by the higher functor, H1 tensor kappa,
   is the untwisted jet realization. This explains why the intermediate
   jet transition itself has no extra kappa factor. In the final
   conjugation the two anti-invariant factors cancel. This is descent
   through the nontrivial double, not an assumption that it splits.

3. Weight rescaling of the local oper connection gives, modulo25,
   the p-connection 5d-eta E12. Its opposite oper-potential entry has
   coefficient25 and disappears at this stage. Its transition does NOT
   become the split Higgs transition. With phi*eta=A eta and
   q=z sqrt(A), it is

       Jtilde = [[q^-1,0],[-5 A^-1 Dq,q]].

   This also follows directly by checking p-connection compatibility.
   On the O chart the Higgs coefficient is eta/z^2. The first diagonal
   compatibility equation is
   -5q^-2 dq + 5(eta/z^2) A^-1 Dq=0 because q^2=z^2 A;
   the other is 5dq-5 A^-1 Dq A eta=0. The remaining derivative
   of the lower-left entry is a multiple of25. Thus the order-five
   jet entry in the script is required, with the stated sign and factor.

4. On a coordinate chart eta=e dz, iterating this p-connection on the
   upper basis vector gives the Taylor terms -e Delta and
   -(5/2)e' Delta^2 modulo25. Terms of degree at least three vanish;
   the divided factorials at degrees at least five do not revive them
   (the p-adic valuation after division remains at least two).
   The two evaluations in the code are appropriate because the target
   coordinate is phi(z): beta(e)=FO(phi(e)), and Delta compares the two
   Frobenius images in that target coordinate. There is no omitted
   extra derivative of phi in this expression. Combining this Taylor
   matrix with FO(Jtilde) gives exactly G as implemented.

5. IU and IO are legitimate arbitrary lifts of the mod-five comparison
   frames. SU is invertible everywhere on the affine double, by its
   Bezout determinant; SO is invertible on the formal O chart since
   bO is a unit. The special affine reconstruction of qU matters:
   a coefficientwise lift of its Laurent series would not establish
   affine regularity. The script correctly reconstructs qU using
   actual affine monomials. Formal patching at O is sufficient to
   compute this coherent cohomology obstruction and the corresponding
   nilpotent curve deformation.

6. Gamma=IO^-1 G phi(IU) reduces to
   [[z^-1,0],[-Dz,z]]. The original Hodge line is the second coordinate.
   If its local corrections are xU and xO, the off-diagonal equation
   is Gamma12/5 + z^-1 xU - z xO=0. Multiplication by z identifies
   the obstruction with rho=z Gamma12/5 in the tangent frame eta^-1.
   This verifies the projection and its normalizing factor, rather
   than merely testing that Gamma12 is divisible by5.

## Result and limitations

The reduced coefficients of rho in z^-3,z^-1,z are

    (1+4t+2t^2, 1+t+t^3, t+2t^2+2t^3).

Their prescribed Serre pairing, independently checked by direct residue,
is

    lambda=3+4t+4t^2+3t^3=(4+4t)^-1 != 0.

The three next-curve deformation directions leave this scalar unchanged,
as required by the known variation formula. Dropping the jet entry gives
zero scalar. Dropping the quadratic Taylor term changes the scalar, so
that term cannot be omitted; the attribution to the jet term means its
contribution after retaining the full Taylor construction.

This disproves universal compatible single-endpoint W3 Hodge lifting in
the exact sense of the request. It does not obstruct lifting the bare
curve. Using the already established etale naturality and trace result,
the nonzero intrinsic class survives pullback of degree prime to5 and
therefore excludes a matched span from THIS endpoint to an ordinary
connection with that degree condition. No conclusion about the fixed
main endpoints follows from this example, and degrees divisible by5
are not excluded by this trace argument. The unmarked common-cover
problem remains unsolved.
