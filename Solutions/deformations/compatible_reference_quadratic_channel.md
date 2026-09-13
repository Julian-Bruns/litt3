# Proof of the compatible-reference quadratic formula

Version4,2026-09-13. Independent geometric audits PASS; no outstanding
objection for the hypotheses in the
[statement](../../Theorems/deformations/compatible_reference_quadratic_channel.md).
The new uniform result below concerns the actual genus3 nodal family.
This is not a linear-carry computation or an initial descent theorem.

## The complete quadratic coefficient

The varying curve displacement starts at25. Its first divided
Frobenius displacement starts at5. A quadratic curve change starts at
625 before that division, hence at125 afterward, zero in the output
mod125. A second Taylor-displacement variation also starts at125:

    v5(K_j/((j-2)!*2!)) >= j-1-v5((j-2)!)-v5(2!) >=1
    for j>=2.

This bound includes factorials divisible by5. The preceding scalar
changes at5 and enters the prescribed-graded oper tilde connection
through25*r, hence first at125. The first two Taylor matrices preserve
that gain directly; subsequent terms do so by the same valuations.
The new graded transitions vary affinely at25. Their products with
the order5 response, and the source pullback of5*q_U, start at125.
Thus L has no further homogeneous quadratic term at the precision
being extracted. The old filtered overlap and NEW graded overlap are
used in their respective places; no raw graph entry is divided by5.

The genuine first Cartier response, conjugated by the actual preceding
frames, is N. Horizontality in companion convention gives D(A)=2B.
This identifies J*N as the FULL first transition, not just its normal
projection. For graph generators e2+5*q_i*e1 the exact normal numerator is

    M12+5*q_U*M11-5*q_O*M22-25*q_O*q_U*M21.

The relevant first entries are

    (JN)11=-B/z, (JN)12=A/z,
    (JN)22=-D(z)*A+z*B, J21=-D(z).

Multiply by z, take the homogeneous quadratic coefficient at25 and
substitute z^2*q_O=A*n^5+q_U. This gives exactly Q in the statement.
Normalizing the Wronskian changes the line by a unit and the
complementary frame; once the first mismatch is25-divisible, it does
not change this reduced normal class. A new second graph digit adds a
regular normal coboundary.

Choose integral kernel representatives and their primitives
coefficientwise, preserving sums. The remaining first repaired
numerator is an additive sum of divisible-by5 basis numerators, so its
division remains additive in the transported coefficients. This does
not discard the ordinary source contribution or identify different
Frobenius twists. The actual ordinary kernel-to-cokernel map can be
nonzero, as the bad-double examples below show.

## The cohomology simplification

Put F=n^5 and h=A*F+q_U=z^2*q_O. Since D(F)=0, direct differentiation
gives the exact identity

    Q=(q_U*D(q_U)-z^2*q_O*D_O(q_O))/2
      +(A*F*D(q_U)-q_U*D(A)*F)/2.

The first pair consists of permitted regular normal0-cochains because
D and D_O are regular in the respective local frames. It is therefore
a genuine normal coboundary. Removing it proves the simpler formula.
Writing the remaining expression as A^2*F*D(q_U/A)/2 is meromorphic
shorthand only; regularity at A=0 has not been established by it.

The two focused independent audits are
[full geometric coefficient](../../Research/audits/BAD_DOUBLE_INITIAL_QUADRATIC_CHANNEL_AUDIT_2026_09_13.md)
and [normal-boundary reduction](../../Research/audits/BAD_DOUBLE_QUADRATIC_COHOMOLOGY_REDUCTION_2026_09_13.md).

## Uniform residue reduction

Use the family in the statement and put S=h^-1(S_C), where S_C is the
eight points above u=0,1,2,3; let I be the reduced inverse image of
infinity. Then div(eta)=2I and div(A)=2S-8I. Define

    gamma_n=D(q_U)-(D(A)/A)*q_U.

The whole primary equation, D(n^5)=0 and A_O=z^8*A give

    gamma_n=D_O(q_O)-(D_O(A_O)/A_O)*q_O.

Here the derivative of z^8 matters: -8=2 in characteristic5. Hence
gamma is a global rational function, regular at infinity, with at most
simple poles on S. Changing n by a source boundary changes q_U by
-A*m_U^5 and leaves gamma unchanged. Removing the regular formal
boundary z^2*q_O*gamma/2 from Q gives [-q_U*gamma/2]. With pairing
<n,b*eta^2>=sum_I Res(n*b*eta), the global residue theorem gives

    <Q(n),b*eta^2> = -sum_S q_U(P)^2*b(P).

