# The natural Hermitian oper is not invariant under cored Galois spans

Over k=bar(F5), let H:X^6+Y^6+Z^6=0 with its natural Gauss rank-two
projective oper P_H. There is a smooth projective connected curve Z and
finite etale Galois maps f,g:Z->H, of equal degree dividing9, such that

    f^*P_H != g^*P_H.

The span has a nonconstant core. In fact it is a connected component of
the fiber product of two actual degree-nine quotient maps H->C, where
C:v^2=t^6+3. Consequently a common core, and even Galoisness of both legs,
do not force compatibility of the natural Hermitian oper.

More explicitly, for h:H->C from `hermitian_genus_two_test` and
sigma(t,v)=(-t,v), take any connected component of

    H x_(h,C,sigma h) H.

If q=h f=sigma h g, the difference of the pulled-back projective
connections is the nonzero regular quadratic differential

    q^*(2t/(t^6+3) (dt)^2).

This is a counterexample to a proposed compatibility shortcut, not to the
common-cover conjecture. It makes no claim of corelessness.
Status: author proof,2026-09-07; short corollary of the exact positive test,
not separately audited. [Proof](../Solutions/Sol_hermitian_oper_noninvariance.md).
