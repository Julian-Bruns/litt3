# Proof: integral inputs, graph normalization and finite precision

Version2, 2026-09-15. This proves the
[statement](../../Theorems/deformations/integral_oper_calculus.md).
The [bounded independent audit](../../Research/audits/INTEGRAL_OPER_CALCULUS_AUDIT_2026_09_15.md)
checks all-order bounds, the odd-prime distinction, both graph formulas
and the complete finite-precision comparison.
All expressions use the whole chosen inputs. Normal projection is not
an operation used to construct a regular graph or a preceding object.

## 1. The two apparently nonintegral series

Write S=exp(pY). Since F0 fixes p and the rational integers, the whole
Frobenius discrepancy has the convergent expansion

    delta=(fuz-F0(z))/p
      +sum_(j>=1) p^(j-1)/j! * (Y^j(fuz)-F0(Y^j(z))).       (1)

For odd p, j-1-v_p(j!)>=0, and this bound tends to infinity.
Thus (1) is integral in the differential coefficients of Y and their
actual Frobenius transforms. It proves the needed precision statement
without separately dividing either term in its numerator. The source
map itself is integral by the stronger coefficients p^j/j!.

There is an equally short uniform proof for the Taylor recurrence.
Over the fraction algebra set L=diag(1,p) and

    B=[[0,-g],[-P*g,0]], H0=Id, H_(j+1)=H_j'+B*H_j.

Direct induction gives

    A_P=p*L*B*L^(-1),  K_j=p^j*L*H_j*L^(-1).              (2)

The H_j are integral differential polynomials. The two diagonal
entries of K_j have a factor p^j, its upper-right entry p^(j-1),
and its lower-left entry p^(j+1). The identity is proved in the
fraction algebra but these divisibilities hold in the original
torsion-free algebra. Division by j! proves the bound in the
statement and convergence at every fixed precision. No cutoff
before later factorial jumps is being assumed.

The dependence on P is better than the general upper-right bound.
In K1 it has a factor p². In

    K2=p*A_P'+A_P²

its diagonal P terms have a factor p², its lower-left terms p³,
and its upper-right term is independent of P. For j>=3 the bound
j-1-v_p(j!) is at least two for p>=5 and at least one for p=3.
Every P-dependent coefficient of K_j/j! therefore has a factor
p^(c_p). After division by that factor the series still converges.
Substitution, F0 and multiplication preserve this property, giving
G(P)-G(0)=p^(c_p)*Gsharp(P). Integral differential polynomials are
Lipschitz for p-adic congruences, so Delta P in p^a gains a further
p^a. This proof also covers derivatives of P and repeated factors.

The distinction at three is real: for g=1 and constant P,
K3=A_P³ has upper-right entry -p²P, whose quotient by 3! has
valuation one when p=3 and P is a unit. For sharpness of G itself,
take the p-completed Laurent algebra Z3[z,z^(-1)], F0(z)=z³,
fuz=z³+3, Y=0 and P=1. Then delta=1 and Jtilde is invertible
and P-independent. The j=3 term has upper-right coefficient -3/2;
all other P-dependent terms are divisible by9. The gain for G is
therefore exactly one in this example.

## 2. Exact normalization, in the current connection

The following algebra only requires 2 invertible. Let I=(c,h),
det I=1, nabla_D h=-c and nabla_D c=-Pcur*h. For a graph h+f*c
with f in a nilpotent ideal preserved by D, put

    d=1-Df-Pcur*f², b=d^(-1/2),
    U(f)=[[b*(1-Df)-f*Db, b*f], [b*f*Pcur-Db, b]].         (3)

The second column of I*U is b*(h+f*c); its first is its negative
covariant derivative. Their determinant is b²*d=1. Differentiating
the determinant shows that the first column again differentiates
into the new Hodge line. The binomial coefficients for d^(-1/2)
have only powers of two in their denominators. Formula (3) also
holds for a topologically nilpotent graph by passage to the limit.

If f=epsilon*q, D(epsilon)=0 and epsilon³=0, write a=Dq and
Bq=Pcur*q². Expanding (3) gives

    U=Id+epsilon*T+epsilon²*V,
    T=[[-a/2,q],[q*Pcur-Da/2,a/2]],
    V=[[Bq/2-a²/8-q*Da/2, q*a/2],
       [q*a*Pcur/2-D(Bq)/2-3*a*Da/4, Bq/2+3*a²/8]].       (4)

When epsilon²=0, the potential in this SAME connection satisfies

    Delta Pcur=epsilon*(D³q/2-2*Pcur*Dq-q*D(Pcur)).        (5)

Indeed the connection matrix in I is C0=[[0,-1],[-Pcur,0]].
Its first change is [C0,T]+DT; the lower-left entry is the
negative of the coefficient in (5).

Changing the connection is a separate operation. Suppose its actual
difference in the I frame is epsilon*C, tr C=0, with epsilon³=0.
Put alpha=Dq+C12 and beta=Pcur*q²+2*q*C11. The normalized graph
frame in the NEW connection is

    I_new=I*(Id+epsilon*T_C+epsilon²*V_C),
    T_C=[[-alpha/2,q],[q*Pcur+C11-Dalpha/2,alpha/2]],
    V_C=[[Pcur*q²/2-alpha²/8-q*Dalpha/2, q*alpha/2],
         [alpha*(q*Pcur+C11)/2-q*C21-D(beta)/2
             -3*alpha*Dalpha/4, beta/2+3*alpha²/8]].        (6)

