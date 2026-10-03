# Proof: larger native section, scalar-field and entire-kernel budgets

Version1, 3 October2026. See the
[statement](../../Theorems/cartier_and_spin/canonical_ten_larger_source_native_sections_and_relation_budget.md).
The component arguments have independent focused **PASS** reports:
[coarse Euler](../../Research/notes/oct03_ten_hour/eight_module_larger_native_coarse_euler_and_horizontal_kernel_budget_coarse_audit.md),
[original-source composition](../../Research/notes/oct03_ten_hour/eight_module_larger_native_coarse_euler_and_horizontal_kernel_budget_source_audit.md),
[fiber evaluation](../../Research/notes/oct03_ten_hour/eight_module_native_section_evaluation_bounds_audit.md),
[odd-field scalar closure](../../Research/notes/oct03_ten_hour/eight_module_larger_odd_coefficient_field_dimension_obstruction_audit.md),
[odd-field original-source audit](../../Research/notes/oct03_ten_hour/eight_module_larger_odd_coefficient_field_dimension_obstruction_source_audit.md),
and [whole-kernel nonhorizontality](../../Research/notes/oct03_ten_hour/eight_module_larger_perfect_four_nonhorizontal_relation_audit.md).
Their frozen notes and independent evidence are retained.
Canonical extraction fidelity is pending; none of the proofs below
supplies a larger-source existence or exclusion.

## Native local lattices in arbitrary rank

The actual stack pullback of the SAME original source is
\(f_1^*\mathcal E_V=\mathcal A_{V,\mathrm{orig}}\twoheadrightarrow K\).
Only \(P_1^8=\omega_{\Gamma_1}^2\) is needed. The exact weak local
invariant-lattice argument in the
[native eight-source proof](canonical_ten_eight_source_perfect_four_section_kernel_exclusion.md)
works block by block for every \(J_s\), \(s\le5\). It gives an
invariant rational \(P_1\)-frame \(r\) of valuation TWO and a regular
coarse basis, for a nilpotent logarithm \(N_0e_\ell=e_{\ell-1}\),
\[
u^{\lceil(\ell-2)/5\rceil}r\exp(-yN_0)e_\ell,
\qquad 0\le\ell<s,\quad y=t^{-1},\quad
u=t^5/(1-t^4).
\tag{1}
\]
The actual weak action is \(g(y)=y+1\). Reciprocal normalization of
the coefficient and scalar lifts preserves the genuine paired action
and the eighth-power identity. No quarter-root is chosen.

Summing the column determinant valuations in (1) gives
\[
(d_1,d_2,d_3,d_4,d_5)=(2,4,6,13,20),\qquad
d_{\rm wild}=2n+5b_4+10b_5.
\]
The tame determinant defect is the ACTUAL paired negative count \(j\).
The coarse direct image is coherent and torsion-free on \(\mathbf P^1_1\),
hence a vector bundle of rank \(n\); generic Galois descent gives the
rank without wild-invariant exactness. Determinant evaluation on the
UNCHANGED atlas \(\Gamma_1\) gives
\[
\frac{nN}{40}
=N\deg\mathcal F_V+\frac N5(2n+5b_4+10b_5)+\frac N2j.
\tag{2}
\]
Solving gives (2) of the statement, and integrality gives \(j\equiv m\pmod2\).
Riemann--Roch on the coarse \(\mathbf P^1_1\) gives
\(h\ge\max(0,\chi(\mathcal F_V))\).

## Evaluation and the entire original horizontal core

A nonzero native section has a \(G_1\)-invariant common-zero locus
on \(\Gamma_1\). Every nonempty orbit has at least \(N/5\) points,
whereas every nonzero scalar coordinate section of \(P_1\) has zero
divisor degree \(N/40\). Therefore no nonzero native section vanishes
at any point. A nontrivial constant linear combination of a basis
of the global section space cannot vanish either. Global evaluation
thus has no fiber kernel and is an everywhere rank-\(h\) subbundle.

