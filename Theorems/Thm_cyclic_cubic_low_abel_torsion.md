# Low Abel images in a cyclic cubic cover: torsion and Frobenius bounds

Let C/F_q be a smooth projective curve of genus g>=2, in characteristic
different from3, with an F_q-defined cyclic cubic map x:C->P1 and an
F_q-defined deck generator rho. Let O be a rational ramification point. Suppose all branch
points on C are F_(q^D)-rational. Put lambda=1-rho on J(C), and write pi
for q-Frobenius. Let 1<=r<=3 and assume every rational function on C of
degree at most2r belongs to the rational subfield k(x).

1. If gamma permutes geometric points, fixes O and every ramification
   point, commutes with rho, has finite orbits on divisors, and its
   extension to divisors acts compatibly on Pic(C), then

       alpha in W_r(C,O), (gamma-1)^2 alpha=0
       implies (gamma-1)alpha=0.                       (1)

   This applies to powers of Frobenius fixing those points, and to rho
   itself. It is a
   low-degree divisor rigidity assertion, not an assumed almost-rational
   property of arbitrary subvarieties of a Jacobian.

2. Every class in W_r(C,O) killed by3 is represented by a degree-r divisor
   supported on ramification points, or is zero. For r=3 there are exactly

       1+n(n-1)+binomial(n,3), n=g+2,                 (2)

   such classes. The nonzero ones correspond uniquely to2P+Q (P!=Q)
   and triples of distinct ramification points.

3. All J(C)[3] is defined over F_(q^(3D)). Define

       a=v_3 det(pi^D-1)-g,
       b=v_3 det(pi^(3D)-1)-3g-a.

   These are nonnegative integers. Every three-primary class in W_r(C,O)
   is F_(q^(3D))-rational and is killed by

       lambda^(3+max(a,b)),
       hence by3^ceil((3+max(a,b))/2).                (3)

   The determinants are computed from the actual Weil polynomial. No
   companion-matrix model of the integral Tate module is assumed.

   More sharply, put M=pi^D, U=(M-1)/lambda, and
   V=U^2-rho^2 lambda U-rho^2 on the actual Z_3[rho]-Tate module.
   If lambda^c U^-1 and lambda^c V^-1 are integral, the exponent
   3+max(a,b) in (3) may be replaced by 3+c. These denominator bounds
   can be certified by Smith exponents, not just determinant valuations.

4. Let P be any finite set of primes different from the characteristic,
   and let D divide N. Suppose pi^N fixes J[ell] for every odd ell in P,
   and fixes J[4] if2 belongs to P. Every class in W_r whose order has
   prime divisors only in P is then F_(q^N)-rational. This applies to
   genuinely mixed torsion; no primary component is assumed to lie in W_r.

For the fixed X, n=11, D=4, a=1, b=2. Consequently

    J(X)[3] is defined over F_(25^12),
    W_3(X,O) intersect J(X)[3^infinity]
       is contained in J(X)(F_(25^12))[lambda^4]
       and is killed by9.                            (4)

Moreover W_3(X,O) intersect J(X)[3] has exactly276 classes.
Every three-primary class in W_1(X,O) is one of the eleven branch
classes, all killed by3. Exact order9 remains open in W_2 and W_3;
order27 and all higher three-powers are absent. The finite bound is
useful for checking small uniform branch fibers; it is not an exclusion
of a common cover, a PGU twist, or a dormant-oper representative.

For fixed X the mixed-prime assertion gives

    W_3(X,O) intersect J(X)[2^infinity 3^infinity]
       is contained in J(X)(F_(25^684))[216].          (5)

It does NOT imply that the two-primary component of a mixed class
vanishes, even though pure two-primary W3 torsion is already zero.

Version4,2026-09-07: finite-prime-support extension and mixed bound216.
Version3 supplied the first-layer bound9 and elementary W1 conclusion.
Independent audit PASS, /root/audit_cubic_torsion,2026-09-07; the
geometric-action hypotheses include its nonbreaking suggestions.
[Audit metadata](../Research/audits/CYCLIC_CUBIC_LOW_ABEL_TORSION_AUDIT_2026_09_07.md)
and the version3 [first-layer audit](../Research/audits/KUMMER_FROBENIUS_LAYER_AUDIT_2026_09_07.md)
and version4 [mixed-prime audit](../Research/audits/MIXED_SMALL_DIVISOR_TORSION_AUDIT_2026_09_07.md)
are reference-only; open their bodies only for a concrete doubt.
[Proof](../Solutions/Sol_cyclic_cubic_low_abel_torsion.md).
