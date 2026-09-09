# Compute one genuine higher-lifting obstruction, not another reduction

Please compute ONE obstruction for the explicit genus-two pair below:
does its canonical marked curve lift modulo25 extend modulo125 so that
the original Hodge line lifts in higher inverse Cartier?

The intended outcome is a reusable Cech/residue calculation of a
ONE-dimensional obstruction. We are using this smallest nonzero defect
as a laboratory for a common-cover problem, NOT asking you to solve that
problem or enumerate further exceptional parameters.

## The explicit pair — verified inputs, not tasks to repeat

Work over k=bar(F5), with t a root of the irreducible polynomial

    t^4+4t^3+t^2+4t+3=0.

Set C:v^2=F(u), with its unique infinity point O, where

    F=u(u-1)(u-2)(u-3)(u-t),
    P=2u^3+(2t+3)u^2+(3t^2+3)u+2t^3+4t^2+4t+4,
    r=2(F'/F)^2-F''/F+P/F.

Primes here are ordinary u-derivatives. Our projective convention is
U''=rU and r_x=(du/dx)^2 r_u-(1/2){u,x}. Put

    E=r''-3r^2,
    N=-(E')^2-3E(E''+3rE).

The curve is smooth of genus2, and r is a globally REGULAR, admissible
ACTIVE nilpotent connection: N=0 and E!=0. Regularity includes O.
The Jacobian is ordinary, with Cartier determinant4; this is NOT
indigenous ordinariness.

Here are useful compact factorizations. Set

    S=u(u-1)(u-2)(u-3), R=u-t, h=4t+3,
    J=S+2R S'
     =4u^4+(2t+3)u^3+t u^2+(t+2)u+2t,
    K=4u^3+(2t+4)u^2+(4t+1)u+2t+1,
    A=K(h)(u-t)(u-h)^2.

Then

    J=(u-h)^2[4u^2+(4t+2)u+3t^2+1],
    gcd(J,J')=u-h, J''(h)!=0, F(h)K(h)!=0,
    E=3A/F^2.

Thus E(du)^4/3 has half-divisor W_t+O+P_h+iota(P_h), four distinct
points. Its canonical double is NONSPLIT, with two-torsion class
O(W_t-O), equivalently adjoining sqrt(u-t). Retain this torsor and
the square-trivial twist in the periodic flow.

Most importantly, the tangent space of the nilpotent connection scheme
on this FIXED curve is EXACTLY the line spanned by

    phi=(u^2+(t+3)u+2t^2+4)(du)^2/F.                 (1)

This was checked by linearizing the ORIGINAL equation N at r on the
complete basis (1,u,u^2)(du)^2/F: its11-by3 coefficient matrix has rank2.
For completeness the nonzero2-by2 minor is2t^2+4t+4, and the full kernel
vector is(2t^2+4,t+3,1). No local scheme-length assertion is being made.
The critical collision explains (1): dr/dh=4J/[F(u)(u-h)^2] is regular
at the double root. These finite-field assertions replay in0.1seconds;
they are NOT certificates for any Witt lift.

## Precisely which higher lift and scalar are requested

Write W_n=W(k)/(5^n). The normalized Fontaine--Laffaille class attached
to r gives one marked W2 lift of C^(1). Transport it and all flow data
by inverse Witt Frobenius, and call the resulting marked lift of C
simply C_2. This is the CANONICAL FIRST lift attached to r, not an
arbitrary coefficientwise or Teichmuller lift of the displayed equation.

Choose theta L=O(O). The canonical first inverse-Cartier object H_1
has its specified Hodge line N_1 and projective oper r. Keep the actual
previous filtered flat object, its graded identification and the
square-trivial periodicity twist; one may use projective notation or
the canonical double. The double is not allowed to be silently split.

For any marked curve lift C_3 of C_2, these previous data define the
higher inverse-Cartier bundle H_2 on C_2, reducing to H_1. The obstruction
to lifting the ORIGINAL line N_1 is

    rho(C_3) in V=H^1(C,Hom(N_1,H_1/N_1))=H^1(C,T_C).

The established variation formula is

    rho(C_3+xi)=rho(C_3)-Psi(xi),

where Psi is Frobenius-semilinear and dual, after consistent relative
twists, to indigenous infinitesimal Verschiebung. Here V has dimension3
and Psi has rank2 by (1). Thus

    epsilon(C,r)=[rho(C_3)] in coker(Psi)

is a well-defined class in a ONE-dimensional space. Under the matching
Serre-dual convention, (1) spans the annihilator of im(Psi). Equivalently
the zero/nonzero test is the single scalar

    lambda(C,r)=<rho(C_3),phi>.                       (2)

It is independent of the arbitrary reference C_3. Please keep relative
Frobenius twists explicit if needed; renaming them must not change the
vanishing test.

The Serre functional is ALREADY explicit. Put z=u^2/v at O and
eta=du/v. With rational tangent frame eta^-1, the Cech quotient is

    H^1(T_C)=k((z))/(k[u,v]+z^2 k[[z]])
            =span_k{z^-3,z^-1,z}.

If the reduced coefficient of rho is a_-3 z^-3+a_-1 z^-1+a_1 z,
then, up to the harmless overall Cech sign,

    lambda=(3t^2+t+1)a_-3+(3t+4)a_-1+3 a_1.         (3)

This follows by pairing with (1) and taking Res_O. We have verified
it using 1/u=z^2(1+F_4/u+...+F_0/u^5) and eta=-z d(1/u).
Computing this pairing or its dimension is therefore NOT the target;
the missing datum is the ACTUAL higher inverse-Cartier cocycle rho.

TARGET: determine whether (2) is zero for THIS pair. If zero, exhibit
a compatible C_3/Hodge lift or an exact cohomological vanishing
certificate. If nonzero, exhibit the nonzero residue/class. Please
make the calculation a reproducible Cech/residue recipe that can be
used for another corank-one pair, explaining which geometric term
vanishes or survives. A numerical verdict without that term would miss
the purpose of this example. A theorem covering a larger class and
therefore deciding this example is equally welcome, but not required.

## Sources and boundaries already checked

Mochizuki, II1.2/2.5 (the first lift), II2.13/3.1 (ordinariness),
III2.5--2.8 (variation and ordinary iteration):
https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf

Lan--Sheng--Yang--Zuo, Section5, especially Proposition5.2/Lemma5.3,
gives the higher variation formula with the full previous-flow input:
https://arxiv.org/html/1404.0538#S5

Krishnamoorthy--Yang--Zuo, Theorem6.4, ASSUMES that the filtration-
compatible lifting locus is nonempty before its Artin--Schreier step:
https://arxiv.org/html/2005.00579v1#S6.SS2
It cannot establish the nonemptiness asked for here.

Do NOT just solve the characteristic-five scalar equation N=0 or J=0
with integer coefficients modulo25: that is not a supplied dictionary
for higher inverse Cartier or for this canonical C_2. Likewise a
nonzero tangent, a double root of J, or a nonzero coker(Psi) does not
prove epsilon!=0. The curve alone always lifts; it is the specified
Hodge compatibility that is being tested. No common cover is asserted.

## Why either answer changes our research

For an actual rigid matched span X<-Z->Y with ordinary r_Y, we have
proved that EVERY existing Witt diagram must use canonical Y. Its next
obstruction lies in ker(barPsi) on V_Z/(f*V_X+g*V_Y). The endpoint
component is epsilon(X,r_X); after that comes a separate source-kernel
mismatch. Thus a nonzero value here would locate a genuine failure of
iteration already on one endpoint, not just in an abstract matrix.
It also gives an all-degree exclusion: etale trace commutes with Psi,
so epsilon pulls back injectively through a cover of degree prime to5.
Thus nonzero epsilon rules out any matched span to an ordinary
connection whose degree toward THIS endpoint is prime to5. This
trace consequence is an input, not the requested new calculation.
A zero value would supply the first nonordinary higher-lift calculation
we can compare with the still-unresolved two-map mismatch; it would
NOT prove universal one-leg lifting or solve the span problem.

We have already derived these reductions and the ordinary case. Please
do not spend the answer reproving them or propose stable-image
containment in place of evaluating (2). If the calculation cannot be
completed, identify the concrete missing coefficient/construction
briefly instead of returning a catalogue of weaker reductions.
