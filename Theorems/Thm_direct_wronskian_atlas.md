# Direct Wronskian test for an untwisted Hermitian atlas

Fix a GEOMETRIC dormant oper on the fixed curve X, with the conventions
of `scalar_hermitian_data`. Put P=A+(B+2x^8)y+C_0 y^2 and define

    S_U=ker(delta^2-P:L(112O)->L(146O)),    dimension32,
    S_T=ker(delta^2-P:L(197O)->L(231O)),    dimension66.

An untwisted PSU Hermitian atlas inducing this oper exists if and only if
there are U in S_U and T in S_T satisfying

    U delta T-T delta U=1,       pole_O(U) in {111,112},       (1)

and the following56-coordinate test. With t=x^3/y, set

    Car_t(H)=sum_(i=0)^4 (-t)^i/i! partial_t^i H,
    eta^5=-Car_t(T/U),       V_0=T+eta^5 U,
    lambda=-rho_32(delta eta).

Then the test is exactly

    rho_48(kappa^5 V_0-eta-U lambda^5)=0.                    (2)

The fifth root defining eta is the unique rational fifth root over the
perfect algebraically closed field. This is a geometric-point existence
criterion, NOT a family identification over a nonreduced oper scheme.

The sharp useful uniform bounds are

    pole_O(eta)<=17,
    val_O(V_0)>=129 if pole U=112, and >=128 if pole U=111.

In particular the argument of rho_48 in (2) has pole at most197. Affine
principal-part reducers only through197 suffice, in place of1084.
All regularity conditions at O are included in (1).

For fixed admissible U, all T satisfying (1) form an affine space

    T+U L(17O)^5,                 dimension9.

Changing T within this space leaves (2) unchanged. There is a unique
choice for which aff(eta)=0. It is obtainable by a linear Wronskian
system and nine linear gauge equations after taking fifth powers.
Thus T is a certificate, not an additional essential existence parameter.

Put A_U=rho_48(kappa^5 V_0-U lambda^5), B_U=rho_48(eta).
One always has B_U!=0. Some nonzero scaling of an admissible U satisfies
(2) if and only if A_U and B_U are NONZERO proportional vectors.
When they are proportional, exactly three scalings work relative to
the chosen U. Thus the remaining existence question can be placed on
an open subset of P(S_U)=P^31, preserving every quotient direction.
It is not settled by the criterion or by finite samples.

Audit: accepted, fresh `direct_wronskian_atlas_audit`, 2026-09-07,
conditional on the scalar reconstruction input; no objections. Five
exact samples on a noninvariant F25 oper check
both pole charts, all scalar identities, Wronskian rank57/nullity9,
the bounds, and nonzero rank-two observations. They do not exclude atlases.
[Proof](../Solutions/Sol_direct_wronskian_atlas.md).
[Audit metadata](../Research/audits/DIRECT_WRONSKIAN_ATLAS_AUDIT_2026_09_07.md);
reference-only unless there is a concrete mathematical doubt.
