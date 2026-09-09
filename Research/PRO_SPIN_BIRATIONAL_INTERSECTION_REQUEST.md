# The remaining two-leg Cartier intersection on a spin-birational source

Please prove or disprove the section-intersection statement below. This
is one marked case of Litt's common finite-etale cover problem, not the
whole problem. A new structural reduction is useful if it genuinely
uses both maps. Reproving one-leg section growth will not close this gap.

## Fixed endpoints and the exact target

Work over k=bar(F_5). Choose a in F_25 with a^2+4a+2=0, and put

    F(x)=x^10+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3a*x^6+4a*x^5
         +(3a+4)x^4+a*x^3+(3a+3)x^2+(4a+2)x+(2a+1).

Let X be the smooth projective model of y^3=F(x). Let

    Y=Y_t: v^2=u(u-1)(u-2)(u-3)(u-t),

where [F_25(t):F_25] is a prime greater than120. Then g(X)=9, g(Y)=2,
and Y is ordinary. The degree condition avoids special small-field
parameters; it does not bound a covering degree.

Suppose there are actual finite ETALE maps f:Z->X and g:Z->Y from the
SAME smooth projective connected curve, with

    f^*k(X) intersect g^*k(Y)=k inside k(Z).

Neither leg is assumed Galois. Let L_X,L_Y be spin lines, with specified
isomorphisms L_i^2=omega_i, and fix a spin-compatible identification
L=f^*L_X=g^*L_Y on Z. The endpoint spins may be ineffective.

Define the twisted Cartier kernel

    K(C,A)=ker[H0(C,A^7)=H0(C,omega_C tensor A^5)
                   -> H0(C^(1),omega_(C^(1)) tensor A_1)],

where A_1 is the Frobenius twist and the map is relative Cartier.
Consider the actual linear intersection

    I=f^*K(X,L_X) intersect g^*K(Y,L_Y) in H0(Z,L^7).

Assume the following additional conditions on Z, which our reduction
allows without losing a hypothetical example:

1. L is globally generated, r=h0(Z,L)>=8, and its COMPLETE section
   ratios generate k(Z). Thus its complete map is birational onto its
   image. The image need not be smooth or projectively normal.
2. Write O_X,O_Y for the unique points at infinity, theta=dx/y^2 on X,
   and eta=du/v on Y. There are regular sections e_0,e_1,e_2,b of L with

       e_0^2=f^*theta,  e_1=(f^*x)e_0,
       e_2=(f^*x)^2 e_0,  b^2=g^*eta.

   Products use the given spin isomorphism L^2=omega_Z. In particular
   e_0 e_2=e_1^2, and e_0,e_1,e_2 are linearly independent.
3. There is another regular spin section c with

       (c/e_0)^2=f^*(A(x)+B(x)y),
       deg A<=5, deg B<=2, B!=0,

   where (A+By)theta has even zero divisor on X. This is a second
   effective endpoint spin, not another shared tensor. In particular
   x and (c/e_0)^2 already generate the embedded k(X).

**Target:** I contains no nonzero section whose zero divisor is reduced.

A negative answer must supply both actual projective etale maps and
the specified embedded-field intersection, with all the conditions above.
An isolated endpoint section, an abstract group quotient, or a ramified
map is not a counterexample.

For proving the target you may pass to the Galois closure over Y:
all the listed conditions persist, and g's Galois group then acts
projectively faithfully on H0(Z,L). The other leg is still not assumed
Galois. A simultaneous finite Galois closure is not available.

## Supplied results; no need to rederive them

For any curve C and spin A, the Cartier map above is onto and
dim K(C,A)=4(g(C)-1). Thus the endpoint spaces here have dimensions32
and4, and dim I<=4. This is not an enumeration of the unknown covers.

There is an exact sequence

    0 -> H0(C^(1),A_1) -> H0(C,A^5) --nabla--> K(C,A)
      -> H1(C^(1),A_1) -> 0.

The final boundary need not vanish. If both endpoint boundaries vanish,
regular primitives Q_X,Q_Y differ on Z by a fifth power of a spin
section. Corelessness requires its class modulo the two endpoint
spin-section spaces to be nonzero. In particular the source spin must
be effective. Do not replace rational exactness by a bounded primitive.

If a reduced nonzero h in I exists, the shared canonical tensor s=h^2
has weight7 and a reduced-double-zero divisor. For a coreless span the
intersection of the two pulled-back canonical rings is then k[s].
Hence there is no common canonical tensor of weight1,...,6, and the
weight7 common space has dimension one. Producing either a lower-weight
common tensor or a second independent weight7 tensor would suffice.

All nonzero-Cartier-eigenvalue regular forms on this fixed X have sixteen
simple zeros. On every allowed Y_t, eta and Cartier(eta) are independent.
The six double-zero differentials on Y_t are never Cartier eigenforms.

## Why the extra source structure is legitimate

We proved and independently audited a one-closure reduction. Choose an
effective spin A' on X different from O_X(8O_X); the odd-theta parity
count ensures existence. Its section square eta' satisfies
eta'/theta=A+By with B!=0. Otherwise even zero multiplicities would make
A a square polynomial and force A'=O_X(8O_X).

Trivialize the three differences of the original spins with O_X(8O_X),
A', and O_Y(O_Y): a common-source mu_2 refinement of degree at most8.
Take its Galois closure over Y. The complete spin space is base-point-free:
a nonzero fixed divisor would descend to Y and consume its whole spin
degree1. The section ratios now contain k(X), so the complete-series
quotient is intermediate in an actual ETALE cover of X and hence etale.
Riemann--Roch makes its image line genuinely spin. The eta probe and
Cartier(eta) recover k(Y); source spin effectivity removes the last
two-torsion ambiguity. Both maps and the original h descend. Further
alternating closures retain birationality and raise r to at least8.
No finite simultaneous Galois closure or joint minimality is asserted.

There is an even stronger audited ONE-LEG boundary test. For every
effective spin A on this same Y_t, its maximal abelian etale cover
T_n->Y_t with group (Z/5^n)^2 has genus5^(2n)+1 and exactly5^n spin
sections. Its complete spin series is base-point-free and BIRATIONAL.
Thus birationality plus arbitrarily many spin sections also occurs on
the genus-two side alone; neither supplies an exclusion without f.
No second leg to X is asserted for these covers.

Once a complete pulled-back spin series is birational, this remains true
after either normal-closure step: its section-ratio field is G-stable
and contains every conjugate of the preceding source field. Thus our
structured two-leg source may also start a tower with projectively
faithful alternating endpoint Galois actions. The section spaces still
grow, so there is no one finite-dimensional space stable under both groups.

Universal claims that exact differentials with uniform zero order force
a core have actual counterexamples. The full two-leg structure and the
particular endpoints here must do substantive work.

Please give a rigorous verdict. If undecided, isolate a new proved
constraint on this TWO-LEG intersection and the precise remaining step.
Keep conclusions separate from hypotheses and from computational evidence.
