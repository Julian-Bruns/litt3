# Proof of the initial binary rank25 loci

Version4,2026-09-13. Independent audits PASS with no outstanding
objection for the hypotheses of the
[statement](../../Theorems/deformations/nodal_first_repair_slice.md).

## Two-digit actual comparison

The curve difference25*xi in W4 is square-zero. Output Hodge graphs
start at5*y and the flat comparison is modulo125. The full compatible
descended reference makes the constant comparison zero. The actual
linear equations for curve and boundary variables have integral
deck-equivariant coefficients and reduce to the ordinary boundary
isomorphism and Psi. After division by5 the remaining nonlinear term
is5 times the COMPLETE quadratic channel of
[compatible_reference_quadratic_channel](compatible_reference_quadratic_channel.md).
Prior scalar feedback starts at125 before division and is absent at
this stage. All ordinary linear source terms remain in the additive
operator; they are not assumed to vanish in the cokernel.

If a leading kernel direction n has quadratic normal class in im(Psi),
choose w with Psi(w) equal to that class. Replacing the combined
normalized curve variable xi by xi-5*w absorbs it. The actual curve
change is125*w, so only the fourth digit changes. The given third
digit and its leading first Hodge repair remain unchanged.

Do this absorption BEFORE boundary/ordinary Schur elimination. The
resulting homogeneous integral linear equation is

    Lx=0 mod25, Lbar=f*Phi,

with the same leading nil coordinate of the given T3. The full source
is recovered by the additive ordinary-block equations. No extra
coefficient-linearity of L is needed. This construction avoids applying
an unrelated Schur projection to an already computed quadratic class.

## Necessity when the whole quadratic channel is zero

By the two-digit homogeneous Fourier--Bockstein lemma in
[abelian_power_late_descent](abelian_power_late_descent.md),
Lx=0 mod25 forces xbar in J7=F1 on the scalar block. Every source
change of basis and the leading ordinary elimination commute with the
deck action, so the FULL leading tangent vector lies in F1(V_T).
The first primary equation also puts it in K. This proves necessity.

## Uniform sufficiency, without a whole-kernel quadratic calculation

Transport coefficient Frobenius once. In formal nodal coordinates
f=uv the space J7 intersect Ann(f) has basis

    u4*v3, u3*v4, u4*v4.

Lift u,v to augmentation-zero integral U,V. An integral multiplier
lifting f differs from U*V only by5 times an allowed additive
deck-equivariant correction. Such a correction on J7 has reduction
in J7 subset im(f).

For x0=U4*V3, the multiplier numerator is U5*V4. Its first divided
reduction is (U5/5)*v4. The factor U5/5 has zero augmentation: apply
augmentation to U5=5a and reduce a modulo5. In R/(uv), every element
of the augmentation ideal annihilates v4. Therefore this first
Bockstein vanishes. The argument for U3*V4 is identical, and
U4*V4 gives U5*V5, already25-divisible. Every leading F1 kernel
direction thus extends to a homogeneous linear solution modulo25.

Its actual source cochain and first Hodge primitive can be chosen in
F1 by the stipulated equivariant sections. Reference coefficients
descend. Ordinary pointwise products of these first repairs lie in F2,
and F2 is contained in im(f), hence in the full primary image. The
complete quadratic channel is therefore absorbable by a terminal
fourth digit exactly as above. This proves existence of a compatible
fourth extension for each given third digit in F1 intersect K.
The actual Hodge line, prescribed grading and original flat twist are
retained by the comparison and the usual uniqueness.

## Consequence and limits

The uniform residue/symbol calculation in
[compatible_reference_quadratic_channel](compatible_reference_quadratic_channel.md)
now supplies the remaining necessity hypothesis for EVERY allowed
nodal cover of the stated genus3 family. It works over F5(t), with
no extra parameter denominator, and accounts for arbitrary quartic
kernel corrections. Thus its fourth-admissible third family is exactly
this3-dimensional slice throughout the domain.
Only one of those dimensions is the descended invariant line. The
following additional comparison excludes the other two at W5; it does
not divide the zero quadratic class without controlling its carry.

