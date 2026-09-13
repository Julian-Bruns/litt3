# Uniform descent and exact obstructions for cyclic powers of five

Version2, 2026-09-13. Proved by the consolidated comparison and the
independently audited norm/absorption mechanism. The strengthening has
bounded independent audit PASS; audited prose is not Lean verification.

Let k=bar(F5), a>=1, q=5^a, and let h:T→C be an actual connected
finite etale cyclic-q cover of smooth projective curves, g(C)>=2.
Retain an active admissible projective connection on C, its full
weight-one maximal-Higgs periodic filtered tuple, prescribed projective
graded identification and actual flat square-trivial periodicity line.
Upper special-fiber data are the original pullbacks. Compatibility of
a W_j curve means extension of this specified tuple through W_(j-1),
with its markings.

Assume Psi_C has a bijective part of dimension 3g(C)-4 and one zero
line, and dim ker Psi_T=2. These actual-cover hypotheses give normalized
nil source/target coordinates, with e=sigma-1 and coefficient Frobenius
Phi fixing e:

    R=k[e]/e^q,  Psi_nil=e²Phi,
    ker Psi_T=e^(q-2)R,  D_T=coker Psi_T=R/e²,
    h*(ker Psi_C)=k e^(q-1).

1. **Finite descent.** For every n>=2, let a compatible C_n and its
   original marked cover h_n:T_n→C_n be given, with the specified
   tuple on T_n pulled back from C_n through W_(n-1). At n=2 assume a given
   compatible C3^0 extending C2, with its original cover and full tuple;
   at n>=3 no additional compatible reference is required. If the given
   T_n has a compatible W_(n+a+1) extension, its given W_(n+1)
   truncation descends along the original map to a compatible C_(n+1)
   extending C_n. All specified upper tuple data are its pullbacks.

2. **Exact obstruction with a compatible next reference.** For any
   a>=1,n>=2, suppose a compatible C_(n+1)^0 extending C_n is given.
   Relative to its original cover, write a compatible next upper lift as

       T_(n+1)(d,b)=T_(n+1)^0+d e^(q-2)+b e^(q-1).

   Every such lift has compatible extensions through T_(n+a). For
   every choice of those intervening compatible repairs, the obstruction
   to T_(n+a+1) is exactly

       Theta_n(d,b)=d^5 e in D_T,

   with orientation rho(S+xi)=rho(S)-Psi(xi). The class is independent
   of smooth terminal digits and has one coefficient Frobenius. Thus
   each partial extension admits a compatible final extension iff d=0.
   At a=1 the intervening range is empty. At n=2 only C3^0 is needed,
   for every a. When d=0 the given T_(n+1) is the original cover of
   C_(n+1)^0+b e_C, where h*e_C=e^(q-1).

3. **Later obstructions without a compatible next reference.** For
   every a>=1,n>=3, retain the given compatible C_n, original h_n and
   pulled-back tuple of Part1. Use the invariant ordinary-repaired smooth lower
   reference of the proof, and let eta0 be its zero-line obstruction.
   A compatible next upper lift has leading difference

       c e^(q-3)+d e^(q-2)+b e^(q-1),  c^5=eta0.

   It has compatible extensions through T_(n+a). For every such
   partial extension, the obstruction to T_(n+a+1) is exactly

       Theta=eta0+(2eta0+d^5)e.

   It is independent of all intervening repairs and terminal digits.
   Thus the final extension exists iff eta0=d=0. Relative obstruction
   differences are (d_2-d_1)^5e. In particular this retains the
   degree-five transfer for two arbitrary compatible next lifts,
   neither required to descend: their next-obstruction difference is
   (d_2-d_1)^5e, and each constant coefficient is eta0.

4. **Full towers.** Every given full compatible upper Witt tower with
   the original W2 marking and a compatible initial C3^0 descends
   uniquely along h. The curves, maps, deck action and full specified
   tuple algebraize over W(k). No descent of the longest finite lift
   at its top precision is asserted in Part1.

The proof includes the explicit genus3/genus51 cyclic25 family on
Delta(t)=(t^5-t)(t²+2t+3)(t²+2t+4)!=0. The earlier small-power
common-cover applications are contained in
[the all-power matched two-defect exclusion](../section_growth/two_defect_nontrivial_five_exclusion.md),
which retains both actual etale maps from the same source. The unmarked
common-cover problem remains UNSOLVED: an initial reference and a given
compatible upper tower are not automatic on an arbitrary common cover.

[Proof](../../../Proofs/deformations/cyclic_descent/cyclic_power_descent.md) ·
[Consolidation audit](../../../Research/audits/CYCLIC_UNIFICATION_SCOPE_AUDIT_2026_09_13.md) ·
[Unrestricted-norm audit](../../../Research/audits/CYCLIC_UNRESTRICTED_NORM_AUDIT_2026_09_13.md).
