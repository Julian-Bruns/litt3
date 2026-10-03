# Cyclic étale global generation of the genus-two Cartier bundle

ID: `genus_two_cartier_cyclic_global_generation`. Version1, 2 October2026.
Independent bounded prose review PASS.

Let $k=\overline{\mathbf F}_5$ and let
$C=Y_S:V^2=(x^4-1)(x-S)$, with $S(S^4-1)\ne0$.
For every finite set of primes $\Sigma$, there is a connected cyclic
finite étale cover $q:D\to C$, of degree avoiding five and every prime
in $\Sigma$, such that $B_D$ is globally generated. Equivalently,
eight prime-avoiding torsion line coefficients can be chosen on
$C^{(1)}$ whose evaluation surjects onto $B_C$.

The construction deforms eight geometric fifth-torsion character
sections with cohomology dimension one. They belong to two independent
nonexceptional Cartier-fixed character lines. The remaining cohomology
jumps and reducible or nonreduced Raynaud divisors are retained: the
deformation uses reduced components and the open constant-cohomology
locus, rather than assuming every torsion character has dimension one.
Prime-avoiding torsion is dense there by Poonen's arithmetic-progression
theorem and the characteristic-five exclusion of abelian Raynaud
components. Properness preserves global surjectivity under deformation.

If an actual finite étale leg $g:T\to C$ is already given, the chosen
cover degree may avoid every prime dividing $\deg g$, so $T\times_C D$
is connected. Both endpoint maps of any original actual bi-étale span
remain finite étale from this same refined source.

This is an intrinsic property of every smooth member of the displayed
family, including both selected genus-two endpoints. Thus finite
étale global generation of their Cartier bundles, even by cyclic
prime-avoiding covers, is not an obstruction to the unmarked common-cover
problem. It supplies no compatible common coefficient, stabilized
relation kernel, admissible source or second endpoint map.

Dependencies: `actual_two_map_twisted_cartier_characters`,
`raynaud_rank_one_dimension`, `prime_avoiding_section_growth`;
the primary torsion-density input is Poonen, Remark5.2 and Corollary5.3.

[Proof](../../../Proofs/jacobians/ordinary_covers/genus_two_cartier_cyclic_global_generation.md).
