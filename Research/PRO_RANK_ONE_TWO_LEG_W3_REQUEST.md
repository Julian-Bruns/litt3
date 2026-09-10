# A simple one-dimensional failure of simultaneous canonical lifting

Please decide ONE sharper case of the genuine two-leg lifting problem.
Both endpoints below are already indigenous-ordinary, so there is NO
one-endpoint obstruction. The common source has exactly ONE defect
direction, with no longer Frobenius-nilpotent chain. The question is
whether the two existing canonical-source
lifts can first separate in that direction modulo125.

This is deliberately more ambitious than the previous proper-theta
lemma, but still asks for only ONE Witt step, not all-level lifting,
partner finiteness, or the entire common-cover theorem.

## Setup and target

Let k=bar(F5), W=W(k), W_n=W/(5^n). Let X,Y,Z be smooth projective
connected curves, g(X)>=2, g(Y)=2, and J(Y) ordinary. Suppose there are
ACTUAL finite etale maps

                         X <-f- Z -g-> Y

with the specified embedded fields satisfying

    k(Z)=f*k(X) g*k(Y),       f*k(X) intersect g*k(Y)=k,
    Hom_k(J(X),J(Y))=0.

Thus the source is jointly minimal and the span is coreless. These are
the original maps, not an abstract common extension or a replacement
of either endpoint.

Suppose regular admissible ACTIVE nilpotent projective connections
r_X,r_Y satisfy f*r_X=g*r_Y=r_Z. Assume BOTH r_X and r_Y are ordinary
in the indigenous, fixed-curve nilpotent deformation sense, but

                       dim T_(r_Z) N(Z)=1.                 (D1)

Make the additional SIMPLE-ZERO hypothesis

                 rank(Psi_Z^2)=rank(Psi_Z),                 (SZ)

where Psi_Z is defined below and powers are SEMILINEAR compositions,
not powers of a coefficient matrix without its Frobenius twists.
Equivalently, V_Z=ker(Psi_Z) direct-sum im(Psi_Z), with Psi_Z bijective
on the second summand. This is still NONordinary: its kernel is a line.

Here N(C) is the scheme of regular nilpotent projective connections on
the FIXED curve C. This is not a curve-deformation tangent space and
not Jacobian ordinariness.

Let X^can/W,Y^can/W be the canonical ordinary lifts of the two pairs.
Their canonical W2 reductions and the original maps have a specified
simultaneous marked lift. Separately lift the ORIGINAL covers f,g to
the two full canonical endpoints, obtaining

    Z_f^can -> X^can,             Z_g^can -> Y^can.

These two full W-curves EXIST individually. They are marked by the
same Z modulo5 and already identified modulo25. Their pulled-back
filtered/projective maximal-Higgs structures also exist individually;
no simultaneous identification of the two full sources is assumed.

TARGET (R1): Must the specified identification of the sources modulo25
extend to an isomorphism

                   Z_f^can modulo125 = Z_g^can modulo125?

Equivalently, must the original two-map diagram lift to W3 in this
simple-one-defect-direction case? Either prove (R1), or construct an ACTUAL
span satisfying all the hypotheses for which it fails. It is enough
to prove a stronger statement without some of these hypotheses.

## Scalar conventions

