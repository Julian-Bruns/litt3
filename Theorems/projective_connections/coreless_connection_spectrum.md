# The common-connection spectrum determined by a shared tensor

Let X<-Z->Y be an actual coreless finite bi-etale span of hyperbolic
curves over bar(F5). Let A be the intersection of their canonical rings
on Z, and P their common regular-projective-connection space, with
[these conventions](../../Definitions/projective_connections.md).

If A=k, then P is empty or a single reduced dormant point.
If A=k[s], let d>=1 be the primitive weight and eS its uniform divisor;
primitivity implies5 does not divide d. For s=a(dt)^d set

    r_s=-a''/(2d a)+(2d+1)(a'/a)^2/(4d^2).

This is an intrinsic common rational connection, and

    P is nonempty iff e=0 or -2d modulo5.                 (1)

When (1) holds:

- If d>2, then P={r_s}. This point is dormant in the Cartier-zero
  branch and active nilpotent otherwise; the latter has d=4.
- If d=1 or2, put q=s^(2/d) and normalize
  C_1(q^3)=epsilon q, epsilon in{0,1}. Then P=r_s+k q.
  In its coordinate c, the dormant and nilpotent schemes are

      k[c]/(c^2-epsilon),       k[c]/(c(c^2-epsilon)^2).

  For epsilon=1 the points c=±1 are dormant and c=0 is active
  nilpotent, with nilpotent lengths2,1,2. For epsilon=0 the sole
  point has dormant length2 and nilpotent length5. For d=1 one may
  equivalently normalize C(s)=epsilon s.

The empty case occurs in the actual genus-seventeen partial-Igusa
family: its shared Cartier-fixed one-form has uniform zero order2.
Thus all its jointly minimal coreless11-power Hecke spans, of
unbounded degree, have P empty. This example has neither the fixed-X
arithmetic nor the Hom-zero hypothesis.

For the fixed genus-nine X, criterion(1) is |image_X(S)|=2 modulo5.
In the nonzero-Cartier branch it selects exactly the half-weight profiles
(d,e)=(2,1),(4,2), excluding(2,4),(4,8). The regular Cartier-zero
quadratic case is absent. Every remaining positive Cartier-zero
invariant admitting a common connection has d>2 and a unique dormant
connection.

This classifies common connections once the shared ring is known.
It does not produce a shared tensor, force matching endpoint opers,
or exclude a common cover when P is empty.

Version3. Status: author proof. The unified weight-one/two reduction,
regularity criterion and scheme-length calculation passed a bounded
medium audit by audit_extension_fiber_scope,2026-09-14.
[Proof](../../Proofs/projective_connections/coreless_connection_spectrum.md).
