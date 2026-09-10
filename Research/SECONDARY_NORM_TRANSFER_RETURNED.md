# Returned Pro: secondary norm transfer by a deck-translate comparison

Received2026-09-10, approximately14:50CEST. Focused medium audit PASS
for the actual W5 comparison and root's local extension to all n>=3;
separate scoped PASS for the full-tower induction and main C10
consequence. Canonical result:
[cyclic_five_delayed_descent](../Theorems/Thm_cyclic_five_delayed_descent.md).
The underlying request is
[PRO_SECONDARY_NORM_TRANSFER_REQUEST.md](PRO_SECONDARY_NORM_TRANSFER_REQUEST.md).
The following records the mathematical argument returned in chat,
retaining the gluing, sign and equivariance claims needed for review.
No executed geometric certificate accompanied this answer.

## Claimed result and convention

With rho(S+xi)=rho(S)-Psi_S(xi), and epsilon=[rho], the requested
constant obstruction component is

    kappa_(C3)(c,d,b)=eta0=c^5.

There is no dependence on d,b or on the lower tuple beyond eta0,
and no extra coefficient Frobenius. The oppositely oriented divided
Psi-comparison has constant coordinate -eta0.

The new device compares a compatible T4 to its marked deck translate,
not to the incompatible reference T4^0. Both upper Hodge lines glue.

## 1. Relative comparison upstairs

Keep T3→C3 and its complete tuple through W2. Let A4,B4 be two
compatible marked W4 lifts of the same tuple, neither required to
descend to a lift of C3. Suppose

    nu=[B4]-[A4]=a e³+b e^4.

The claimed actual obstruction difference is

    epsilon_T(B4)-epsilon_T(A4)=a^5 e in D_T=R/e².       (5)

Use local filtered frames of the preceding ACTUAL H3, compatible with
the prescribed graded identification and including the flat periodicity
line. Its filtered transition and connection matrices are

    Mbar_ij=[[a3_ij,b3_ij],[0,d3_ij]],
    Gammabar_i=[[alpha3_i,beta3_i],[gamma3_i,-alpha3_i]].

Let a4_ij,d4_ij,gamma4_i be the prescribed graded Higgs data over W4.
The local weight-one construction gives

    Mtilde_ij=[[a4_ij,5*btilde3_ij],[0,d4_ij]],
    nablatilde=5d+[[5*alphatilde3,25*betatilde3],
                  [gamma4,-5*alphatilde3]] mod625.       (6)

The tildes are arbitrary lifts of the coefficients indicated; the
displayed powers of5 remove their ambiguity. In particular the
diagonal transition entries and lower connection entry are from the
PRESCRIBED GRADED object. This is attributed to the local filtered-lift
construction and its gluing morphisms in Lan--Sheng--Zuo,
https://arxiv.org/pdf/1311.6424.

Since the two objects agree through W2, their H3 data in matching
frames differ by25 times characteristic-five cochains. Their graded
W4 data differ by125 times tangent cochains. Thus the upper transition
and diagonal connection differences in(6) are125 times additive
expressions, and the change of25*beta3 is zero mod625. The previous
tuple contribution is additive in the first difference and Hodge repair.

### The raw quadratic graph term and the filtered gluing morphism

For the graph change I+25q E21, the lower connection coefficient is

    gamma'=gamma+25(q'-2alpha*q)-625beta*q².

The diagonal restoration aligning the grading through W3 needs only
the linear q term. In(6), the lower coefficient is then prescribed
gamma4, not an arbitrary lift of gamma'.

The raw rescaled transition has lower entry5L+125Q mod625, as in the
request's exact graph identity. The returned proof distinguishes that
matrix from the gluing morphism USED by higher inverse Cartier:
for actual preceding filtered objects the overlap mod125 is triangular,
and the filtered-and-graded gluing morphism lifts it with lower-left
entry exactly zero BEFORE rescaling. In raw coordinates its correction
therefore includes -5L-125Q. This is a property of the local functor
using both the previous filtered object and prescribed graded data,
not an inference about division preserving the augmentation ideal.

This replacement is available for A4,B4, because both preceding Hodge
lines glue; it was not available for the lower incompatible C4^0.
The final graph difference and leading Taylor difference both have
order25, so their product625 vanishes in the resulting W4 bundle.
Previous H3 corrections enter at125 by(6). Consequently the proof
claims no surviving quadratic normal-projection term or cross term
with the compatible reference A4's top digit at this precision.

