# Proof: one paired last-digit calculation gives the complete dictionary

[Statement](../../Theorems/deformations/all_height_bt_hodge_dictionary.md).
This merges the original actual BT2 comparison with the later
predecessor-sensitive all-height induction. The Cech sign is j minus i.
All Frobenius coefficient twists, divided maps, finite determinants
and flat periodicity lines are retained.

## Paired local completions and actual groups

The first periodic datum is fixed, including its actual first
Frobenius and Verschiebung arrows. At N=1 it is paired with H and
the marked W2 curve. At a general stage, fix the entire paired
BT_N/Hodge predecessor through W_(N+1), denoted A_N.

Work on affine etale opens. A smooth next curve lift exists, and
the Hodge line lifts since its obstruction is coherent H1 on an
affine. Maximality persists by Nakayama. The determinant restores
the maximal graded Higgs identification using a square root lifting
the previous scalar. The prime-to-five flat twist lifts uniquely.
Repeat locally at every precision, retaining each predecessor.
This supplies local full periodic completions, rather than a global
full completion. The filtered-flow construction and Hodge variation
are those of
[Lan--Sheng--Zuo, Section5](https://arxiv.org/pdf/1311.6424v2) and
[Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/html/1404.0538#S5).

In a normal decomposition P=P0+P1 set Psharp=P0+5^-1 P1 and
nabla-tilde=5nabla. The periodic comparison U:sigma*Psharp->P gives
\[
F=U\operatorname{diag}(1,5),\qquad
V=\operatorname{diag}(5,1)U^{-1}.
\]
The crystalline connection is d+(d sigma/5)nabla-tilde. Local
Frobenius changes use the divided Taylor comparison
\[
\Gamma_{ij}=\sum_{n\ge0}\widetilde\nabla_{\partial_u}^{\,n}
 \frac{((\sigma_i(u)-\sigma_j(u))/5)^n}{n!}.
\]
Integrality follows from nabla-tilde^n(Psharp) contained in
5^(n-1)Psharp for n>=1. These are effective weights-[0,1] windows:
the integral crystal, its Hodge lattice and horizontal F,V satisfy
the same effectivity hypotheses as the retained
[local window construction](versal_bt_cartier_realization.md#4-the-actual-local-windows).
The established window equivalence gives actual local full groups.
The [marked comparison theorem](versal_bt_display_descent.md)
supplies unique normalized isomorphisms of actual truncations.
Their first N levels identify with A_N inductively. At N=1 the
retained first crystal identifies them with the supplied actual H.
This local construction uses the initial periodic datum; an actual
global H is needed to name the marking, not for affine completion.

Two next-Hodge references differ by the last normal variation
in F_*T_C, modulo mu(T_C) from the last marked curve identification.
The square-zero last ideal is5^N/5^(N+1), so its response uses the
fixed mod-five reduction; the higher digits remain in the references.
No preceding line, grading or divided map is changed.

## The full predecessor removes every lower mixed digit

On an ordinary splitting cover choose the SAME absolute Frobenius
lift sigma for two paired references. In normalized ordinary frames,
\[
\nabla e_0=0,\qquad \nabla e_1=e_0\,d\log Q,\qquad
\Phi_1(e_1)=e_1+\ell_Qe_0,\qquad
\ell_Q=\frac15\log\frac{\sigma(Q)}{Q^5}.
\]
The marked characteristic-five equality gives q_j=q_i a^(5^N).
Initially the mixed lifts give only
\[
R_{ij}=Q_j/(Q_i\widetilde a^{\,5^N})
 \in1+5\mathcal O\pmod{5^{N+1}}.
\]
The ENTIRE paired predecessor identifies the normalized frames
and divided maps modulo5^N. This is more input than an abstract
BT_N marking.

Suppose the first nonzero digit is
R_ij=1+5^r Btilde modulo5^(r+1), with1<=r<=N and B!=0 modulo5.
Its contribution is
\[
\ell_{Q_j}-\ell_{Q_i}
 \equiv5^{r-1}B^5\pmod{5^r}.
\]
The factor atilde^(5^N) contributes
5^(N-1)log(sigma(atilde)/atilde^5), divisible by5^N.
The ratio R contributes5^(r-1)sigma(Btilde)-5^r Btilde;
all further logarithmic terms vanish modulo5^r, also when r=1.
Agreement of the preceding divided maps forces B^5=0 on the
reduced overlap, a contradiction. Therefore
\[
Q_j=Q_i\widetilde a^{\,5^N}\pmod{5^{N+1}}.
\]
This includes the first step. Witt coefficient Frobenius is not
replaced by fifth powering on the mixed-characteristic ring.

## The same Hessian-Bol response at every last digit

Put dlog(Q_i)=w_i du and c=dlog(a)/dlog(q_i). Then
w_j=w_i(1+5^N ctilde) modulo5^(N+1). For
\[
R(w)=\frac34(w'/w)^2-\frac12w''/w,
\]
the divided last variation is
\[
\frac{R(w_j)-R(w_i)}{5^N}
 =-\frac12\bigl(c''-(w'/w)c'\bigr)
 =\frac12\mathscr D_H(c^5-c)\pmod5.
\]
Quadratic last-digit terms vanish since2N>=N+1.
Here s=w^4(du)^4, so s'/s=-w'/w modulo five. The
[actual Cartier difference classification](versal_bt_cartier_realization.md)
identifies c^5-c with Delta_N(A_i,A_j).

A last Hodge change f partial_u has normalized cyclic generator
\[
e\longmapsto(1-5^Nf'/2)e+5^Nf e'
 \pmod{5^{N+1}}.
\]
Differentiating the preceding scalar equation e''=re and dividing
by5^N gives
\[
\mathfrak b_r(f\partial_u)
 =(2rf'+r'f-\tfrac12f''')(du)^2.
\]
Thus the ACTUAL overlap cocycles satisfy
\[
\mathscr D_H\Delta_N(A_i,A_j)
 =2\mathfrak b_r(f_{ij}\partial_u).
\]
Both sides are regular over the whole overlap. The Hodge references
are integral, and the
[actual Hessian theorem](bt_cartier_tangent_identification.md)
supplies regularity on the left. Equality on the dense ordinary
open extends across the supersingular divisor. No generic group
isomorphism is invented in this step.

## Exact quotient and summed-Wronskian normalization

The Hodge projection is mu(f partial_u)=s_u f^5 partial_u.
Its composite with b_r is zero. The latter lands in N_r because
it changes the Hodge line of the same nilpotent flat connection.
At a simple supersingular point s has order two, less than five;
its image in F_*T is primitive. It is primitive on the ordinary
open as well. The quotient F_*T/mu(T) has rank four and degree
4(g-1), exactly the degree of N_r.

On an ordinary logarithmic chart Omega=dx/x, put D=x partial_x.
Then
\[
\mu(fD)=f^5D,\qquad
\mathfrak b_r(fD)=-\tfrac12D^3f\,\Omega^2,\qquad
\mathscr D_H(b)=D^2b\,\Omega^2.
\]
The first operator identifies the rank-four quotient with N_r
generically. Its determinant has an effective zero divisor of
degree zero, so it is an isomorphism everywhere; no supersingular
torsion cokernel remains. Cohomology identifies coker(Psi_r)
with H1(N_r).

The summed-Wronskian pairing is2C(hDk Omega), and its Hessian
pullback is2C(bDb' Omega). Frobenius duality gives
j(b)=[-2D^3b D] in F_*T/mu(T), since
\[
C((-2D^3b)D^2b'\Omega)=2C(bDb'\Omega),\qquad
\overline{\mathfrak b}_rj(b)=D^6b\,\Omega^2=D^2b\,\Omega^2.
\]
The last equality uses D^5=D. Hence
J=bbar_(r*)^-1 D_H*. Taking cohomology of the actual overlap
identity gives
\[
\mathscr D_{H*}e_N(A_N)
 =2\overline{\mathfrak b}_{r*}\epsilon_N,\qquad
J(e_N)=2\epsilon_N.
\]
This retains absolute scalar Frobenius and the j-minus-i convention.

## Effective correspondence, truncation and full supplied objects

Paired local completion gives an equivariant map from the local
next-Hodge torsor to the actual next-BT torsor, for
\[
F_*T/\mu(T)
 \xrightarrow{\ 2\mathscr D_H^{-1}\overline{\mathfrak b}_r\ }
 \mathcal B_H.
\]
It is an isomorphism: both torsors are locally nonempty and the
coefficient map is an isomorphism.

A global Hodge solution makes the actual next-group differences
zero. Their unique normalized marked isomorphisms satisfy the
cocycle and descend finite locally free Hopf algebras, F,V and
the A_N marking. Conversely, a global BT_(N+1) differs from
each paired local reference by d_i=Delta_N(A_i,A). Translate that
Hodge reference by (1/2)bbar_r^-1 D_H(d_i). Changes of representative
lie in mu(T) and are absorbed by last marked curve identifications.
The translated references glue without changing their predecessor.

This gives the correspondence inductively, including N=1, and
respects truncation. Every construction is functorial for ACTUAL
etale pullback, including the group difference and divided Taylor
comparison. It compares existence and paired objects; an
arbitrary selected pair need not have zero difference.

For a supplied compatible full Hodge tower, perform the same
effective descent at every N. The crystalline comparisons commute
with truncation, so the inclusions and multiplication maps descend
with the Hopf algebras and define an actual full group.
Conversely the truncations of a supplied full group translate the
paired local Hodge references successively by the just-established
correspondence, giving a compatible global full Hodge tower.
Neither direction requires a separate global-completion theorem
or indigenous ordinariness.

The BT_N group corresponds to curve length N+1. Its next divided
comparison uses the extra curve digit, proving the finite-height
translation m -> m-1. No nonemptiness or common-cover conclusion
is inferred.

The original all-height predecessor calculation was independently
reviewed in
[the earlier audit](../../Research/audits/ALL_HEIGHT_BT_HODGE_DICTIONARY_AUDIT_2026_09_21.md).
Original first/all-height records, proofs, source and receipt hashes
remain in
[external provenance](../../../litt3-computation-data/archive_cleanup_20260930/bt_hodge_merge_before_hindsight/).
