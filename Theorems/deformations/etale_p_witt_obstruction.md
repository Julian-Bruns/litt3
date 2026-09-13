# Which higher Hodge obstructions survive an actual p-group cover?

Version1,2026-09-10. Author proof and exact computation; focused medium
audit PASS /root/audit_p_cover_witt_repair. Not Lean verified.
Use the [intrinsic obstruction](../../Definitions/witt_hodge_obstruction.md).

Let h:T->C be an actual connected finite etale Galois cover of smooth
projective curves of genus>=2 over k=bar(F5), with finite5-group P of
order q. Pull back the specified admissible active connection and its
previous-flow data. Write

    d_C=corank(Psi_C), d_T=corank(Psi_T), R=k[P],
    D_T=coker(Psi_T),

retaining the relative Frobenius twist when linearizing Psi.

Then D_T needs exactly d_C generators over R, and

    rank_k(h*:coker(Psi_C)->D_T)
      = number of free R summands in D_T.

In particular d_C<=d_T<=q d_C. If P is cyclic, write
R=k[e]/(e^q). Its Smith decomposition has the form

    D_T = direct-sum_(i=1,...,d_C) R/(e^(l_i)), 1<=l_i<=q.

Then d_T=sum l_i, and pullback has rank #{i:l_i=q}.

For d_C=1 this specializes to the sharp dichotomy

    epsilon(C,r)!=0 implies
    epsilon(T,h*r)!=0 iff d_T=q,
    epsilon(T,h*r)=0 iff d_T<q.

## Six actual covers of the explicit genus-two example

For the F625 pair in
[explicit_genus_two_witt_obstruction](explicit_genus_two_witt_obstruction.md),
there are exactly SIX geometric connected cyclic5 covers T->C.
Every one has genus6 and

    d_T=2, epsilon(T,h*r)=0.

Thus each pulled-back canonical first lift T2 has some W3 curve lift
on which the original Hodge line lifts. The source connection is still
nonordinary. NO such repaired curve lift permits extension of the
original map T2->C2 to ANY marked C3 above the original canonical C2.

The last assertion distinguishes one-curve repair from repair of an
actual diagram. No second endpoint or common-cover counterexample is
constructed. The main and backup common-cover problems remain unsolved.

[Proof and exact finite certificate](../../Proofs/deformations/etale_p_witt_obstruction.md).
