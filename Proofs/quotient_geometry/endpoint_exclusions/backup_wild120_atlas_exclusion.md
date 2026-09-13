# Degree120: bounded cubic primitive and uniform local extensions

Version1,2026-09-10. Root proof, independently audited PASS by
/root/audit_backup_wild120_dictionary. All three exact ideals replayed
independently. Audited prose and exact algebra, not Lean verification.
[Statement](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_wild120_atlas_exclusion.md).

Let C:v²=F(u) be a smooth genus-two curve in characteristic5, with F
monic of degree5 and O its point at infinity. Put eta=du/v and D=v*d/du.
Suppose an ACTUAL orbifold atlas C->S has coarse degree120, one wild
fiber D_w of six points with(e,delta)=(20,27), and one tame fiber D_0
of40 points of index3. Normalize their coarse values to infinity and0.
Every completion at D_w is the SAME Galois extension of the completed
coarse field. The assertion below uses this, not just the profile.

## 1. Globally available cubic data

The regular cubic tensor (df)^3/f² has precisely the reduced divisor D_w.
Write a nonzero scalar multiple as S*eta³, so

    S=A(u)+c*v,    deg A<=3,      div(S)=D_w-6O.

There is a rational B and, after harmless scaling of the coarse function,

    f=B³/S^20,             DB=S^7,             B in L(40O).       (1)

Here no unproved cube-root or3-torsion trivialization is taken. If
s0=(Df)³/f², the explicit rational function b0=(Df)^20/f^13 satisfies
b0³=f*s0^20 and Db0=2*s0^7. For S=l*s0 take B=(l^7/2)*b0;
then DB=S^7 and f differs from B³/S^20 only by a constant. Divisors give
div(B)=D_0-40O. This construction works even when O is wild.

## 2. Fixed-base local Galois normal form

At infinity in the coarse field K=k((f^-1)), inertia has order20,
wild subgroup C5, and lower break2, since27=19+4*2. Write its tame
fixed field as k((v0)), v0^-4=f. Artin--Schreier reduction gives

    y^5-y=a*v0^-2+b*v0^-1.

The tame generator sends v0 to i*v0, i of order4. Its action on the
one-dimensional Artin--Schreier class must multiply by a scalar of
F5^*. The nonzero leading coefficient a forces that scalar to be-1,
whereas the degree-one term has eigenvalue i^-1 != -1. Thus b=0.
Every completion therefore has the fixed-base form

    y^5-y=a*sqrt(f),        a!=0.                            (2)

Changing the Artin--Schreier generator or fourth root v0 changes a
only by F5^*. Hence a^4 is invariant, and is the SAME at all six wild
points of an actual atlas. Conversely only this necessity is used below.

## 3. Two local coefficients and one shared scalar

At a finite wild point, use z=S as uniformizer and write eta=H(z) dz.
Equation DB=S^7 gives

    B=B0+B5*z^5+2H0*z^8+4H1*z^9+O(z^10).

With b²=B0, the principal part of sqrt(f)=B^(3/2)/z^10 is

    b³*z^-10 +4b*B5*z^-5 +3b*H0*z^-2 +b*H1*z^-1.           (3)

There are no other negative terms. Artin--Schreier exactness of a times
(3) forces the reduced pole2 and pole1 coefficients to vanish. Their
fifth powers give, respectively,

    a^4=3/(B0*H0^5),       B5=3*B0*(H1/H0)^5.              (4)

Set lambda=3/a^4. It is nonzero and common to all wild points. Since
H0=1/DS and H1/H0=-D²S/(DS)², equation(4) is

    B0=lambda*(DS)^5,
    B5=2lambda*(D²S/DS)^5.                                (5)

Consequently

    R=(B-lambda*(DS)^5)/S^5

is regular at every finite wild point. Indeed its numerator vanishes
there, and its derivative has order at least7; in characteristic5 its
first possible remaining term therefore has degree5. Away from the
wild points and O there is no possible pole. At O, S has pole6 or5,
DS has pole at most9 or8, and B has pole40, so R has pole at most15.
Thus

    R in L(15O),       DR=S²,
    R*(DS)^5=lambda*(D²S)^5 along every finite point of D_w.  (6)

The last identity follows by taking the constant term of R in(5).
We need not impose its additional infinity counterpart in order to
exclude a chart whose finite equations already have no solution.

