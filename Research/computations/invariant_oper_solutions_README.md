# Invariant dormant-oper solutions and full local multiplicities

Reproduce the exact computations from the workspace root:

```sh
/usr/local/bin/sage scripts/invariant_oper_multiplicities.sage
/usr/local/bin/sage scripts/invariant_oper_multiplicities.sage --export-only
```

`invariant_oper_solutions.json` lists the 55 distinct points in the slice
A=C=0, with all 24 coordinates ordered b0,...,b7,c0,...,c4,a0,...,a10.
The field constant `a` is unrelated to the coordinate names `a0`, etc.
The base field is F5[a]/(a^2+4a+2). Each orbit specifies its irreducible
polynomial h in b7. For that orbit, interpret `u` in F25[u]/h(u).
The row with Frobenius exponent j applies the 25^j power map to every
coordinate of row zero. Different orbits use different quotient fields.
All 96 full equations are evaluated exactly for every exported row.
Distinctness within each orbit is checked directly; distinctness across
orbits follows from the pairwise coprime b7 minimal polynomials.

`invariant_oper_multiplicities.json` records full-scheme local lengths,
not lengths in the reduced invariant slice. Its certificates specify
21 pivot rows and columns of the full Jacobian and three free coordinates.
Formal implicit elimination solves the pivot equations modulo m^N.
The script checks those equations vanish, substitutes into every full
equation, and computes the exact rank of all surviving monomial multiples
in the three-variable vector space modulo m^N. Thus the reported lengths
are lengths of the full local algebra modulo m^N.

Consecutive equal lengths modulo m^(N-1) and m^N imply
m^(N-1)=m*m^(N-1) in the completed local quotient. This ideal is a
finitely generated module over a noetherian local ring; Nakayama therefore
gives m^(N-1)=0. The stabilized length is the exact local multiplicity.
The listed eliminated coordinates and residual equations at stabilization,
together with the reproducible exact rank computation, certify the result.

For faster arithmetic the script also uses an absolute presentation.
Writing h=h0+a*h1 over F5, its norm is h0^2+h0*h1+2*h1^2.
It verifies that this degree-2deg(h) polynomial is irreducible and maps
a to -h0(u)/h1(u). Exported solution coordinates are reduced back to the
relative quotient F25[u]/h(u).

This enumeration covers only the invariant slice. It does not enumerate
the remaining full-scheme points or resolve the common-cover problem.
