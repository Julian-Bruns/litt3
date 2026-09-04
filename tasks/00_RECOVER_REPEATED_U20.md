# Prerequisite: recover or reprove the repeated-`u20` layer

## Status

The retained chain jumps from the simple-`u20` response in file `97` to a
simple-`u25` response in file `101`, whose use in the tower assumes that
the repeated `u20` layer has already been solved. The old ledger calls the
missing source note `100`. No copy of that note, its equations, or its
executable certificate is present.

This is not the only evidence gap in the tower. Several response identities
in files `81`, `92`, `96`, and `104` are also certificate transcripts.
Thus completing this task repairs the missing transition, but does not by
itself make the whole tower self-contained. It also does not prove that the
specialized local tower covers the full entry-zero branch; that is the
independent Task 00B.

## Exact objective

Restore a self-contained justification of the repeated-`x=0,u20` step on
the clean charted branch over \(k=\overline{\mathbb F}_5\). It must:

1. display the repeated-layer equations and every response column used;
2. state the ambient old and new variables and the incoming solved graph;
3. use the priority cover
   \(D(\Delta\rho_3)\) and
   \(V(\rho_3)\cap D(\Delta\rho_4)\), including any later pivot opens;
4. prove the rank/solvability statement needed to pass from file `97` to
   file `101`, uniformly over all \(k\)-points and all earlier free
   variables; and
5. record any residual equation imposed on the older variables, or prove
   that there is none.

Acceptable outcomes are:

1. recover the original note `100` and all inputs needed to verify it;
2. give a replacement proof or exact reproducible certificate;
3. find a counterexample or gap showing that the claimed layer chain fails.

Analogy with the repeated-`u15` and repeated-`u25` files, or enumeration of
only \(\mathbb F_5\)-rational parameter values, is not a proof over \(k\).

## Minimal reading

1. `routes/profile4/double_fiber/layer_certificates/README.md`;
2. files `80`, `96`, and `97` for the determinant convention and
   incoming conditional graph;
3. files `101` and `104` for the precise downstream use;
4. files `81`, `83`, and `92` only if reconstructing the response
   pattern.
