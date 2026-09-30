# A degree-seven norm forces the opposite endpoint into a half-turn

27 September2026. Retain the exact four trace equations, coefficient
rows and fields E=F_(5^8), K0=F_(5^14), B=F25. Their compositum
F=F_(5^56) has order-four automorphism sigma fixing K0 and shifting
the four roots cyclically. Put L=Fix(sigma^2)=F_(5^28).

For a fixed polynomial row p, write its root Fourier coefficients as
p_l=(1/4)sum_i2^(-li)p(alpha_i). Its endpoint sum at exponent r is
sum_l p_l S_l(r), where S_l(r)=sum_j(sum_i2^(li)m_ij)xi^(rj) lies
in K0 and all integer weights are reduced in F5. The nonzero p_l
belong to the corresponding sigma eigenspaces over K0.

The fixed coefficient identities are

- c1,c2,c3 and u1,u2,u3 are nonzero;
- e1,e2,v1,v2 are nonzero, while e3=v3=0;
- e2/c2=[12], and -c2*v1/(c1*v2)=[11]=zeta, of order three;
- c0=[20], e0=[8], u0=[12], v0=[4].

These identities follow by four-term Fourier sums in the displayed
quartic root field and are reconstructed in the executable below.

## Reduction when the first endpoint is balanced

The equations are invariant under
(L0,Linf,epsilon,X,Y)->(Linf,L0,epsilon^-1,barX,barY).
Thus assume L0 is balanced, so all its four sums lie in K0. The whole
K0 scalar sector is already excluded. The third equation, with
epsilon not in K0, gives

X^625=U0/eta, and Y^(5^8)=-V0/eta.

It determines X,Y uniquely in K0. Put a=E0-eta*barX and
b=C0-eta*Y. The first two equations say

Cinf=epsilon*a+eta*barY, and Einf=epsilon*b+eta*X.

Both a and b must be nonzero. If a=0, Cinf lies in K0, and its three
nonconstant root Fourier coefficients force the four phase counts to
agree. If b=0, Einf in K0 forces S1(8)=S2(8)=0. Every at most eight
distinct phases is F5-independent, so these vanish phasewise. The
inverse Fourier vector then has only characters0 and3. A nonzero
character3 coefficient would give four distinct residues in F5,
impossible when each integer count is in{0,1,2}. Hence Linf would
again be balanced. Both cases contradict the already excluded
double-balanced endpoint system.

Because a!=0, the first equation puts epsilon in F even if the
original scalar was any geometric element. Because b!=0 and e3=0,
the character3 projection of epsilon is zero. Consequently Cinf has
zero character3, giving S3(5)=0. Phase independence makes this a
phasewise statement and hence S3(r)=0 for EVERY exponent r, notably17.

The character3 projection of the fourth trace equation is therefore
epsilon1*Vinf2+epsilon2*Vinf1=0. Substituting the two corresponding
components of Cinf=epsilon*a+eta*barY gives

c1*v2*S1(5)*S2(4)+c2*v1*S2(5)*S1(4)=0.

If both S1(5),S2(5) are nonzero, set R=S2(5)/S1(5). Since
5*5^8=4 modulo29, the integer-weighted phase sums satisfy
S_l(4)=S_l(5)^(5^8). Thus R^(5^8-1)=zeta. Frobenius5^8 has
order seven on K0 with fixed field B. Taking its relative norm gives
1=zeta^7=zeta, a contradiction.

At least one of S1(5),S2(5) is therefore zero. If S2(5)=0, its
phasewise vanishing together with S3=0 leaves only characters0 and1.
The same four-distinct-residues argument forces complete balance,
again impossible. Hence S1(5)=0. Both odd components of epsilon
vanish, so epsilon lies in L, and both odd components of Cinf vanish.
The latter gives m0j=m2j and m1j=m3j at every phase: Linf is half-turn.

All uses of the small integer bound are explicit. The argument is not
valid for unrestricted multiplicities merely congruent modulo five.

## A small complete coefficient exclusion

Represent a balanced L0 by an unordered phase pair p, with repetition.
There are435 such pairs. Let Z_r be its two-phase sum at exponent r.
Then C0=4c0 Z5,E0=4e0 Z8,U0=4u0 Z17,V0=4v0 Z4. Compute X,Y,a,b
as above. All435 values of a and b are nonzero.

Represent the opposite half-turn endpoint by TWO unordered phase pairs
p_even,p_odd, assigned to root types0,2 and1,3 respectively. This retains
every such endpoint; there are435^2=189225 ordered choices. Let Z_r and
W_r be their sums. If the pairs coincide the endpoint is balanced and
already excluded. Otherwise its character2 coefficients satisfy

Einf2/Cinf2=[12]*(Z8-W8)/(Z5-W5).

The denominator is nonzero by the same phase independence, also checked
exactly. The two old trace equations REQUIRE this quotient to equal b/a.
The set of435 possible b/a values is disjoint from ALL188790 nonbalanced
half-turn quotients. Thus even this necessary two-trace test is empty.
No fourth-equation search or unbounded scalar enumeration is needed.

The [Sage producer](../../scripts/arithmetic/eight_one_balanced_endpoint.py)
works in an absolute degree14 field over F5, constructs all435 moment
pairs, and tests all189225 half-turn endpoints. It also reconstructs the
quartic Fourier identities and checks all81 count vectors in{0,1,2}^4
used in the proof. The
[native verifier](../../scripts/arithmetic/verify_eight_one_balanced_endpoint.cpp)
uses seven F25 coordinates, explicit multiplication/inversion and the
independently retained phase table. It also independently reconstructs
the quartic root Fourier coefficients by polynomial reduction and
checks the crucial norm constant[11]. Both give435 target classes, no
zero-denominator boundary and ZERO quotient matches.

Executed with Sage10.9/Python3.14.3 and Clang with assertions enabled.
The exact receipts are one_balanced.json, one_balanced.log and
one_balanced_independent.log in the external
[evidence directory](../../../litt3-computation-data/uniform_eight_k0_20260927/).
Run the Python source with an output path. Compile the native source
with -O3 -std=c++17 and an include path to the adjacent external
prime_field_phases_20260927 directory containing sextic_paired_data.hpp.
The field-norm proof is author-reviewed; the finite enumeration has the
separate independent arithmetic replay. Neither is an actual-cover search.

## Half-turn matching for the remaining cases

Suppose L0 is half-turn. If epsilon is outside L, its third equation
has the form epsilon*a=b with a,b in L, forcing U0,V0 in K0. The
nonzero character2 coefficient of u and phase independence then force
L0 to be balanced, contradicting the result just proved. Therefore
epsilon is in L. The first old equation now puts Cinf in L; its two
odd coefficients force Linf to be half-turn too. Apply endpoint
symmetry for the converse. Hence half-turn invariance must match
between the endpoints, and the full degree-four scalar case has no
half-turn endpoint at either end.
