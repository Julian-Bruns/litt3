# Bounded genus-four ordinary-endpoint followup

Date: 2026-09-07. Author computation, not independently audited.
No new search is running. No library/state promotion.

The prescribed 24 trials completed in 210.8 seconds, below the soft
240-second bound. They did not produce the requested certificate that
both Jacobians are absolutely simple with one ordinary and the other
nonordinary. This finite negative result is not a general obstruction.

The fields and all exact counts are retained in
`Research/computations/cubic_balanced_ordinary_search.json`.
The family is `A=t(t-1)(t-lambda)`,
`B=(t-mu)(t-nu)(t-xi)`, with the four parameters distinct and outside 0,1
in `F25=F5[a]/(a^2+2)`. The two curves have equations `y^3=A*B` and
`w^3=A/B`. The count explicitly gives each zero of A or B one point on
each curve and adds three points at infinity to each. Counts through
F390625 and the functional equation determine degree-eight Frobenius
polynomials.

All 24 minus polynomials pass the ordinary middle-coefficient test, and
all 24 plus polynomials are nonordinary by that test. There are 17
irreducible minus polynomials and two irreducible plus polynomials. The
latter occur in trials 13 and 21 and are identical. In trial 21 the minus
polynomial is reducible. In trial 13 both polynomials are irreducible, but
the plus self-ratio resultant has the cyclotomic factor Phi_3, so the
chosen sufficient absolute-simplicity test fails. Failure of this
sufficient test alone is not a proof that the plus Jacobian is not
absolutely simple.

Trial 13 does certify an ordinary absolutely simple minus endpoint.
Its parameters `(lambda,mu,nu,xi)` are
`(a+4,a+3,2a+2,2)`. Its four point counts are
`27,711,15627,391923`, and its polynomial is

```
X^8 + X^7 + 43X^6 + 43X^5 + 1249X^4
    + 1075X^3 + 26875X^2 + 15625X + 390625.
```

It is irreducible, and its self-ratio resultant has no cyclotomic factor
after removing exactly `(z-1)^8`. Exact gcds with every Phi_m of degree
at most 64 independently verify this. The order bound m<=8192 follows
from m/phi(m)^2<=2. The plus endpoint for this trial is nonordinary and
has irreducible polynomial

```
X^8 + X^7 + 16X^6 - 65X^5 - 425X^4
    - 1625X^3 + 10000X^2 + 15625X + 390625.
```

Its counts are `27,657,15384,388737`. The self-ratio test detects exactly
cyclotomic order 3. These statements are arithmetic certificates only;
the actual common-source etale quotient geometry is left to the main
proof.

The unsuccessful prototype was retired recoverably, as requested, to
`/Users/julian/.Trash/litt3-cubic-exploration.98VZ95/cubic_balanced_ordinary_search.py`.
Its SHA256, saved with the retained data, is
`1f9e1ada0eab5bc2eca7406900ebb889ed80e6a9e1d5a24a2c5fdcdd590ec8d4`.
The script can be recovered if further inspection is needed; no old-path
alias was created.

## The remaining ambiguity in trial13 is now resolved

Main-agent exact calculation,2026-09-07: if pi is a root of the displayed
plus polynomial, pi^3 has minimal polynomial

    Q(T)=T^4-121T^3+29625T^2-1890625T+244140625.

Thus the plus Jacobian over F_(25^3) has characteristic polynomial Q^2.
In K=Q(pi^3), the primes above5 have (ramification index,residue degree,
valuation of pi^3) respectively (1,1,0),(2,1,6),(1,1,6). The normalized
slopes are0,1/2,1. Multiplying by the local degrees gives the integral
values0,1,1, so all Honda--Tate division-algebra invariants vanish.
The simple variety belonging to Q is consequently an abelian surface,
and the plus Jacobian is isogenous to its square over F_(25^3).
It is therefore NOT absolutely simple, not merely unverified by the
root-ratio criterion. This exact diagnosis applies to trial21 too,
which has the identical plus polynomial. It does not assert a general
obstruction for the parameterized family.

The formula used is
[Milne, Honda--Tate Theorem15.4](https://jmilne.org/math/xnotes/svi.pdf).
Reproduce the two small number-field computations in Sage by constructing
K8=NumberField(P_plus), taking minpoly(K8.gen()^3), and then in its quartic
field K computing (p.ramification_index(),p.residue_class_degree(),
K.ideal(K.gen()).valuation(p)) for p in K.primes_above(5).
No larger polynomial solver is involved.
