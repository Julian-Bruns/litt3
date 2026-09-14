# Proof: Kummer inertia and Frobenius root ratios

[Statement](../../Theorems/examples/kummer_common_covers.md).

## 1. The common source and its two free quotients

A valuation in S_A forces the exponent of A in any relation
A^i B^j in k(t)^(n) to be zero modulo n; a valuation in S_B does
the same for j. Thus L/k(t) has group G=(Z/n)^2. At a point of S_A
its inertia is the first coordinate axis, and at S_B it is the second.
Outside these sets the extensions are unramified: in the completed
local field every unit has an n-th root. This includes infinity.

The diagonal and anti-diagonal cyclic subgroups meet both axes
trivially, hence act freely on the normalized smooth projective T.
Their fixed fields are k(t,u/v) and k(t,uv), giving both etale maps.
Because n is odd, these subgroups generate G; their fixed fields
therefore intersect in k(t). Each endpoint has degree n over P1 and
full index n at all r branch points. Tame Hurwitz gives the genera
in the statement.

For the genus-three Picard row the five branch points are
0,infinity,1,a,a+2. Its minus model in the original quartic coordinate
is obtained from w=u/v by x=1/t and z=1/(tw):

    z^3=x(1-x)(1-a*x)(1-(a+2)*x).

For the genus-four row the six finite roots of A*B are distinct,
and infinity is unramified. Thus both recorded examples are instances
of the same construction, with their original two maps retained.

## 2. Exact arithmetic for the two examples

The point counts over degree j extensions of F25 are

| j | Genus3 plus,minus | Genus4 plus,minus |
|---|---|---|
|1|26,17|33,33|
|2|590,509|615,657|
|3|15431,15566|16095,15726|
|4|—|392427,391017|

At a simple zero or pole of A or B there is one point in either
endpoint fiber. Elsewhere the fiber has3 points for a nonzero cube
and0 otherwise. The genus-three models have one point at infinity;
the monic genus-four models have three.

Newton identities and the functional equation give the Frobenius
polynomials, in the notation f_A used by Howe–Zhu:

    genus3:
    f_+(X)=X^6-18X^4-65X^3-450X^2+15625,
    f_-(X)=X^6-9X^5-18X^4+385X^3-450X^2-5625X+15625;

    genus4:
    f_+(X)=X^8+7X^7+19X^6+175X^5+1525X^4
              +4375X^3+11875X^2+109375X+390625,
    f_-(X)=X^8+7X^7+40X^6+199X^5+931X^4
              +4975X^3+25000X^2+109375X+390625.

All four are irreducible over Q. The degree of the reciprocal
polynomial modulo5 gives p-ranks(2,2) and(2,4).

For two polynomials f,g of degree d the roots of

    R_fg(Z)=Res_X(f(X),Z^d g(X/Z))

are the ratios of their Frobenius roots. For each self-pair, remove
exactly (Z-1)^d. Every resulting polynomial, and the genus-three
cross-resultant, has no cyclotomic divisor. The verifier checks this
by exact gcd with every Phi_m of degree at most D=deg R_fg.
The finite range m<=2D^2 is exhaustive, since

    m/phi(m)^2=product_(ell^e exactly dividing m)
                         ell^(2-e)/(ell-1)^2 <=2.

Only the factor ell=2,e=1 can exceed1. No factorization of the
resultants or numerical root approximation is needed.

## 3. The published simplicity criterion

Irreducibility first gives simplicity over F25. The self-ratio tests
ensure that distinct conjugates of a Frobenius root pi remain distinct
under every positive power, hence Q(pi^m)=Q(pi) for all m.
Absolute simplicity now follows directly from
[Howe–Zhu, Proposition3(2)](https://arxiv.org/pdf/math/0002205#page=4);
this sufficient direction does not require ordinariness.

In genus three the cross-ratio test makes the two Frobenius spectra
disjoint over every finite extension. Any geometric homomorphism
descends to one such extension, where its Tate-module map is zero.
Faithfulness gives Hom=0; see
[Milne, Abelian Varieties, Theorem9.14](https://www.jmilne.org/math/CourseNotes/AV110.pdf).
In genus four, absolute simplicity and the different p-ranks already
exclude an isogeny and hence a nonzero homomorphism.

## Reproduction and evidence

The [single verifier](../../scripts/examples/verify_kummer_examples.py)
recounts both models, reconstructs all four Frobenius polynomials and
runs exactly these root-ratio tests. Use `--genus 3` or `--genus 4`
to select one example.

```sh
sage -python scripts/examples/verify_kummer_examples.py
```

The original exact arithmetic records for
[genus three](../../Research/computations/picard_cubic_common_cover_certificate.json)
and [genus four](../../Research/computations/cubic_ordinary_common_cover_certificate.json)
retain their provenance and independent audits:
[Picard example](../../Research/audits/PICARD_SIMPLE_COMMON_COVER_AUDIT_2026_09_07.md),
[ordinary endpoint example](../../Research/audits/ORDINARY_SIMPLE_COMMON_COVER_AUDIT_2026_09_07.md).
The older genus-four cross-resultant is redundant once its p-ranks and
absolute simplicity are known.
