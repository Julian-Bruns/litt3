# Actual defect growth and exact cyclic towers

Version8,2026-10-03. Work over an algebraically closed field of
characteristic five and retain the ACTUAL pulled-back connections.

## Defect growth and one-defect sources

Dormant tangent bundles \(V_d\) and admissible active tangent bundles
\(E_r\), in every genus at least two, have perfect alternating
\(\omega\)-valued pairings. The
[symplectic section theorem](cyclic_symplectic_blocks.md) applies to
their actual finite étale pullbacks: odd defects grow under every
nontrivial cover with five-group Galois closure; defect-one sources
have prime-to-five actual deck groups. Neither conclusion makes an
arbitrary leg Galois or bounds its closure.

For an ACTUAL coreless bi-étale span \(X\leftarrow Z\to Y\) with
matching admissible active connections, if \(Z\to Y\) is Galois
and the \(X\)-defect is positive, then \(\delta_Z>\delta_X\).
No Jacobian ordinariness, genus-two or Hom-vanishing assumption is needed.

For \(Y_t\) in [the high-degree table](../../projective_connections/genus_two_active_twists.md),
parameter degree\(>9\), a Galois active-defect-one source factors
through one of its ten bad doubles \(D\to Y_t\). Its connection
is one of the five exceptional ones, \(Z\to D\) has prime-to-five
degree and preserves defect one, and
\(\operatorname{rank}\Psi_Z^2=\operatorname{rank}\Psi_Z\).
For a coreless witness the \(X\)-connection is ordinary. The later
[descent theorem](../defect_preserving_etale_descent.md) excludes this
whole Galois one-defect branch for the selected main pair.

## Exact semilinear towers

Let \((C,r)\) be any active pair with a simple zero:
\(\dim\ker\Psi_C=1\) and
\(\operatorname{rank}\Psi_C^2=\operatorname{rank}\Psi_C\).
Put \(d=\dim H^1(C,T_C)\). If a connected cyclic-five étale cover
has defect \(\ell<5\), necessarily \(\ell\in\{2,4\}\), it extends to cyclic towers of every height.
For ANY such tower \(C_n\to C\), \(n\ge1\), \(q=5^n\),
\[
\operatorname{rank}\Psi_{C_n}^{\,j}
=(d-1)q+\max(q-j\ell,0),\qquad j\ge0.
\]
The defect stays \(\ell\), while the nilpotent summand has dimension
\(q\) and nilpotence index \(\lceil q/\ell\rceil\).
Every nonzero \(v\in\ker\Psi_C\) pulls back nontrivially, with
\[
v_n\in\operatorname{im}\Psi_{C_n}^{\,j}
\quad\Longleftrightarrow\quad j\ell\le q-1.
\]
These are actual Frobenius-semilinear iterates, with the deck parameter
fixed by coefficient Frobenius.

For EVERY main bad double in the ten-pair table at parameter degree\(>23\), including
the selected main endpoint, and EVERY backup bad double in the twelve-pair table,
ALL cyclic five-power covers have \(\ell=2\). Each ordinary genus-three
double has31 cyclic-five directions, all of which extend to towers.
Here \(d=6\), so the rank is \(5q+\max(q-2j,0)\).
This uses the later [exact abelian classification](../abelian_covers/abelian_defect_flags.md),
rather than a direction census.

For the remaining degree\(>9\) family range, the older conclusion
is retained and sharpened: each exceptional connection's two bad
twists give isomorphic rank-four bundles, with theta multiplicity
\(m\in\{2,4\}\). At least \(6-m\) of the six cyclic-five directions
on \(Y_t\) work SIMULTANEOUSLY on both doubles, with \(\ell=m\).
At degree\(>23\), \(m=2\) and all six work.

Finally, every connected prime-to-five étale map \(Z\to C\) preserving
defect one transfers these formulas to the connected base-change
towers, replacing \(d\) by \(\dim H^1(Z,T_Z)\). Any two actual endpoint
maps from \(Z\) survive. A nonzero actual mixed canonical \(W_3\)
difference in \(\ker\Psi_Z\) stays nonzero, enters arbitrarily deep
finite images, and never enters the stable image at a finite level.
This does not repair the original diagram or supply an example
realizing such a difference.

[Proof](../../../Proofs/deformations/section_growth/symplectic_p_cover_section_growth.md).