Indeed gamma*eta=dq_U-q_U*dlog(A), and A has order2 at S. Since
Res_P(gamma*eta)=-2*q_U(P), the same pairing is the sum of squared
residues times b(P). This holds against every holomorphic quadratic
differential, before restricting to the primary annihilator.

There is also an exact Cartier description of these repair functions:

    Cartier(eta/A)=eta,
    K -> ker(gamma -> Cartier(gamma*eta/A)/eta), n |-> gamma_n,

where the target is taken in H0(O_T(S)); the second map is a
fifth-power-semilinear isomorphism. For the first identity, write
eta/A=v^-5*P(u)(u-t)^2/(t+1)^2*du and use
[u^4]P(u)(u-t)^2=(t+1)^2. For the second, note
d(q_U/A)=gamma*eta/A. A zero gamma makes q_U/A a fifth power whose
possible poles have order at most2, hence no poles; the corresponding
formal argument shows that n is a source boundary. Conversely a
Cartier-zero gamma*eta/A has local primitives with poles at most2 on S.
Their differences are fifth powers of regular functions. The affine
H1(O)=0 glues them; the regular infinity primitive and d(z^10)=0
give the required primary Cech equation. This uses Cartier's local
exactness, not a claim that a meromorphic primitive is regular.

If all q_U(P) vanish, gamma has no poles, hence is a constant c.
The displayed Cartier identity then forces c=0 and n=0. Thus every
nonzero n has a genuinely double-polar quotient q_U/A somewhere on S.

The actual dual annihilator is

    H_A={b*eta^2 holomorphic : Cartier(A*b*eta)=0}.

It remains to annihilate the POLARIZED residue tensor
sum_S q(n)(P)*q(m)(P)*b(P) for n,m in K and b*eta^2 in H_A.

## Universal geometric jets and the cubic identity

Set y=v/kappa, R0=u(u-3), E=(u-1)(u-2)(u-t). The same affine curve
has ring k[u,kappa,y]/(kappa^2-R0,y^2-E), v=kappa*y.
In component order1,kappa,y,v, the infinity normal lattice has
u-powers <=(-1,-2,-3,-4), and the affine lattice has nonnegative
powers. The remaining cohomology and dual quadratic bases are

    n=(kappa/u,v/u,v/u^2,v/u^3,y/u,y/u^2),
    d=(y,1,u,u^2,kappa,kappa*u).

Their Serre pairing is the identity (the residue is the v/u
coefficient). The quadratic infinity bounds are (2,1,0,-1).
These give exact Laurent-polynomial projections Aff,Coh,For.

For an actual AS character chi=alpha*v/u+beta*v/u^2+gamma*y/u,
put a=alpha^5,b=beta^5,c=gamma^5, delta=t^5-t,s=t+1 and H=t^2+2t+3.
Frobenius fixation gives

    alpha=[u^4]F^2*a+[u^9]F^2*b,
    beta =[u^3]F^2*a+[u^8]F^2*b, gamma=H*c,
    f_U=v*(a*[F^2/u^5]_+ + b)+y*c*[E^2/u^5]_+.

For a directional symbol lambda, define the actual primary and
primitive jets through degree4 by

    A*exp(lambda*f_U)*n_j^5+Q_j(lambda)
       -exp(-lambda*chi)*R_j(lambda)=sum_i M_ij(lambda)*n_i.

Recursively split
G_jd=A*n_j^5*f_U^d/d! - sum_(r<d)(-chi)^(d-r)*R_jr/(d-r)!
and take Q_jd=-Aff(G_jd), M_:j,d=Coh(G_jd), R_jd=For(G_jd).
The two ordinary block determinants are delta*s^7 and
(t-1)(t-2)*s^4. Normalize both Schur vectors by first coordinate1:

    M*a_vec=f*e0, ell*M=f*e0^T, q=sum_j Q_j*a_j.

For the actual dual, construct affine B_j(lambda), B_j(0)=d_j,
such that exp(lambda*chi)*B_j meets the quadratic infinity bounds,
with no original d-basis monomial in a positive-order correction.
Put b_sym(lambda)=sum_j B_j(lambda)*ell_j(-lambda).
The minus sign is REQUIRED: translation is adjoint to inverse
translation under the actual AS trace. On total-degree<=4 polynomial
representatives, partial_i=log(sigma_i) is ordinary differentiation,
commutes with coefficient Frobenius and has its original deck marking.
Thus the actual spaces of repair and dual functions are

    q_U=q(partial)P, f(partial)P=0;
    b=b_sym(partial)R, f(-partial)R=0.

