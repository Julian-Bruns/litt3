# Exact canonical-root section rows on an actual PSL-eight weak curve

Version1, 3 October2026. The separate
[coarse-lattice audit](../../../Research/notes/oct03_ten_hour/eight_module_actual_coarse_lattices_and_sections_audit.md),
[row-normalization audit](../../../Research/notes/oct03_ten_hour/eight_module_actual_root_row_etale_normalizations_audit.md),
and [third-type extension audit](../../../Research/notes/oct03_ten_hour/eight_module_actual_third_wild_picard_rows_audit.md)
are PASS. Fresh [canonical fidelity audit](../../../Research/notes/oct03_ten_hour/eight_module_canonical_root_rows_canonical_fidelity_audit.md): **PASS**; original audit snapshots are preserved.

Let \(k=\overline{\mathbf F}_5\), \(Q=PSL_8(\mathbf F_5)\), and \(W\)
the prescribed natural projective module with multiplier \(\alpha_Q\).
Retain an ACTUAL faithful connected smooth projective \(Q\)-curve \(D\)
whose coarse quotient is \(\mathbf P^1\), with precisely one weak
cyclic-five branch of break ONE and one tame cyclic-two branch.
The tame natural lift is balanced primitive EIGHT.
Retain the ACTUAL invariant line \(P\), with obstruction \(-\alpha_Q\)
and the specified SAME-action \(P^4=\omega_D\).
Assume its natural wild type is one of the THREE specified partitions
in the table below; full image alone is not asserted to select them.

On \(\mathcal S=[D/Q]\) put \(E=P\otimes W\) and
\(E'=\omega_{\mathcal S}\otimes E^*=P^3\otimes W^*\), meaning the paired
genuine descents from the actual atlas \(D\).
For the coarse map \(\pi:\mathcal S\to\mathbf P^1\), put
\(F=\pi_*E\) and \(F'=\pi_*E'\).
They are ACTUAL rank-eight vector bundles, with the following exact
constraints:

| Wild type | \(\deg F\) | \(\deg F'\) | Wild duality defect | \(h^0(F)\) | \(h^0(F')\) |
|---|---:|---:|---:|---:|---:|
| \(J_5\oplus J_3\) |−7|−7|2|1 or2|1 or2|
| \(J_4\oplus J_4\) |−7|−7|2|1 or2|1 or2|
| \(J_5\oplus J_2\oplus J_1\) |−7|−6|3|1|2|

There is a natural rational dual-lattice extension
\[
0\longrightarrow F^*\otimes\omega_{\mathbf P^1}
\longrightarrow F'\longrightarrow k_b^{\,\ell}\longrightarrow0,
\]
where \(b\) is the ACTUAL wild branch point and \(\ell\) is the table's
defect. It does not identify \(\pi_*\omega_{\mathcal S}\) with
\(\omega_{\mathbf P^1}\): canonical invariants allow a simple pole at
the wild point.

In the two-block cases, each of \(F,F'\) is exactly one of
\[
\mathcal O\oplus\mathcal O(-1)^7,\qquad
\mathcal O^2\oplus\mathcal O(-1)^5\oplus\mathcal O(-2).
\]
In the third case the exact types are
\[
F=\mathcal O\oplus\mathcal O(-1)^7,\qquad
F'=\mathcal O^2\oplus\mathcal O(-1)^6.
\]
The table's \(h^0\) values are exactly the compatible natural-module
multiplicities
\[
\dim\operatorname{Hom}_{SL_8(\mathbf F_5)}(W^*,H^0(D,P)),
\qquad
\dim\operatorname{Hom}_{SL_8(\mathbf F_5)}(W,H^0(D,P^3)),
\]
respectively. Full scalar actions and their signs are retained.

EVERY nonzero such natural copy is base-point-free on the ACTUAL \(D\).
Its projective row has nonzero first derivative at every wild point.
For the normalization \(D_{\rm row}\) of its image, the ACTUAL map
\[
D\longrightarrow D_{\rm row}
\]
is finite ÉTALE, \(g(D_{\rm row})\ge2\), and \(Q\) acts faithfully
on the normalized row.

Degree ONE, identity of quotient orbifolds, and function-field generation
are NOT conclusions. These additional quotient rows are not identified
with an original generating row on \(T/N\), and no original Cartier map,
degree-ten source, carrier identity or full spin-image transfer is
supplied. The input curve and its root are not constructed.
BOTH original finite étale endpoint maps remain on their SAME \(T\).

[Proof](../../../Proofs/quotient_geometry/local_actions/actual_psl_eight_canonical_root_coarse_rows_and_etale_geometry.md).
