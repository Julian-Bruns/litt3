# Proof: the tensor quotient exclusion settles the cored comparison

By [the comparison normal form](../../Theorems/cartier_and_spin/new_line_comparison_normal_form.md),
the two actual pullbacks of tau=A^16 theta^13 are proportional.
If the span has a core, the
[cored orbifold bridge](../../Theorems/quotient_geometry/cored_orbifold_bridge.md)
supplies an actual connected finite etale refinement W->T whose
maps to both copies of X are Galois. This use of the bridge requires
the nonconstant intersection; it is unavailable in the remaining case.

Let G_i=Gal(W/X_i) and G=<G_1,G_2> in Aut(W). The curve W is
hyperbolic, so G is finite. The common rational weight13 tensor
t=h_1^*tau, pulled further to W, is fixed by each G_i, hence by G:
proportionality by a constant is enough for the second invariance.
Invariant rational canonical tensors for a finite separable Galois
extension descend to its fixed field. Thus t is the pullback of a
rational weight13 tensor on the smooth coarse curve C=W/G.

Each X_i->C has geometric Galois closure dominated by W, which is
etale over X_i. Every intermediate cover of W->X_i is etale, so
the closure is etale over X_i as required. The
[completed uniform-quotient exclusion](../../Theorems/shared_tensors/new_line_uniform_quotients.md)
therefore forces deg(X_i/C)=1. Consequently both endpoint fields
equal k(W)^G, proving their equality in the original k(T).

If a common finite etale Galois refinement is already supplied,
the same argument applies without invoking the core theorem.
When both original maps are Galois, take W=T.