The source polynomial here has undergone coefficient Frobenius; this
is not an arbitrary new AS character. All required jets have degree
at most4, so their factorials are units.

Writing q_d,b_d,f_d for directional coefficients and Sigma for the
sum over the EIGHT points of S_C, exact symbolic calculation gives

    f0=f1=f3=0, f2=delta*(3*s^2*a^2-c^2),
    Sigma(q0^2*b1)=0,
    Sigma(q0^2*b3+q0*q2*b1)=H*c*f2.                 (*)

The certificate verifies the entire defining Cech identities and
dual pairings, not merely these final expressions. Coefficient
denominators are supported on delta=0. Also q0=-s^2*kappa*
(u^3-2*u^2+u-1), b0=y, and on S_C

    q0*b0=0, q0*q_d=0 for d odd.

The actual involution (kappa,y,w1,w2)->(kappa,-y,-w1,-w2)
gives q_d parity(-1)^d and b_d parity(-1)^(d+1).

## Why the cubic identity exhausts the kernel tensor

For a node f, Ann(f) lies in J4, equivalently AS degree<=4. Choose
linear coordinates X,Y on the original AS polynomial representation
along the null directions of f2. The two scalar kernels have bases

    1,X,Y,X^2,Y^2,X^3,Y^3,X^4+l_X*X*Y,Y^4+l_Y*X*Y.

This includes ARBITRARY quartic corrections: f3=0, mixed cubic and
quartic leading terms are excluded by f2, and an XY correction cancels
the constant f4 image of each pure quartic. It is not necessary that
l_X or l_Y vanish.

Consider a triple of these basis vectors in the residue tensor. Even
leading degree sum vanishes by involution. Odd sum is at most11.
An actual AS reduction w_i^5=w_i+f_U,i lowers degree by4 or5; on this
range trace sees ONLY the original degree8 term w1^4*w2^4. After a
linear change to X,Y its value is a nonzero scalar multiple of the
X^4*Y^4 coefficient. Only sums9 and11 with derivative losses1 and3
can contribute. A quartic lower correction loses2, so its sole case
is sum11 with one derivative, killed by q0*q1*b0 or Sigma(q0^2*b1).

For pure powers, one direction occurs in a single minority factor,
necessarily degree4 with no derivatives. At sum9 the majority degrees
sum to5: their repair derivatives cancel if the minority is dual;
otherwise the same two vanishing identities apply. At sum11 the
majority degrees are3 and4. If the minority is dual, both paired
falling-factorial coefficients are1+4=0. If it is a repair, the
survivor is a scalar multiple of the left side of (*) along the
majority null direction. Its right side is H*c*f2=0. Odd repair
factors kill the other contractions. This exhausts all triples,
including the quartic corrections, and proves the polarized identity.
Perfect Serre duality therefore gives Q(n) in im(Psi) uniformly.

## Stronger repair on the surviving F1 slice

For n,m in F1 intersect K the transported scalar polynomials P,Q have
AS degree at most1. Extend the holomorphic dual frame B_j and the left
Schur row over the whole ring k[lambda1,lambda2]/(lambda1^5,lambda2^5).
This is legitimate because H1(C,omega_C^2)=0, the normal/dual modules
are free by nilpotent induction and relative duality, and the five
ordinary blocks remain invertible. Use the PRODUCT of the individual
truncated exponentials, whose factorials are units; do not introduce
a total-degree-eight exponential with denominator5!.

The entire nil-dual summand is b_sym(partial)R for arbitrary reduced
AS polynomials R of degree at most8, without imposing f(-partial)R=0.
Only its already computed jets through degree2 can enter the residue:
the total degree is at most1+1+8=10, and trace sees only original
degree8 on this range. With derivative loss0 the coefficient q0^2*b0
vanishes pointwise. Loss1 gives q0*q1*b0 and Sigma(q0^2*b1), both zero.
Every loss2 coefficient has odd base involution parity, so its sum
over S_C is zero, including mixed directional coefficients.

