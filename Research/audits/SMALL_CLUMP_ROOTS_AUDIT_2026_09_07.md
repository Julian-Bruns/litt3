# Small clump endpoint roots: independent bounded audit

Verdict: **PASS** for the new mathematical portion specified below.
Auditor: `/root/audit_small_clump_roots`.
Date: 2026-09-07.
No blocking mathematical objection or required correction was found.
This is a prose audit, not Lean verification.

## Scope

- `canonical_intersection` v2: exact primitive clump normalization,
  endpoint torsion orders, endpoint tensor roots, and norm divisibility
  (proof Sections 2–3, using the retained unique-clump input).
- `cartier_generator` v2: arbitrary one-endpoint root Cartier identity,
  its exponent-independent vanishing consequence, and the full one-form
  power exclusion (Section 4). The preceding degree and Cartier arguments
  were read and checked for the conventions this extension needs.
- `small_clump_root_reduction` v1: the whole new reduction and finite
  root-weight table, conditional on its named retained dependencies.

The three statements and solutions, their registry statements and
dependency trees, and the required definitions were read. The pertinent
uniqueness and native-cubic-fiber arguments in `two_primary_w3` and
`cyclic_cubic_low_abel_torsion` were also read. Existing audits of the
mixed bound216, pure two-primary W3 vanishing, uniform Cartier eigenform
zeros, and the all-c cubic-fiber certificate were accepted as inputs;
their large arithmetic certificates were not rerun. This verdict does
not silently certify all older portions or external inputs of the first
two whole statements.

## Checks supporting the verdict

1. **Exact normalization and actual norms.** From the actual etale
   equalities f*D_X=g*D_Y=S and the canonical pullbacks, the two positive
   pairs (r_X,r_Y) and (h_X,h_Y) have the same primitive integer direction.
   Thus d_0=m/gcd(m,h), e_0=h/gcd(m,h) are precisely the coprime solution
   of e_0 r_i=d_0 h_i. Triviality of both L_i^n is necessary and sufficient
   for a shared tensor with this divisor ratio: two pullbacks having the
   same divisor differ by a scalar. Hence n=lcm(q_X,q_Y) gives the exact
   primitive weight, and the separate root exponent is q/q_i.
   The identity f*L_X=g*L_Y in J(Z), followed by the actual norm maps,
   gives (deg f)L_X=0 and (deg g)L_Y=0 under Hom-zero. Reverse Hom-zero
   follows by duality and the canonical principal polarizations.
   No Galois assumption or replacement of either map is present.

2. **Global Cartier and scalar roots.** Independently of twist notation,
   for a nonzero rational one-form eta the same operator is

       C_n(u)=eta^n C(u/eta^(5n)).

   Replacing eta by h eta leaves it unchanged by the ordinary Cartier
   fifth-power rule. A local regular frame shows regularity, and ordinary
   Cartier functoriality gives etale compatibility. If d=bm is prime to5,
   the congruence mr=a+5j has j>=0 and n=n_b+bj, giving exactly
   C_n(t^(mr))=t^j C_(n_b)(t^a). Multiplication by the nonzero rational
   tensor t^j is injective. A nonzero scalar factor in s_X=t^m can be
   absorbed over the algebraically closed field and never changes
   Cartier vanishing.

3. **The exceptional weights dividing4 are covered.** For a one-form
   root, C_n(omega^(rd))=omega^n C(omega). When d is1,2,4, one has
   n=d-1 and the image is c omega^d; otherwise its image is zero.
   Thus the eigenvalue-zero case is included. Reducing an arbitrary
   shared power to the primitive generator uses that a rational function
   with constant q-th power is constant, also when5 divides q. Simple
   zeros on X force multiplicity d on Y by the same two actual etale
   pullbacks, so the retained shared-simple-root theorem applies.

4. **Mixed torsion and the table.** For r=1,2,3 the pairs (d_0,e_0) are
   (1,16),(1,8),(3,16). The norm gives q_X|deg f. Since5 does not divide
   the primitive shared weight, it cannot divide q_X. The identity
   e_0 q_X alpha=0 therefore places the full class alpha, without any
   effectiveness assertion about its primary projections, in the mixed
   two/three-primary group covered by the retained bound216. Each e_0
   kills its two-primary part of order at most8, leaving q_X in
   {1,3,9,27}. Weight1 is excluded by the one-form argument. For r=3,
   q_X=1 gives pure two-primary alpha and hence alpha=0; reducedness
   leaves precisely the native cubic fibers above finite unramified
   values. The
   all-c nonzero C_1(t_X^2) certificate excludes this weight3 root for
   every full primitive power, since the latter weight is divisible
   by3 and cannot divide4. The stated retained rows follow.

5. **Finite-field descent and unbounded second leg.** Every retained
   q_X exceeds1, so alpha is nonzero. Low-pencil uniqueness then applies;
   the zero class's moving cubic pencil has already been removed.
   Frobenius fixes both alpha and O, so uniqueness fixes D_X as a divisor.
   The degree-zero line bundle omega_X^(b_X)(-e_0 q_X D_X) is defined
   over F_(25^684), and its geometric section space has dimension one.
   Flat scalar base change supplies a nonzero section over that field.
   This proves finiteness up to scalar. No bound or prime restriction on
   deg g is needed: q_Y changes the full power exponent, and the root
   Cartier test was proved independently of that exponent.

## Nonblocking wording suggestion

In `small_clump_root_reduction`, “defined over F_(25^684)” is correct for
the divisors and the tensor lines. For clarity one may add:

> Each D_X is rational as a divisor over this field; its individual
> support points need not all be rational over it. The tensor root can
> be chosen over this field.

No mathematical change is required. No clump existence, exclusion of
the retained tests, bound on larger clumps, or solution of the original
unmarked common-cover problem follows from this audit.
