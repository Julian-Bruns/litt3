# Why the all-cover asymptotic slope theorem does not compute the etale invariant

Source review: /root/etale_asymptotic_line_slope_source_check,
2026-09-06. Verdict: the near-match does not apply, and the proposed
identification is numerically false. This is a boundary note, not a new
common-cover obstruction.

Let a_et(E) be the supremum of deg(L)/deg(f), over finite etale f:D->C
and line subbundles L of f^*E. For the exact-differential bundle B_C,
etale base change gives

    a_et(B_C)=(g(C)-1)*tau_et(C).

The invariant tau_et and its elementary bound are in
[file28](28_ETALE_STABLE_TANGO_INVARIANT.md). In characteristic five,

    a_et(B_C) <= (2/5)*(g(C)-1) < g(C)-1 <= L_max(B_C).

Here L_max(E)=lim_m p^(-m)*mu_max(F^(m)*E) is the strong-HN maximum.
The last inequality follows from L_max(E)>=mu(E) and mu(B_C)=g(C)-1.
Thus the standard all-finite-map invariant is strictly larger than the
etale invariant on every curve of genus at least two in this setting.

## Exact source boundary

* Parameswaran--Subramanian, [On the spectrum of asymptotic slopes,
  Section4, Theorems4.1 and4.3](https://repository.ias.ac.in/87688/1/5-a.pdf),
  allow ALL finite maps. Lemma3.4 and Remark4.2 construct the approximating
  complete-intersection covers to be genuinely ramified: they have no
  nontrivial etale intermediate cover. Taking their maximal etale factor
  therefore leaves only C, not an approximation in its etale tower.
* [Brenner, Section1 before Definition1.1 and Remark1.2](https://arxiv.org/pdf/math/0302230)
  records preservation of HN slopes under finite separable pullback.
  This controls maximal slopes over arbitrary ranks, not approximation
  by line subbundles on etale covers.
* [Langer, Theorem2.7](https://annals.math.princeton.edu/wp-content/uploads/annals-v159-n1-p04.pdf)
  obtains strongly semistable HN factors after Frobenius pullback. That
  reduction is inseparable and supplies no etale substitute.
* [Joshi](https://comptes-rendus.academie-sciences.fr/mathematique/item/10.1016/j.crma.2004.02.019.pdf)
  proves stability of B_C. Its slope bound gives only tau_et<=1, weaker
  than the retained Tango bound2/5.

The bounded primary-source review found no improvement of the etale
bound and no rank-one approximation theorem suitable for this tower.
Do not cite any of these results as computing tau_et.
