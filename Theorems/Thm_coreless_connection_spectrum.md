# Exact common-connection spectrum from a positive invariant

Work over bar(F5) with an ACTUAL coreless finite bi-etale span
X←Z→Y of hyperbolic curves. Let A be its canonical-ring intersection and
let P be its common regular-projective-connection space, using
[these conventions](../Definitions/Def_projective_connections.md).

If A=k, P is empty or a single reduced point; any such point is dormant.
No existence is asserted in this case.

Suppose A=k[s], with primitive weight d>=2 and uniform divisor eS.
At either endpoint write s=a(dt)^d and set

    r_s=−a''/(2d a)+(2d+1)(a'/a)^2/(4d^2).

This is an intrinsic common RATIONAL connection. The following gives an
exact criterion, independently of all cover degrees:

    P is nonempty iff e=0 or−2d modulo5.

If this criterion fails, P is empty. If it holds, then

* d>2: P={r_s}. It is dormant in the Cartier-zero branch and active
  nilpotent otherwise (the latter necessarily has d=4).
* d=2: P={r_s+t s:t∈k}. Normalize C_1(s^3)=epsilon s, epsilon∈{0,1}.
  Its dormant and nilpotent schemes, respectively, are exactly

        k[t]/(t^2−epsilon),      k[t]/(t(t^2−epsilon)^2).

  For epsilon=1 there are two dormant points and their active nilpotent
  midpoint; the nilpotent lengths are2,1,2. For epsilon=0 there is one
  dormant point, of dormant length2 and nilpotent length5.

For the fixed genus-nine X, the criterion is equivalently
|image_X(S)|=2 modulo5. In its nonzero-Cartier branch, common regular
connections occur exactly in the half-weight profiles (d,e)=(2,1),(4,2),
not (2,4),(4,8). The regular Cartier-zero quadratic case is absent.
For every remaining positive Cartier-zero invariant with a common regular
connection, d>2 and that connection is unique and dormant.

The theorem does NOT produce a clump or decide which endpoint opers have
compatible pullbacks. A reduced common locus does not supply ordinary
pullback or a lifting argument. No common cover is excluded merely from
the empty common-connection locus: a cover need not preserve a connection.

Version1,2026-09-07. Author proof; independent audit requested with the
Cartier/dormant secant chunk. [Proof](../Solutions/Sol_coreless_connection_spectrum.md).