The independent proof audit is
[BAD_DOUBLE_EXACT_FOURTH_ADMISSIBLE_SLICE_AUDIT](../../Research/audits/BAD_DOUBLE_EXACT_FOURTH_ADMISSIBLE_SLICE_AUDIT_2026_09_13.md).
The two complete500/700 fixed-cover audits at t^2+2=0 and at the
actual backup alpha^3+alpha+1=0 remain in the quadratic-channel proof.
Their source-preimage checks are independent evidence for these special
cases. Uniformity is proved by the geometric residue tensor, not
inferred from those examples. Equality concerns the reduced/geometric
locus, and does not assert scheme-theoretic reducedness.

## The stronger quadratic repair and integral product

Set I equal to the ORIGINAL integral augmentation ideal. On
S=F1 intersect K the strengthened residue argument in the
[quadratic proof](compatible_reference_quadratic_channel.md)
annihilates the whole nil Schur target component of Q(S,S). Hence
Q has an ordinary Schur source preimage and WHOLE regular normal
primitives in F2=J6. Choose integral lifts in I6. This stronger bound,
not just Q in im(Psi), is needed for the next division.

Two exact integral facts are

    (I7 Fun)*(I7 Fun) subset I6 Fun+5 I2 Fun modulo25,
    ((Ir M intersect5M)/5)mod5 subset J^(r-4) Mbar,
                                                   r=6,7,9.

The second follows by normal-form reduction with the original relations
e_i5=-5(e_i+2e_i2+2e_i3+e_i4): one carry lowers degree at most4;
two vanish modulo25. For the first use binomial function coordinates
B_i(s)=binomial(s,i),0<=i<=4. The exact wrap difference is
e B_i=B_(i-1)-binomial(5,i)B4. Thus I7 Fun lies in P1+5P5 and
P2 lies in I6 Fun+5P6; pointwise multiplication gives P2+5P6, with
5P6=5I2 Fun. These are intrinsic inclusions on the actual torsor
after etale trivialization, including pulled-back bundle coefficients.
They are not products of function augmentation ideals in the abstract
group algebra. The [small exact verifier](../../scripts/deformations/rank25/check_nodal_initial_fifth_filtration.sage)
checks625 lattice-generator pairs, all three colons and a second
residue independently over an unramified quadratic coefficient order.

## Actual three-digit comparison through W5

Use the FULL compatible descended reference through W5; its normal
constant is zero through flat precision625. An actual curve change
has coordinates25*x and the graph is5*q+25*r+125*s. The curve
difference ideal is NOT square-zero. Choose first source/graph lifts
in I7, which changes only their later digits. After ordered boundary
and ordinary elimination the additive scalar operator, with coefficient
Frobenius transported once, is L=M_(UV)+5D modulo125, with D arbitrary
additive deck-equivariant and f=uv. No ordinary source term is deleted.

For x0 in I7, UV*x0 lies in I9. Its first divided reduction is J5,
and D*x0 contributes J7. These have source repairs in J3. The integral
ordinary/boundary cancellation is in I7, so its divided remainder and
primitives also lie in J3. Add the J6 quadratic repair. Every other
compatible fourth choice differs by K subset J4. Consequently ALL
second source/graph reductions lie in J3=F5, not just a convenient
particular fourth choice.

The weight25 quadratic is an ordinary product of I7 first lifts.
Write Q=Qsharp+5Qprime modulo25 with Qsharp in I6 and Qprime mod5
in J2. If w,b are the I6 source and whole-boundary lifts repairing it,

    Z=delta(b)-P(w)+Qsharp lies in I6 intersect5M.

Hence Z/5 mod5 and Qprime both lie in J2. This retains the ABSOLUTE
integral carry of Q. No claim that the reduced normal class is zero
in H1, or that division preserves J6, is used.

All other nonlinear terms are already at final flat weight125. In
the exact Riccati numerator
z*(M12+lambda_U*M11-lambda_O*M22-lambda_O*lambda_U*M21), the new
terms are first/second products F1*F5 subset F6=J2 and cubic first
products F3. Both orders of the first/second product are retained.
The quadratic curve-overlap term starts at625 BEFORE Frobenius division
and125 afterward; its reduced two first factors lie in F2. Source
pullback of the first graph and new-graded/first-response products
have the same bound. An already divided first mismatch lies in J3,
so multiplying it by a first frame variation also gives F1*F5.