The smallest regular-frame coordinate valuation of (1) is
\[
2-\ell+5\lceil(\ell-2)/5\rceil.
\]
For \(0\le\ell\le4\), it is ZERO only at \(\ell=2\). That column
exists precisely for \(s\ge3\), and its closed-fiber value is the
block's socle. Hence the wild evaluation space has dimension
\(b_3+b_4+b_5\). The tame evaluation space is the positive paired
eigenspace of dimension \(n-j\). Fiberwise injectivity proves (3).

Ordinarity of the selected original \(Y\) implies \(H^0(Y_1,K)=0\).
Every native global section is therefore killed by the ORIGINAL map
to \(K\). Pull the SAME source relatively and \(k\)-linearly, giving
the Cartier-horizontal subbundle \(\mathcal O_\Gamma^{\oplus h}\)
in \(M^{10}W_{\rm rel}\). The SAME original source \(a\) kills its
pullback to \(T\); composing with the SAME evaluation gives zero
under \(b\). ENTIRE finite-pushforward adjunction, including the
inclusion in \(M^6\phi_*\mathcal O_T\), puts it in
\(M^{10}\mathcal R_V\). A trace of \(b\) does not suffice for this step.

The quotient by this trivial bundle is locally free even inside the
kernel: the kernel is saturated in the ambient bundle, and the
trivial subbundle is already an ambient subbundle. Over the smooth
curve their induced quotient is torsion-free. This proves (4), with
its everywhere-subbundle and exact original-action assertions.

## The perfect-four kernel and its nonzero original oper image

The retained exponent-ONE radical and original rank-seven lifted
row give \(\det\mathcal J_V=M^{26}\omega_\Gamma^{-1}\). Since the
untwisted constant source is an ordinary trivial vector bundle,
\(\det\mathcal R_V=M^{-26}\omega_\Gamma\) as an underlying line.
The paired genuine \(\mathcal B=M^{10}\mathcal R_V\) has rank \(n-7\)
and degree
\[
\deg\mathcal B
=(10(n-7)-26)\deg M+\deg\omega_\Gamma
=\frac{(5n-44)N}{40}.
\tag{3}
\]
An everywhere trivial subbundle of the same rank would be an
isomorphism and force degree ZERO. Formula (3) is nonzero for every
integer \(n\); hence \(h\le n-8\).

Every genuine \(G_1\)-linearized line on the ACTUAL \(\Gamma_1\)
has degree in \((N/10)\mathbf Z\). Indeed Hilbert90 over
\(k(\Gamma_1)/k(\mathbf P^1_1)\) supplies a genuine invariant rational
section. Its divisor is a sum of actual orbits of sizes \(N,N/2,N/5\).
This uses the faithful actual curve action, not a faithful matrix image.

If the ENTIRE \(\mathcal B\) were preserved by the actual Cartier
connection, equivariant Cartier descent would produce a genuine
\(G_1\)-bundle \(\mathcal B_1\) with \(F_\Gamma^*\mathcal B_1=\mathcal B\).
Its determinant would have degree
\[
\frac{5m-11}{5}\frac N{10}\notin\frac N{10}\mathbf Z,
\]
because \(5m-11\equiv4\pmod5\). This contradicts the orbit-degree
lattice. Thus the entire kernel is nonhorizontal, in every dimension
under consideration; its proper horizontal core is not excluded.

The original horizontal map \(a\) and its original evaluation
\(\lambda\) satisfy \(b=\lambda a\), whose ENTIRE adjoint is
\(M^{10}J_V\). If \(a(\phi^*\mathcal B)=0\), differentiate using
horizontality of \(a\). The SAME entire adjunction forces
\(\nabla\mathcal B\subset\mathcal B\otimes\omega_\Gamma\).
The separating \(\phi\) has nonzero generic differential, so generic
vanishing after pullback is vanishing before pullback. Saturation
extends the resulting inclusion over the curve. This is the forbidden
whole-kernel horizontality.

