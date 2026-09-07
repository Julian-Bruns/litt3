# A parameterized degree-three common cover of two genus-two curves

Let k be algebraically closed of characteristic different from2 and3,
and lambda in k minus{0,1}. The smooth bidegree(3,3) curve

    T_lambda: u^3 v^3-lambda v^3-u^3+1=0 in P1 x P1

has genus4 and two everywhere finite etale Galois maps of degree3 to
the smooth projective genus-two curves

    C_plus:  z^2=w^6+(2-4lambda)w^3+1,
    C_minus: z^2=w^6+(2lambda-4)w^3+lambda^2.

Explicitly, w=uv, z=2u^3-1-w^3 on the first leg, and
w=u/v, z=2u^3-lambda-w^3 on the second. The same actual source is
retained, including all points at infinity. This span has core P1 with
coordinate t=u^3. After scaling, its endpoints have parameters
a_plus=2-4lambda and a_minus=2-4/lambda in C_a:z^2=w^6+a w^3+1.

In characteristic5, C_a is superspecial for a=0 and ordinary for a!=0.
At lambda=3 the two endpoints are respectively superspecial and ordinary,
and both Hom groups between their Jacobians are zero. In particular,
ordinary versus superspecial, Hom(J_X,J_Y)=0, genus-two endpoints, and
both legs being prime-to-five Galois do not exclude common covers, even
when imposed together.

Over bar(F5) the lambda=3 endpoints also admit a CORELESS common etale
cover with prime-to-five Galois-closure orders, by the audited Bolza
commensurability theorem. This second source is not the displayed genus4
source and no explicit degree for it is asserted.

Every C_a in this family has an elliptic quotient, so its Jacobian is
NOT absolutely simple. The result therefore supplies no counterexample
to an obstruction that additionally requires absolute simplicity, and
does not resolve the original common-cover problem or its fixed pair.

Version1. Elementary family audit PASS2026-09-07,
/root/cubic_genus_two_family_check. The coreless corollary uses the
separately audited theorem, not the elementary span's core.
[Audit metadata](../Research/audits/CUBIC_GENUS_TWO_FAMILY_AUDIT_2026_09_07.md).
[Proof](../Solutions/Sol_cubic_genus_two_common_covers.md).
