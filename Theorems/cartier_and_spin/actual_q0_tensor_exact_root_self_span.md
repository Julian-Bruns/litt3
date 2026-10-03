# Actual q0-tensor self-spans and the marked exact cubic root

Version1,3 October2026. [Independent scope audit PASS](../../Research/audits/OCT03_ACTUAL_ROOT_JOINT_FIELD_SCOPE_AUDIT_2026_10_03.md). This is not tensor recognition or a common-cover exclusion.

Work over an algebraically closed field k of characteristic FIVE. Use the fixed genus-nine curve X:y³=P(x), its differential θ=dx/y², and its settled squarefree quadratic q=q0, whose roots are disjoint from the ten roots of P. The accepted exactness input is qθ=d(Q/y⁵), where Q′=qP. Put τ=q⁸θ³.

Let X′ have function field k(x,y,w), with y³=P and w³=q. It has genus31. The diagonal C3 action (y,w)↦(ζy,ζw) is FREE. Its quotient is the genus-eleven curve
\[
Z:r³=P/q,
\qquad η=q²dx/r²=d(Q/r⁵),
\qquad \operatorname{div}(η)=10(U+V),
\]
where U,V are the two points above the roots of q. The cover X′→Z is finite étale of degree THREE, and pulls η back to w⁸θ. The cover X′→X has degree THREE and is ramified precisely at the six points above the roots of q.

Suppose two actual finite étale maps h1,h2:S→X from the SAME smooth projective connected source satisfy h1*τ=c h2*τ for c∈k×. There is one connected cubic extension S′→S and two actual finite étale maps S′→X′, lifting h1 and h2 after choosing a constant cube root of c. They pull w⁸θ back proportionally. Their compositions f1,f2:S′→Z are finite étale and satisfy
\[
f1*η\sim f2*η,
\qquad f1*(U+V)=f2*(U+V).
\]
Thus the lifted span has the ACTUAL two-point marked exact form, together with the common étale C3-cover marking X′→Z. It retains both original maps by composition with X′→X. However, S′→S is RAMIFIED; if S also maps étale to Y, the resulting map S′→Y is ramified. This auxiliary source is not a replacement common X,Y witness.

No converse from an arbitrary η-preserving Z-span to an X-span is asserted. In particular the exact form and its two-point zero divisor do not yet recognize the original X-fields, preserve the additional quotient X′→X, or produce a core.

[Proof](../../Proofs/cartier_and_spin/actual_q0_tensor_exact_root_self_span.md).
