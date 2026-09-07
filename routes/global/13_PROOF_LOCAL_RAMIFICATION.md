# Local ramification results

Status: author proved-text. All actions are faithful on k[[z]],
k=Fbar_5. For σ≠1 put j(σ)=v_z(σ(z)−z)−1, and for a finite
5-group P put P_i={σ:j(σ)≥i} and ε(P)=∑_(i≥1)(|P_i|−1).
A lower break b means P_b≠P_(b+1).

## LEM-WILD-EXCESS-IDENTITY — wild excess as a sum of breaks

    ε(P)=∑_(σ≠1)j(σ),
    ε(P)−(|P|−1)=∑_(σ≠1)(j(σ)−1).

Indeed σ contributes to |P_i|−1 exactly for1≤i≤j(σ).

## THM-LOCAL-SWAN-DIVISIBILITY — divisibility at the first break

If P=P_1=⋯=P_b and q=dim_F5(P/P_(b+1)), then

    5^ceil(q/2) | ε(P)−b(|P|−1).                            (1)

In particular b=1 gives divisibility of ε(P)−(|P|−1).
The quotient A=P/P_(b+1) is elementary abelian. For complex
representations use the integral additive Swan conductor

    Sw(V)=∑_(i≥1)(|P_i|/|P|) codim V^(P_i).

The regular representation has Sw(C[P])=ε(P). Decomposing it gives

    ε(P)−b(|P|−1)
      =∑_(χ≠1)(dimχ)(Sw(χ)−b dimχ).                         (2)

Characters factoring through A are one-dimensional of conductor b,
so contribute zero. Group the other irreducibles into twisting orbits
under A^∨. Their Swan conductors are constant on each orbit: the
restrictions to P_i for i>b agree, and for i≤b none has a P-fixed vector.

If dimχ=5^a and its twisting stabilizer has order5^s, then s≤2a.
For each stabilizing character, an intertwiner χ→χ⊗λ lies in its
distinct character eigenspace of End(χ); these independent vectors
give5^s≤(dimχ)². The orbit's contribution to (2) is

    5^(q−s+a)(Sw(χ)−b5^a).

The last factor is integral. If a≥ceil(q/2), divisibility follows
already from dimχ; otherwise q−s+a≥q−a≥ceil(q/2).
Summing proves (1).

The inputs are precisely Swan integrality/additivity and its displayed
filtration formula, the regular-character decomposition, p-power
irreducible degrees for p-groups, and elementary-abelian ramification
quotients. The proof works with any prime p in place of5.
It bounds a sum of breaks; it does not prescribe individual breaks
or realize a formal filtration.

## LEM-TAME-CHARACTER-GRADED — the tame action on a lower quotient

Let I=P⋊C_T with5∤T. Linearize a tame generator as z↦ζz,
ζ primitive of order T. For a nonzero P_b/P_(b+1), put its
F_5-dimension q_b. Then

    ord_(T/gcd(T,b))(5) | q_b,
    equivalently T | b(5^q_b−1).                            (3)

The order modulo1 is1. Indeed σ(z)=z+a z^(b+1)+⋯ gives

    τστ^(-1)(z)=z+aζ^(-b)z^(b+1)+⋯.

Leading coefficients embed P_b/P_(b+1) as an additive F_5-subspace
stable under ζ^b, hence a vector space over F_5(ζ^b). Its extension
degree is precisely the multiplicative order in (3).
The sign convention for conjugation changes none of these conclusions.

## LEM-LEADING-COMMUTATOR — exact lower-break commutator

If σ,τ have exact breaks r,s and leading coefficients a,c, and5∤s−r,
their commutator has exact break r+s. Direct substitution gives first
nonzero term(s−r)ac z^(r+s+1), up to commutator convention.
Thus P_(r+s)/P_(r+s+1)≠0.

This excludes a proposed filtration with breaks r,s but none at r+s.
A blanket common-residue rule still requires a maximal-break or
vanishing argument; it is not contained in this calculation alone.

## LEM-SUMMATION-BY-PARTS-TAME — tame divisibility of the excess

For lower breaks b_1<⋯<b_r, put
q_i=dim_F5(P_(b_i)/P_(b_i+1)) and d_i=∑_(j>i)q_j. Counting exact breaks,

    ε(P)=∑_i b_i(|P_(b_i)|−|P_(b_i+1)|)
        =∑_i b_i 5^d_i(5^q_i−1).

Each summand is divisible by T by (3), so T|ε(P).

These necessary local lemmas do not validate the historical global
exclusions in [file11](11_PROOF_OVER_ORBIFOLD_CLASSIFICATION.md).
In particular that file's missing arithmetic table and cited
COMP-LOCAL-ARITHMETIC-CHECKS/ALG-LOCAL-SEARCH sources are not supplied
by the commutator lemma. Use canonical atlas theorems for their
separately proved degree bounds.
