# Evaluate the initial quadratic obstruction for an actual dihedral five-cover

Compute the next Hodge obstruction on the two-dimensional space of
compatible W3 lifts of the explicit curve below. The new opportunity
is that the dihedral involution separates the two deformation directions:
one is even and one is odd. The integral linear carry is known, while
one quadratic coefficient remains to be evaluated geometrically.

This calculation decides whether the first delayed-descent step survives
when a cyclic-five cover is dihedral, rather than cyclic, over the
genus-two endpoint. The later-level relative comparison is already
available; the initial quadratic correction is the target here.

## 1. An explicit family of actual covers

Work in characteristic five, at the geometric generic parameter t and
then on an explicitly specified specialization open set. Put

    R=u(u-3), S=(u-1)(u-2)(u-t), F=R*S,
    H=t²+2t+3, J=t²+2t+4,
    (t^5-t)*H*J != 0.

Let Y,C,T denote the smooth projective models of

    Y: v²=F,
    C: k(u,kappa,gamma), kappa²=R, gamma²=S, v=kappa*gamma,
    T: k(u,kappa,gamma,w), w^5-H*w=gamma*(u+4-2t).       (1)

The map C→Y is the etale double with involution
tau:(kappa,gamma)→(-kappa,-gamma). The curve E:gamma²=S is ordinary,
with Hasse coefficient H. Equation(1) is pulled back from its connected
etale cyclic-five cover. Indeed, at infinity of E use z=u/gamma.
The affine part of z^-5-H*z^-1 is gamma*(u+4-2t), and the remainder
has positive valuation. Thus w_O=w_U-z^-1 gives a regular AS equation
on the other chart. This realizes the nonzero class in H1(E,O_E).

The ramified quadratic C/E is disjoint from this degree-five extension.
Consequently h:T→C is connected finite etale, g(C)=3 and g(T)=11.
Choose lambda with lambda^4=H and set sigma(w)=w+lambda. The involution

    tau:(kappa,gamma,w)→(-kappa,-gamma,-w)

is free and satisfies tau*sigma*tau=sigma^-1. Hence the ORIGINAL
T→Y has group D10. This is not the cyclic-five AS pullback from Y.

