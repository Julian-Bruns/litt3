# Neutral cyclic-five descent from two normal digits

[Statement](../../Theorems/deformations/neutral_galois_witt_descent.md).
This is a
cyclic/Galois partial resolution of N5, not its primitive degree-five
case. Both original maps are retained in any subsequent application.

## The theorem and its leverage

Let h:T→C be an actual connected finite etale CYCLIC degree-five cover,
with a regular active admissible nilpotent projective connection r_C
and the specified full weight-one periodic tuple, including its actual
flat square-trivial line and projective graded identification. Suppose
d(T,h*r_C)=d(C,r_C)=d. No simple-zero or bounded-string condition is made.

For every n>=2, let h_n:T_n→C_n be the original marked cover with a
compatible lower tuple. A GIVEN compatible T_(n+2) extending T_n forces
its GIVEN T_(n+1) to descend compatibly along h to a C_(n+1) extending
C_n. In particular every given full upper compatible tower descends
uniquely along the original h and algebraizes.

Applying this degree-five step along a subnormal series in a Sylow-five
subgroup, followed by the established prime-to-five neutral theorem,
gives the same full-tower assertion for EVERY defect-neutral
GALOIS cover, without a hypothesis on its group. Neutrality on every
intermediate is automatic by injectivity of defect sections. This does
not address a non-Galois cover whose closure adds defects.

The key gain over the returned primitive norm example is that the
ENTIRE cyclic-cover kernel is deck-invariant. The special operator
therefore has only length-one nonunit Smith blocks, not a norm block.

## 1. Actual deck modules and length-one blocks

Put R=k[e]/e^5, e=sigma-1, and r=3g(C)-3. On any genuine descended
smooth W-reference, both tangent H1 and normal H1 are free of rank r
over the Witt deck ring. Integral negative Cech sections and primitives
exist. These are the actual geometric statements in
[neutral degree-five structure](../../Theorems/deformations/cyclic_descent/neutral_degree_five_obstruction_structure.md).
Global-oper scalar H0(omega²) is the regular dual by Serre duality.

Linearize coefficient Frobenius in Psi and use independent source and
target R-bases. Neutrality and pullback on the canonical defect bundle
give K_T=h*K_C, hence eK_T=0. Smith normal form over the Artin principal
ring R therefore has only unit entries and entries e: an entry e^j,
2<=j<=5, would have a kernel on which e is not zero. The number of
e entries is exactly d. Thus in these bases

                Psi = diag(I_(r-d), e I_d) Phi.          (1)

This is LEFT-RIGHT equivalence of the linearized operator. It is not
semilinear conjugacy and makes no claim about iterated Psi ranks.
The source/target basis changes are deck-linear and lift integrally.
On invariants the unit blocks identify lower image coordinates and
the e-blocks identify lower kernel/cokernel coordinates. Pullback is
the norm N=1+sigma+...+sigma^4 on these free lattices.

## 2. Actual two-digit comparison, with an incompatible reference

Let m=n-1 and O=W_2(k). Extend C_n smoothly through C_(n+2)^a and
extend its GLOBAL filtered input oper sufficiently far using
H1(omega²)=0. This extends an oper, not its next periodicity. Lift the
original cover over this reference. All fixed coefficients descend.

Use the global-input-oper comparison chart of
[the uniform comparison proof](cyclic_descent/cyclic_power_descent.md),
Sections2--5, at only TWO normalized digits, with r-d unit blocks and
d nonunit blocks instead of its special rank-one e² block. The chart
construction and termwise estimates precede use of that special block.
Here are the adaptations that must be checked rather than assumed:

* Actual curve displacements begin at 5^(m+1); local output Hodge
  graphs and global input-oper scalar differences begin at 5^m.
  Genuine global input opers are independent variables. Nongluing
  output graphs are never inverse-Cartier input objects.
* Integral deck-projective cotangent and scalar modules give equivariant
  formal coordinates. Fixed marked deformations descend, because every
  lifted deck map is unique by negative tangent H0, its relations hold,
  and the special-fiber free action remains free. This is also valid
  over the chosen finite reference, not an assumed compatible full one.
* The normalized degree-j term has valuation at least m(j-1).
  This follows from corrected filtered/graded tilde transitions, scalar
  feedback with a factor25, and the exact Taylor identity
  K_j=diag(5,1)5^jL_jdiag(5,1)^(-1). Frobenius numerators are expanded
  with the extra5 on the curve variable BEFORE division. At precision
  O only a quadratic term can survive, and only when n=2. Denominator5
  Taylor terms are included by the all-order bound, not dropped.
  In fact the first scalar feedback is zero at these two normalized
  digits: its factor25 vanishes in O. The projected scalar equality
  is still imposed, so this simplification does not omit the previous
  periodic flow. Only the quadratic graph channel can remain at n=2.
* Boundary graphs, global scalars and the UNIT cohomology block have
  invertible additive diagonal blocks modulo5. The inverse of the last
  is coefficient inverse Frobenius, with source/target bases retained.
  Finite integral implicit elimination preserves deck equivariance,
  valuation bounds and the GIVEN remaining curve coordinate.
