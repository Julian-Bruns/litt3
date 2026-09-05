# A cored bi-etale correspondence has a common effective orbifold

**Status:** author proof, 2026-09-05. Author:
`/root/x_elliptic_quotient_maps`.

This is the bridge from the field-theoretic notion of a core to the
finite-orbifold results.  It works in arbitrary characteristic and does not
assume either original leg is Galois.

## Theorem

Let `k` be an algebraically closed field.  Let

\[
                    X\xleftarrow{f}Z\xrightarrow{g}Y
\]

be finite etale maps of smooth projective connected curves, with
`g(X),g(Y)>=2`.  Suppose the correspondence has a core, equivalently

\[
       \operatorname{trdeg}_k\bigl(k(X)\cap k(Y)\bigr)=1
       \quad\text{inside }k(Z).
\]

Then there is a smooth proper connected effective Deligne--Mumford
orbifold curve `S` and representable finite etale surjections

\[
                         X\longrightarrow S,
                         \qquad Y\longrightarrow S.
\]

The coarse curve of `S` has function field `k(X) cap k(Y)`.  The statement
allows wild stabilizers and the original maps `Z -> X,Y` may be non-Galois.

## Proof

### 1. A simultaneous Galois refinement which remains etale

The curve `Z` is hyperbolic.  Krishnamoorthy,
[Correspondences without a Core, Lemma 4.2](https://doi.org/10.2140/ant.2018.12.1173),
therefore gives a finite extension `F/k(Z)` which is Galois over both
`k(X)` and `k(Y)`.  His stated finite ground-field extension is unnecessary
because `k` is already algebraically closed.  The associated cover over `Z`
need not itself be etale, so one cannot use it directly.

Instead start with `L_0=k(Z)` inside `F` and alternately take the Galois
closure over `k(X)` and over `k(Y)`, always inside a fixed algebraic closure.
Every resulting field remains inside `F`: a Galois closure of a subfield of
the finite normal extension `F/k(X)` (respectively `F/k(Y)`) is contained in
`F`.

Every step is also unramified over `Z`.  Inductively, the curve belonging to
`L_i` is finite etale over `Z`, hence finite etale over whichever of `X` or
`Y` is used next.  The Galois closure of an unramified extension of smooth
projective curves is unramified: its conjugates are unramified, and so is
their compositum.  Thus the next curve is again finite etale over `Z`.

The increasing chain of subfields `L_i` lies in the finite extension `F`, so
it stabilizes.  Since the two closure operations alternate, the stable field
`L` is Galois over both `k(X)` and `k(Y)`.  Let `W` be its smooth projective
curve.  We have obtained actual finite etale maps

\[
                         W\longrightarrow Z,
\]

for which both composites `W -> X` and `W -> Y` are Galois and etale.

### 2. The quotient orbifold

Put

\[
 A=\operatorname{Gal}(W/X),\qquad
 B=\operatorname{Gal}(W/Y),\qquad
 G=\langle A,B\rangle\subset\operatorname{Aut}_k(W).
\]

The group `G` is finite because `g(W)>=2`.  Define

\[
                              S=[W/G].
\]

This is a smooth proper connected Deligne--Mumford curve.  It is effective
because `G` acts faithfully on `W`.  This remains true when the order of `G`
is divisible by `char(k)`: `G` is the constant finite etale group scheme,
while its fixed points account for wild ramification of the coarse map.

Both `A` and `B` act freely, since `W -> X,Y` are etale Galois covers.  Hence

\[
                  X\simeq[W/A],\qquad Y\simeq[W/B].
\]

For an inclusion of finite constant groups `A<=G`, the induced map
`[W/A] -> [W/G]` is representable finite etale and surjective (after base
change by the atlas `W -> [W/G]`, it is the finite etale coset cover
`G/A`).  The same applies to `B`, yielding the two required atlases.

Finally, Galois correspondence gives

\[
 k(W)^G=k(W)^A\cap k(W)^B=k(X)\cap k(Y).
\]

Thus the coarse curve of `S` is the coarse core.  This completes the proof.

## Relation to prior files

Krishnamoorthy's Lemma 4.2 supplies the finite simultaneous *field*
envelope.  The alternating unramified-closure argument above is the needed
extra step ensuring a simultaneous Galois refinement remains etale.
Proposition 21.3 of
`21_SIMULTANEOUS_ENVELOPE_CORE_TOWER_CRITERION.md` contains the same quotient
stack construction once such a refinement is available, in the self-orbifold
setting.  Neither source by itself licenses taking the possibly ramified
Galois closure over the coarse core as the common atlas.
