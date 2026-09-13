# All uniform Cartier roots, and an infinite family surviving the endpoint test

Let C be an ordinary genus-two curve over k=Fbar_5, choose a Weierstrass
point O, and write J1=Pic0(C^(1)), O1=F_C(O), V=F_C^*. A uniform
Cartier-zero tensor is a nonzero s in H0(C,omega^d), 5 not dividing d,
with div(s)=eD for a REDUCED divisor D of degree r, er=2d, and zero
eligible generalized Cartier image.

Necessarily r is1,2,or4 modulo5. Let a in{1,2,3} satisfy ar=2mod5,
and put j=(ar-2)/5. Consider

    T_r={(D,theta): D in Sym^r(C), V(theta)=[D-rO]}.

This is connected, smooth and projective of dimension r, finite etale
of degree25 over Sym^r(C). For r>=3 it is the projective bundle with
fiber |rO+V(theta)| over J1. Set M=O(jO1) tensor theta^a. Then

    omega_C tensor V(M)=O(aD).

Define Z_r by requiring that the SPECIFIED section with divisor aD
have zero twisted Cartier image in H0(C^(1),omega_(C^(1)) tensor M).
This is not merely the condition that some section be Cartier-zero.

A uniform Cartier-zero tensor with this D exists IFF Z_r contains a
pair(D,theta) with theta of prime-to5 order. For a fixed D at most ONE
of the25 lifts has this property. Put h=gcd(r,2), d0=r/h, e0=2/h.
If n is the order of N=O(e0D)omega^(-d0)=V(theta)^e0, the minimal
tensor has weight d0 n and divisor e0 n D. Larger p-prime weights
give the same zero/nonzero test. Thus this removes the UNBOUNDED weight
from the geometric criterion for every prescribed reduced divisor.

For allowed r>=4, j>0 and Z_r is locally cut out by j+1 equations on
T_r. Every nonempty component meeting the reduced open locus therefore
has dimension at least r-j-1:

| r | a | j | lower dimension |
| --- | --- | --- | --- |
| 5k+1, k>=1 | 2 | 2k | 3k |
| 5k+2, k>=1 | 1 | k | 4k+1 |
| 5k+4, k>=0 | 3 | 3k+2 | 2k+1 |

## Actual surviving roots for an entire infinite progression

For EVERY k>=1, r=5k+2, there is a nonempty open U_k in J1 such that
Z_r over U_k is a projective bundle of relative dimension4k-1, and
each fiber contains reduced divisors. Every prime-to5 theta in U_k
therefore supplies genuine uniform Cartier-zero tensors as above.
Their MINIMAL weights are unbounded. Prime-to5 torsion is dense in J1,
and the orders of V(theta)^e0 are unbounded on this open set.

The first case has a particularly simple formula. Write

    C:v^2=F(u), deg F=5, eta=du/v, div eta=2O.

For b not a branch value put alpha=(u-b)du and s=alpha^2 eta^5.
Then s has weight7, div(s)=2D, and D consists of the five finite
Weierstrass points and the two points over b. Thus D is reduced of
degree7, and C_(C,4)(s^3)=0. This tensor is NOT a proper tensor power.

Separately, let C be ANY subcanonical curve of genus g>=3 in
characteristic5: div(eta)=(2g-2)O for a regular differential eta.
For a general f in L((5g-6)O), the tensor

    s=(df)^2 eta^5

has weight7, divisor2D with D reduced of degree7(g-1), and the same
Cartier-zero identity. Ordinarity is unnecessary. Thus the fixed X,
the genus-two backup, and the fixed hyperelliptic Y ALL have independent
endpoint tensors of this SAME profile (support sizes56,7,168).

If two such tensors ever have equal pullbacks in an actual CORELESS
span, that span has NO shared regular projective connection. This is
a conditional structural statement, not an exclusion of those spans.

These are one-ENDPOINT tensors, NOT common covers or realized clumps.
They prove that excluding all uniform Cartier-zero profiles on an
ordinary genus-two endpoint is impossible. Any final exclusion must
retain the other endpoint and both actual maps from the SAME source.
The four-point nonemptiness question and the no-clump case remain open.

Version2,2026-09-08: adds the projective-bundle normal form, actual
unbounded-weight surviving families and the shared-connection boundary;
simplifies the preferred-lift rule.
AUTHOR proof, not independently audited.
[Proof](../../Solutions/connections/uniform_cartier_root_locus.md).