Thus Q(n,m) annihilates the FULL nil-dual module and has zero nil
Schur coordinate. It has AS degree at most2. The ordinary inverse and
all Schur maps are equivariant and preserve F2; their source preimage
therefore lies in F2. After subtracting its primary cochain the exact
normal cochain is still F2 and has whole regular F2 primitives by the
stipulated equivariant contraction (equivalently negative H0 on the
associated graded). This improves the location of the quadratic
repair, without declaring its subsequent integral carry zero.
The [independent relative/filtered audit, Section6](../../Research/audits/NODAL_RELATIVE_FIFTH_ADDITIVE_QUOTIENT_AUDIT_2026_09_13.md)
checks the full dual extension and the degree argument.

## Replay and independent audit of the uniform theorem

The returned complete checker was executed under Sage's Python on
2026-09-13. Its regenerated4,988,141-byte coefficient certificate is
BYTE-IDENTICAL to the returned one, SHA256
ed761f607c3eaa973f4d91b458f2d3d59aa762f158d2588569f27ec4a54fc83a.
It checks30 whole Cech identities,180 dual-basis pairings, all relevant
denominators, the cubic identity,78 AS trace monomials and729 ordered
triples with independent quartic correction coefficients. The earlier
Cartier/residue reduction checker also passes; its local checks alone
do not prove the tensor vanishing.

The [root audit and provenance](../../Research/audits/UNIFORM_NODAL_RETURN_AUDIT_2026_09_13.md)
records both original archives and replay commands. The independent
[source/dual/trace audit](../../Research/audits/UNIFORM_NODAL_SOURCE_DUAL_TRACE_AUDIT_2026_09_13.md)
checks the geometric symbol identification and exhaustive contraction.
These give uniformity without finite-parameter interpolation or a new
specialization exclusion. They do not control a subsequent integral
division of an absorbed quadratic term.

## Preserved independent fixed-parameter diagnostics

Use the actual bad-double model

    P=u(u-1)(u-2)(u-3), F=P(u-t), A=(t+1)^2*P,
    C:k(C)=k(u,v,kappa), v^2=F, kappa^2=u(u-3),
    z=u^2/v, eta=du/v, D=v*d/du.

The selected nodal rank25 cover uses one Frobenius-fixed invariant
H1(O) class and the anti-invariant class kappa*z. Its exact primary
module is retained in
`Research/computations/bad_double_rank25_fitting_nodal_p320.json`.
Here t^2+2=0 in the recorded F625 field. Its six regular free columns
reconstruct the actual150-dimensional SAME-coordinate operator M*Phi.
The ordinary map ker(Psi)->coker(Psi) has rank2; it is not set to zero
by using independently chosen source and target Schur bases.

The script `scripts/genus_two/probe_bad_double_initial_quadratic.sage` constructs
all9 actual primary primitives with the original affine/formal reducer.
Products use w_i^5=w_i+f_i and kappa^2=u(u-3), not group-ring
multiplication of function ideals. Polarizing Q gives all45 coefficients.
At Laurent precisions500 and700 EVERY complete150-coordinate normal
vector agrees, and all45 projections to the9-dimensional cokernel are
zero. The normal vectors themselves generally are nonzero.

The separate finite audit
`scripts/genus_two/audit_bad_double_quadratic_receipts.sage` reconstructs M,
checks the kernel and dual equations, verifies every projection and
precision equality, and solves every image equation in the AS filtration.
Its [receipt](../../Research/computations/bad_double_initial_quadratic_audit.json)
retains explicit preimages. The9 kernel degrees are4,4,3,3,2,2,1,1,0.
Each quadratic normal coefficient has a source preimage with no
increase of its AS degree. Many coefficients are NOT in the bijective
Fitting image, so that latter shortcut is false even in this test.
The [independent finite audit](../../Research/audits/BAD_DOUBLE_QUADRATIC_AND_QUOTIENT_RECEIPTS_AUDIT_2026_09_13.md)
checks the actual inverse-Frobenius source preimages as well as every
saved normal vector; its separate receipt is
`Research/computations/bad_double_quadratic_independent_finite_audit.json`.

These computations independently prove vanishing for this fixed actual
cover over all extensions of its coefficient field; they are
coefficientwise, not sampled kernel values. Uniformity now comes from
the residue proof above, not from extending these numerical conclusions.
The changed cubic backup parameter alpha^3+alpha+1=0 now has the SAME
complete two-precision verification: all45 full150-coordinate normal
vectors agree at500/700, all projections are zero, and each has a
primary source preimage with no AS-degree increase. The changed-input
receipts are
`Research/computations/backup_initial_quadratic_audit.json` and
`Research/computations/backup_quadratic_independent_finite_audit.json`.
The latter is a replay of the independently authored finite verifier,
on this changed input, not a repetition of the first parameter's test.
This independently verifies the SECOND fixed actual cover over every
extension of its coefficient field. Neither numerical audit computes
the later divided carry.