## 4. Exact finite polynomial system

Write R=P(u)+vQ(u), deg P<=7, deg Q<=5. The equation DR=S² is

    P'=2cA,
    F Q'+(F'/2)Q=A²+c²F.                                 (7)

Thus

    P=c*(2a0*u+a1*u²+4a2*u³+3a3*u⁴)+r0+r1*u⁵.

The second equation is a9-by6 constant coefficient linear system for
Q0,...,Q5. It has rank6 and leaves three quadratic equations in the
coefficients of A,c. The implementation checks the inverse ENTRYWISE
after extending to a polynomial ring; this avoids the known faulty
optimized finite-extension-field matrix backend.

If a3!=0, the coefficient of the only possible pole45 term in
B=S^5 R+lambda*(DS)^5 must vanish, since B in L(40O). It is
a3^5*(Q5+3lambda), giving

    lambda=3Q5.                                          (8)

There are exactly three charts for a nonzero S with six simple zeros
as a cubic differential:

1. c=1, a3!=0. Introduce a3inv with a3*a3inv=1. Put
   N=(A²-F)/a3², a monic degree6 polynomial. At the finite wild points
   v=-A. Reduce equation(6) modulo N, using

       R=P-AQ,
       DS=-AA'+F'/2,
       D²S=F A''+(F'/2)A'-(A/2)F''.

   Use(8). There are six coefficient equations.

2. c=1, a3=0. Then N=F-A² is monic degree5. Use the same finite
   equations, with lambda FREE. The remaining wild point is O;
   omitting its extra equations only enlarges the necessary system.

3. c=0, a3=1. A lower-degree polynomial S would give a multiple zero
   at O and is excluded by reducedness of D_w. Work modulo the monic
   cubic A, retaining both sheets v²=F. Here DS=vA' and
   D²S=F A''+(F'/2)A'. Equation(6) has even and odd parts

       Q*F³*(A')^5-lambda*(F A''+(F'/2)A')^5 = 0 mod A,
       P*F²*(A')^5 = 0 mod A.

   Again use(8). These give six coefficient equations.

Repeated roots or unwanted branch intersections have NOT been discarded
by computational saturation: they are allowed in these systems. Proving
the enlarged systems empty therefore excludes every valid source in
the chart. Normalizing c or a3 is legitimate because S was defined only
up to scalar and B can be rescaled correspondingly in(1).

## 5. Exact replay and conclusion

The script scripts/genus_two/verify_backup_wild120.sage uses the actual
F125 parameter alpha³+alpha+1=0. ALL THREE necessary ideals have
Groebner basis[1], over the coefficient field rather than just among
its rational points. Generic chart4--9s; infinity and even charts
each about0.15s internally. These are calculations over the algebraic
closure via the unit ideal, not a bounded-point search.

Run, using an existing Sage installation:

    sage scripts/genus_two/verify_backup_wild120.sage --chart generic
    sage scripts/genus_two/verify_backup_wild120.sage --chart infinity
    sage scripts/genus_two/verify_backup_wild120.sage --chart even

Each command asserts that the exact Groebner basis is[1]. The independent
replays took4.631s,0.161s,0.141s internally. The generic chart was also
run with a eliminated lambda relation and took9.23s with the same result.
The enlarged necessary systems are empty, so no actual atlas can exist.

The optional --certificate multiplier extraction is not part of this
short replay; it was stopped after several minutes. No stored explicit
unit multiplier is claimed. The proof instead uses the exact ideal
calculation with its full, small source, independently replayed with the
geometric dictionary. This is different evidence from the original-row
factored identities in the separate405-pair Hermitian calculation.

The focused audit checked global B without cube-root assumptions,
the shared fixed-base a^4, both local coefficient signs, the R identity,
the forbidden pole45, all normalizations, finite Weierstrass points and
both sheets when c=0. Its scope does not include the proposed240 transfer.
[Audit](../../../Research/audits/BACKUP_WILD120_DICTIONARY_AUDIT_2026_09_10.md).

The same geometric mechanism should apply to wild240 on the actual
etale double obtained by adjoining sqrt(f): upstairs the profile becomes
(20,27;3). Its cubic section is anti-invariant under the double, so a
finite two-torsion-twisted version of(7) is the next computation. This
transfer is a proposed next step, not yet an exclusion of wild240.
