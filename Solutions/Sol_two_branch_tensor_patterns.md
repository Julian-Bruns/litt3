# Proof: bounded tame orders and integer tensor patterns

[Statement and author-proof metadata](../Theorems/Thm_two_branch_tensor_patterns.md).
Use c=δ−qt, t=g0t0, d=g0m, gcd(m,t0)=1 and

    cm−qt0=D|h,   c≥q−2,   n=(h/D)qg0t0m.

## 1. Bounding the tame data independently of q

The [first-layer theorem](Sol_wild_first_layer.md) bounds the first
lower break b and graded rank r by constants B,R depending only on p,h.
The tame leading character gives t|b(p^r−1), hence

    t≤T=B(p^R−1),   g0,t0≤T,
    m=(qt0+D)/c≤(qT+h)/(q−2)
       ≤T+(2T+h)/(p−2)=:M,
    d≤TM.

No bound on the deeper wild group or its jump denominators is used.

## 2. An actual tensor with bounded integer pattern

Put the wild point at z=0 and the tame point at∞.
The rational d-tensor β=(dz)^d/z^(d+1) has orders−(d+1),1−d there.
Its pullback along the actual coarse map π has orders

    −(d+1)qt+dδ=dc−qt=g0D at the wild fiber,
    (1−d)d+d(d−1)=0 at the tame fiber,

and none elsewhere. Thus s=π^*β is nonzero and regular, with

    div(s)=eE,   e=g0D≤Th,
    E reduced,  u=deg E=n/(qt)=hm/D≤hM.

The bounded integer triple(d,e,u) proves the result.
Separability gives nonzero pullback. Replacing z by w=1/z gives
the equivalent expression(dw)^d/w^(d−1), up to scalar.

A fixed triple also gives O(E)^e≅ω_C^d. Multiplication by e on the
Jacobian is finite, even when p|e, so only finitely many geometric
line-bundle classes O(E) occur. But their complete linear systems can
have positive dimension. A fixed integer pattern or line-bundle class
therefore does NOT give a fixed divisor, tensor, or finite atlas list.
The [fixed genus-nine theorem](Sol_fixed_x_orbifold_bound.md) obtains
its atlas bound by additional endpoint geometry.
