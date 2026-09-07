# Proof: two free diagonal subgroups, not a presumed simultaneous closure

[Statement](../Theorems/Thm_cubic_genus_two_common_covers.md).

## 1. One projective source and two actual free actions

Put t=u^3 and v^3=(t-1)/(t-lambda). Valuations at0 and1 show that these
two Kummer classes are independent. Hence k(T)/k(t) has degree9 and
Galois group C3^2, acting by independent cube-root scalings of u,v.

The bidegree(3,3) model is already smooth. At a finite point its partial
derivatives are3u^2(v^3-1) and3v^2(u^3-lambda). If u or v is zero the
other derivative is nonzero, using lambda!=0. If both are nonzero,
simultaneous vanishing would give u^3=lambda,v^3=1, contradicting
lambda!=1 in the defining equation. At u=infinity, the equation in s=1/u
is v^3-lambda s^3v^3-1+s^3=0; when s=0 its v-derivative is nonzero.
The v=infinity chart is similar, with u^3=lambda. None of the four
corners u,v in{0,infinity} belongs to T. Adjunction gives g(T)=4.

The diagonal and anti-diagonal order-three subgroups have only these
four corners as ambient fixed points. They therefore act freely on T.
Their quotient maps are finite Galois etale of degree3 on the WHOLE
projective curve. Riemann--Hurwitz gives genus2 for both quotients.

For the anti-diagonal quotient, w=uv gives

    t^2-(1+w^3)t+lambda w^3=0.

Completing the square with z=2t-1-w^3 gives C_plus. The field generated
by t,w has index3 in k(T), since adjoining u recovers v=w/u. For the
diagonal quotient, w=u/v similarly gives

    t^2-(lambda+w^3)t+w^3=0,

and z=2t-lambda-w^3 gives C_minus. Its invariant field also has index3.
The two subgroups generate C3^2, so their invariant fields intersect
in k(t): the displayed span is cored. Scaling w=lambda^(1/3)W,z=lambda Z
in C_minus gives the stated a_minus. The sextics are squarefree: their
quadratic discriminants in w^3 are16lambda(lambda-1) and16(1-lambda),
and their constant coefficients are nonzero.

## 2. Characteristic-five test and the coreless corollary

For f=w^6+a w^3+1, its square is

    w^12+2a w^9+(a^2+2)w^6+2a w^3+1.

The hyperelliptic Hasse--Witt coefficient matrix at indices(4,3;9,8) is
[[0,2a],[2a,0]]. The Cartier-semilinear convention takes fifth roots of
the entries and has the same rank. Thus its vanishing at a=0 gives
superspeciality; its invertibility at a!=0 gives ordinarity.
At lambda=3 the plus coefficient is0, while the normalized minus
coefficient is4. The unnormalized minus equation is
z^2=w^6+2w^3+4. The plus curve is isomorphic to C:v^2=t^6+3:
take t=r w,v=s z with r^6=s^2=3.

A superspecial abelian variety has only Newton slope1/2, and an ordinary
one only slopes0,1. A nonzero homomorphism would have a positive-dimensional
image isogenous to both a quotient of the source and a subvariety of the
target, impossible with these disjoint slopes. This proves both Hom
vanishings. It does not say either Jacobian is simple.

The lambda=3 maps have Galois groups C3, so both endpoints are in the
prime-to-five etale commensurability class of C. Apply
[bolza_prime_to_five_coreless_neighborhood](Sol_bolza_prime_to_five_coreless_neighborhood.md)
to obtain a coreless common span with prime-to-five leg closures. This
uses a DIFFERENT source; corelessness has not been attributed to T.

## 3. Exactly why absolute simplicity is unavailable

On every smooth C_a, the involution (w,z)->(1/w,z/w^3) has invariant
functions

    X=w+1/w, Y=z(w+1)/w^2,
    Y^2=(X+2)(X^3-3X+a).

The quartic is squarefree: its cubic discriminant is27(4-a^2), and
the cubic's value at-2 is a-2. Both are nonzero for a^2!=4. Thus the
quotient is elliptic. The displayed map has degree2, and pullback of
its Jacobian is a nonzero elliptic subvariety of J(C_a), proving that
J(C_a) is not absolutely simple.

This is a parameterized positive test, complementary to the degree-two
genus5/genus3 construction in completed_local_orbifold_rigidity, not a
replacement for that theorem's Hermitian quotient classification.
