# Proof: the entire ordinary140 coefficient coverage

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/WILD140_ORDINARY_FOUR_PAIR_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/wild140_ordinary_four_pair_reduction.md).

The [ordinary carrier theorem](canonical_wild_degree_140_ordinary_spin_reduction.md) gives a Weierstrass point P, exact poles7P,20P, seven simple F zeros and dG=cF³σ. Write F=A₃+yB₁, with B₁ linear and nonzero. Its PURE-ODD case A₃=0 is already excluded on BOTH endpoints by the actual characteristic-polynomial argument. Normalize B₁=w−b and write A=a₃w³+a₂w²+a₁w+a₀ in a monic quintic model with P at infinity.

For ANY monic quintic, the highest odd Cartier coefficient, the w¹⁹ coefficient of (A³+3AΦB₁²)Φ², is a₃³+3a₂+4qa₃−ba₃, where q is the fourth-degree quintic coefficient. If a₃=0 this is3a₂, forcing a₂=0. Thus exact degree two is impossible. Every cubic case is excluded at all six origins by the [ordinary cubic theorem](wild140_ordinary_cubic_even_part_exclusion.md). It remains to cover A=uw+v with (u,v)≠(0,0).

The reduced-fiber differential gate proved in the [fixed-origin ODE reduction](wild140_fixed_origin_cubic_ode_reduction.md) applies also when a₃=0: E=d(dF/σ)/(Fσ)∈L(5P). Its odd constant coefficient is then zero, as the coefficient of w⁶ in d(dF/σ)/σ=FE forces that coefficient to equal a₃. Therefore E=C₂ is a polynomial of degree at most two. For
\[
\Phi=w^5+qw^4+\lambda w+s,\quad q\ne0,
\quad A=uw+v,\quad B_1=w-b,
\]
the even and odd differential identities are
\[
(w-b)C_2=V',\qquad AC_2=\Phi'u/2,
\quad V=\Phi+\Phi'(w-b)/2.
\]
Comparing the odd coefficients gives
\[
C_2=q(2w^2+bw+b^2),\qquad qb^3=\lambda.
\]
The w² and w¹ coefficients of the even identity give
\[
ub+2v=0,\qquad ub^2+vb=0.
\]
Consequently v=2ub and3qub²=0. The [tiny symbolic source](../../scripts/genus_two/oct03_wild140_low_even_part_ode_identities.py) and [receipt](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/low_even_part_ode_receipt.json) verify these exact coefficients; no Gröbner calculation or endpoint enumeration is used.

At each FIXED origin, the projective F₅ transport from the fixed-origin theorem gives Φ=w⁵+qw⁴−w−q, hence λ=−1. Thus b≠0; the preceding identities force u=v=0, contradicting the actual pure-odd exclusion. This closes all five fixed-origin lower even parts generically and is stronger than the older BACKUP-only Cartier check.

At the MOVING origin the centered model has λ=0 and q,s≠0. Thus b=0 and then v=0. The non-pure-odd function necessarily has the shape F=w(y+u), u≠0. Rename u as v for the four-pair formula. The necessary same-completion equality follows from the retained original source and actual quotient β=G⁷/F²⁰, by the [weak local invariant](../quotient_geometry/weak_local_completed_extension_invariant.md).

The [accepted common-completion proof](wild140_exceptional_common_completion_refinement.md) is algebraic for arbitrary nonzero q,s,v,c. Its original statement was restricted to the BACKUP exceptional family, but NONE of its primitive, five-point conic or paired-point steps uses a finite-field endpoint value. Applying those displayed identities now to the universally forced shape proves v²=2s and exactly the four stated pairs. This broader application passed the current whole review; no endpoint-specific hypothesis was imported. The proof excludes v²=s by the seven-simple-zero requirement before its divisions.

Exact pole twenty requires C−3c/q≠0. Failure is equivalent to q⁵=4s. The [accepted moving-family theorem](../quotient_geometry/wild140_moving_coarse_map_family.md) already proves this value absent on MAIN by a degree-at-most20 polynomial and on BACKUP by its exact field comparison. Thus no displayed pair is lost at this pole check on the selected endpoints.

Every possible even-part degree and all six origins have now been covered under the ORDINARY carrier hypotheses. The four pairs are a remaining family of necessary data, and the accepted moving-family coarse construction confirms that their numerical and full local-completion constraints alone do not delete them. The original X map and global primitive carrier conditions remain required. Neither distinguished cone is covered.