For \(v\in\ker\lambda\), the intrinsic first jet is
\(j_1\lambda(v)=d(\lambda v)-\lambda(\nabla v)\). Choosing a target-line
connection leaves this expression unchanged when \(\lambda v=0\).
If it vanished on the original \(a(\phi^*\mathcal B)\), differentiate
the original zero relation \(b(\phi^*\mathcal B)=0\). The same
separating/adjunction argument again forces whole-kernel horizontality.
Both assertions (6) follow. They are nonzero sheaf-image conclusions,
not pointwise nonvanishing claims.

## The odd-field coefficient restriction

This part uses the actual paired line and the exact original multiplier
\(d=4\) or EIGHT, but not irreducibility. For the original group,
pull back \(SL_n\to PGL_n\) and let \(H\) be generated by the unique
normalized order-five lifts of \(a,b\). It maps onto the ORIGINAL
\(G\); its finite scalar kernel \(K_0\) carries the original multiplier.
Every \(k^\times\)-character of \(H\) is trivial, because its two
generators have order FIVE. Transgression from
\(\operatorname{Hom}(K_0,k^\times)\) is injective. Therefore the
faithful scalar character has exact order \(|K_0|=d\).
The scalar kernel injects into the normalized matrix image even if
\(G\to PGL_n\) is nonfaithful. Its center may be larger than this kernel.
Only finite \(k\)-points of the scalar group are used, so dimensions
divisible by FIVE introduce no nonexistent prime-five roots of unity.

If the projective class has an \(\mathbf F_q\)-model, \(q=5^r\),
the unique normalized unipotent lifts are \(\mathbf F_q\)-matrices:
a representative's scalar fifth power has a unique fifth root in
\(\mathbf F_q\). Their product \(C\) is also \(\mathbf F_q\)-rational.
For ODD \(r\), \(q\equiv5\pmod8\), so \(\mathbf F_q^\times\)
has no primitive eighth scalar. The injection of \(K_0\) into this
matrix image excludes \(d=8\).

For \(d=4\), the original paired line \(P=M^2\) (or its actual
relative pull \(M^{10}\)) has genuine fourth power. Write
\(P^8=\omega_\Gamma^{2e}\), \(e=1\) or FIVE. The ratio
\(P^4\omega_\Gamma^{-e}\) has equivariant square trivialization:
normalization ambiguities are characters of the original \(G\),
which has no prime-to-five quotient. The accepted auxiliary
two-torsor argument in the
[scalar proof](../quotient_geometry/local_actions/canonical_ten_eight_source_scalar_and_wild_constraints.md)
uses only the actual weak/tame curve: a nontrivial equivariantly
square-trivial line gives a connected étale double torsor whose
\(G\)-quotient is a double cover of \(\mathbf P^1\) branched at at
most the single tame value, impossible in odd characteristic.
It gives \(P^4=\omega_\Gamma^e\) as SAME actions. No particular
wild Jordan type is used.
At the actual tame point its fiber is MINUS ONE; the reciprocally
paired normalized \(C\)-lift therefore has \(\lambda^4=-1\).

Coefficient Frobenius for ODD \(r\) exchanges \(\lambda\) and
\(-\lambda\). Rationality of
\((X-\lambda)^{n-j}(X+\lambda)^j\) forces \(j=n-j=2m\).
Finally \(\det C=\lambda^n(-1)^j=(-1)^{m+j}=1\), so \(m\) is EVEN.
Thus \(8\mid n\), proving the last conclusion.

Even coefficient fields, proper horizontal cores and larger-source
geometric realization remain undecided. The original endpoint maps
have been retained on SAME \(T\) at every step; none receives a
quotient-field replacement. No composition factor or separately
constructed flag has been identified with the specified original
generating source or its entire adjoint kernel.