For Taylor order j with l changed displacement factors the full bound is
j-1-v5(l!)-v5((j-l)!). For l=2 this is at least1. Every surviving
nonlinear Taylor term therefore has final weight125 and two first
factors; higher variations vanish. Fixed K5/5! is retained in the
compatible reference. Source exponential orders4 and5 are also retained:
any surviving such term involving only the fixed first source digit is
part of that reference; variable nonlinear terms satisfy the stated
final-weight bounds. No factorial divisible by5 is treated as a unit.

The actual preceding scalar changes first at5 and enters the correctly
filtered/graded tilde connection with an additional25. Its SAME-graph
first variation is additive in the first source/repair and thus in J7;
retain it in L. The next scalar digit and nonlinear scalar normalization
start at625. Genuine input opers and the actual flat twist are used;
a nongluing output graph is not substituted as an input object.

Thus, after all permitted eliminations, the fifth obstruction modulo
J2 is exactly the signed SECOND LINEAR residue. The independent
[filtered comparison audit](../../Research/audits/NODAL_INITIAL_FIFTH_FILTERED_COMPARISON_AUDIT_2026_09_13.md)
gives the full entrywise expansion and checks every precision class.

## The second residue separates two directions

Lift U,V to the torsion-free group ring if needed and put
A0=U5/5, B0=V5/5. Modulo(5,J2) write A0=a*u+b*v, B0=c*u+d*v.
Their augmentations are zero, so integrally A0=U*H+V*G and
B0=U*H'+V*G'. There are exact first-repair identities

    UV*(U4*V3-5*H*V3)=25*B0*G,
    UV*(U3*V4-5*U3*G')=25*A0*H',
    UV*(U4*V4)=25*A0*B0.

The resulting second residues in R/J2 are

    b*(c*u+d*v), c*(a*u+b*v), 0.

For u=alpha*e1+beta*e2+O(J2), v=gamma*e1+delta*e2+O(J2), let
C=((alpha,beta),(gamma,delta)). The carry matrix is -C^[5]*C^-1.
In particular ad-bc=det(C)^4 and

    b=(alpha5*beta-alpha*beta5)/det(C),
    c=(gamma*delta5-gamma5*delta)/det(C).

Both are nonzero by ORIGINAL rational-direction anisotropy. The two
residue columns have determinant bc(bc-ad)!=0. Higher terms of U,V
do not affect these linear carries. Arbitrary additive5D corrections
have first source repair in J5 and subsequent remainder in J3;
D of the principal J3 repair stays there. Free first repairs in
Ann(f) subset J4 contribute at worst J2 after one division. Final
source digits contribute fR subset J2. None alters the two columns.

The coefficients here follow ONE coefficient-Frobenius transport.
Normal sign negates both columns, with no effect on the zero locus.
Thus the residual class vanishes precisely on k*u4*v4=kN.

## All fourth choices and existence on the invariant line

There is also an exact relative comparison. Write the entire fourth
response E4(n)=D4(n)+[Q(n)], where D4 retains the ordinary and coefficient
Frobenius terms. For a fixed n in S, changing the fourth digit by beta
in K shifts the primary response and its Hodge repair from weight5 to
weight25. Its surviving fifth mixed terms are exactly

    Q(n+beta)-Q(n)-Q(beta).

The relative source/Taylor/scalar terms not in D4 have weight625 and
vanish. Since Q vanishes in the primary cokernel on ALL K,

    E5(n,beta)=C5(n)+E4(beta).

This is a relative Witt calculation, not differentiation of an
inseparable map. The [independent audit](../../Research/audits/NODAL_RELATIVE_FIFTH_ADDITIVE_QUOTIENT_AUDIT_2026_09_13.md)
retains the ordinary beta term and both mixed graph products.

In the actual nil Schur coordinates E4(K) lies in J2/(f). Indeed
Ann(f) subset J4, so an I4 lift has UV numerator in I6; its first
divided reduction is J2, and D contributes J4. Quadratic projection
is zero by the uniform theorem. Since ker(E4) has reduced dimension3,
its additive image has dimension9-3=6, equal to dim J2/(f). A
constructible subgroup of this full dimension contains an open set,
whose differences cover the vector group. Hence its geometric image
is ALL J2/(f), without assuming E4 is coefficient-linear.

It follows that the exact obstruction after varying every fourth
choice takes values in R/J2. The preceding calculation proves its
kernel is kN. On this line a fourth change removes its remaining
J2/(f) class; a terminal smooth fifth digit removes the primary-image
part. Whole regular primitives then give the compatible full tuple.
Therefore Z5=kN, as a geometric/reduced third-lift locus.

## Recovering the original map and the full tower

An invariant leading third vector is h^*b for a unique lower b, by
the actual invariant tangent identification. Its primary equation and
injectivity of pullback put b in ker(Psi_C). Modify the compatible
lower reference C3 by b and lift the ORIGINAL etale h. Its source has
the same marked third deformation class as the given T3. Negative
tangent H0 gives the unique relative identification; uniqueness of
the Hodge line, grading and marked flat twist recovers the given tuple.

For a full given tower use T5 for this initial T3 descent, then the
late theorem with T6 over C3 to descend T4, with T7 over C4 to descend
T5, and continue. The maps are compatible by uniqueness. The canonical
ample bundles and Grothendieck effectivity algebraize the original
finite etale cover and tuple in the supplied scope. No arbitrary
longest finite lift is claimed to descend, and no compatible tower
is constructed on a hypothetical unmarked common source.

## Exceptional pulled-endpoint plane

Here T=C x_Y Z, with Z->Y the original C5^2 cover and the entire
reference pulled from the ordinary Y throughW5. The original double
involution commutes with G. Its positive primary block is bijective:
its augmentation reduction is the ordinary operator on Y and its
cohomology is regular free over k[G]. Thus K and O are negative.
The actual quadratic on K is positive and has zero obstruction
projection. On F1 its source inverse and whole boundary primitive
lie in F2. This proves the stronger repair property required above.

Use the actual scalar type f=u2+v4 and the original-coordinate carries
A0=U5/5=a*u+b*v+O(J2), B0=V5/5=c*u+d*v+O(J2). The irrational u-line
gives b!=0; the carry matrix has ad-bc!=0. No c!=0 assumption is used.
Homogeneous binary norm improvement and quadratic absorption put Z4
inside F1. For x=u4*v3, y=u3*v4 its first residue is

    A*x+B*y+C*N |-> (b*A+a*B)*u*v4.

Consequently Z4=<a*x-b*y,N>, in coordinates after one coefficient
Frobenius transport. The actual additive fourth image is

    W=(J2+span(a*u+b*v))/(f), dim W=8.

Indeed K=Ann(f) has dimension10, lies in J3, and its only class below
J4 is g=u3-u*v4. The exact identity
f(U,V)*(U3-U*V4)/5=A0-U*B0*V3 gives its first residue a*u+b*v modulo
J2. All other classes give J2. The additive image has dimension10-2=8
and therefore fills W geometrically, by the vector-group argument
above. Ordinary additive terms and mixed coefficient transports are
retained in this assertion.

The absolute geometric comparison is unchanged: first lifts are I7,
every second repair and free fourth direction lies in J3=F5, and
the quadratic's next divided carry and all other nonlinear terms lie
in J2. For S=a*U4*V3-b*U3*V4, write A0=a*U+b*V+H, H in I2. The first
divided U2 contribution is

    a2*U2*V3-b2*V5+H*(a*U*V3-b*V4).

After the first repair5*a2*V3, the only linear second residue is
-b2*(c*u+d*v). The H part gives J2; the V4 scalar term and arbitrary
5D corrections give J3 after their repairs. Original integral monic
relations lower augmentation degree by at most4 per carry. Modulo W
the displayed residue is nonzero since b!=0 and ad-bc!=0. The norm
has zero residual. Thus Z5=kN, and the relative fifth formula and
surjectivity onto W also supply existence on that line.

The [independent exceptional audit](../../Research/audits/EXCEPTIONAL_RANK25_INITIAL_FIFTH_EXTENSION_AUDIT_2026_09_13.md)
checks the actual involution, whole filtered repairs, both residues,
larger relative image, and an independent unramified integral model.
The original-map and full-given-tower arguments are then as above,
using the exceptional case of late descent. This does not extend the
nodal residue theorem to arbitrary nonnodal symbols.
