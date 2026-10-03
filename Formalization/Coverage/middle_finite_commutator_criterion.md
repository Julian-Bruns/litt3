# Finite commutator criterion: full-source scope review

Canonical statement: `Theorems/cartier_and_spin/middle_finite_commutator_criterion.md`,
Version1. Statement SHA256:
`0078e4090659de7682c3edadb3b6276f0f5a58de545ef150c1b712ecc9f67fe5`.
Reviewed proof SHA256:
`ec485c940637115c621b689dcacf9f5e9386daa17c0902738076f83e5f692545`.

Status: complete for this exact Version1 source snapshot. The literal
ten-clause quantified proposition
`Specifications.MiddleFiniteCommutatorCriterion`, proved by
`Solutions.CartierAndSpin.MiddleFiniteCommutatorCriterion.middle_finite_commutator_criterion`.
No clause is represented by an opaque proposition or supplied conclusion.
The root's independent whole-source readback accepts the exact canonical
statement and proof, all ten quantified clauses, and the full implementations
of rank/kernel, row compression, counts, degrees and actual fibers. The
displayed block form is the source's explicit input; its universal
arbitrary-linear-matrix specialization covers that input directly.

| Canonical clause | Actual construction and proof |
| --- | --- |
| Algebraically closed field, arbitrary characteristic, positive n | `FiniteCommutatorEigenCriteriaClause` quantifies every algebraically closed field and every natural n>0. All matrix entries, vectors and eigenvalues are actual elements. No characteristic hypothesis is introduced. |
| Nonzero intersection of kernels of [U^i,V^j], 1≤i,j≤n−1 | `boundedPowerCommutatorKernel` is the literal finite infimum of actual linear-map kernels. `matrix_bounded_power_kernel_criterion` proves its equivalence to an actual common eigenvector. |
| Dimension-one empty intersection equals k | `one_dimensional_bounded_power_kernel` proves that the actual submodule is top over every commutative coefficient ring. |
| Ordered stack CU^aV^b for a+b≤n−1 has rank<n | `orderedCommutatorStack` retains every actual row. `matrix_ordered_commutator_rank_criterion` proves the equivalence using actual matrix rank, actual rank-nullity and a finite descending kernel chain. |
| Both finite tests are exact | `finite_commutator_eigen_criteria_clause` proves both equivalences to the same literal common-eigenvector predicate, together with the alternative power-stack rank criterion. |
| Normal ordering over any original commutative ring | `commutator_word_rows_eq_ordered` proves equality of actual original-ring row submodules. It first proves equality of genuine left ideals over arbitrary noncommutative rings, then uses the actual row multiplication formula. No fraction field is introduced. |
| Exact displayed H=[b₀I₁₅+U(z); b₁I₁₅+V(z)] | `shiftedPencilStack` is that literal vertical matrix. `linearPolynomialMatrix` and `linearMatrixFiber` retain arbitrary coefficient matrices for all eight coordinates z. `shifted_pencil_stack_kernel` proves exactly Us=−b₀s and Vs=−b₁s. |
| Every geometric z≠0, unrestricted b₀,b₁ | `middle_pencil_fiber_clause` quantifies every z≠0 and unrestricted scalar coordinates. Its proof actually works at every z, without a generic-fiber restriction. |
| 120 blocks and 1800 rows | `OrderedCommutatorPairs 14` is the actual dependent finite type of all pairs a+b≤14. A symbolic triangular-count theorem gives its cardinal 120; the actual product with Fin 15 has cardinal 1800. No matrix enumeration occurs. |
| Ordered entries degree≤16 | `linear_polynomial_ordered_stack_degree_bound` bounds actual multivariate-polynomial entries by d+2, from polynomial sum/product bounds. The literal d=14 specialization gives 16, with cancellation and zero entries retained. |
| Alternative 2940-row, degree≤28 stack | `powerCommutatorStack` is the actual stack indexed by Fin 14×Fin 14 and all fifteen rows. The exact cardinal is 2940; the actual polynomial entry bound is i+j≤28. Its actual rank criterion is also proved. |
| Zero fiber exception b₀=b₁=0 | Genuine homogeneous linear evaluation gives U(0)=V(0)=0. `middle_zero_fiber_clause` proves that the actual stack has a nonzero kernel exactly when both scalar coordinates vanish, without algebraic closedness. |
| Specialization and normalization retain every fiber | `ordered_commutator_stack_map` and `power_commutator_stack_map` prove exact coefficient-ring specialization identities. `linear_matrix_fiber_smul` proves the literal scaling law for arbitrary coefficients. |
| No determinantal emptiness, polynomial-left-inverse bound or common-cover conclusion | The quantified aggregate concludes only these eigenvector, row-module, rank, degree, count and fiber identities. It contains none of the stronger conclusions disclaimed by the source. |

The power proof uses actual Cayley–Hamilton to span every power by the
first n powers. Bilinearity extends the finite commutator tests to all
powers on the original vector. The resulting literal common kernel is
invariant under both actual operators; their restrictions commute.
Algebraic closedness then supplies an eigenvector on an actual nonzero
invariant subspace. The ordered proof instead uses the actual descending
sequence W₀=ker C and W₍d+1₎=W_d∩U⁻¹W_d∩V⁻¹W_d and strict finite-dimensional
rank drops. These are independent algebraic proofs, with no Hermitian form
or positivity.

The linear-pencil application is proved uniformly for all eight-variable
homogeneous linear coefficient matrices, rather than by encoding a
particular numerical middle tensor. The source explicitly supplies the
displayed block form; the universal theorem applies to that form. The
separate identification and support exclusion recorded in
`middle_common_eigenvector_boundary` are not conclusions of this record
and are not imported as axioms. Their wider formalization remains separate.

The earlier [joint audit](../../../litt3-computation-data/formalization-20261003/verification/20261003T044925Z/report.json)
checked the initial row-compression foundation as part of 396 transitive
declarations, using only Classical.choice, Quot.sound and propext, with zero
forbidden dependencies and zero source changes. The complete aggregate
passed the [focused trust audit](../../../litt3-computation-data/formalization-20261003/verification/20261003T051048Z/report.json):
one solution root, 156 transitive Litt3 theorem declarations, only the three
standard logical axioms, zero forbidden dependencies and zero source changes.
Together with the independent whole-source readback, this closes the exact
canonical finite criterion. The separate middle-support source remains separate.
