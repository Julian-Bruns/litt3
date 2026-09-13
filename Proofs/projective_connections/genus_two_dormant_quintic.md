# Proof: triangular curvature elimination, then exact endpoint separation

[Statement](../../Theorems/projective_connections/genus_two_dormant_quintic.md).
Universal formulas and gcd argument: returned NC Pro response2026-09-08.
Scheme-level elimination and family resultant: main-agent verification.
The [short exact checker](../../scripts/genus_two/check_genus_two_dormant_quintic.sage)
uses symbolic F5 polynomial arithmetic, not sampling or a finite-field
bound on the connection parameters.

Write eta=du/v. In a local uniformizer z, eta=h dz gives a rational
projective connection (h²)''/h², by the characteristic-five Schwarzian
identity. In coordinate u this is 2(F'/F)²-F''/F. It is regular at every
finite point, since eta is a unit differential there. At infinity use
u=z^-2: eta=-2z²(1+O(z²))dz. The base coefficient has polar part2z^-2,
whereas adding (2u³/F)(du)² contributes3z^-2 and cancels it. Both
expansions are even, so there is no simple pole. All regular connections
are therefore

    base+(2u³+c2 u²+c1 u+c0)/F,

because 1,u,u² times (du)²/F form the full quadratic basis.

The polynomial F²(r''-3r²) has u^4 and u^3 coefficients

    a3+a4 c2-2c1+2c2²,
    -2a2+2a4 c1-2c0-c1 c2.

Their unit coefficients solve c1=W(c2), c0=V(c2) over EVERY coefficient
algebra, including nonreduced ones. After substitution the exact identity
is F²(r_T''-3r_T²)=Psi(T)(u+T+3a4). Hence the entire curvature ideal,
not only its roots, is the stated triangular ideal and quintic. Its
leading coefficient is -2, so length is5. The checker also evaluates
the resultant after a4=-(t+1), a3=t+1, a2=-(t+1), a1=t, a0=0 and
verifies Res(Psi,Psi')=-G(t)². Smoothness here is exactly G(t)!=0.

For the matching assertion, no-clump makes common rational quadratic
tensors zero. A common rational connection has no poles (otherwise its
pole set is a clump), and its intrinsic quartic curvature is zero, so
it is dormant. Its Y-coefficient must be r_lambda for Psi(lambda)=0.
The displayed A-basis expansion then gives exactly the gcd test.

Two roots would give two common connections and a nonzero common
quadratic, impossible. A multiple matching root would also give such
a quadratic: differentiate in T to obtain

    b² (u²+W'(lambda)u+V'(lambda))/F in A.

The Y quadratic is nonzero since its u² coefficient is1. Thus the gcd
is either1 or a single simple linear factor, even when Psi itself is
nonreduced on another curve. If the gcd is1, the h_j generate the unit
ideal in A[T]/(Psi). Take representatives V_j of degree<=4. The residual
numerator has degree<=7, so division by Psi gives U of degree<=2.
This proves all claims without a degree bound or a Galois closure of M.

The general candidate count in dormant_rank_two_candidates remains the
broader theorem; it is not replaced. Nor does simple endpoint dormancy
imply that a pulled-back dormant object on a common cover stays ordinary.
