# One missing lemma: a proper theta divisor for the actual active tangent bundle

Please settle ONE bounded statement in characteristic five. This is
not a request to solve our common-cover problem, lift a correspondence,
or repeat the previous obstruction calculation.

Work over k=bar(F5). Let C be an ordinary-Jacobian smooth projective
genus-two curve, and r a regular admissible ACTIVE nilpotent projective
connection. Assume its canonical etale double is connected and its
fixed-curve nilpotent tangent space has dimension ONE.

The target is

    (*) There exists L in Pic^0(C^(1)) such that
        H^0(C^(1), E_r tensor L)=0,

for the ACTUAL bundle E_r defined below. Equivalently its generalized
theta locus is a proper divisor, not the whole Jacobian.

A proof for a larger class that includes these bundles is welcome.
A negative answer must give a curve and active r satisfying these
hypotheses, with the actual E_r having no theta divisor. A generic
rank-four base-point bundle not realized by this construction would
not disprove (*).

## Definitions and established inputs — do not reprove these

In a separating coordinate x use U''=rU and

    E(r)=r''-3r^2,
    N(r)=-(E')^2-3E(E''+3rE).

We have N(r)=0, E(r)!=0. Admissibility means the nonzero nilpotent
p-curvature is nowhere zero. Its quartic s=E(r)(dx)^4/3 has divisor
2D with D reduced of degree4. Let

    kappa=O_C(D) tensor omega_C^-2 in Pic(C)[2].

It is nontrivial by the connected-double hypothesis. The associated
connected etale double pi:C_s->C has tautological regular quadratic q,
q^2=pi^*s. Both d_+=pi^*r+q and d_-=pi^*r-q are dormant, meaning
d''-3d^2=0. Their deck involution exchanges them.

For a dormant connection d on a curve S, let V_d be the rank-two
Cartier descent on S^(1) of J^1(omega_S^2) with the scalar connection

    (v,v')'=(v',d v).

Equivalently V_d is the kernel of the O_(S^(1))-linear operator
F_*(v''-d v) on regular quadratics. Its global sections are EXACTLY
the dormant tangent vectors. Define

    E_r = pi^(1)_* V_(d_+).

Here are the relevant established bundle properties:

* E_r is stable of rank4 and degree4, so chi(E_r)=0; h^0(E_r)=1.
* V_d has determinant omega_(S^(1)). Its wedge pairing, followed by
  trace along the double, gives E_r a nondegenerate omega_(C^(1))-valued
  alternating pairing. In particular det(E_r)=omega_(C^(1))^2.
* E_r tensor kappa^(1) is isomorphic to E_r.
* Its Frobenius pullback is NOT semistable. More precisely, on C_s,

      pi^* F_C^* E_r = J^1(omega_(C_s)^2) direct-sum J^1(omega_(C_s)^2),

  and each summand has its exact jet sequence

      0 -> omega_(C_s)^3 -> J^1(omega_(C_s)^2)
        -> omega_(C_s)^2 -> 0.

  Thus E_r cannot be a strongly semistable bundle. The two summands
  have different dormant connections; the displayed isomorphism here
  concerns their underlying bundles, not an identification of those
  connections.
* The construction and tangent-space interpretation commute with
  every actual finite etale cover, retaining the canonical double.

For any bundle of Euler characteristic zero, determinant of cohomology
gives either an identically zero theta section, or a divisor numerically
rank(E_r)Theta=4Theta. Stability ALONE is not a properness argument in
rank4. Properness for nonordinary active E_r is precisely what is missing.

## Why (*) is useful, and what we already know

The previous explicit example has a NONZERO intrinsic W3 Hodge
obstruction. We have now independently proved and audited that ALL SIX
of its geometric unramified cyclic5 covers remove that obstruction;
their nilpotent tangent dimension is2, not0. A repaired source lift
cannot preserve the original map to the base. Do not recompute this
example or infer a simultaneous two-leg lift from it.

We also already have the general deck-module criterion: for a connected
Galois5-group cover of a corank-one pair, the nonzero W3 obstruction
survives exactly when the upstairs tangent dimension equals the full
cover degree. For a cyclic5 cover, this is the difference between
defect5 and defect<5. No new Witt calculation is required upstairs.

The theta divisor governs these same tangent defects via the actual
cover's character group scheme, including nonreduced mu5. We want to
understand the mechanism uniformly, not enumerate more examples.
A proof of (*) would remove the missing hypothesis from this theta
approach and from our existing general cyclic cover-selection theorem.
In our separate conditional argument, evenness and the nonzero
two-torsion translation symmetry bound the theta multiplicity at0 by4:
compare with the integral curve [2](Theta), of class4Theta and
multiplicity6 at0; an intersection contribution36 would exceed32.
The six mu5 tangent directions then provide at least two covers with
defect<5. You do not need to reprove this conditional argument; (*) is
the requested lemma. Properness must not be assumed in using it.
A counterexample would identify a genuine exceptional class requiring
different treatment. Neither outcome alone solves the common-cover
problem; both change the next mathematical step.

## A concrete possible route, with a characteristic warning

Pauly, "Rank four vector bundles without theta divisor over a curve of
genus two," arXiv:0804.3001, Theorem1.1 and Section2, describes precisely
the sixteen Raynaud base-point bundles:
https://arxiv.org/pdf/0804.3001

Hitching, "Rank four symplectic bundles without theta divisors over a
curve of genus two," treats the symplectic subcase:
https://arxiv.org/pdf/math/0604637

Both papers formulate their results over the COMPLEX numbers. Do not
quote them as characteristic-five theorems without justifying the
needed transfer or supplying a characteristic-five argument.

The classical Raynaud bundles split as sums of equal-degree lines
after an etale multiplication-by-two cover, so in characteristic5 they
are strongly semistable. Our E_r is not. This would exclude them if
the relevant no-theta classification is valid here. Extending only the
needed set-theoretic exclusion is enough: no moduli degree, scheme
reducedness, or complete classification is requested.

Please focus on (*) itself. If it remains open in your attempt, state
the precise unproved step; do not replace it with a catalogue of weaker
facts already included above. In particular ordinary Jacobian is NOT
ordinary indigenous connection: h^0(E_r)=1 is part of the hypotheses.
