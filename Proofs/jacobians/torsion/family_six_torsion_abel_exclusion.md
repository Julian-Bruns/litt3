# Proof: repeated cubic support and two polynomial square-root jets

[Statement](../../../Theorems/jacobians/torsion/family_six_torsion_abel_exclusion.md). [Independent whole-implication review: PASS](../../../Research/audits/FAMILY_SIX_TORSION_ABEL_AUDIT_2026_10_02.md). No computation is run; the arithmetic inputs are the accepted BACKUP Abel-torsion statement and complete cubic-torsion census, whose discriminant gcd excludes EVERY repeated-support nonzero cubic class.

## The BACKUP implication uses all cubic torsion classes

The accepted [BACKUP curve arithmetic](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md), Version2, already states that W1[36] consists exactly of the six Weierstrass classes. Since W1[6]⊂W1[36], its six-torsion conclusion follows immediately. We also spell out the narrower complete cubic-support argument, which is the exact specialization input used below.

Suppose6[P−O]=0 for a non-Weierstrass P on BACKUP. The class L=2[P−O] is a nonzero three-torsion class. It cannot be zero: a non-Weierstrass point has no function with sole pole2O and sole zero2P; L(2O)=⟨1,u⟩, whose nonbranch zeros are the pair P+ιP. The unique reduced degree-two representative of L is2P, with Mumford polynomial U=(u−u(P))². It has REPEATED support.

Section1 of the accepted [complete norm census proof](../../quotient_geometry/endpoint_exclusions/backup_hermitian_atlas_exclusion.md) constructs ALL80 nonzero three-torsion classes, including repeated support initially, then excludes that support by an exact discriminant gcd in the full reduced40-point norm algebra. Its retained [census](../../../../litt3-computation-data/legacy_workspace_computations/backup_genus_two_torsion.json) has repeated_support_norm_points=0. Thus L cannot exist. No restriction to rational torsion or sampling is used.

## Two Hasse coefficients characterize the family incidence

Write Φ=Φ_t(u)=u(u−1)(u−2)(u−3)(u−t), and Φ_[j](u)=[h^j]Φ(u+h). At a nonbranch point u=c, choose either nonzero square root v(c). The unique formal root of Φ(c+h)/Φ(c) with constant term one gives the local expansion of v/v(c).

The space L(6O) has basis1,u,u²,u³,v. If6[P−O]=0 andP is non-Weierstrass, its defining function has form A(u)+v after nonzero scaling, with degA≤3. The v coefficient cannot vanish, since a polynomial in u has conjugate paired zeros. A cubic polynomial cancels the first four local coefficients atP, so zero order at least six is equivalent to vanishing of the fourth and fifth coefficients of the local square root.

Conversely, if these two coefficients vanish at a nonbranch point, choose A to cancel the first four coefficients. The nonzero A+v has pole degree at most six and zero order at least six atP, hence its divisor is exactly6P−6O. Thus the two-jet incidence is EQUIVALENT to the stated six-torsion condition.

Define polynomial-scaled coefficients
\[
A_i(u,t)=\Phi(u)^i[h^i]\sqrt{\Phi(u+h)/\Phi(u)},\qquad i=4,5.
\]
The square root is defined by recursive coefficient comparison, dividing only by2, which is invertible in characteristic five. Clearing Φ^i makes A_i a POLYNOMIAL. Each monomial has total Hasse weighti; therefore deg_uA_i≤4i and deg_tA_i≤i. This definition is in characteristic five and does not divide by5 or use an undefined binomial denominator.

At a smooth branch point Φ=0, A5=2Φ_[1]^5, which is NONZERO since Φ is squarefree. Hence no branch point can be a common zero ofA4,A5.

## The resultant is nonzero, including the infinity check

Put R(t)=Res_u(A4,A5). Its degree in t is at most16·5+20·4=160. The complete BACKUP exclusion proves that at t=α there are no finite common zeros away fromΦ=0; the preceding branch calculation excludes the remaining finite roots. We must ALSO verify the leading-degree specialization before claiming R(α)≠0.

In characteristic five,
\[
\Phi=u^5-(t+1)u^4+(t+1)u^3-(t+1)u^2+tu.
\]
The fourth root coefficient has expansion
\[
A_4=\tfrac12\Phi^3\Phi_{[4]}
-\tfrac18\Phi^2(2\Phi_{[1]}\Phi_{[3]}+\Phi_{[2]}^2)
+\tfrac3{16}\Phi\Phi_{[1]}^2\Phi_{[2]},
\]
because its remaining binomial term has coefficient−5/128=0. The first term has u-degree15 and leading coefficient2(t+1); all other terms have degree at most14. Thus A4 has generic degree15, unchanged atα, sinceα≠−1.

In A5 the term(1/2)Φ⁴Φ_[5] has degree20 and leading coefficient3; every other term has degree at most18 because Φ_[1],Φ_[2],Φ_[3],Φ_[4] have degrees3,2,1,0. Thus A5 has degree20 with constant nonzero leading coefficient. The true-degree Sylvester resultant specializes without an infinity-degree drop atα. Since the specialized polynomials have no finite common root, R(α)≠0. In particular R is NONZERO. Its tighter degree bound155 is unnecessary; we retain160.

Any non-Weierstrass six-torsion point at a smooth family parameter gives a common zero ofA4,A5 and therefore R(t)=0. The finite support is defined overF5 and has at most160 points. A parameter of F5-degree greater than160 avoids it; the selected MAIN parameter does so. This proves the two endpoint conclusions without asserting complete MAIN Jacobian simplicity.

## Linear sextic spectral models force precisely this forbidden torsion

Use the independently reviewed [sextic spectral reduction](../../cartier_and_spin/sextic_ramified_spin_spectral_reduction.md). It gives functions f,g,h onY, with f=e3/s³ having sole pole3P, β=h/f² generating the rational coarse quotient, and P non-Weierstrass. A nonzero g=e4/s⁴ has sole pole4P: its only possible pole is at P of order at most four and EVEN parity, so the non-Weierstrass gaps one and two leave only order four unless it is constant. A nonzero constant would make s⁴ descend toΓ and contradict the mixed target fiber. The following linear residual ensures g is nonzero. Consider
\[
g^3/f^4=c(\beta-b),\qquad b,c\ne0.
\]
Its pole atβ∞ is simple. At a zero R of f of multiplicity m, one has ord_Rβ=−2m, so the displayed relation gives3ord_Rg−4m=−2m and ord_Rg=2m/3. The integer m is therefore divisible by three. Since degdiv0(f)=3, there is exactly one such R, of multiplicity three. Thus the infinity profile is(6), divf=3R−3P and ord_Rg=2.

Set z=g/f. Its only poles are simple poles atP andR; its degree is TWO. The fields k(f,g) and k(Y) agree, since their index divides both degf=3 and degg=4. Therefore k(z,f)=k(Y), and z is the hyperelliptic coordinate. Its two simple poles are a conjugate pair: R=ιP. It follows that3[ιP−P]=0. Since P+ιP∼2O, this is6[P−O]=0. The non-Weierstrass P contradicts the endpoint theorem just proved.

Thus every linear spectral residual is excluded. No conclusion about the surviving non-square quadratic models is inferred.
