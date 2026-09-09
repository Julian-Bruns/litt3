# A finite-partner theorem for the active nilpotent branch

Please try to prove the precise finite-partner statement (AP) below, or disprove it with an actual infinite family. 

## Target (AP)

Work over k = algebraic closure of F5. Fix a in F25 with a^2+4a+2=0, and the smooth projective genus-nine curve X: y^3=F(x), where

F(x)=x^10+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3ax^6+4ax^5
 +(3a+4)x^4+ax^3+(3a+3)x^2+(4a+2)x+(2a+1).

For t in k with t^5-t != 0, let Y_t be the smooth projective ordinary genus-two curve

v^2=u(u-1)(u-2)(u-3)(u-t).

Fix ONE active, admissible, regular nilpotent projective connection r_X on X. Is the following set FINITE?

{t in k : there exist a smooth projective connected Z, actual finite ETALE maps
 f:Z->X and g:Z->Y_t, and a regular nilpotent projective connection r_t on Y_t,
 such that f^*r_X=g^*r_t and f^*k(X) intersect g^*k(Y_t)=k inside k(Z)}.   (AP)

Both maps must be everywhere etale from the SAME source, with their specified embeddings. Their degrees are unbounded and may be divisible by five. Neither map is assumed Galois. The quantifier fixes r_X BEFORE varying t and all spans.

Equivalently, prove that this set is contained in the roots of some nonzero polynomial E_(X,r_X)(T) in k[T]. An explicit degree bound would be excellent, but finiteness itself is the target. Do not replace it by finiteness at each fixed map degree, or by nonexistence for transcendental t: neither supplies a uniform finite exceptional set over k.

A theorem valid for every fixed active admissible pair (C,r_C), or for every ordinary genus-two partner, is welcome, but only the displayed X and family are required.

## Why this exact result helps

For this X, an independently audited theorem bounds EVERY representable finite etale atlas X->S to a smooth proper effective DM orbifold curve by 336000, including wild stabilizers and non-Galois atlases. Hence only finitely many genus-two curves can have a CORED common cover with X. This is supplied, not a task to reprove.

The regular nilpotent scheme on a fixed genus-g curve has finite length 5^(3g-3). Thus X has only finitely many r_X. A positive answer to (AP), followed by a finite union over those r_X, would let us choose t outside BOTH the cored partners and all active-nilpotent partners. This would eliminate an entire unbounded-degree branch without the large atlas calculation.

It would NOT solve Litt's problem: dormant matches and the possibility of no shared connection remain separate open branches. We are not asking you to prove that the given coreless span secretly has a core. Even proving existence of a different cored span would be stronger than necessary. Finiteness of endpoint partners is enough.

## Precise scalar conventions

A projective connection has equation z''=r z in a separating coordinate u and transforms as

r_w=(du/dw)^2 r_u - {u,w}/2,
{u,w}=u'''/u'-(3/2)(u''/u')^2.

Regular means regular in every local uniformizer, including infinity. Set E=r''-3r^2. Dormant means E=0. Nilpotent means

-(E')^2 - 3E(E''+3rE)=0.

Active means nilpotent but not dormant. Admissible means its p-curvature is nowhere zero, NOT the stronger deformation-theoretic ordinary-indigenous condition.

For active regular connections put s=E(du)^4/3. Then s is an intrinsic regular quartic, compatible with etale pullback. Admissibility is equivalent to div(s)=2D with D reduced. Conversely an active admissible connection is recovered from s=A(du)^4 by

r=3A''/A+(A'/A)^2.

Its normalized twisted Cartier identity is C_3(s^4)=s, where C_3 maps weight16 to weight4 and locally sends A(du)^16 to C_u(A)(du)^4, with C_u extracting the u^4 coefficient in the expansion over fifth powers.

Every active regular nilpotent connection on a genus-two curve is admissible. Thus in (AP), both endpoint quartics have reduced double-zero divisors, with deg D_X=32 and deg D_t=4; f^*D_X=g^*D_t.

For a genus-two model v^2=P(u), P monic squarefree of degree5, EVERY regular projective connection is

r=2(P'/P)^2-P''/P+(2u^3+c_2u^2+c_1u+c_0)/P.

Nilpotence is exactly the scalar determinant equation above. This gives the entire length125 scheme in three scalar parameters, not just a sample of candidates.

## Available structural reduction

For any active admissible (C,r,s), the line

L_s=O_C(D) tensor omega_C^(-2)

has order dividing two. Its canonical etale double torsor pi:C_s->C carries a quadratic q with q^2=pi^*s and simple zeros. On it,

pi^*r+q and pi^*r-q

are distinct regular DORMANT projective connections. The deck involution exchanges them. If L_s is trivial, the torsor is split; use its components, not a falsely connected double. Compatible active connections through two actual etale legs give compatible double torsors and dormant pairs on a common etale refinement. All these constructions are canonical and pullback-compatible.

Every connected double of Y_t has genus three; the dormant scheme of a genus-three curve has length15. The genus-two dormant scheme has length5. For the specified Y_t family its five dormant points are all distinct. This reducedness does NOT imply reducedness or ordinary-indigenous status after arbitrary etale pullback.

For a dormant pair with simple difference q on C, its further spectral double Sigma->C, defined locally by A^2=2q, is RAMIFIED at div(q). On Sigma there is a canonical nonzero Cartier-fixed one-form eta with div(eta)=2R, R the ramification divisor, and a corresponding norm-trivial line of exact order five on Sigma^(1). This is a mu_5 class, NOT an etale cyclic five-cover. This reduction retains actual upper etale legs but does not force the resulting Prym contribution to descend to the original Jacobians.

The specified J_X is absolutely simple of dimension nine, so Hom_k(J_X,J_(Y_t))=0. This does not by itself exclude shared Prym factors on auxiliary covers.

## Boundaries that matter

Coreless etale correspondences preserving such structures genuinely exist, for example in quaternionic/Igusa-Hecke settings. A self-correspondence, or infinitely many correspondences between fixed endpoints, does not disprove (AP): it asks for infinitely many DISTINCT t, equivalently infinitely many partner isomorphism classes since this family has uniformly finite isomorphism fibers.

Do not infer finite partner sets merely from finitely many connections on each individual curve. The missing uniformity is precisely in the changing curve and unbounded map degrees. A finite-field coefficient argument on an infinite tower of growing section spaces is also insufficient.

Do not use a simultaneous finite Galois closure, unproved common-connection existence, automatic ordinary pullback, or simultaneous characteristic-zero lifting. Actual coreless spans may acquire arbitrarily many spin sections under etale refinement. No one-leg Jacobian or formal-germ substitution for the two actual etale maps is allowed.

Please pursue a proof of (AP), rather than only counting the already finite endpoint connection schemes. If (AP) is false, construct an actual infinite set of distinct Y_t partners for ONE fixed (X,r_X); counterexamples only for another X should be explicitly separated from the stated target. If undecided, identify the sharpest proved finite-partner implication you obtain and the exact missing hypothesis; avoid returning only another necessary numerical condition on an arbitrary source. Cite precise hypotheses of any external theorem used.
