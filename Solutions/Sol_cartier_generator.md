# Proof: primitive invariants and one-endpoint powers

[Statement](../Theorems/Thm_cartier_generator.md).
Version2,2026-09-07; author prose, not independently audited.
Use actual differential pullbacks throughout. The canonical-intersection
theorem gives A=k[s], primitive weight d, and A_m=0 unless d divides m.

## 1. The canonical connection removes a factor of five

On omega_C^(5m), the formula nabla(a e^5)=e^5 da in a local frame e of
omega_C^m defines a canonical regular connection, compatible with etale
pullback. A frame change multiplies e^5 by a fifth power, whose derivative
vanishes. If d=5m>0, applying it to the two presentations of s gives a
shared section in A_(d+1)=0. Injectivity of etale pullback makes both
endpoint sections horizontal.

In a rational frame horizontality says da=0, hence a=b^5 because k is
perfect and k(C) is a one-variable function field. The fifth root be is
regular by valuations and unique. The two endpoint roots have equal
pullbacks, since their fifth powers agree in k(Z). This gives a nonzero
element of A_m with 0<m<d, a contradiction. Thus5 does not divide d.

## 2. Twisted Cartier, with the actual scalar untwisting

Write C'=C^(1) for scalar twist by5-Frobenius and F_C:C->C' for relative
Frobenius. Projection formula and relative Cartier give the k-linear map

    H0(C,omega_C^(5n+1))
      = H0(C',omega_C'^n tensor F_C*omega_C)
      -> H0(C',omega_C'^(n+1)).

For each weight a, scalar base change j_(C,a):u->u tensor1 is an additive
bijection to H0(C',omega_C'^a), semilinear for c->c^5. Compose the
displayed map with j_(C,n+1)^(-1) to obtain C_(C,n) on the ORIGINAL
section spaces. It is inverse-Frobenius-semilinear and commutes with
etale pullback; no k-isomorphism C=C' is chosen or asserted.

In a separating parameter t, write uniquely a=sum_(i=0)^4 a_i^5 t^i.
Then

    C_(C,n)(a(dt)^(5n+1))=a_4(dt)^(n+1).

Regularity and coordinate independence follow from relative Cartier and
projection formula. The ordinary fifth-power rule also gives

    C_(C,n+b)(v^5 u)=v C_(C,n)(u),

when v has weight b and u weight5n+1.

## 3. Primitive-degree and zero-multiplicity constraints

Choose1<=r<=4 with rd=1 modulo5; set n=(rd-1)/5 and w=n+1.
Functoriality puts C_(Z,n)(s^r) in A_w. Since5w=rd+4 and5 is prime to d,
d divides w exactly when d divides4. If not, the image is zero. If so,
d is1,2 or4, r=5-4/d and w=d; the image is c s for c in k.
Every eligible exponent is r+5q, q>=0, and the fifth-power rule gives
C_(Z,n+qd)(s^(r+5q))=s^q C_(Z,n)(s^r). No nonvanishing is assumed.

At a zero of order e, write s=t^e u(t)(dt)^d with u(0)!=0. If e+d=0
modulo5, then er=4 modulo5. The first term of s^r survives Cartier, so
its image is nonzero of EXACT order (er-4)/5. If d does not divide4,
this contradicts zero image; if d divides4, it contradicts image c s,
since (er-4)/5<e. Therefore e+d is nonzero modulo5.

For a clump image of size t at an endpoint of canonical degree h,
the divisor-degree identity is et=dh. If5 does not divide h, then it
divides neither e nor t, and e+d!=0 is equivalent to t!=-h modulo5.
For h=16,48 this excludes respectively residues{0,4} and{0,2}.
These are restrictions, not a clump-existence theorem.

## 4. Test a root on ONE endpoint, independently of its exponent

Suppose s_X=t^m, where t has weight b and d=bm. Both b and m are
prime to5. Choose1<=a<=4 with ab=1 modulo5 and put n_b=(ab-1)/5.
For the inverse r of d used above, mr=a+5j for some j>=0. Then
n=n_b+bj and the exact fifth-power rule gives

    C_(X,n)(s_X^r)=t^j C_(X,n_b)(t^a).

If d does not divide4, the left side vanishes, so the bounded root
test C_(X,n_b)(t^a)=0 is necessary, regardless of m. The root t need
not be shared or descend through the other map. In particular nonzero
root image excludes ALL powers whose full weight does not divide4.

Suppose s_X=omega^d for a regular one-form omega. Since rd=5n+1,

    C_(X,n)(s_X^r)=omega^n C(omega).

If d does not divide4, Section3 forces C(omega)=0. If d divides4,
then n=d-1 and that section is c omega^d, so C(omega)=c omega.
The zeros of omega have uniform positive multiplicity, because those
of s_X do.

More generally, if a nonzero shared tensor t of weight m is omega^m on
X, write m=q d and t=c s^q. The quotient s_X/omega^d has constant
q-th power, hence is constant itself. Rescale to apply the previous
paragraph to the primitive generator. This works even if5 divides q.

Assume now that every such uniform Cartier eigenform on X, with zero
eigenvalue allowed, has simple zeros. Then div(s_X)=d D_X for a reduced
D_X. Because BOTH maps are etale and their pullbacks are equal, the
zeros of s_Y also have precisely multiplicity d. The
[shared-simple-root theorem](../Theorems/Thm_shared_tensor_core.md)
forces a core, a contradiction. No root of s_Y was taken, no endpoint
was replaced, and no simultaneous Galois closure was presumed.

## Source boundary

Krishnamoorthy's [Correspondences without a core](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
Proposition8.2 and Corollary8.10, supply the invariant-section context;
Question9.7 leaves existence of the first clump open. The arguments
above are the explicit characteristic-five consequences used here.
Cartier-zero higher tensors alone need not define a Tango structure or
force a core. Nothing here produces a shared tensor in an arbitrary
span, or turns the possible zero Cartier image into a contradiction.