To check it, the negative derivative of the unnormalized second
column (epsilon*q,1) is

    (1-epsilon*(Dq+C12)-epsilon²*C11*q,
     epsilon*(q*Pcur+C11)-epsilon²*C21*q).

Its determinant with that second column is
1-epsilon*alpha-epsilon²*beta. Multiply the second column by
1+epsilon*alpha/2+epsilon²*(beta/2+3*alpha²/8) and differentiate
in the new connection. This gives (6), including
tr(T_C)=0 and tr(V_C)+det(T_C)=0. In particular q=0 is the
reframing of an unchanged Hodge line in a changed connection.
Neither (5) nor (6) permits replacing the genuine preceding P by
a potential extracted from a different tuple.

## 3. One finite-precision argument for all depths

Equations (1)--(3), residue-unit inversion, the fixed square roots,
derivations and fixed coefficient Frobenius express the complete
comparison integrally. Modulo any p-power only finitely many terms
of the two series are required. Inverses and square roots have
integral expansions about their chosen residue units. Consequently,
under input changes p^r times integral directions, every product
of a new direction has at least its indicated p-weight.

This can be formalized by a central bookkeeping variable epsilon,
with D(epsilon)=0 and F0(epsilon)=epsilon. The coefficient of
epsilon in the whole expression is its additive first variation;
substitution epsilon=p^r respects the actual Frobenius because
F0(p)=p. This is not a derivative of the residue p-th-power map.
All terms of order at least two lie in p^(2r), including those
from frame inversion and normalization.

If r>=b, then 2r>=r+b, so these terms vanish modulo p^(r+b).
The remaining coefficient only uses ordinary inputs and directions
modulo p^b. The P-sensitive part carries p^(c_p), so its background
P and normalized variation need only b-c_p digits, if positive.
This proves the whole matrix identity at arbitrary depth b.
Matching Y modulo p^b is precisely matching X modulo p^(b+1).
Multiplication by the fixed normal factor z does not change this
p-adic statement.

For b=3,r=2, a quadratic term can occur at p^4; terms of order
three have weight at least p^6 and vanish modulo p^5. Its
coefficient depends only on the residue background and is quadratic
in the residue new directions. Filtered residue operations and
multiplication put it in F_(2d) under the stated degree assumptions.
This includes all cross-products in the WHOLE matrix, not just (4).
A primary direction of weight p^r and delayed direction of weight
p^(r+1) have product p^(2r+1), which vanishes modulo p^(r+3)
for every r>=2. The delayed direction may therefore have any
degree. It can still interact with old weight-p data, which remain
in the common lower inputs and are not discarded.

These arguments concern chosen complete local inputs. A whole
primary solve is an additional global requirement. Vanishing of
normal H0 is unnecessary for the local identities; it can ensure
uniqueness of a whole regular primitive and hence remove an
ambiguity when an intrinsic obstruction is defined.

## 4. Polarization recovers the complete relative response

The [bounded audit](../../Research/audits/INTEGRAL_POLARIZATION_AND_MARKED_RESPONSE_AUDIT_2026_09_15.md)
checks this identity and its actual rank125 application.

Use the integral expansion established above, and write F for the
whole normal numerator. With bookkeeping variables fixed by all
derivations and coefficient Frobenius, its expansion at v0 is

    F(v0+epsilon*h)=F(v0)+epsilon*L(h)
                              +epsilon²*B(h,h)+O(epsilon³).

Here L is additive, and B is the symmetric biadditive polarization
of the quadratic coefficient, over the prime-adic scalars. The
factors may include fixed Frobenius transforms; they remain additive.
This notation does not assert linearity over the residue field.

The whole primary repair says L(h)=0 modulo p, before taking
cohomology. Therefore, at epsilon=p, whole division by p² gives

    E(h)-E(0)=[L(h)/p]+[B(h,h)] = A(h)+Q(h).               (7)

The brackets mean reduction modulo p followed by the actual normal
and primary quotient. This division is legitimate because the
ENTIRE L(h), including its source and both graph terms, is p-divisible.
No separate product-carry summand is divided. An allowed additional
input p²*b contributes [L(b)] and is a terminal primary/boundary
term by hypothesis, so it does not change (7).

Now vary a background v0+p*h+p²*b by p^r*k, r>=2. All terms
with two new k factors have weight at least 2r>=r+2. Terms with
k and two old small factors, or with p²*b, also have weight at
least r+2. The complete remaining difference is thus

    p^r*L(k)+2*p^(r+1)*B(h,k) modulo p^(r+2).             (8)

Both first variations are primary-repaired, so division of the
whole expression by p^(r+1) gives A(k)+2Q(h,k), using (7).
This proves the formula. A higher section of the new input adds
a terminal source or graph term, already killed by the same quotient.

Choose integral representatives h,k and their sum when polarizing
the residue directions. The assumed independence from allowed higher
sections permits this choice. The
argument uses the actual fixed Frobenius on each input and F0(p)=p;
it does not differentiate a residue inseparable map or insert a new
Frobenius into the source coordinates. Applying (7)--(8) to a geometric
problem still requires identifying Q with the quadratic term of its
actual WHOLE comparison, not merely a model of its primary symbol.
