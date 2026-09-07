# Proof: universal radial identity, exact normalization, and the tangent rank

[Statement](../Theorems/Thm_compact_etale_atlas_system.md).
We use the audited scalar differential projection and direct atlas criterion.
No generic-rank density argument is used to discard invalid strata.

## 1. The radial identity on every kernel stratum

Take N_U eta^[5]=0, and put

    T=-aff(U eta^5), V=rem(U eta^5), lambda=-rho32(delta eta).

Both T,V are horizontal, val_O V>=128, and w=Wh(U,T)=Wh(U,V) is
constant, as proved in the matrix-pencil criterion without assuming w=1.
The rational representative of R is Y=kappa^5 V-U lambda^5.
It is horizontal, so rho48Y lies in J. Choose g in L64 with Qg=U.

Under local residues Q*=-Q: the adjoint of Pdelta is -Pdelta-delta P,
and -delta P+3delta P=2delta P=-3delta P in characteristic five.
Since a fifth power commutes with Q and 2!=0,

    Res_O lambda^5 g Qg theta = -Res_O lambda^5 g Qg theta =0.

Hence i(R_U eta^[5])(U)=Res_O kappa^5 V g theta.

We compute this local pairing without restricting U. It factors through
the Frobenius fiber of Qg in W24. A local element in ker Q is Lf by
the exact complex; self-adjointness of L and horizontality of kappa^5 V
annihilate its residue. If Qg has zero fiber, local surjectivity lets us
write g=t^5 g0 modulo ker Q, with g0 of pole at most64. The residue then
vanishes by valuation: -85+128+5-64+16=0. The power is t^5, NOT t,
because these are scalar Frobenius realizations of the bundle fiber.

Two fiber generators are Q(t^-61), Q(t^-60). Their leading terms are
2t^-112 and 3t^-111; the first has no t^-111 term. A horizontal V of
valuation>=128 is determined in its first two possible terms by v128,v129;
these give the two relevant local fiber coordinates. Since theta begins
2t16 dt and its next correction starts at least three orders higher,
the pairing with t^-61,t^-60 is respectively 2v129,2v128.
Using delta t=3t^-16(1+O(t^3)), the corresponding constant Wronskians
are v129,v128. These calculations show, for arbitrary U,V as above,

    Res_O kappa^5 V g theta =2w.                           (1)

For clarity, the Wronskian's constant term also factors through these
fibers: increasing the scalar valuation of U by five or of V beyond129
makes the relevant product have positive valuation. The globally constant
Wronskian is exactly that constant term. This proves the claimed radial
identity on all kernel strata.

## 2. Exact equivalence, including invalid strata and O

In the compact system eta=i^-1(beta) lies in J. Its first equation
implies R_U eta^[5] lies in J by the full-tensor projection theorem.
Thus the projected second equation is the full equality R_U eta^[5]=eta,
independently of how i was extended outside J.

Now the last equation and (1) force 2w=2, hence w=1. At any finite
point where the descended section u vanished, both scalar U and delta U
would vanish, contradicting Wh(U,T)=1. If pole_O U<=110, the formula
Wh(U,V) has valuation at least128-110-17=1, again contradicting1.
Since U is already in S_U, its pole is therefore111 or112. All actual
admissibility conditions have been recovered, rather than assumed.
The direct atlas criterion now reconstructs the atlas. Conversely every
atlas satisfies the compact equations by the same radial identity.

## 3. The swapped pencil has a one-dimensional kernel at every solution

At a solution let eta be its Wronskian-normalized extension class. In
descent coordinates it gives

    0 -> O(-24O) --u--> W -> O(24O) ->0.

Tensor by W. The cohomological connecting map is cup product with eta:

    H0(W24) -> H1(W(-24O)).

Its kernel is the image of H0(W tensor W). Stability gives
H0(W(-24O))=0 and H0(W tensor W)=H0(End W)=k, using det W=O.
The image of that one-dimensional space is precisely ku. Consequently,
in scalar Frobenius coordinates as well,

    ker[U' -> Ntilde_(U') eta^[5]]=kU.                      (2)

This uses the actual extension determined by the normalized solution,
not arbitrary one-leg data. Passing to the coefficient Frobenius twist
does not change the kernel dimension or this line over perfect k.

## 4. The compact scheme is finite and reduced

Linearize its equations at an arbitrary geometric solution. Derivatives
of beta^[5] are zero in characteristic five. Thus the first equations
and (2) imply dU=cU. The second equations imply dBeta=cBeta. Differentiating
the quadratic normalization then gives

    0=d(U dot Beta)=2c(U dot Beta)=4c.

Hence c=0 and both variations vanish. The Jacobian has full rank64.
At every geometric point the local ring has zero cotangent space, so it
is a field by Nakayama. A finite-type affine scheme with this property
has dimension zero and is finite and reduced. The empty scheme is allowed.
This proves finiteness without an unproved generic-transversality claim.

## Exact implementation

Let Qc be the32x56 coordinate matrix of Q and S the residue pairing matrix.
The canonical inclusion Bc:A*->E is

    Bc=(S^T)^-1 Qc^T.

Choose a left inverse Iproj, for example from the pivot columns of Qc.
The compact tensors are N_i Bc^[5] and Iproj R_i Bc^[5]. The exporter
`scripts/export_canonical_atlas_system.sage` saves all coefficients and
checks Bc spans J, Iproj Bc=1, the full-tensor R-image implication, and
the all-coefficient radial syzygy for the first new F25 oper. Output:
`Research/computations/canonical_atlas_system.json`.

No solver has established that this finite reduced scheme is empty, even
for that first oper. Finite, reduced and explicitly computable is a useful
reduction, not the exclusion required to solve the common-cover problem.
