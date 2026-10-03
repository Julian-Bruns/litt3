# Proof: recover both hyperelliptic field generators from Cartier

Use the hypotheses of the [statement](../../Theorems/cartier_and_spin/genus_two_cartier_cyclic_differential_field_descent.md). View both actual function fields as their given subfields of k(T); the equality of differentials is in Ω_{k(T)/k}. Since the extensions are separable, pullback of differentials is injective. Absolute Cartier on one-variable function fields over the perfect field k is functorial for separable embeddings; its defining decomposition into a separating parameter's p-basis gives this same functoriality.

Applying Cartier to q*η=r*γ gives
\[
q^*(a\eta+b x\eta)=r^*C_Z\gamma.
\]
Taking ratios with the SAME nonzero q*η=r*γ therefore gives
\[
\boxed{q^*x=r^*\big((C_Z\gamma/\gamma-a)/b\big)\in r^*k(Z).}
\tag{1}
\]
Cartier itself is p⁻¹-semilinear; a,b already mean the coefficients of Cη, so no scalar is moved through C without its fifth-root transport.

Differentiate the actual field element in(1). Separability and η=dx/w give
\[
\boxed{q^*w=d(q^*x)/(q^*\eta)\in r^*k(Z).}
\tag{2}
\]
The numerator is nonzero because x is separating on Y and q is separable. Thus q*k(Y)=k(q*x,q*w) is a subfield of r*k(Z). The corresponding function-field inclusion induces the unique finite map π:Z→Y of smooth projective curves with q=πr. It is separable as an intermediate extension of k(T)/q*k(Y).

If q is étale, multiplicativity of ramification indices gives
\[
1=e_t(T/Y)=e_t(T/Z)e_{r(t)}(Z/Y)
\]
at every t. Each factor isONE. Over algebraically closed k, finite separable maps of smooth curves with every ramification indexONE are étale. Since r is surjective, this applies to every point of Z as well. No descent of an endpoint is inferred from a formal quotient alone; the descent here is proved from the actual differential equality and field generators.

For the sparse model, write H=Ax⁵+Bx⁴−1. Since w⁵=wH²,
\[
\eta=H^2dx/w^5,
\qquad
H^2=A^2x^{10}+2ABx^9+B^2x^8-2Ax^5-2Bx^4+1.
\]
Cartier extracts the x⁴ and x⁹ coefficients and takes their fifth roots, while carrying the denominator w⁵ to w. Hence
\[
C_Y\eta=(3B)^{1/5}\eta+(2AB)^{1/5}x\eta.
\]
The second coefficient is nonzero. This proves the asserted specialization with the actual x,w,η, not a model inferred only from degrees.

Focused review tasks: check Cartier functoriality and semilinear constants in(1); the nonzero derivative and actual subfield recovery in(2); finite/separable map factorization and every ramification index; sparse coefficient extraction; and the exact one-form/intermediate-field premise. No original source construction is part of this lemma.
