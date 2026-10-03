# Actual weak PSL-eight curves have one invariant étale five-torsor line and an exact Sylow ledger

Version 1, 3 October 2026. Fresh focused
[independent audit PASS](../../../Research/notes/oct03_ten_hour/eight_module_actual_curve_p_torsors_and_sylow_five_audit.md).
No matrix enumeration or characteristic-zero realization is used.
All statements concern an ACTUAL characteristic-five curve.

Let \(k=\overline{\mathbf F}_5\) and \(Q=PSL_8(\mathbf F_5)\).
Assume a faithful \(Q\)-action on an actual smooth projective connected
curve \(D/k\), with \(D/Q=\mathbf P^1\), exactly one weak \(C_5\)
branch value of lower break one, and one tame \(C_2\) branch value.
The original coarse quotient has TWO branch values.
Retain the accepted primary fact that the universal central extension
\(SL_8(\mathbf F_5)\to Q\) has kernel \(C_4\).
Then:

1. The invariant constant étale torsor group is exactly
   \[
   H^1_{\mathrm{et}}(D,\mathbf F_5)^Q\simeq\mathbf F_5.
   \]
   Its four nonzero markings give the same connected étale \(C_5\)
   cover \(D'\to D\). This cover is the normalized pullback of the
   unique global Artin--Schreier line matching the completed weak
   extension over the SAME coarse field.

2. For every \(n\ge1\),
   \[
   H^1_{\mathrm{et}}(D,\mathbf Z/5^n)^Q
   =\operatorname{Hom}(C_5,\mathbf Z/5^n)\simeq C_5,
   \]
   up to the choice of generator of that line.
   Every reduction map from level \(n+1\) to \(n\) is ZERO on these
   invariant groups, and \(H^1_{\mathrm{et}}(D,\mathbf Z_5)^Q=0\).
   A nonzero invariant mod-five class has no invariant lift to
   coefficients \(\mathbf Z/25\), surjective or otherwise.
   This is a statement about constant étale torsors. It does not
   identify their invariants with invariant geometric
   \(\operatorname{Pic}(D)[5]\) points.

3. The actual \(D'\to D/Q\) has group \(Q\times C_5\).
   Its quotient by \(Q\) is the rational Artin--Schreier curve \(U\).
   The actual \(Q\)-cover \(D'\to U=\mathbf P^1\) has precisely five
   tame \(C_2\) branch values and no wild ramification.
   Moreover
   \[
   g(D)-1=|Q|/20,\quad
   g(D')-1=|Q|/4,\quad
   f_5(D')-1=5(f_5(D)-1).
   \]

Assume ADDITIONALLY that the actual wild generator has natural Jordan
type \(J_5\oplus J_3\). Let \(P_5\) be a Sylow-five subgroup of \(Q\),
of order \(5^{28}\), and put \(E=D/P_5\).
Then its action has exactly
\(\kappa=16,531,456\) short orbits, all of length \(5^{27}\).
There are no additional short orbits.
The complete flag count for a \((5,3)\) unipotent over \(\mathbf F_5\)
is \(4036\), and \(\kappa=4^6\cdot4036\).
The exact Hurwitz and Deuring--Shafarevich formulas are
\[
g(D)-1=5^{28}(g(E)-1)+4\kappa5^{27},\qquad
f_5(D)-1=5^{28}(f_5(E)-1)+4\kappa5^{27}.
\]
Consequently
\[
f_5(D)\ge1+66,125,819\cdot5^{27},\qquad
g(D)-f_5(D)=5^{28}(g(E)-f_5(E)).
\]
Thus the p-rank defect is divisible by \(5^{28}\), and \(D\) is
ordinary exactly when \(D/P_5\) is ordinary. Ordinarity is not forced.
With \(m=|Q|/(20\cdot5^{27})=\frac1{16}\prod_{i=2}^8(5^i-1)\),
the quotient genus is exactly \(g(E)=1+(m-4\kappa)/5\).

## Transfer and exact limitation

If an ACTUAL free kernel \(N\) gives \(\Gamma\to D=\Gamma/N\) and
\(5\nmid|N|\), pullback on \(H^1_{\mathrm{et}}(-,\mathbf F_5)\) is
injective. Thus the lower p-rank bound transfers to \(\Gamma\).
For the actual extension \(1\to N\to G\to Q\to1\), coprime
cohomology gives \(H^2(G,C_{5^n})=0\); the same actual two-branch
argument gives precisely one \(G\)-invariant torsor line and the
same higher-coefficient zero reductions on \(\Gamma\).
This applies in particular to a two-group kernel.
For a general necessary even kernel, \(5\nmid|N|\) is a separate
hypothesis and this transfer is not asserted.

These conditions leave a large nonempty numerical range. Neither
the quotient curve nor the original common-cover source is realized
or excluded. BOTH original finite étale endpoint maps remain on
their SAME original \(T\); no endpoint map descends to \(D\), \(D'\)
or \(\Gamma/N\).

[Proof](../../../Proofs/quotient_geometry/local_actions/actual_psl_eight_weak_curve_invariant_five_torsors_and_sylow_ledger.md).
