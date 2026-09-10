# Focused audit: short Frobenius strings and the prime-to-five defect image

Verdict: PASS, with the representation-duality citation clarification below.
Auditor: /root/audit_frobenius_character_order.
Date: 2026-09-10.
Target: Solutions/Sol_frobenius_defect_order_bound.md, Sections 1–8.
Scope: a prose audit of this NEW stratum and its quantitative exclusion;
not Lean verification, not a full common-cover theorem, and not a new
whole-proof audit of the inherited canonical inputs.

The conclusion checked is for an ACTUAL prime-to-five Galois Y-leg,
source defect two, a nonordinary matched active connection on X, and
prime-to-five degree of the actual X-leg. For the stated genus-nine /
genus-two pair, Hurwitz makes that final degree condition automatic.
The argument retains both original finite etale maps from the same Z.

## Checks and precise duality clarification

1. The trace projector really gives a Psi-stable direct summand, not
   merely a kernel injection. Section 1 of
   Solutions/Sol_defect_preserving_etale_descent.md supplies the needed
   trace/Frobenius and projection-formula identities independently of
   its later equal-defect assumption. A nonzero nilpotent summand of
   V_X therefore supplies a string length ell <= 3g(X)-3 in V_Z. The
   multiset of lengths is additive under a semilinear direct sum over
   this perfect field.

2. The cyclic restriction of V_Z is a multiple of the regular module.
   The deck action is free; every character line on Z/<sigma> has
   degree zero, and every tangent twist has negative degree. Its H1
   dimension is exactly 3g(Z/<sigma>)-3, including the trivial line.
   Consequently the linearization of Psi gives
   Frob(ker Psi) = coker Psi in the semisimple representation ring,
   and hence an isomorphism of the actual cyclic modules. Here Frob
   raises characters to fifth powers.

3. The statement about (coker Psi)^dual needs the actual Cartier/Serre
   identification, not just equality of defect dimensions. A precise
   existing input is Solutions/Sol_symplectic_p_cover_section_growth.md,
   Section 7, which realizes the defect by

       U = ker[phi -> C_1(s phi)] on H0(omega^2).

   Combined with the inherited local expression Psi(v)=s F(v), the
   Serre residue identity is

       <Psi(v), phi> = <v, C_1(s phi)>^5,

   up to an immaterial nonzero normalization of Psi. This identifies
   the annihilator of im Psi with U. The pairing and Cartier are
   functorial under the actual deck automorphisms, so this is the
   required representation identification, with relative Frobenius
   retained in the fifth power. Cite this input and identity explicitly
   in the final proof: the currently mentioned
   forced_canonical_witt_endpoint Section 1 by itself does not display
   the representation-level duality. This is a citation/explication
   correction, not an additional missing geometric hypothesis.

4. The head filtration in the target is CORRECT:

       H_j = (ker Psi^j + im Psi)/im Psi.

   A string of length L contributes its head precisely when L <= j;
   H_j/H_(j-1) therefore records length exactly j. All these spaces are
   cyclic-deck-stable. An eigenvector in this quotient lifts to an
   eigenvector in ker Psi^j by semisimplicity. For a nonzero quotient
   class its (j-1)-st image is nonzero. The head has character chi or
   chi^-1, while the tail has character chi^(1/5) or chi^(-1/5).
   Thus chi^(5^j)=chi or chi^-1. Since chi has the order of the
   faithful image element, the claimed divisibility follows. No bound
   on a Frobenius orbit is inferred merely from defect dimension two.

5. The inherited actual self-duality gives the reciprocal pair for
   elements of order greater than two and restricts the scalar kernel
   to {I,-I}. The stated prime-to-five PGL2 classification then gives
   max(48,4(5^d+1)). Lifting a rotation generator cannot decrease its
   projective order. This bounds Gamma, not the original Galois group.

## Core, count, and unchanged parameters

K=ker(G -> GL(U)) fixes the pulled-back actual quadratic. It therefore
descends through the actual etale quotient Z -> T=Z/K. The normalized
quartic descends from Y as well. The inherited nonconstancy argument
applies to phi_X^2/s_X, producing the same nonconstant function in
k(X) and k(T). Hence the exact field intersection is a core. Under
the stated cored-orbifold bridge, effectivity makes the generic stack
stabilizer trivial, so the X atlas degree equals the extension degree
over the coarse core field and is at most 64. This does not assert
that X and Y have a core. Hurwitz gives g(T)=|Gamma|+1.

All displayed coarse estimates in Section 7 check out. In particular:
D<2^378, G0<2^382, M_h<2^62 and log2(M_h!)<2^68 give the four
displayed bounds 378, 2^393, 2^779, 2^452 for log2 K_h, with total
less than 2^781. A quotient subgroup of order at most N<2^59 has at
most 59 generators. The inherited automorphism bound gives fewer
than 2^(2^127) choices by padded 59-tuples. Summing over fewer than
2^59 genera consequently gives fewer than 2^(2^782) curves, and the
advertised 2^(2^800) bound is valid.

For Frobenius stability one can explicitly use the enlarged counted
set of ALL genus-two etale Galois quotients of order <= N of genus
<= H partners T through X atlases of degree <= 64. That set depends
only on X/F25 and the numeric bounds; no choice of a particular
matched connection has to be Frobenius-fixed.

The unchanged main K contains 3^(4G_big^2 L_big), and
D0=(335999)! >= 2^335998 makes this exceed 2^(2^671996).
The inherited 120-parameter fiber bound and prime degree r>K force
a moduli Frobenius orbit of length r, contradicting the new finite
count. There is no change to X, Y_t, or the already chosen parameter.

No blocking objection remains within this scope. The case with a
nontrivial five-part acting trivially on U remains outside the proof,
as do ordinary X, higher defects, and non-Galois sources.
