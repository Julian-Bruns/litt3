# Scalar stabilizers and the exact large-image residual

2026-09-10. Author deductions from the existing audited orbit,
effective-orbifold and bounded-carrier counting inputs. No new full
common-cover exclusion or fresh independent audit is claimed here.

Keep an ACTUAL matched main-pair span X←Z→Y, with Galois Y-leg,
source defect2 and nonordinary X. Suppose five-elements act trivially
on the actual defect space U. Then Gamma=G/ker(U) has prime-to5 order,
and T0=Z/ker(U) has defect2, genus |Gamma|+1. The span X←Z→T0
is cored, with X-atlas degree<=64, by the already proved nonconstant
ratio F=phi_X²/s_X.

## 1. Bounded image is excluded without the trace hypothesis

Sections7--8 of Sol_frobenius_defect_order_bound.md count ALL genus-h
cored partners T0 of X with X-atlas degree<=64, 2<=h<=H, followed
by their actual genus2 Galois quotients of degree<=N, where

    N=4(5^24+1)=238418579101562504, H=N+1<2^59.

The count is <2^(2^800)<the SAME existing selection constant K.
That COUNT has no prime-to5 hypothesis on the original map Z→X
or Z→Y. The prime-to5 hypothesis was used earlier to PRODUCE the
bound on Gamma by a trace-preserved short string.

Consequently ANY remaining trace-zero main-pair witness must satisfy

    |Gamma|>N, |barGamma|>N/2.

This strengthens the former necessary projective-image threshold5250.
It does not give an upper bound or exclude arbitrary finite images.
All these statements retain the original two endpoint fields.

## 2. The scalar character of a line stabilizer has bounded order

Choose nonzero phi_X and its pulled-back line L=k*phi inside U.
Let H_L⊂Gamma stabilize L, with scalar character chi:H_L→k*, and
let b=[Gamma:H_L] be the projective line orbit. Set m=ord(chi²).
Write G_L for the inverse image of H_L in G and C_L=Z/G_L.
This is an ACTUAL intermediate curve; g(C_L)=b+1. No normality of
H_L or Galoisness of C_L→Y is assumed.

The function F=phi²/s transforms under G_L by chi². Hence F^m
belongs to BOTH original k(X) and k(C_L) and is nonconstant. Thus
X←Z→C_L is cored. The fixed-X effective orbifold theorem gives

    [k(X)k(C_L):k(C_L)]<=B0=336000.

Since k(Z)/k(C_L) is Galois with group G_L, the orbit of F consists
of exactly m distinct scalar multiples. Therefore

    m=[k(C_L)(F):k(C_L)]<=B0.                            (1)

This elementary order bound does not divide either map degree by5.

Restriction of the actual faithful self-dual semisimple2D module U
to H_L is chi⊕psi. If chi has order>2, self-duality forces
psi=chi^-1, so H_L is cyclic of order ord(chi)<=2m. If chi has order
at most2, psi also has order at most2 and faithfulness gives |H_L|<=4.
Thus

    |H_L|<=max(4,2B0), |Gamma|<=2B0*b.                  (2)

In particular a remaining witness has

    b > N/(2B0).

Numerically this is a much stronger projective-line orbit requirement
than the former degree<=640 test, but remains a lower bound only.

## 3. The X line cannot be a rotation eigenline

If Gamma is cyclic and L is an eigenline, b=1 and C_L=Y itself;
the preceding norm already gives a forbidden core for X,Y.
For a dihedral projective image, a rotation eigenline has b<=2.
Then |Gamma|<=4B0=1344000<N by(2), and Section1 excludes it for
the unchanged main pair.

Therefore the exact residual has a genuinely mixed X defect line,
with very large projective orbit, relative to the two rotation
eigenlines. It is not permissible to take phi_X to be an eigenvector
when using the scalar action to simplify a function or its branch set.

## 4. Why the tested further shortcuts stop

If F were an eigenfunction, a large scalar rotation would restrict
its branch values to0,infinity. But its power would already produce
the small-index core above. In the remaining mixed-line case Gamma
does not act on F by scalar multiplication, so that branch-set argument
does not apply. No ramification exclusion has been obtained from it.

Taking the N-orbit span of H1(X,T_X) gives a small Psi-stable subspace
because the actual cored joint X,T0 leg has degree<=64. Its N-invariants
do lie in H1(T0,T_T0), but it is only a subspace, not a direct summand.
It can still occupy the bottom of a long Psi string. This does not
repair the lost normalized trace, even after the cyclic five-part
has been reduced to order5 or25.
