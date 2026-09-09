# Can an actual matched active span stop at the first Witt lift?

Please decide ONE lifting step, from W2 to W3, in the setup below.
This is deliberately narrower than finite-partner finiteness, replacement
by an ordinary witness, or lifting to all Witt levels. The first lift and
rigidity are established inputs, not conclusions to reprove.

## Precise setup and target

Let k=algebraic closure of F5 and W_n=W(k)/(5^n). Let

    Y=Y_t: v^2=u(u-1)(u-2)(u-3)(u-t),
    [F5(t):F5]>11.

Let X be a smooth projective connected curve of genus at least two.
Suppose we have ACTUAL finite etale maps from the SAME smooth projective
connected source

                  X <-f- Z -g-> Y,

such that the specified endpoint fields satisfy

    f*k(X) intersect g*k(Y)=k inside k(Z),
    Hom_k(J_X,J_Y)=0.

Suppose there are regular admissible ACTIVE nilpotent projective
connections r_X,r_Y with

                     f*r_X=g*r_Y=r_Z.

Use the canonical simultaneous marked W2-lift of this diagram supplied
by Input1 below. Is there necessarily a simultaneous marked W3-lift,
with both maps finite etale, reducing to this W2 diagram?

Equivalently, prove that the exact joint deformation ring CANNOT be

                           W(k)/(25),

or construct an actual span satisfying the displayed hypotheses whose
joint ring IS W(k)/(25).

The curves and maps must lift; the question does NOT require the given
connections themselves to lift as nilpotent connections over W3.
Neither endpoint is prescribed a particular full W(k)-lift. Their
W3 lifts may vary, subject to their fixed W2 reductions.

## Conventions for the connections

In a separating coordinate x a projective connection is represented by
r in the equation U''=rU, with transformation law

    r_x=(du/dx)^2 r_u - (1/2){u,x}.

Put E=r''-3r^2 and

    N=-(E')^2-3E(E''+3rE).

Nilpotent means N=0. Active means the global quartic differential
E(dx)^4 is nonzero. Admissible means its divisor is2D for a REDUCED
effective divisor D. These are the usual admissible nilpotent indigenous
bundles in the scalar characteristic-five convention. All connections
are regular on the complete curves.

Ordinary for such a connection means zero tangent space in the scheme
of regular nilpotent connections on its FIXED underlying curve. It is
not Jacobian ordinariness and not merely reducedness of a dormant point.

## Established inputs — use without reproving

1. **The actual first lift exists.** Normalized Frobenius-lifting (FL)
   extensions of F_C*T_(C^(1)) by O identify with marked W2 lifts of
   C^(1). An admissible active connection supplies one such normalized
   class, functorially for ALL finite etale maps. Therefore equality
   f*r_X=g*r_Y gives equal marked W2 source lifts. Untwisting by inverse
   Witt Frobenius gives the displayed W2 lift of the original span.
   No common-source ordinariness or degree restriction is needed.

   Primary source for the one-step dictionary: Mochizuki,
   *A Theory of Ordinary p-adic Curves*, II Propositions1.1--1.2 and2.5:
   https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf
   This dictionary stops at W2; its iteration is not an input.

2. **The whole marked span is already rigid.** For EVERY coreless
   bi-etale span with a genus-two endpoint that lifts to W2, we proved

       f*H1(X,T_X) intersect g*H1(Y,T_Y)=0 in H1(Z,T_Z).

   Consequently its prorepresenting marked deformation ring is
   R=W(k)/(5^e), with e>=2 or e=infinity (the zero ideal).
   There is at most one marked diagram at each Witt length. The target
   is precisely to rule out e=2, not to prove e=infinity.

3. **Refining cannot repair a failure.** For any fixed connected finite
   etale h:Z'->Z, replacing BOTH maps by fh,gh preserves the entire
   marked deformation functor over every Artinian W(k)-algebra, and
   hence preserves e. No presumed finite simultaneous Galois closure
   is available for a coreless span.

4. **Both endpoint ordinariness facts on Y are available.** The displayed
   Y has ordinary Jacobian. It has exactly85 active regular nilpotent
   connections, all indigenous-ordinary:10 with split canonical double
   and75 with nonsplit double. Thus the chosen r_Y is ordinary. It has
   five dormant connections, all reduced; every connected etale double
   has15 dormant connections, all reduced. These are input facts for
   degree(t)>11, not a new computation requested here.

   NONE of these asserts that r_Z is ordinary. If r_Z is ordinary,
   the known canonical-lifting compatibility theorem already lifts the
   whole span to W(k). Therefore the ONLY case requiring work here is
   a nonordinary r_Z. A nonzero source defect persists after etale
   refinement. Do not reprove the ordinary-source case or replace this
   question by finding a different ordinary witness.

5. **The first lift retains actual pointed FL data.** It gives matching
   nonsplit bundles with their ORIGINAL connections

       0->O_i --e_i--> E_i ->omega_i^5->0,

   with everywhere nonzero nilpotent p-curvature and kernel O_i e_i.
   In this active case E_i is unstable, its maximal line has degree
   6(g(C_i)-1), its second fundamental map is an isomorphism, and its
   projection to omega_i^5 has a reduced divisor of degree4(g(C_i)-1).
   The induced oper is precisely the given intrinsic active connection.
   These pointed bundles, connections and lines match under BOTH maps.
   A bare rank-two bundle with the same degrees is not a substitute.

## The exact obstruction to be decided

Fix the unique W2 diagram. Choose arbitrary W3 lifts X_3,Y_3 of its
endpoints. Lift the original finite etale covers uniquely to them;
write Z_(f,3),Z_(g,3) for the two resulting marked lifts of the SAME Z_2.
Their difference lies in H1(Z,T_Z), using 25W3=k. Its class

    o_3(f,g)=[Z_(g,3)-Z_(f,3)]
       in H1(Z,T_Z)/(f*H1(X,T_X)+g*H1(Y,T_Y))

is independent of the chosen endpoint W3 lifts. The desired W3 diagram
exists exactly when o_3(f,g)=0. This exact obstruction formula is also
an input. A reformulation of o_3 without a new vanishing argument or an
actual nonzero example is not the requested result.

The target concerns the original embedded fields and maps. Abstract
rings W/(25), formal local germs, or pairs of unrelated endpoint lifts
do not give counterexamples. Separate smooth-curve liftability does not
make this two-source matching obstruction vanish. Hom(J_X,J_Y)=0 kills
the degree-one correspondence map, not arbitrary quadratic cross traces.

## Requested answer and why it matters

Give either a proof of o_3=0 under the stated hypotheses, or a rigorous
construction of an actual coreless span with o_3!=0, verifying its
projectivity, BOTH everywhere-etale maps, connection match and Hom-zero
condition. A construction by a proved nonempty algebraic locus is
acceptable; an abstract deformation-ring possibility is not.

A positive answer removes the first unknown higher Witt level in the
active branch for BOTH our main and backup choices. It would motivate
studying whether the proof has a higher-level analogue, but would not
by itself prove full lifting or solve the common-cover problem.
A counterexample would show that even this one-step iteration is false;
we would stop treating first-lift rigidity as a route to automatic higher
lifts and concentrate on global characteristic-five exclusions. Such a
counterexample need not disprove our particular fixed-pair conjecture.

Do not return a catalogue of weaker known reductions. If neither verdict
can be obtained, identify the one additional mathematical implication
your attempt needs, briefly, without reproving the five supplied inputs.