## Rank125 filtered extension and its sharp limitation

For the original maximal C5^3 cover put s=a+b. Pair Q(F_a K,F_b K)
against full nil-dual polynomials of degree<=14-s, or the full degree12
dual if s<=2. Total polynomial degree is<=14. The actual AS trace first
sees degree12 and next sees degree16; only derivative losses0,1,2 can
contribute. The pointwise q0*b0 and q0*q1 identities kill loss0 and the
first part of loss1; sum_(S_C)q0^2*b1 kills its other part. Loss2 has
odd base-involution parity. These are actual source/dual symbols with
the inverse-deck sign, not multiplication in formal scalar coordinates.

The trace annihilator of P_r is P_(11-r): products have degree below12
and dimensions are complementary. Thus the ENTIRE nil coordinate is
in F_(s-3)=J^(15-s). For s<=7 it is in(f). For s<=6, use
J^j subset f J^(j-2) for j>=9: in uv+w4 coordinates every monomial of
degree>=9 has all exponents positive and is the image of the monomial
with the u,v exponents decreased by1. Its extra w4 term vanishes.
Units and formal coordinate changes preserve this ideal assertion.
The nil source lies in F_(s-1), the ordinary source in F_s, and the
whole equivariant primitive preserves F_s. The independent
[weighted/filtered audit](../../Research/audits/RANK125_WEIGHTED_REDUCTION_AUDIT_2026_09_13.md)
checks this extension, including the full rather than annihilator dual.

### An actual nonzero component at the cubic parameter

Work in k0=F5[t]/(t3+t+1); choose zeta4=2 in its degree4 extension.
The original AS characters, in y=v/kappa notation, are

    chi1=zeta3*(1+t+t2)*y/u,
    chi2=(4+4t)*v/u+(3+3t+4t2)*v/u2,
    chi3=zeta*((2+2t+4t2)*v/u+(3+3t+t2)*v/u2).

They are Frobenius-fixed cohomology classes and independent. Use
s_i=zeta^(j_i)*log(sigma_i), W_i=zeta^(-j_i)*w_i, j=(3,0,1).
This stores coefficients in k0 but does NOT change original rational
directions: evaluate them at s_i=zeta^(j_i)*a_i. All31 such directions
have nonzero quadratic symbol. The scalar Schur quadratic is

    q2=(4+2t)s1²+(4+2t+4t²)s2²+(4t+t²)s2*s3+t²*s3².

Its cubic is zero and the actual radical quartic is nonzero. Put

    g3=(4+2t+3t²)s1³+(4t+3t²)s1*s2²
       +(1+2t+t²)s1*s2*s3+(3+3t²)s1*s3².

One has q2²*g3=0 and q2*g3!=0 in k0[s1,s2,s3]/(s_i5). Let f4 be
the actual quartic Schur term, and prescribe H_s=s*(q2-f4)*g3 modJ8.
This jet extends to Ann(f): the degree5,6,7 partial kernel spaces have
dimensions4,6,8, totaling18; the actual kernel has dimension43 and
its J8 intersection has dimension25. The injection of actual jets is
therefore onto the entire partial solution space. Restoring the right
ordinary Schur column and inverse coefficient Frobenius gives n_s.

The scalar dual polynomial

    R(W)=W1³+(3+t+t²)W1*W2*W3+(4+2t+2t²)W1*W3²

is killed by q2(partial); higher f terms kill it by degree. Restore
the WHOLE extended dual frame with ell(-s) to obtain gamma_R in the
primary annihilator. Exact residue evaluation gives

    <Q(n_s),gamma_R>=(4+t+3t²)*s².

The calculation needs symbol jets only through total degree5: source
function degree<=7 and test degree3 give total<=17, so an omitted
derivative of order>=6 falls below trace degree12. It DOES retain
degree16/17 AS reductions. In each original fiber use
T0=...=T3=0, T4=-c_i^-1 and
T_n=c_i^-1*T_(n-4)+c_i^-1*f_U,i*T_(n-5), c_i=2^(j_i).
Direct evaluation at the eight base points agrees with the independent
symbol convolution. A completion change in J8 has function degree<=4,
so the same loss0/1/2 argument proves independence of the displayed
component from EVERY such completion.

