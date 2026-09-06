# Etale roots give a linear-in-weight contact bound

In characteristic five, let X <-f- Z -g-> Y be a jointly minimal finite
etale span of smooth projective connected curves of genus at least two.
Let s_X,s_Y be regular nonzero weight-d tensors with 5 not dividing d,
equal actual differential pullbacks, and div(s_X)=dD_X, div(s_Y)=dD_Y
with D_X,D_Y reduced. If hX,hY are the orders of omega_X(-D_X) and
omega_Y(-D_Y), then hX,hY divide d and

    deg(g) <= 20 lcm(hX,hY)(g(X)-1) <= 20d(g(X)-1),
    deg(f) <= 20 lcm(hX,hY)(g(Y)-1) <= 20d(g(Y)-1).

The identical root construction in characteristic p>=5, p not dividing d,
replaces 20 by 4p/(p-4), using the general contact bound. No Galois,
corelessness, or Jacobian hypothesis is imposed. These are bounds for
the specified tensor-preserving spans, not all unmarked covers.

Evidence: PASS, `/root/contact_root_extension_audit`, 2026-09-06
(characteristic-five source; general constant comes from contact theorem).
[Proof](../Solutions/Sol_etale_root_contact_bound.md).
