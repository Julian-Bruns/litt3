# Proof: the marked scalar class, its Artin–Schreier torsor and the two Hom maps

Version1, 3 October2026. Independently audited theoretical argument; all eight focused checks passed in [the review](../../Research/audits/OCT03_PULLED_NATIVE_SCALAR_TORSOR_AND_HOM_AUDIT.md). Use the accepted actual [wild-fiber marking](canonical_ten_power_quotient_wild_marking.md), the explicit [fixed endpoint normal form](canonical_ten_fixed_backup_endpoint_normal_form.md), and the audited [native scalar class](canonical_ten_native_two_power_self_extension_classes.md). No computation is used.

## The actual pulled scalar class

At the weak point use the SAME common parameter t, u=ONE/t andσu=u+ONE. The native scalar class is represented byu. Its pull toY has principal partONE/t at each of the TWO actual wild points. This is actual pullback along the original stack map, not replacement of its wild points by an arbitrary divisor.

In the accepted common regular cotangent transport, s=a₊dt or a₋dt at those points andη=c_* a₊dt or c_* a₋dt, with one nonzero common constantc_*. Therefore Serre duality pairs the scalar class withη by
\[
c_*(a_++a_-).
\]
This is nonzero: their ratio satisfiesr²−r+ONE=ZERO, so r≠−ONE. Pairing withη₀=z_coordη isZERO at both points since z_coord vanishes there. Thus the scalar class is nonzero and its functional line is exactly the line annihilatingη₀.

The class e ofV lies inH¹O(−P). Its image inH¹O has the same annihilator by the accepted marking. Indeed the Serre-dual inclusionH⁰ω→H⁰ω(P) is an isomorphism, so the canonical multiplication byσ_P preserves that functional description. The sequence ZERO→O(−P)→O→kP→ZERO shows the H¹ map is an isomorphism, sinceH⁰O→kP is an isomorphism. Hence z and that image ofe are nonzero proportional classes.

## The explicit connected étale torsor

The scalar class is Frobenius-fixed: in the native local cohomology its fifth power differs fromu by the invariant functionu⁵−u=f/λ. The actual global function f_Y is the pull of the SAME coarse function. At both wild points the exact fixed-f weak parameter givesf_Y/λ=u⁵−u. Thus the displayed Artin–Schreier equation splits over the completed local field there; its normalization has FIVE unramified local branches. At every other pointf_Y is regular, so the derivative ofy⁵−y−f_Y/λ with respect toy is−ONE and the integral cover is étale. Normalizing gives a finite étaleC₅-torsor over allY. The connecting class in the Artin–Schreier sequence is represented by these localu principal parts, givingZ up to the fixed Cech sign or nonzero endpoint scalar.

It is connected. If the degree-FIVE Artin–Schreier equation were reducible, it would have a rootg in k(Y), since FIVE is prime. Its poles could occur only atR₊,R₋. At each point a pole ofg of orderm gives a pole ofg⁵−g of orderFIVE m. The functionf_Y has exactly orderFIVE at each wild point, so g would belong toH⁰O(R₊+R₋).

This wild pair is a hyperelliptic fiber on a genus-two curve, andH⁰O(R₊+R₋) is TWO-dimensional, spanned byONE andONE/z_coord. Every suchg is hyperelliptic-invariant. But f_Y is not: its odd part underw↦−w isTWO bw/z_coord⁵, which is nonzero because b²=THREE. This contradictsg⁵−g=f_Y/λ. Thus the torsor is connected. Its associated unipotent extension is nontrivial, consistently with the preceding nonzero class.

No connectedness of its pullback toT is inferred. An actualC₅ quotient ofG is not excluded by absence of prime-to-FIVE quotients. Pullback is a finite étale torsor, and each of its connected components is a finite étale cover ofT, so composing with each of the two original endpoint maps preserves both actual étale legs.

## The Hom dimension

The actual marked extension is
\[
ZERO\longrightarrow O(-P)\longrightarrow V
\xrightarrow{q_V}O\longrightarrow ZERO.
\]
Since Hom(O(−P),O)=H⁰O(P)=kσ_P and the boundary sendsσ_P to the nonzero image ofe inH¹O, applying Hom(−,O) givesHom(V,O)=kq_V. In the following term it also gives
\[
\ker\!\left(q_V^*:H^1(O)\to\operatorname{Ext}^1(V,O)\right)
=k(\sigma_P e)=kz.
\]
The dual unipotent extensionZ* has class−z. ApplyingHom(V,−) to ZERO→O→Z*→O→ZERO, its boundary on the one-dimensional Hom(V,O) is the pullbackq_V*(−z), which isZERO by this exact kernel calculation. Therefore
\[
ZERO\longrightarrow k\longrightarrow\operatorname{Hom}(V,Z^*)
\longrightarrow k\longrightarrow ZERO
\]
is exact. This proves dimensionTWO and the distinguished map/lift interpretation. Tensor-Hom adjunction givesh⁰((V⊗Z)*)=TWO.

This computes actual ordinary Hom after pullback. It does not identify ordinary Ext with native Ext, supply a specific original coefficient map, or resolve either remaining source family.