* The constant auxiliary solution is invariant and thus actual lower
  data. Its remaining normal error is N eta with eta mod5 the actual
  lower cokernel obstruction vector, BEFORE passing to the upper
  obstruction quotient. This holds also at n=2: unlike the old e²
  initial theorem, no compatible next lower reference is presumed.

Consequently the actual nil equation of the given compatible upper
object has the form

       L x = N eta + 1_(n=2) 5 Q(bar x) in (O[C5])^d,   (2)
       L mod5 = e Phi.

L is additive and deck-equivariant; it may mix coefficient Frobenius
and coefficient-linear corrections. Q is homogeneous quadratic and
deck-equivariant on the reduced module. Since2 is invertible, its
polarization is an equivariant bi-additive map. Nonzero reference
constants are retained in eta; linear terms after translation belong
to L. The actual flat periodicity line is kept in the preceding object.

## 3. Reuse the uniform cyclic norm carry

Transport once by Phi and put $y=\Phi(x)$,
$A=L\Phi^{-1}$, so $A\bmod5=eI$. Write Q for the transported
reduced quadratic. Reduction of (2) gives
\[
e\overline y=e^4\overline\eta,\qquad
\overline y=e^3\overline\eta+e^4b.
\]
In the regular-function model this is an affine binomial polynomial.
An equivariant bi-additive operation on affine inputs is quadratic
in the translating parameter. Hence
$Q(\overline y)\in\ker(e^3)=e^2R^d$.

The whole nonlinear error $5Q(\overline y)$ is therefore in the
image of $A$: choose a reduced preimage under $e$, lift it,
and multiply by five. Subtracting that terminal correction preserves
the GIVEN leading curve digit and gives an exact additive equation
$Ay'=N\eta$ modulo25. The later
[cyclic norm theorem](cyclic_descent/cyclic_power_additive_norm.md),
with $p=5,h=1,a=1$ and coefficient module $W_2(k)^d$, now gives
\[
\overline\eta=0,\qquad\overline y'=\overline y\in e^4k^d.
\tag{6}
\]
Its normal form is precisely the one-dimensional norm obstruction
per coefficient block. This replaces a separate divided-augmentation
calculation; no nonlinear term is discarded before it is absorbed.

## 4. Recover the given truncation

The lower reference after invariant auxiliary elimination has zero
obstruction by(6), so is compatible. Relative to that reference the
given upper leading displacement is invariant in ker Psi_T. Neutrality
identifies it uniquely with a lower ker Psi_C digit. Modify the lower
reference by that digit and lift the ORIGINAL cover. Its marked upper
curve is the GIVEN T_(n+1). Naturality supplies the compatible tuple;
negative normal H0 and trivial projective graded automorphisms identify
it with the specified one, including the original flat twist.

Iteration uses the GIVEN higher upper truncations, not replacement
sources. Uniqueness makes the descents an inverse system; the existing
canonical-ampleness/Grothendieck-existence argument algebraizes it.

For a neutral Galois cover Z→C, let P be a Sylow-five subgroup. Its
subnormal chain has degree-five cyclic successive quotient maps.
All intermediate defects equal d. Descend the GIVEN tower through that
chain to Z/P, then along the original prime-to-five map Z/P→C using
defect_preserving_etale_descent. No normality of P in G is required,
and no new simultaneous Galois closure is introduced.

The same chain proves the finite range. Set $a=v_5(|G|)$ and
fix the marked intermediate covers through $W_n$, using the
unique finite-etale lifting of the original subgroups. From a given
top tower through $W_{n+a+1}$, repeated cyclic steps recover the
first intermediate through $W_{n+a}$: at each next level its
previous tuple is already the descended one. Each of the $a$
cyclic arrows loses one last level. The final prime-to-five arrow
loses none, leaving the original $C_{n+1}$. Every recovered source
is the GIVEN corresponding truncation, and uniqueness retains all
markings, maps and periodic data. For $a=0$, apply prime-to-five
descent directly.

## Verification and boundary

The norm carry in Section3 is the length-one case of the later
uniform cyclic theorem.
The substantial audited issue is the two-digit GLOBAL-INPUT comparison
(2) with an incompatible n=2 lower reference and multiple left-right
Smith blocks. The norm algebra alone does not certify Hodge geometry.
The primitive S5 norm example is not covered: its full closure kernel
is not deck-invariant, even though its endpoint invariant dimensions
agree. Nothing here proves the original two-leg problem or full N5.

The [unified cyclic checker](../../scripts/deformations/cyclic/verify_general_cyclic_order.py)
includes p=5,h=1 with arbitrary norms at the first nonlinear weight.
The [focused audit](../../Research/audits/CYCLIC_NEUTRAL_TWO_DIGIT_AUDIT_2026_09_11.md)
also checked300 rank-three mixed operators, the incompatible n=2
reference, left-right Smith blocks and original-map Sylow descent.
These are prose and finite algebra verification.