In a separating coordinate x use U''=rU, with transformation law
r_x=(du/dx)^2 r_u - {u,x}/2. In characteristic5 put

    E(r)=r''-3r^2,
    N(r)=-(E')^2-3E(E''+3rE).

Nilpotent means N(r)=0; active means E(r)(dx)^4 is nonzero; admissible
means its divisor is2D with D reduced, or equivalently nonzero
nilpotent p-curvature is nowhere zero. Regularity is on the entire
projective curve. Let V_C=H1(C,T_C).

Use Psi_C:V_C->V_C for the Frobenius-semilinear higher-Hodge variation
map, with the relative-Frobenius twists retained. Its dual is the
infinitesimal Verschiebung. Thus ordinariness means Psi_C is bijective,
and (D1) means ker Psi_Z and coker Psi_Z both have dimension1.
Concretely, writing s_C=E(r_C)(dx)^4/3, its kernel/image structure is
that of Frobenius followed by multiplication by s_C on H1(T_C).
Its Serre-dual operator is twisted Cartier phi->C_1(s_C phi), up to
the harmless nonzero scalar/sign fixed by the Hodge convention. The
scalar does not change(SZ), the kernel, image, or their annihilators.

## Strong established inputs: use them, do not reprove them

1. The normalized Frobenius-lifting extension attached to an active
   admissible connection gives its canonical marked W2 curve lift,
   functorially for ALL finite etale maps. The actual flat bundles,
   Hodge lines, graded identifications and square-trivial previous-flow
   twists match under both maps. Inverse Witt-Frobenius transport is
   included; coefficients are not silently Frobenius-fixed.

2. For this coreless genus-two-endpoint W2-liftable span,

       A=f*V_X, B=g*V_Y have A intersect B=0 in V_Z.

   The full marked joint deformation ring is W/(5^e), e>=2 or infinity.
   Every EXISTING W_N diagram must use BOTH ordinary canonical
   endpoints and therefore the two original covers lifted to them.
   The original Hodge/filtered data match one level below it. These
   are necessity statements, not an assertion that e>=3.

3. For a marked W3 lift C_3 of the canonical C_2, the obstruction to
   lifting the ORIGINAL Hodge line in higher inverse Cartier is
   rho_C(C_3) in V_C. It satisfies

       rho_C(C_3+xi)=rho_C(C_3)-Psi_C(xi).

   It is natural under the actual lifted etale maps. On either
   canonical ordinary endpoint rho=0, so BOTH individually constructed
   source lifts above have rho_Z=0. Therefore their ACTUAL difference

       delta=[Z_g^can modulo125]-[Z_f^can modulo125] in V_Z

   lies in ker Psi_Z, a line. Since Psi_X and Psi_Y are bijective and
   A intersect B=0, this line meets A+B only in0. Consequently

       o_3=[delta] in Q=V_Z/(A+B),
       (R1) iff delta=0 iff o_3=0.                         (1)

   All of this is already known. Replacing the problem by (1), by a
   Frobenius-kernel statement, or by stable-image containment is NOT
   new progress. Once delta is in a Frobenius kernel, its containment
   in the stable image is equivalent to its vanishing.

   Hypothesis(SZ) now supplies an EXACT one-scalar test. Choose nonzero
   phi in the one-dimensional annihilator of im(Psi_Z) inside
   H0(Z,omega_Z^2), using Serre duality and retaining Frobenius twists.
   Then the pairing with phi is nondegenerate on ker(Psi_Z), so

                  (R1) iff <delta,phi>=0.                  (2)

   Moreover f_*phi=g_*phi=0, since A+B lies in im(Psi_Z). Those trace
   zeroes and the equivalence(2) are supplied linear algebra, not the
   requested geometric vanishing of this ACTUAL mismatch scalar.

   To COMPUTE (2) one may use ANY next endpoint curve lifts above the
   fixed canonical W2 endpoints, rather than calculate their canonical
   W3 corrections: changing these choices adds an element of A+B to
   the source difference, which phi annihilates. The original maps
   and their common marked W2 lift must still be retained. This does
   not assert that a difference of two affine lift torsors lies in A+B.

4. If r_Z were ordinary, the standard ordinary canonical-lifting
   compatibility theorem would already give a full W-lift. Its stated
   hypothesis is ordinariness of the UPPER bundle; it cannot be invoked
   here. Ordinary connections can become nonordinary under an actual
   etale cover: on a high-degree genus-two family some ordinary active
   connections have etale DOUBLE covers of source defect exactly1.
   Those are one-leg examples, not coreless witnesses satisfying this
   question. They even satisfy(SZ). One explicit block certificate is:
   for Y:v²=G(u)(u-t), G=u(u-1)(u-2)(u-3), take normalized active
   quartic s=(t+1)²G(u)(du/v)^4 and the etale double w²=u(u-3),
   with parameter degree>828. The parent connection is ordinary.
   On its anti-invariant quadratic space the twisted Cartier map has
   an invertible2x2 block and one zero scalar block; the determinant
   before coefficient fifth roots is(t+3)(t+4)(t+1)^4. The invariant
   parent block is invertible as well. Thus the actual source Psi has
   a bijective five-dimensional summand and a zero line. It has a full
   canonical-endpoint pullback lift. Neither(D1) nor(SZ) alone forbids it.

5. Any connected finite etale refinement of the common source,
   retaining BOTH original legs, preserves the ENTIRE joint deformation
   functor. A nonzero delta cannot be repaired that way. Negative H1
   pullback is injective in every degree. Do not divide by a leg degree
   without proving it prime to5; no presumed finite simultaneous Galois
   closure is allowed.

   In fact, in the selected Galois one-defect branch of Input7, there
   are genuine common cyclic5^n refinements with fixed defect ell=2 or4
   on which a HYPOTHETICAL nonzero delta remains nonzero but lies in
   im(Psi^j) exactly for j<=floor((5^n-1)/ell). This all-degree statement
   is already proved and scoped-audited. Fixed-depth image or residue
   tests after refinement can therefore hide an obstruction; they
   cannot establish(R1) on the original minimal source.

6. The preceding Pro theorem is now proved and independently audited:
   EVERY actual active tangent bundle E_r on a genus-two curve has a
   proper theta divisor. In every genus E_r is omega-symplectic,
   H0(E_r)=T_r N(C), and it commutes with actual etale pullback.
   It is the pushforward of the dormant jet-descent tangent bundle
   along the canonical double; both summands are retained if split.
   Do not redo the no-theta classification. Its genus-two properness
   conclusion does NOT automatically apply to the higher-genus Z.

   We also have genuine examples of nonzero ONE-endpoint epsilon in
   coker Psi, and of p-covers killing it while losing the original map.
   They cannot answer this question: BOTH endpoint cokernels here are0.
   The specific genus-two/F625 example with nonzero epsilon also FAILS
   (SZ): its exact semilinear ranks are rank(Psi)=2, rank(Psi²)=1,
   rank(Psi³)=1. A single kernel direction need not be a simple zero.
   Hypothesis(SZ) deliberately removes this extra complication.

7. The following additional reductions explain why this is a meaningful
   first stratum, not an arbitrary small matrix problem. For any
   omega-symplectic bundle with an ODD number of sections, a nontrivial
   p-group-Galois-closure cover strictly increases that number: on the
   first two-dimensional unipotent layer the cup form is alternating,
   hence singular in odd dimension. Thus a source with exactly one
   section has prime-to-p DECK group (not necessarily monodromy).
   If its Galois endpoint has zero sections, the unique source section
   has a nontrivial quadratic character: reciprocal characters have
   equal h0 by Serre duality/RR and must coincide. It therefore comes
   from a bad etale double of that endpoint.

   For our high-degree family in Input4, the complete twist table says
   there are exactly ten such bad doubles, two for each of five active
   connections; all have the block shape described there. Any further
   section-preserving Galois cover is prime to5. Its trace projector
   splits off this simple-zero block, with a bijective complement.
   Therefore(SZ) is AUTOMATIC for every Galois Y-leg of source defect1.

   In a coreless matched active span with a Galois Y-leg, a nonordinary
   X must contribute STRICTLY fewer defect sections than the source.
   Indeed, equality makes the source Cartier-kernel quadratics all come
   from X. Their products divided by s_Z span a Galois-stable subspace
   of k(X); finite orbit polynomials have coefficients in k(X) intersect
   k(Y)=k. Hence every phi²/s_Z is constant. Rescaling phi²=s_Z gives
   C_1(s_Z phi)=phi from C_3(s_Z^4)=s_Z, contradicting its kernel property.
   Thus defect1 also forces r_X ordinary in this Galois branch.

   So the target retains the ENTIRE Galois Y-leg one-defect branch of
   the selected family. It still allows non-Galois legs satisfying(SZ).
   None of these reductions has evaluated <delta,phi>; do not substitute
   them for the requested mixed vanishing.

## What is genuinely new here

The previous unrestricted W3 attempt allowed a nonordinary X and an
arbitrarily large source defect. Its endpoint connecting obstruction
could be nonzero; that mechanism has now been computed and understood.
Here that mechanism is removed completely. There is only a single
SIMPLE genuinely mixed direction, and both candidate source lifts
already extend INDIVIDUALLY to full W with their pulled-back canonical
filtered data. Any proof must exploit more than the linearized
variation equation, which only leaves the line in (1).

A positive answer rules out exact Witt height2 in this simple-zero
two-leg stratum. We would then investigate whether its mechanism
iterates or constrains larger source defects; no all-level conclusion
is assumed. A counterexample would show that even ordinary endpoints
and a SINGLE new source direction can obstruct actual diagram lifting,
forcing us to abandon that vanishing shortcut in the global strategy.
It need not be a counterexample for our particular fixed main pair.

For a negative answer, verify actual projectivity, both everywhere-
etale maps, the specified coreless field intersection, Hom-zero, the
connection match, the two endpoint ordinariness statements, source
defect1 AND(SZ), and the nonzero ACTUAL delta. An abstract W/(25) deformation
ring, unrelated curve lifts, or a one-leg bad double does not suffice.

Please give a verdict on (R1). If neither verdict is reached, state the
precise genuinely additional implication still needed, without a
catalogue of weaker reductions or repeating the already supplied
   kernel/stable-image reformulation.

Relevant primary constructions: Mochizuki, A Theory of Ordinary
p-adic Curves, II Sections1--3 and III canonical lifting/etale
compatibility; Lan--Sheng--Yang--Zuo, arXiv:1404.0538, Section5, for
the full higher inverse-Cartier construction including previous-flow
twists and Taylor/jet gluing. The inputs above record their already
checked application here, not a request to re-audit them.
