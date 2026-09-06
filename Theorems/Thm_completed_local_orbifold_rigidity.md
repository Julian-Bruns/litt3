# Completed-local data determine an effective orbifold with an etale atlas

Let k be algebraically closed and B a smooth projective connected curve.
Let S_1,S_2 be smooth proper effective connected DM curves with identified
coarse curve B, each admitting a finite etale atlas by a smooth projective
scheme curve. For b in B, an atlas completion above b is a finite Galois
extension L_(i,b)/k((t_b)); its fixed-base isomorphism class is independent
of the atlas and the chosen point over b.

The stacks S_1,S_2 are isomorphic over B IF AND ONLY IF

    L_(1,b) is isomorphic to L_(2,b) over k((t_b)) for every b.

When these conditions hold, every component of the normalization of
X_1 x_B X_2, for any two finite etale scheme atlases X_i -> S_i, is a
common finite etale cover of X_1,X_2. All maps and completions are actual;
the statement does not infer local normality from ramification indices.

Consequently, fix odd p, t>p+1 and a prime-to-p integer m>=2. Among such
orbifolds with coarse P^1, one wild branch of the filtration in
`hermitian_local_normality` with tame complement t, and one tame branch
of order m, there is AT MOST ONE isomorphism class over k. Existence is
not asserted. The single wild scalar can be aligned by a global scaling
of P^1 fixing the two branch points.

In characteristic five the two remaining large genus-nine signatures
give exactly the quotient stacks [H/PSU_3(5)] and [H/PGU_3(5)], where
H is the Hermitian genus-ten curve. Every curve atlas of either stack
therefore has a common finite etale cover with

    Q: y^2=x^5-x,                 F: X^4+Y^4+Z^4=0.

Here H -> Q is itself etale of degree nine. Q and the ordinary Fermat
quartic F have a genus-five common etale cover of degrees four and two.
Q is superspecial. Thus these two large quotient cases belong to ONE
known common-cover class, and ordinarity alone cannot exclude that class.

This does not assert that every curve commensurable with Q is an atlas
of either stack, or that the fixed genus-nine X is such an atlas. The
remaining small cored cases and the coreless branch remain open.

Audited PASS, /root/completed_local_global_major_audit, 2026-09-06;
no breaking issue or required correction. Audit metadata is in the library.
[Proof](../Solutions/Sol_completed_local_orbifold_rigidity.md).