The active connection on Y is specified by

    G=u(u-1)(u-2)(u-3), A=(t+1)²G, eta=du/v,
    a=A/F², r=3a''/a+(a'/a)².                            (2)

Derivatives are in u; the scalar oper convention is U''=rU with the
corresponding Schwarzian law. The normalized quartic is A*eta^4.
This connection is regular, active admissible nilpotent, and ordinary
in the indigenous deformation-theoretic sense on Y. Its pullbacks
to C and T are the connections used throughout.

Use the canonical ordinary full lift of (Y,r) and lift the ORIGINAL
finite etale covers to obtain reference towers C_j^0,T_j^0. In the
higher inverse-Cartier construction retain the whole previous filtered
projective Higgs--de Rham tuple, its specified graded identification,
and the actual flat square-trivial periodicity line pulled back from
O_Y(W_t-O). The line is not replaced by the trivial line globally.

Write W_j=W(k)/(5^j). A compatible W_j curve has the given full tuple
through W_(j-1). The reference towers are compatible. The subsequent
curve lifts in the question have the same canonical W2 marking but
can differ from these references.

## 2. Established cohomological and comparison inputs

Let V_Q=H1(Q,T_Q). The Hodge-projection map Psi_Q is Frobenius-semilinear,
with relative twists retained and convention

    rho(S+xi)=rho(S)-Psi_Q(xi), epsilon=[rho] in coker Psi_Q.

At later stages epsilon is formed from an already existing compatible
previous tuple. It vanishes exactly when that tuple has a compatible
next lift. Compatible Hodge lines, if they exist, are unique because
the relevant H0 of the negative normal line vanishes.

The following facts hold for the actual family(1), not just for an
abstract representation. They may be used as inputs.

* V_C has a five-dimensional bijective Psi part and a one-dimensional
  zero part. The original tau is negative on that zero line.
* Write mathcal R=k[sigma]/(sigma^5-1). The space V_T is free of rank
  six over mathcal R. Its semilinear Fitting decomposition consists
  of a bijective part of module rank five and a nilpotent part of
  module rank one. The latter has elementary divisor of order two.
* Put q=log(sigma)=(sigma-1)-(sigma-1)²/2+(sigma-1)³/3
  -(sigma-1)^4/4 in mathcal R, so q^5=0 and tau*q*tau=-q.
  Choose tau-odd generators of the source and target nilpotent blocks,
  and normalize them to write Psi_nil=q²*Frob. Coefficient Frobenius
  fixes the abstract deck algebra. Then

      ker Psi_T=k q³+k q4, h*(ker Psi_C)=k q4,
      D_T=coker Psi_T=mathcal R/q²,
      h*:coker Psi_C→D_T is zero.

  Tau has signs(+,-) on(q³,q4) and(-,+) on(1,q) in D_T.
  Document the chosen scalar normalization when reporting a coefficient;
  the vanishing and descent conclusions do not depend on that choice.
* For the integral tangent and normal lattices over W2, both are free
  of rank six over W2(k)[sigma]/(sigma^5-1). Their two-affine Cech
  complexes have equivariant cohomology sections and primitives.
  In particular an exact q³ cochain has its normal Hodge repair in
  q³ at cochain level. The sections can also respect tau. This does
  not assert that division by five preserves the augmentation ideal.

These inputs have an executed exact characteristic-five calculation.
The commuting involution j:kappa→-kappa splits the tangent calculation.
Using D0=eta^-1, the D0-frame has Cech basis(z^-1,z), local lattice z²,
and Psi multiplier A; the kappa*D0-frame has basis(z^-1,z,z²,z³),
lattice z^4, and multiplier A*R². Use affine scalars k[u,gamma] in
both blocks, five powers of w, and w_O=w_U-z^-1. This constructs
matrices of sizes10 and20 directly from(1).

Their ranks under the first four semilinear iterates are

    10,10,10,10   and   18,16,15,15.

The nonzero18-minor is

    2*t^8(t+2)^8(t+3)^8(t+4)^8(t+1)^43*J*H^32,

and the determinant of the10-block is

    (t+3)^5(t+4)^5(t+1)^20*H^20.

All matrix entries are polynomials in t. The deck-fixed kernel has
dimension one; tau has one positive and one negative kernel direction.
The generic calculation and two Laurent precisions at
t4+4t3+t2+4t+3=0 agree. Reconstructing these ranks is not the target.

There is also a proved later-level mechanism. Once T_n→C_n and its
previous tuple have descended, at n>=3 two COMPATIBLE upper lifts
differing by a q³+b q4 have next-obstruction difference a^5 q.
The actual filtered-and-graded construction, integral Cech repair and
deck translate then detect a lower obstruction without assuming that
a compatible lower reference already exists. This comparison does not
use tau. It is the initial n=2 quadratic term that is new in(1).

## 3. The single quantity to evaluate

All compatible W3 lifts of the canonical T2 can be written

    T3(d,b)=T3^0+d q³+b q4.                              (3)

For each one take any smooth W4 extension and form, from its ACTUAL
previous compatible tuple, the next Hodge obstruction

    mathcal P_t(d,b)=epsilon_T(T3(d,b)) in D_T.            (4)

It is independent of the chosen smooth fourth digit. Calculate(4).
The specifically tested form is

    mathcal P_t(d,b)=(d^5+B_t*d^10)q.                    (5)

The task is to evaluate the GEOMETRIC coefficient B_t, including a
justification of the form(5), or to give the corrected formula if
additional terms survive the full higher comparison. Normalize the
nonzero integral linear carry to the coefficient one shown in(5).
An explicit expression on the geometric generic parameter, with its
specialization exclusions stated, would settle the question for the
high-degree family. In particular determine whether B_t is zero.

This is an actual initial obstruction calculation. If B_t is nonzero,
identify the resulting nonzero compatible class modulo h*ker Psi_C
and verify that it has a compatible W4 extension. If B_t=0, prove
that a compatible W4 extension forces the GIVEN T3 to descend along
the ORIGINAL h. Both outcomes test the same mechanism.

## 4. What has already been tested about the quadratic term

The exact integral relation, with e=sigma-1, is

    e^5=-5e-10e²-10e³-5e4.

After the equivariant first Hodge repair, its divided carry gives
+d^5*q in the obstruction orientation of Section2. Additive
deck-equivariant next-digit contributions on q³ cochains vanish
in D_T. This is the same linear carry as in the cyclic case.

At this INITIAL precision the first normal repairs are of order five
and are linear in d^5,b^5. Their products can contribute at order25.
Thus the quadratic candidate has degree10 in d,b, not degree two.
The full previous tuple and the prescribed graded correction must
be kept when computing it. The relevant graph term has the shape

    K22*q_i-K11*q_j-B_ij*q_i*q_j,

in addition to the graded-restoration, jet-transition and Taylor
contributions. A raw graph matrix alone is not the higher functor's
filtered gluing morphism.

There is a useful exact equivariance check on the candidate form.
Put U=d^5,V=b^5. The canonical marked deck actions are

    sigma:(U,V)→(U,V+U), tau:(U,V)→(U,-V).

On D_T, sigma(K+Lq)=K+(L+K)q and tau(K+Lq)=-K+Lq.
Furthermore mathcal P_t(0,b)=0: these are lifts descended from C3,
and the cokernel pullback from C is zero. Linear algebra over F5
shows that the degree-at-most-two polynomials in U,V satisfying these
identities are precisely (a*U+B*U²)q. This computation determines the
allowed quadratic channel, not its geometric coefficient. Unlike the
cyclic-over-Y case, tau does not kill that channel.

Use the actual weight-one filtered/graded construction of
[Lan--Sheng--Zuo, Lemmas4.6,4.7,4.10 and Proposition4.11](https://arxiv.org/pdf/1311.6424)
and the higher Taylor gluing in
[Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/pdf/1404.0538).
The complete reference is supplied by the fixed ordinary Y pair.
The corrected previous Hodge generators, their linear divided carry,
the prescribed graded morphism and the original flat periodicity
twist are all part of this comparison.

## 5. How the answer advances the common-cover strategy

If B_t=0, the initial dihedral step joins the established later-level
comparison and yields delayed descent along this ORIGINAL cyclic-five
map. This would extend a bounded-genus carrier mechanism to a new
monodromy shape. If B_t!=0, the nonzero solution d^5=-1/B_t instead
exhibits the precise initial failure and identifies which deformations
need a different higher-level test. Such a W4 lift is not by itself
a full non-descending tower or a common-cover counterexample.

There is a smaller geometric interpretation if useful: T/<tau> has
genus6, defect one and a Psi zero block of length two. The d-direction
is its deformation direction. Its degree-five map to Y is non-Galois,
so this is not the already handled Galois one-defect setting.
