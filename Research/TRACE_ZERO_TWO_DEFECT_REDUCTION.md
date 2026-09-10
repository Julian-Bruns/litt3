# A bounded five-part in the remaining two-defect case

2026-09-10. Author proof of the finite-group reduction below; no new
whole-stratum exclusion or higher-Witt descent is asserted. This is the
continuation after the audited
[Frobenius-string bound](../Theorems/Thm_frobenius_defect_order_bound.md).

## 1. Retain the two actual maps

Let X←Z→Y be an actual matched active finite etale span, with Z/Y
Galois of group G, Y ordinary, source defect two, and X nonordinary.
Suppose every five-element acts trivially on the two-dimensional
defect representation U. By the audited two-defect deck theorem,
every Sylow-five subgroup of G is cyclic.

Put N=ker(G→GL(U)), T0=Z/N, and Gamma=G/N. Then Gamma has order
prime to five. The actual T0/Y is etale Galois, with the same two
defects. A nonzero X defect quadratic phi_X pulls back to a section
fixed by N, hence descends to T0. The quartic s also descends, and

    phi_X²/s_X = phi_T0²/s_T0

is nonconstant. Its X-degree is at most B=8(g(X)-1). Thus the actual
span X←Z→T0 is cored, with X-atlas degree at most B. Let R be its
joint normalization inside Z. The cored-orbifold degree inequality gives

    [k(R):k(T0)] <= B.

All these are actual intermediate curves. No bounded genus of T0 or
core for the original X,Y span is inferred.

## 2. A minimal Galois witness has bounded cyclic five-part

Let H=Gal(Z/R), so H⊂N and s=[N:H]<=B. Define

    H_core = intersection over gamma in G of gamma H gamma^-1,
    Z' = Z/H_core, G'=G/H_core.

This is the Galois closure of R/Y INSIDE the original Galois cover Z.
It is therefore finite etale over both X and Y, and contains the
ORIGINAL embedded fields k(X), k(Y), and k(T0). Its defect remains
exactly two: it contains T0, which has two, and is dominated by Z,
which has two. Its faithful defect image is still Gamma.

The faithful permutation action of G' on G'/H' has a block system
indexed by G'/N'=Gamma, each block having s elements. A Sylow-five
subgroup P' of G' is cyclic and lies in N', so it fixes every block.
Every orbit of P' inside a block has five-power size at most s.
For a cyclic five-group, the order of its permutation image is the
LARGEST of those orbit sizes. Faithfulness of the full coset action
therefore gives

    |P'| <= 5^floor(log_5(s)) <= 5^floor(log_5(B)).

This is an order bound, not a bound on the number of five-generators.
There is no assumption that P' is normal in G'.

For the main genus-nine X, B=64, hence |P'|<=25. The case |P'|=1
is already excluded by the audited Frobenius-string theorem. The
residual can therefore be represented with Sylow-five order5 or25.

It is important to replace the ORIGINAL source by this contained
Galois closure before imposing the bound. A redundant source can
still have an arbitrarily long defect-neutral cyclic tower on top.

## 3. What this reduction does and does not supply

After removing a normal prime-to-five defect-neutral kernel, the
remaining group is C_(5^a) semidirect Gamma, with a=1 or2 and the
action given by det Gamma. The faithful prime-to-five projective
image is still cyclic or dihedral of order at least5250 in a
hypothetical main-pair span. This reduction does not bound that image.

The normalized X-trace is zero because the X-degree is divisible by
five. A short Psi string injected from X can be the bottom of a
longer source string, so the proof for prime-to-five maps does not
extend merely by replacing the degree with5 or25.

The actual cored correspondence X←R→T0 still has its small leg of
degree<=64. A possible next mechanism is to use that correspondence
to recover a nonzero short-string map into H1(T0,T_T0), or to bound
its failure through the small wild part. Neither assertion is proved.
Normal closures over its common orbifold are legitimate because the
core has been proved; their Sylow quotients can have wild stabilizers
and must not be silently treated as smooth free quotients.

## 4. Subsequent linear-model stress test

[TRACE_ZERO_REGULAR_MODULE_TEST.md](TRACE_ZERO_REGULAR_MODULE_TEST.md)
now constructs regular deck modules retaining the short X injection,
surjective Psi-compatible trace with degree-zero composition, ordinary
base and reciprocal defect2, with cyclic five-part5 or25 but arbitrarily
large prime-to5 image. This strengthens the bottom-of-string warning:
adding those linear data still does not bound the image-depth. The
actual cored maps/functions are not constructed by that model and
remain the geometric input to exploit.
