# Proof: determinant normalization fixes the descended source line

Version1, 3 October2026. [Independent focused audit PASS](../../Research/audits/OCT03_ORIGINAL_POSITIVE_SOURCE_DETERMINANT_CALIBRATION_AUDIT_2026_10_03.md), all three checks. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_original_positive_source_determinant_calibration.md).

The [general actual-source descent](actual_finite_source_strong_semistability_and_cartier_surjectivity.md) gives rank \(n=4m\) and degree \(m\). We prove the line identity, keeping all coefficient and scalar actions on the literal relative target \(\Gamma_1\).

Choose the paired actual lifts \(A_g\) of \(V\) and \(B_g\) of \(M_1^2\). Their scalar cocycles are inverse because \(V\otimes M_1^2\) is genuinely equivariant. Rescale them oppositely, using \(n\)-th roots in the algebraically closed constant field, so that every \(A_g\) has determinant one. This does not change their genuine tensor action or its descent. If
\(A_gA_h=c(g,h)A_{gh}\), determinants give \(c(g,h)^n=1\). Thus the \(n\)-th powers of the opposite line lifts form a genuine \(G\)-linearization of \(M_1^{2n}=M_1^{8m}\).

Set \(S=M_1^{8m}\omega_{\Gamma_1}^{-m}\). The underlying identification \(M_1^{16}=\omega_{\Gamma_1}^2\) gives \(S^2=\mathcal O\). The just-constructed line action and the canonical action on \(\omega_{\Gamma_1}\) give \(S\) a genuine action. The difference between the action on \(S^2\) and any chosen trivialization is a global character, so \(\operatorname{Hom}(G,k^\times)=0\) makes that trivialization equivariant.

The genuinely equivariant two-torsion lemma in [the higher-trace proof](canonical_ten_higher_trace_section_module.md) applies on \(\Gamma_1\). Explicitly, if \(S\) were nontrivial, its connected étale double torsor would admit the genuine commuting \(G\)-action. Its quotient would be a connected degree-two cover of \(\Gamma_1/G=\mathbf P^1\), unramified away from the two retained branch values. Wild \(C_5\) cannot permute two sheets; only the single tame value can branch. Tame Hurwitz excludes a connected double cover with at most one branch value. Hence \(S=\mathcal O\), and its genuine action is trivial because \(G\) has no characters. Consequently
\[
M_1^{8m}=\omega_{\Gamma_1}^{m}
\]
for the actual determinant-normalized action.

Taking the determinant of the genuine source presentation and using the retained different identity now gives
\[
q_1^*\det A_V=\phi_1^*M_1^{8m}
=\phi_1^*\omega_{\Gamma_1}^{m}
=q_1^*\mathcal O_{Y_1}(mP_1).
\]
There is no irreducibility assumption in this determinant calculation: normalization of any finite-dimensional projective representation has the same scalar-cocycle property.

Finally \(q_1^*:\operatorname{Pic}(Y_1)\to\operatorname{Pic}(T_1)\) is injective under the retained character vanishing. Indeed if \(q_1^*D\) is trivial, its canonical genuine torsor descent action becomes an action on \(\mathcal O_{T_1}\). All invertible global functions on the connected projective \(T_1\) are constants, so the action is a character of \(G\). It is trivial; effective descent then identifies \(D\) with \(\mathcal O_{Y_1}\). This argument needs no averaging and works when \(5\mid |G|\). Applying it to the displayed determinant ratio proves the claimed identity on \(Y_1\).

The determinant formula for a kernel follows from the actual integral exact sequence. It leaves the independent determinant of \(K\) explicit and does not promote a rank-three trace with a trivial quotient to the full rank-four positive-trace hypothesis.
