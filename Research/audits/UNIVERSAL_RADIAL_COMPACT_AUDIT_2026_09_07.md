# Bounded followup audit: universal radial identity and compact atlas scheme

- Verdict: PASS, conditional on the canonical differential-projection,
  direct-atlas and extension-pencil inputs.
- Auditor: `/root/resultant_gradient_major_audit` (bounded followup).
- Date: 2026-09-07.
- Object: the universal radial identity and compact-system tangent argument
  supplied by `/root` in the followup task.
- Remaining objections: none.
- Scope: this lemma and its finite/reduced consequence, not a whole-chain
  audit or an emptiness certificate.

## Universal identity, including rank-drop strata

For any U and eta with N_U eta^[5]=0, let T, V, lambda, and Y have the
canonical meanings. Horizontality of T,V and constancy of w=Wh(U,T)
follow without any admissibility hypothesis. With Qg=U,

    i(rho48 Y)(U) = Res_O kappa^5 V g theta.

Indeed Q is formally anti-self-adjoint for the residue pairing:
Q*= -Q in characteristic five. Since delta(lambda^5)=0, integration by
parts gives Res lambda^5 g Qg theta equal to its negative. It is zero
because two is invertible. All this is a formal Laurent computation;
possible finite poles of the rational principal-part representatives
cause no difficulty.

For fixed V, the right side factors through the Frobenius fiber of Qg in
W(24O). If Qg=0 locally, exactness writes g=Lf with f in F_*O(32O).
Formal self-adjointness of L and L(kappa^5 V)=0 kill its residue. If Qg
has zero Frobenius fiber, it belongs to t^5 W(24O) in scalar coordinates.
Local surjectivity of Q then writes g=t^5 g0 plus an element of ker Q,
where val g0>=-64. The remaining differential has valuation at least

    -85 + 128 + 5 - 64 + 16 = 0,

so again its residue vanishes. The fifth power on t is essential here.

The classes represented by g1=t^-61 and g2=t^-60 form a fiber basis.
Their Q-images start respectively with 2t^-112 and 3t^-111; Qg1 has
no t^-111 term. Because theta=2t^16(1+O(t^3))dt, pairing with V depends
only on its coefficients at t^128 and t^129 and has matrix

    [0 2]
    [2 0].

Wh(Qg,V), in the same two bases, has matrix

    [0 1]
    [1 0].

For example, its two cross coefficients are
2*3*(129+112)=1 and 3*3*(128+111)=1 in characteristic five.
The potential t^-1 coefficient vanishes. Terms beyond those displayed
cannot contribute to the constant coefficient. Since Wh(U,V)=Wh(U,T),
this proves the universal identity

    i(R_U eta^[5])(U) = 2 Wh(U,T).

There is no extension of a generic-kernel assertion across a rank-drop
locus in this proof; arbitrary constrained tensors of the indicated
decomposable form are treated directly.

## Compact normalization and tangent space

Use eta in J and write beta=i(eta). On the N and R equations, the
normalization beta(U)=2 now forces w=1. It also restores all admissibility
conditions: the affine horizontal column cannot vanish anywhere because
its Wronskian with T is one; if pole U<=110, the bound val V>=128 makes
the constant Wronskian zero, a contradiction. Thus pole U is 111 or 112.
The direct criterion then supplies the required atlas, including infinity.

At a solution the extension represented by eta is

    0 -> O(-24O) -> W -> O(24O) -> 0.

Tensoring by W identifies the kernel of its connecting map
H0(W(24O))->H1(W(-24O)) with the image of H0(W tensor W).
Stability gives H0(W(-24O))=0 and H0(End W)=k; trivial determinant
identifies W tensor W with End W. The image of the identity is the
original section U, up to the fixed determinant convention. Hence this
kernel is exactly kU. Passing to scalar coefficient-Frobenius coordinates
preserves the kernel dimension and gives precisely the linear map
U' -> N_U' eta^[5], using the fixed injective tensor comparison.

For a tangent vector (dU,deta), differentiation of eta^[5] is zero.
The N equations therefore force dU=cU. Differentiating R gives
deta=c eta, and differentiating beta(U)=2 gives 4c=0. Thus c=0 and
the tangent vector vanishes. Equivalently, in coordinates on A and J,
the 97-equation compact system has Jacobian rank 64 at every geometric
solution. This description presumes that the 32 R equations express its
J-coordinates; membership in J is already guaranteed on N=0 by the
canonical full-tensor projection theorem.

An affine finite-type scheme with zero tangent space at every geometric
point is zero-dimensional and reduced, hence finite over the algebraically
closed coefficient field. This includes the possibility of the empty
scheme. Finiteness and reducedness are not proofs of emptiness and do not
solve Litt3.
