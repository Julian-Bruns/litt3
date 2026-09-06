# Exact stopping, reduced-root extraction, and completeness certificates

Use [finite-algebra conventions](../Definitions/Def_finite_algebra_certificates.md).
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

For the [normalized fixed-X system](Thm_fixed_x_oper_cubic_quotient.md),
D=9645 over F25. Three applications of a->a^25 suffice in (2), since
25^3=15625. Its F5 encoding has dimension19290, but the known F25 structure
still makes six fifth-power applications sufficient. These are worst-case
sufficient bounds, not assertions that all iterations are necessary.

This theorem does not supply the currently missing basis or assert that
the running solver has already met the stopping criterion. It gives exact
certificates, not a runtime estimate or a common-cover exclusion.

Status: audited prose. [Proof](../Solutions/Sol_finite_algebra_completion_certificates.md).
[Audit metadata](../Research/audits/FINITE_ALGEBRA_CERTIFICATES_AUDIT_2026_09_06.md).
