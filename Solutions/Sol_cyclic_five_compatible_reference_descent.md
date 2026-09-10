# Proof with a compatible lower reference

This is the scoped part of the returned D5 proof, with the root's
explicit oper normalization repair. Focused medium audit by
/root/audit_d5_two_digit_descent,2026-09-10: PASS at n=2 and for all n
under compatible-reference existence. Full D5 allowing an incompatible
reference: GAPS. The obstruction there is recorded at the end below.

## 1. First difference and equivariant primitives

Choose the compatible reference C^0_(n+1) from the statement, canonical
when n=2. Lift the original cover to T^0_(n+1). The first difference
xi=[T_(n+1)]-[T^0_(n+1)] lies in ker Psi_T. Absorb u(e) in source and
target normalizations. Then

    xi=d e³+b e^4.                                      (1)

The ordinary component is zero. Extend the smooth reference curve
arbitrarily one more Witt digit and lift the cover. The difference
of the two upper W_(n+2) curves with their common W_n marking is a
two-digit tangent class, because (5^n W_(n+2))²=0. Use the integral
lattices

    M2=H1(T2,T_(T2/W2)),
    P2=H1(T2,Hom(Fil2,H2/Fil2)).

The maximal second fundamental isomorphism identifies their coefficient
lines equivariantly. Each is free of rank six over
R2=W2(k)[sigma]/(sigma^5-1): lift a free basis modulo5 and compare
the resulting free W2 modules of equal rank. The lower lattices pull
back to their invariants, equal to the norm submodules NM2,NP2.
This also follows from negative-H0 Cartan--Leray and reduction.

On a two-affine cover pulled from C, either coefficient sheaf has H0=0.
Thus 0→Cech0→partial Cech1→cl H1→0 is exact. Since H1 is free over
the deck algebra, choose an equivariant section s of cl. The map

    Q=partial^-1(1-s cl)

is an equivariant primitive. In particular an exact cochain in e²Cech1
has its unique primitive in e²Cech0, integrally and modulo5. At n=2
average the choices under tau. This is a cochain statement, not an
inference from equivariance on cohomology alone.

## 2. Normalize the full previous filtered objects before rescaling

Put m=n-1. Both previous objects now exist GLOBALLY with their Hodge
lines. In an adapted frame let the connection matrix be
A=[[alpha,beta],[gamma,-alpha]], with gamma a unit. If a Hodge line
changes by the graph gauge B=I+epsilon*q*E21, epsilon=5^m, its lower
connection coefficient becomes

    gamma'=gamma+epsilon*(q'-2alpha*q)-epsilon²*beta*q².

