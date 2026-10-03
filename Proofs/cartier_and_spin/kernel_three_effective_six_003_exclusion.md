# Proof: primitive actual cube field, two power fibers and the impossible triple zero

Version1. [Statement](../../Theorems/cartier_and_spin/kernel_three_effective_six_003_exclusion.md). Both actual endpoint maps remain onT. Put U=T/K and H=G/K. The actual U→Y is Galois étale, U→Γ has degree six, and its different is one reduced qUP. The distinguished image is ordinary, so U→Γ has one ramified sheet and four unit companions there; the effective Y→B=Γ/H map has degree six and special fiber2P+Q1+...+Q4.

The canonical s is primitive of original degree eighteen overΓ by the accepted tame different theorem. Its cube b=s³ in a rational Nu frame generates k(U) overΓ: Γ(a³) is contained inU and its index inT is at most three, hence exactly three. Since H acts faithfully onΓ, k(U)=k(Γ)k(Y). Its degree-six characteristic coefficient sections are e3,e6,e9,e12,e15,e18 in Nu,...,Nu⁶.

## A genuine generator gives the actual minimal polynomial

For weightsNu=(0,0,3) on cones(3,3,6), choose the unique nonzero invariant generator t ofNu. Its forced zero is order three at the order-six cone and it is a unit at the distinguished ordinary value. Put f=t/s³. It is an ACTUAL Y function with divisor3R−3P, hence degree THREE.

The identity b=t/f gives k(Γ)(f)=k(U). Let F=k(B)(f)⊂k(Y). Then[ΓF:Γ]=[U:Γ]=6, while[ΓF:Γ]≤[F:B]≤[Y:B]=6. Thus F=k(Y). This field reconstruction does NOT invoke coprimality of three and six. It uses the actual primitive cube generator and the same source fields.

Choose coarse coordinate β with the distinguished ordinary point zero and the order-six cone infinity. The invariant Nu^j spaces have coarse degrees floor(j/2). Dividing their sections by t^j gives polynomials inβ of that degree. The norm e18 has coarse zero orderTHREE atβ=0, so e18/t⁶=κ0β³ withκ0≠0. Also e15 vanishes to target order at leastTWO atβ=0: the b-ramified quadratic has trace of order at least two and norm of order three, and the four companion factors are units. Therefore e15/t⁵ is a constant multiple ofβ².

The actual primitive sextic minimal polynomial of f overB has constant one and form
\[
P_\beta(f)=\kappa_0\beta^3f^6-\lambda\beta^2f^5+L_2(\beta)f^4-L'_1(\beta)f^3+L_1(\beta)f^2-Af+1,
\]
where Lj has degree at most j and A,λ are constants. Its leading coefficient and constant are units at the two finite nonzero order-three cone positions β=a,b.

## The two cube fibers interpolate every coefficient except one

At either of these cones, the actual Y fiber has two points each of index THREE. Since f is finite there, its norm polynomial specializes to the CUBE of a quadratic. Normalize the quadratic's constant coefficient to one by multiplying it by a cube root of unity. Its linear coefficient is then v=−A/3, the same at both cones.

If v=0, the specialized cubes have zero f³ coefficient at both a,b; since L1′ is linear, it is identically zero. They also have zero f⁵ coefficient, soλ=0. Together A=0 these make every odd coefficient of the original degree-eighteen polynomial zero. The primitive original polynomial is EVEN, contrary to the actual commuting-minus obstruction. Hence v≠0.

Write the quadratic leading coefficients as t_a a and t_b b. Cubic leading comparison gives t_a³=t_b³=κ0. Comparison of the f⁵ coefficient gives t_a²=t_b² because v≠0; thus t_a=t_b=:t0≠0. The coefficients of f, f² and f³ in the norm polynomial agree at two points with the corresponding coefficients of(1+vf+t0βf²)³; each has degree at most one inβ and hence agrees identically. In particular its f² coefficient L1(β) equals3t0β+3v². The f⁵ and leading coefficients already agree identically. Its f⁴ coefficient has degree at most two and agrees at a,b, so its only possible difference is D(β−a)(β−b). Therefore
\[
P_\beta(f)=(1+vf+t_0\beta f^2)^3+D(\beta-a)(\beta-b)f^4.
\]
The constant D is NONZERO, otherwise the actual minimal polynomial would be a cube and would not be irreducible of degree six.

## An actual degree-four function makes the triple zero impossible

Put g=βf². Its only pole is4P: atP β has zero order two while f² has pole six; atR the pole ofβ has order six and exactly cancels the zero of f². At the four Qj it has simple zeros, since f is a unit there. Thus degg=4 and k(f,g)=k(Y) by coprime degrees three and four.

The interpolated equation becomes the actual plane equation
\[
F(f,g)=(1+vf+t_0g)^3+D(g-af^2)(g-bf^2)=0.
\]
It is birational toY; as a cubic in g it is the minimal equation over k(f), since degf=3. At the sole zeroR of f, the function g is a unit and satisfies J(g)=(1+t0g)³+Dg²=0. Since D≠0, this root has1+t0g≠0. The partial derivative F_f(0,g)=3v(1+t0g)² is NONZERO. Hence the plane curve is smooth there, g−g(R) is a local parameter, and the zero order of f equals that root's multiplicity in J.

But J cannot have a triple root with D≠0. If J=t0³(g−r)³, its constant and linear coefficients imply r³=−t0^-3 and r²=t0^-2, hence r=−t0^-1. Its quadratic coefficient then gives3t0²+D=−3t0³r=3t0², so D=0. This contradicts the nonzero D. Thus ord_Rf≤2, whereas its exact divisor gave ord_Rf=3.

The stated weight assignment is excluded. Every polynomial specialization and field identity here is attached to the actual same-source maps; no new numerical calculation or presumed simultaneous Galois closure is used.
