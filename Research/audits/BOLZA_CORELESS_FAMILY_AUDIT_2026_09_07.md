# Bolza prime-to-five coreless family: fresh bounded audit

Verdict: PASS, with nonblocking exposition suggestions below.
Auditor: `/root/bolza_coreless_family_audit` (fresh bounded agent).
Date: 2026-09-07.
Scope: complete current statement and proof of
`bolza_prime_to_five_coreless_neighborhood`; arithmetic inputs, actual
same-source specialization, and prescribed-endpoint descent. This is a
prose/source audit, not formal verification. No conclusion about Litt3.

Reviewed [statement](../../Theorems/Thm_bolza_prime_to_five_coreless_neighborhood.md)
and [proof](../../Solutions/Sol_bolza_prime_to_five_coreless_neighborhood.md)
completely. The source note was consulted, but neither it nor the old
coreless route was treated as proof authority. Also inspected the actual
free quotient and invariant-function argument in
`Sol_hermitian_genus_two_test.md`.

## Checks and conclusions

1. The characteristic-five coordinate transformation checks directly:
   r^5=-r, and x^5-x=-2r(s^6-1)/(s-1)^6=y^2. Its Mobius determinant is
   nonzero. The sextic and Bolza polynomials are separable at5; the stated
   Cartier coefficients all vanish. The Hermitian clock-and-shift group
   acts freely, and the displayed cubic discriminant gives the claimed
   genus-two quotient. Thus the Hermitian endpoint is the actual curve H.

2. The arithmetic identifications and congruence sandwich are present in
   [Katz–Katz–Schein–Vishne](https://u.math.biu.ac.il/~scheinm/text61.pdf),
   Section4, Theorems1.4–1.5 and Propositions5.3,5.5. These identify the
   curve's surface group, not only its Jacobian. In particular its level
   has only dyadic support and the algebra splits at both primes above7.

3. [Voight28.5.3](https://link.springer.com/chapter/10.1007/978-3-030-56694-4_28)
   supplies strong approximation because one archimedean place splits.
   The requested adelic open set is nonempty: at lambda use a neighborhood
   of diag(7,7^-1), at2 use the identity congruence neighborhood, and use
   maximal compact conditions elsewhere. The local hyperbolicity of g
   follows from its negative trace valuation.

4. The local normal-core argument is valid. Conjugation is integral away
   from lambda, and at2 acts trivially modulo2, preserving Gamma's
   congruence condition. Deep lambda kernels therefore enter both groups.
   The finite quotient has order dividing 336*7^(3(m-1)); its projective
   version introduces no factor5. The elementary intersection lemma in
   Section2 correctly retains prime-to-five normal-core indices for an
   arbitrary normal prime-to-five subgroup L, including noncongruence L.

5. Finiteness of discrete overgroups holds. If L is contained in M with
   index at most N, K=core_M(L) lies in L with index at most N!, is normal
   in M, and has genus at least2. There are finitely many possibilities
   for K and each M/K lies in the finite automorphism group of its curve.
   The local boundedness argument excludes g^a in N(L) for a nonzero a:
   otherwise every g^(aj) would lie in the bounded normalizer. Consequently
   only finitely many conjugates can lie in discrete overgroups. A
   nondiscrete generated group cannot preserve a nonconstant meromorphic
   function: choose a regular point moved by an identity-approaching
   sequence and apply the identity theorem. This establishes geometric
   corelessness of the characteristic-zero span.

6. The GIVEN cover D->C can be lifted along the fixed Bolza model. The
   prime-to-five specialization equivalence and extension of each
   constructed leg follow from [Stacks58.30.3](https://stacks.math.columbia.edu/tag/0BUQ).
   Applying this to the Galois closures, then taking quotients, handles
   non-Galois legs. Both resulting source models are smooth proper stable
   curves with the specified same generic fiber, so stable-model uniqueness
   identifies them by that identity. Both original maps then extend on
   one source. Connectedness and the finite prime-to-five monodromy survive.

7. [Krishnamoorthy4.10](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
   printed p.1188, has precisely the needed direction: a special core in
   a smooth proper finite etale hyperbolic family implies a generic core.
   The constructed diagram meets its hypotheses, including geometric
   integrality after the stated field extensions. No arbitrary given
   two-leg diagram has been assumed to lift.

8. Endpoint descent is correct: the two new endpoint fields are subfields
   of the old two fields in the unchanged k(Z), so their intersection is
   still k. The compositum Galois cover has prime-to-five group, and tower
   normal closures are controlled by finite wreath products of such
   groups. This handles any two prescribed family members, including
   covers of H. Arbitrary Cartesian endpoint extension is not being used.

## Nonblocking suggestions, in priority order

- Make the lift/descent bookkeeping explicit with a single sentence:
  start over the strict henselization of a number-field DVR above5, whose
  residue field is k and whose fraction field is algebraic over Q; proper
  henselian lifting gives the prescribed D, and finite presentation
  descends the data to a finite extension. Characteristic-zero invariance
  of finite etale covers then gives the complex construction over Qbar;
  maps between fixed hyperbolic curves descend as well. This explains why
  the chosen special fiber remains the prescribed cover when passing
  through number fields and complex uniformization.
- Replace “normal cores in L” by the explicit core_M(L) and factorial
  index argument in item5; the present phrase is understandable but terse.
- Define the local reduction kernel using the inverse image of Gamma in
  the norm-one group, or reduction modulo the central signs. This removes
  harmless ambiguity about SL2 versus its projective quotient.
- Say explicitly that negative trace valuation excludes a power in the
  bounded normalizer because all powers would then be bounded. No stronger
  assertion that every element of a bounded set is elliptic is needed.

No statement restriction, new mathematical hypothesis, or change of
construction is required by this audit.

## Version2 scope addendum

Verdict: PASS for the explicitly strengthened Version2 statement,
its rewritten Section5, and
[prime-to-p etale commensurability](../../Definitions/Def_prime_to_p_etale_commensurability.md).
These were read after the initial audit; Sections1–4 are the same
construction audited above. This addendum authorizes no further scope.

The definition correctly requires prime-to-p Galois-closure order, not
merely degree. Transitivity follows from a connected fiber-product
component: each projection is a base change component of one original
cover, and its composite to the outer endpoint is a tower of covers
with prime-to-p monodromy. The subgroup and wreath-product arguments
preserve that condition.

For the witnesses C<-Wi->Ci in Version2, the compositum D of the
closures of Wi->C is connected Galois over C with prime-to-five group.
Moreover D->Wi is Galois with group a subgroup of Gal(D/C); hence
D->Ci has prime-to-five monodromy by composition with the prescribed
Wi->Ci. Sections1–4 only need the single cover D->C. After specializing
the constructed coreless selfspan on D, composing its two legs with
the actual special-fiber maps D->Ci gives the desired coreless span
with the two prescribed endpoints. There is no lifting assumption
on Wi->Ci or D->Ci. Thus the entire restricted equivalence class is
indeed covered. The optional statement without the Wi->Ci monodromy
condition is also correct as written, since it drops the final
monodromy conclusion but retains etaleness and endpoint-field descent.
