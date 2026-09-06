# Pro scalar reconstruction: rank-two frame audit

Date: 2026-09-06. Auditor: `/root/pro_scalar_frame_check`.
Verdict: PASS Sections 2.1–2.3 for each prescribed globally regular
dormant geometric potential over the stipulated algebraically closed field.
No material obstruction or dual/Frobenius-twist error found. This is a
bounded prose audit, not machine verification or an audit of Sections 1,3–6.

The canonical inputs read were `Def_fixed_pair`,
`Thm/Sol_dormant_rank_two_candidates`, and
`Thm/Sol_hermitian_atlas_extension_criterion`, together with the scalar-oper
statement and the sent Pro prompt. Canonical statements/dependencies were
also inspected through the research workspace CLI. The primary source
[Wakabayashi](https://arxiv.org/pdf/1411.1191) was opened; the checks below
are direct checks of the proposed construction against the canonical inputs.

## Horizontal frame and bounds

With `L=O(8O)`, the jet bundle `B=J^1(L^-1)` has the displayed transition
`T_op`. For a horizontal section of `B(5nO)`, multiplication by its inverse
gives coordinates

    h=t^(5n-8) f,  t^16 delta(h).

Here `t^16 delta=(t^16 delta(t)) d/dt` has a unit coefficient at O.
Thus both coordinates are regular exactly when h is regular. This verifies
the identification of the kernels with the Frobenius-semilinear realization
of `H^0(W(nO))`, including the condition at O.

The stability argument is valid: any line A in W pulls back to a horizontal
line, cannot equal/be contained in the nonhorizontal oper line, and therefore
maps nontrivially to L^-1. Thus `5 deg A <= -8`. Stability and duality give
the stated dimensions 20 and 54 and global generation of W(18O).
A general section of this rank-two globally generated bundle is nowhere
zero on a curve. Its exact sequence, twisted by 35O, lifts the section 1
because `H^1(O(17O))=0`. Taking the horizontal realization and normalizing
the determinant yields the claimed Wronskian-one pair. Delta raises poles
by at most 17, giving 184 for H and its adjugate.

Implementation clarification: one must choose f1 in the open locus just
described, not assume an arbitrary vector in S18 can be completed. Solving
the bounded bilinear Wronskian-one system is an alternative exact selection
procedure. This does not invalidate the existence argument.

## Cartier projection and the actual V

The target uses absolute Frobenius, as does the sent prompt. Consequently
entrywise fifth roots realize the descent on the same curve. With
`V=W tensor L`, its pullback is `B tensor L^5`, so its lattice in horizontal
coordinates is exactly `H^-1 t^-40 T_op R^2`. This lattice is stable under
`partial_t` because the dormant connection is regular and the twist is a
Frobenius pullback. Applying the truncated Taylor projector to each basis
column preserves the lattice and changes its basis by a matrix congruent
to the identity modulo t. The projected columns are horizontal, since
`partial_t^5=0`. Taking fifth roots gives a basis of the descent lattice;
this proves invertibility, not merely generic rank.

Both rational horizontal frame sections lie in W(35O). Tensoring by L
reduces their local coordinate pole bound to 27. This is the bound on
G^-1. The unit normalization epsilon does not increase it. The determinant
valuation is -16; after normalization `det G=t^-16`, and the adjugate
formula gives the bound 43 for G.

There is no wrong-dual issue: `B^vee tensor L^-1` has transition

    [[1, -8 t^15 delta(t)], [0,t^16]].

Its upper entry differs from t^-1 by an O-regular function. The identity
on the affine chart therefore gives an isomorphism with the selected K.
Equivalently `B=K^vee tensor L^-1`, so

    F^*V = B tensor L^5 = K^vee tensor omega^2,
    det V = L^2 = omega.

Changing the dual oper frame to the dual horizontal frame yields exactly
`j0_U=H^T`. The local correction is regular unipotent and has determinant
one. This is precisely the untwisted candidate required by the criterion.

Finally `H^0(K)=k e` forces automorphisms to preserve the distinguished
line. Nonzero extension class forces their two diagonal scalars to agree;
the remaining entry is in `H^0(omega)=L(16)`, of dimension nine. Thus the
claimed ten-parameter isomorphism choice is correct.

## Limits

The above is a construction for each geometric r. Selection of H and inverse
Frobenius do not establish a polynomial construction over the entire
nonreduced oper parameter scheme. No preservation of its local
multiplicities follows from this construction. These checks alone do not
solve the later 96 reconstruction equations or produce/exclude an atlas.
No computational process, script, or research-state file was altered.
