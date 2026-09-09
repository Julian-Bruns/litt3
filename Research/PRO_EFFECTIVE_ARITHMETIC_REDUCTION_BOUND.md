# An explicit bound for arithmetic genus-two reductions

Please prove the single quantitative statement below. This is a small
effectivity question inside an investigation of Litt's common-cover
problem, NOT a request to settle the common-cover problem, construct
ordinary replacement witnesses, or establish a new lifting theorem.
You do not need our curve coefficients or computation files.

## Target

Let \(\mathcal E_{2,5}\) be the set of geometric isomorphism classes of
smooth projective genus-two curves over \(\overline{\mathbf F}_5\) that
are potential good reductions at 5 of compact arithmetic complex curves
of genus two.

Here an arithmetic complex curve means \(\Gamma\backslash\mathfrak H\)
for a torsion-free cocompact arithmetic lattice
\(\Gamma\subset\operatorname{PSL}_2(\mathbf R)\). Include ALL arithmetic
lattices: not just congruence lattices or groups contained in the norm-one
group of a maximal quaternion order. Include all number-field models,
places over 5, finite extensions needed for good reduction, and geometric
residue-field conjugates. Twists are not separately counted if their
geometric special fibers are isomorphic.

Prove, with explicit constants and no unexecuted enumeration,

\[
             |\mathcal E_{2,5}|\le 2^{\,2^{1000}}. \tag{EB}
\]

The enormous slack is intentional. We want a short, rigorous upper bound,
not an exact classification, an optimized constant, curve equations, or
a numerical approximation. A substantially smaller proved bound is welcome.

## Established inputs: use these, do not reprove them

1. This set is finite and Frobenius-stable. Borel's bounded-covolume
   theorem gives finitely many arithmetic genus-two complex curves;
   they are defined over number fields, including the noncongruence case.
   Stable-model uniqueness makes the set of their potential good
   geometric reductions finite. Merely reproving finiteness does not
   answer (EB).
2. In an ACTUAL coreless span \(X\leftarrow Z\to Y\), with both maps
   finite etale from the SAME smooth projective source and \(g(Y)=2\),
   a simultaneous smooth proper mixed-characteristic lift of the whole
   span forces \([Y]\in\mathcal E_{2,5}\).
3. A matching nilpotent indigenous connection that is ordinary on the
   common source gives such a full lift. Endpoint ordinariness alone
   does not. No proof of these two lifting implications is requested.
4. The family
   \(Y_t:v^2=u(u-1)(u-2)(u-3)(u-t)\) has at most 120 parameters per
   geometric curve class. If \([\mathbf F_{25}(t):\mathbf F_{25}]\)
   is prime \(r>120\), its geometric moduli class has Frobenius-25
   orbit of length exactly \(r\).

## Why the numerical bound is the missing useful result

Our ALREADY prescribed parameter has prime degree
\(r>2^{2^{1000}}\); this follows from a separate, larger, explicit bound.
Thus (EB), together with input 4, would exclude every simultaneously
liftable coreless span for this same curve, and in particular every
ordinary-common-source witness. No change of endpoints is needed.
Nonordinary/nonliftable witnesses and spans without a matching connection
would remain open; do not claim their exclusion.

If the proposed numerical ceiling fails, an explicit larger certified
bound still tells us exactly how to enlarge the parameter prescription.
If no explicit bound is obtained, report that limitation briefly; do not
replace the requested count by ordinary-cover constructions or another
qualitative finiteness theorem.

## Useful starting points and counting pitfalls

- Maclachlan--Rosenberger, *Commensurability classes of arithmetic
  Fuchsian surface groups of genus 2*, Math. Proc. Cambridge Philos. Soc.
  148 (2010), 117--133,
  https://doi.org/10.1017/S0305004109990260, treats all relevant
  commensurability classes. A count of commensurability classes is NOT
  yet a count of curves; orders, conjugacy classes and subgroup indices
  must still be controlled.
- Macasieb, *Derived Arithmetic Fuchsian Groups of Genus Two*,
  https://arxiv.org/abs/0803.1519, has explicit tables, but its **derived**
  hypothesis is narrower than the target. Do not silently use its
  degree-five field bound for every arithmetic lattice.
- A compact genus-two surface has area \(4\pi\). The universal
  orientable hyperbolic orbifold lower area bound \(\pi/21\) bounds its
  index in an overgroup by 84. Once the relevant overgroups are
  explicitly bounded, very crude subgroup counts suffice.
- Counting complex curve classes alone needs an additional argument
  controlling ALL good reductions and residue conjugates. One possible
  route is to prove the relevant complex list Galois-stable, then fix
  one 5-adic place and use stable-model uniqueness. Do not assume this
  descent step or identify trace fields with fields of moduli.

Please give the explicit numerical inequalities and precise primary
references supporting them. The requested deliverable is (EB), not a
catalogue of further hypothetical reductions.