## 2. Divided Cech comparison

Choose smooth W5 extensions whose two-digit difference is

    nutilde=atilde e³+btilde e^4 in e³ M2.

The square-zero ideal5³W5 is the coefficient module W2. Changing the
next digit changes the final answer only by a Psi image.

The Taylor stage uses divided Frobenius discrepancies and the
intermediate5-connection. Its reduction-compatible comparison repairs
the original specified lower object, not a separately chosen Hodge line.
This is attributed to Lan--Sheng--Yang--Zuo Section5,
https://arxiv.org/pdf/1404.0538.

Let ztilde be the positive two-digit Psi-comparison cochain, whose
reduction represents Psi(nu). With the supplied Cech splittings its
cohomology map is claimed to be an additive deck-equivariant lift of
Psi. On the relevant nilpotent block write

    Psitilde=e²*varphi+5B.                              (7)

The reduction of B is additive and deck-equivariant; other
coefficient-linear divided-Frobenius terms may be included in B.
No particular coefficient-semilinearity of B is needed below.

The cochain can be chosen in e³ Cech1(P2). Use the INTEGRAL
equivariant primitive Q supplied in the question:

    qtilde=Q ztilde in e³ Cech0(P2).

Modulo5 this is the actual normal Hodge repair, unique because
H0(T_T)=0. The splitting gives

    ztilde-partial qtilde = s cl(ztilde).

Since Psi(nu)=0, the right side is divisible by5. Thus the divided
cochain is legitimate and has class cl(ztilde)/5. All other terms
from(6), grading restoration and Taylor transport are additive,
deck-equivariant expressions in the first cochains and primitive;
their inputs are in e³⊂e², so their projection to D_T vanishes.
This includes coefficient-Frobenius terms because Frobenius fixes e.
The divided cochain itself must NOT be dismissed by that argument:
its division by5 is where the integral deck carry survives.

### Orientation and carry

For the stated rho convention, the normal obstruction difference
starts with -25(ztilde-partial qtilde), plus the additive125 terms.
After dividing by125 and projecting,

    epsilon(B4)-epsilon(A4)
      = -[e² varphi(nutilde)/5] in D_T.                 (9)

The 5B term contributes B(nu), which projects to zero. Use

    e^5/5=-e-2e²-2e³-e^4,
    e^6/5=0 mod(5,e²).

Then [e² varphi(nutilde)/5]=-a^5 e, proving(5). The flat twist is
retained in the preceding filtered object and Taylor identifications.
Tensoring filtration and quotient by the same line cancels it in the
normal coefficient line, not globally in the flat object.

## 3. Compare T4 with its marked deck translate

The original generator sigma acts on marked lifts of T3; sigma T4
does not mean sigma already lifts to an automorphism of T4.
The smooth reference T4^0→C4^0 is fixed in the curve-lifting torsor,
even if its lower Hodge reference is incompatible. Therefore

    [sigma T4]-[T4] = e*xi = c e³+d e^4,
    xi=c e²+d e³+b e^4, c^5=eta0.                     (10)

Both T4 and sigma T4 are compatible and reduce to the same
deck-equivariant tuple through W2 on T3. Apply(5):

    epsilon(sigma T4)-epsilon(T4)=c^5 e.

Naturality for marked automorphisms identifies the left side with
e*epsilon(T4). Writing epsilon(T4)=K+Le gives

    K e=c^5 e, hence K=c^5=eta0.

Only sigma is used, with no tau action required on arbitrary C3.
The coefficient transport is c→c^5, already eta0; it does not add
a further fifth power on eta0.

For fixed c, the same relative formula gives

    epsilon(c,d',b')-epsilon(c,d,b)=(d'-d)^5 e.

Thus b does not change epsilon, and d changes only its e coordinate.
For the tested norm expression

    Bnorm=-eta0(1+2e)-d^5 e,

one obtains epsilon(T4)+Bnorm in eD_T. This proves only the CONSTANT
coordinate of the full geometric correction is zero; it does not
identify the entire next obstruction with the norm expression or
claim the raw Q cochain vanishes.

## 4. Claimed next descent step

If T4 has a compatible T5, epsilon(T4)=0. The evaluated transfer
then forces eta0=0 and c=0. The chosen lower C4^0 is consequently
compatible; the established compatible-reference theorem forces d=0
and descends the GIVEN T4 along the ORIGINAL h to C4, with the full
previous tuple. The returned answer claims this W5/W4 step, not
explicitly all later levels.