Follow by diag(v,v^-1), with v=(gamma/gamma')^(1/2), taking the unique
root congruent to1. This restores gamma exactly. The first variation
of v is additive in q. The prescribed graded/second-fundamental
identifications then align the diagonal transitions; the curves differ
only one factor of5 later. All these operations retain the actual
flat square-trivial line, not a fictitious global trivialization.

The preceding filtered transitions are triangular. With S=diag(1,5),
the rescaling is

    M=[[ell,c],[0,ell^-1]] → [[ell,5c],[0,ell^-1]],
    d+A dx → 5d+[[5alpha,25beta],[gamma,-5alpha]]dx.

The normalized first previous-tuple changes therefore gain a factor
of5. This explicitly controls the first Taylor coefficient. For the
higher ones, tildeD=5S^-1 D S gives

    v5(tildeD^j/j!) >= j-1-v5(j!).

For j>=2 the affected terms likewise retain the needed extra factor.
These are the rescaling and Taylor operations of
[Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/pdf/1404.0538),
with their full previous tuple, as in
[the higher-lift dictionary](Sol_forced_canonical_witt_endpoint.md).

## 3. The divided carry in the actual normal obstruction

Choose local Frobenius lifts downstairs and pull them to the cover.
They commute with sigma. An order5^n curve derivation tilde nu changes
the divided Frobenius discrepancy by

    5^(n-1)(-F2(tilde nu)+5L(nu_bar)) modulo5^(n+1).

The first Taylor coefficient followed by the normal Hodge projection
and the chosen Cech projection constructs an ACTUAL semilinear,
R2-equivariant map A2:M2→P2 reducing to Psi_T. Its other linear
contributions, including the corrected previous Hodge generators,
occur with an extra factor5 and are additive equivariant operators.

For completeness, normal graph gluing for G=[[A,B],[C,D]], with
C divisible by5^m, and generators e_i+5^m q_i f_i gives, after division
by5^m, its linear equation plus

    5^m((K_ij)_22 q_i-(K_ij)_11 q_j-B q_i q_j).

Thus the only additional nonlinear term at the required next digit
is quadratic when n=2; it vanishes at n>=3. The first curve cochain
is in e³, hence e², by(1). Its exact first Hodge error has a primitive
in e² by Section1. Normalization in Section2 and all other first
changes are additive in these data. Their linear divided contributions
are therefore in e² and vanish in coker Psi_T=R/e².

At n=2 the reference is canonical and tau-equivariant. All first
corrections can be chosen anti-tau, whereas the quadratic term is
tau-invariant. Its image in the anti-tau cokernel is zero. This use
of tau is confined to the canonical initial comparison.

The chosen reference may have a NEXT obstruction, but its first
obstruction is zero. Consequently its two-digit reference error has
the form 5*eta1 downstairs. The necessary residual equation is

    [(A2(tilde xi)-5N*eta1)/5]=0 in R/e².                 (2)

After division, N*eta1 reduces to e^4*eta1 and has zero image here.
No next compatibility of the arbitrary C^0_(n+2) is assumed.

On the nilpotent line A2 has the form (e²+5B(e))*varphi, where varphi
is Witt Frobenius on coefficients and fixes e. The off-diagonal blocks
reduce to zero. Write tilde xi=tilde d*e³+tilde b*e^4+5*zeta. The
5B term projects to zero because xi is divisible by e², and zeta
contributes an image of Psi. The integral relation

    e^5=-5e-10e²-10e³-5e^4

then turns(2) into -d^5*e=0 in R/e². Hence d=0. The exact polynomial
carry, independently checked in
[the standard-library verifier](../scripts/verify_cyclic5_integral_carry.py),
is used only AFTER this geometric comparison.

## 4. Retain the given upper truncation and original map

Now xi=b e^4=h*beta for beta in ker Psi_C. Set
C_(n+1)=C^0_(n+1)+beta. It is compatible by the variation formula.
The unique lift of the ORIGINAL cover over it has exactly the marked
deformation class of the GIVEN T_(n+1), so a marked isomorphism
identifies them and transports the map. It restricts to the specified
map on T_n. Naturality and H0(T_C)=H0(T_T)=0 identify the given and
pulled-back Hodge lines; the graded identification and prescribed flat
twist were retained throughout. This proves both stated cases.

## 5. Historical limitation of this proof and its subsequent resolution

If no compatible C^0_(n+1) is known, local reference Hodge lines need
not glue. In adapted local frames the preceding overlap has a lower
entry 5^m*r_ij. Weight rescaling divides this entry by5, producing
5^(m-1)*r_ij. The triangular calculation in Section2 does not apply
to that reference. One must combine this error with the actual upper
Hodge repair before rescaling and determine the resulting divided
carry. Merely calling it a pulled-back reference error does not do
that calculation. In particular its disappearance cannot be inferred
from the e² cochain lemma after a division by5.

The first compatibility equation in that situation is instead
xi=a e²+d e³+b e^4 with a^5=eta0, the lower obstruction. An arbitrary
matrix lift gives -eta0(1+2e)-d^5e, but the omitted lower reference
term has not been shown to leave this actual geometric residual
unchanged by THIS calculation. No contradiction to D5 or actual
counterexample is claimed.

The gap is now resolved by
[the compatible deck-translate comparison](Sol_cyclic_five_delayed_descent.md):
compare two genuinely gluing upper objects, never a nongluing lower
Hodge reference. Their relative next obstruction is a^5 e for a
difference a e³+b e^4. Applying this to the marked deck translate
forces the lower obstruction eta0 to be the constant upper component.
This separate proof, including all n>=3, passed a focused medium audit.