### The first low quotient really can vanish

In the principal original weighted relations s_i5=-tau*2^(j_i)*s_i,
the covector for this dual test gives t*s on the additive first carry.
Together with the actual quadratic it is t*s+(4+t+3t²)s², with nonzero
root s*=3+3t+3t². The returned source adjustment also cancels every
other degree1..3 equation. Under the established integral equivariant
additive comparison, these are the COMPLETE E4 equations modulo
(f)+J4: source order>=5 puts ordinary terms and every mixed5D correction
in J5, while only q2*H5 can carry as low as degree3. All higher scalar
terms and q2*H6 or higher carry into J4 or above. The extra degree16
AS trace has base-independent T8=-c_i^-2 and its loss1 term vanishes
by the same residue identities. This proves a low quotient, not W4.

The exact source jet at that adjusted point is recorded using field
codes [m]=m0+m1*t+m2*t², m=m0+5m1+25m2:

    H5: (3,1,1):12, (1,0,4):29, (1,1,3):16, (1,2,2):58,
        (1,3,1):15, (3,0,2):73, (3,2,0):93, (1,4,0):9;
    H6=0;
    H7: (1,2,4):90, (1,3,3):11, (1,4,2):88,
        (3,0,4):43, (3,1,3):107.

Every actual kernel completion of this jet passes that low quotient.
There are25 free completion coordinates in Ann(f) intersect J8.

### One more quotient: every completion passes modulo J5

The actual marked involution (u,v,kappa,w)->(u,-v,kappa,-w) acts
on the scalar source and normal modules as MINUS deck inversion.
The full compatible pulled reference is equivariant. Its scalar primary
f is even to all orders, and the odd jet H# therefore has an odd
kernel completion. Such a completion is fixed by the actual involution.
The complete E4 scalar, including the additive carry, is consequently
odd modulo(f). After killing its already-vanishing low quotient, no
degree-four obstruction remains.

This is also visible in the original integral coordinates. If
ell=(log_4(sigma)-log_4(sigma^-1))/2 over Z/25[C5], its e-coefficients
are (0,1,2,2,1), and ell^5/5=-ell mod5. Odd integral lifts therefore
create no degree-four additive carry. All other additive corrections
of a completion in J8 have first divided order at least J6.

For an arbitrary completion change, the only possible new degree-four
quadratic class is the polarized cubic-symbol map from the degree8
kernel of q2, of dimension9, paired with the fixed H5#. Its projection
to degree4 modulo q2 is ZERO on all9 basis vectors. This was computed
from the actual residue symbol and independently rechecked by generic
finite-field elimination in
[the degree-four cross checker](../../Research/audits/check_rank125_grade4_cross_20260913.py).
Higher completion terms contribute only in J5 or above. There is no
hidden f4 correction: eliminating an odd degree-three term introduces
f4 times a linear source only in degree5; eliminating a degree-four
cross term introduces its f4 correction only in degree6.

Thus ALL25 completions satisfy E4=0 modulo(f)+J5. The residual
(J5+(f))/(f) has dimension18 (successive degrees5,6,7 have dimensions8,6,4).
Its actual value is not computed. This is not an actual W4 witness or
an exclusion of the completion family. The
[independent geometric audit](../../Research/audits/RANK125_NONZERO_QUADRATIC_AUDIT_2026_09_13.md)
records both the integral-log calculation and the full equivariance
argument.
No complete W4 lift or counterexample to sixth-level descent follows.

### Provenance and independent verification

The original two user archives are preserved. Extracted evidence is in
`../litt3-computation-data/pro_rank125_return_20260913/`, with the
continuation under `continuation/rank125_continuation_certificate/`.
The root replay of run_all.py passed; EVERY regenerated JSON is
byte-identical, and all20 manifest entries match. The separate partial
verifier also reproduced its results byte-for-byte. It does not verify
the missing mixed-characteristic comparison. The
[independent geometric audit](../../Research/audits/RANK125_NONZERO_QUADRATIC_AUDIT_2026_09_13.md)
checks actual kernel completion, normalized AS trace, sufficient symbol
precision and the complete low-quotient interpretation. Its independent
field checks use a separate implementation. Numerical coefficient
agreement is evidence for this fixed actual cover, not a uniform
vanishing theorem on all43 directions or all parameters.
