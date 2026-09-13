# Proof and scope of the sharp dihedral heights

[Statement](../../Theorems/deformations/neutral_dihedral_sharp_height.md).
Version2,2026-09-11. The selected closure consequence below is now
independently audited; it was explicitly outside Version1's scope.

The original base has H(C)=2 by explicit_genus_two_witt_obstruction.
The selected genus-six source has compatible third lifts, and
neutral_five_fourth_obstruction excludes a fourth lift for every one
of them. Thus H(T_1)=3. Substitution in the independently established
finite-height translation gives

    H(T_a)=H(T_1)+a-1=a+2,       a>=1.

The genus and defect formulas are those of neutral_dihedral_towers.
In particular, each fixed T_a has a finite maximum compatible Witt
length. A full compatible tower would exceed this maximum, which is
impossible. Varying a proves the absence of a uniform finite-height
bound for defect one in this actual family; it does not produce a full
tower on any fixed source.

For the original cyclic-five closure W_1→D, d(D)=1 and d(W_1)=2;
the actual Smith factors are five units and e². Apply
[cyclic_five_secondary_trace](cyclic_five_secondary_trace.md).
It proves constancy of epsilon_W(S3) in O_W/eO_W on EVERY compatible
marked third lift of the original W2, regardless of whether reflection
lifts to S3.

Choose one reference S3 by pulling back a compatible T_1,3 along the
original etale double W_1→T_1. Pullback on obstruction cokernels is
injective, since ordinary trace composed with pullback is2 and is
compatible with Psi. Its nonzero fourth obstruction is reflection-
positive. The cyclic coinvariant O_W/eO_W is O_D by actual norm
specialization. Since D→C is prime-to-five and defect-neutral, O_D is
pulled back from C, with trivial reflection. Reflection inverts the
cyclic generator, so it acts by -1 on eO_W and by +1 on its quotient.
As two is invertible, the positive line maps isomorphically onto the
coinvariant. The reference has nonzero coinvariant, and constancy
therefore excludes W4 for ALL other compatible third lifts as well.
Thus H(W_1)=3.

Each specified W_a→W_(a-1), a≥2, is cyclic-five and defect-neutral.
Its obstruction pullback is zero, giving one extra possible repaired
digit; neutral_galois_witt_descent with one extra digit gives the
opposite bound for every upper repair. Consequently H(W_a)=a+2.
The reflection is used only to evaluate a reference coinvariant; no
action on an arbitrary repaired source is inferred.

This proof replaces the former unregistered closure-residue candidate.
The [focused audit](../../Research/audits/CYCLIC5_FOURTH_LIFT_AUDIT_2026_09_11.md)
checks the general constancy mechanism and this selected corollary.
It does not promote the other thirteen numerical W4 comparisons to
family-wide audited theorems.
