# Exact stopping, reduced-root extraction, and completeness certificates

Version2,2026-09-13. Use [finite-algebra conventions](../../../Definitions/finite_algebra_certificates.md).
Suppose dim_K(R/I)=D is independently known.

1. If G is a finite set of derived polynomials in I and the ideal generated
   by their leading monomials has at most D standard monomials, then it has
   exactly D and G is a Groebner basis of I. No remaining S-pair need be
   processed. A count below D contradicts the hypotheses.
   Alternatively, D elements of A whose span contains1 and is stable under
   multiplication by all z_i form a basis. The stability identities must
   be certified modulo the actual I.

2. Over F_q, N^D=0. If q^e>=D, then

       ker(F_A^e)=N,    B=im(F_A^e) -> A/N is an isomorphism

   under the quotient map. Thus B is the canonical reduced subalgebra of A.
   A sharper adaptive certificate is rank(F_A^e)=rank(F_A^(e+1)); this
   already implies the same conclusions, including e=0.
   Keep A as well as B: if e_i are B's primitive idempotents and
   e_i B=F_(q^d_i), then dim_Fq(e_i A)=d_i*ell_i recovers multiplicities.
   A product of finite fields need not be monogenic over F_q.

3. Verified distinct closed points with certified local lengths ell_i are
   exhaustive exactly when sum(d_i*ell_i)=D. Certified lower bounds already
   suffice if their weighted sum equals D. Exact consecutive local
   truncation lengths that agree certify the entire local algebra by
   Nakayama; an apparent numerical plateau is not such a certificate.

These certificates retain roots and multiplicities. They require the
stated independent lengths or exact identities; a solver's progress or
an approximate plateau does not supply those hypotheses.

Status: audited prose. [Proof](../../../Proofs/atlases/finite_algebras/finite_algebra_completion_certificates.md).
[Audit metadata](../../../Research/audits/FINITE_ALGEBRA_CERTIFICATES_AUDIT_2026_09_06.md).
