# Proof: compatible etale roots and the linear weight bound

[Statement and audit evidence](../Theorems/Thm_etale_root_contact_bound.md).
The linear improvement is due to /root/contact_root_extension_audit,
2026-09-06. Work with the actual jointly minimal span in the statement
in characteristic p>=5, p not dividing d, and put c_p=4p/(p-4).

## 1. A single common root torsor

Let L_X=omega_X(-D_X). The tensor s_X trivializes L_X^d and defines a
finite etale mu_d root torsor T_X->X. Its tautological root is a regular
one-form whose zeros are the inverse image of the reduced D_X.
Construct T_Y similarly.

Equality of the tensor pullbacks and etaleness identify f^*D_X=g^*D_Y
and f^*L_X=g^*L_Y, INCLUDING their d-th-power trivializations. Hence

    T_Z=Z x_X T_X=Z x_Y T_Y.                          (1)

Choose a component W of this SAME torsor, with images in components
X' of T_X and Y' of T_Y. These are smooth projective curves; W->X',Y'
are surjective finite etale maps. Write

    hX=deg(X'/X), hY=deg(Y'/Y), c=deg(W/Z).

The component degrees hX,hY are the orders of L_X,L_Y: the cyclic root
torsor monodromy has exactly the order of the torsion line bundle.
All three degrees divide d, and c divides both hX,hY. Disconnectedness
is allowed throughout. The two tautological forms pull back to the
SAME simple-zero form on W by(1).

Joint minimality also survives. Write s_X=A_X eta_X^d in a rational
differential frame, with root xi_X^d=A_X. Then

    k(W)=k(Z)(xi_X), k(X')=k(X)(xi_X),
    xi_X f^*eta_X=xi_Y g^*eta_Y.

The frame ratio is in k(Z)=k(X)k(Y), so k(X')k(Y')=k(W).
No irreducibility of a binomial defining the whole torsor is assumed.

## 2. Keep every component with the chosen endpoint pair

Put h=gcd(hX,hY). The diagonal mu_d action stabilizes X',Y' through
mu_hX,mu_hY and their pair through mu_h. The stabilizer of W is mu_c.
Thus exactly h/c components of T_Z lie over this pair, of total degree
h over Z.

Their joint images are DISTINCT: the original endpoint coordinates
recover k(Z), and either root coordinate then recovers the torsor point.
The whole joint map is generically injective onto its reduced image,
not merely birational separately on each component.

Let C* be that reduced union in X' x Y'. If a=deg f,b=deg g and
t=a(g(X)-1)=b(g(Y)-1), its total degrees are

    A=a h/hX, B=b h/hY, T=sum_i(g(W_i)-1)=h t,
    g(X')-1=hX(g(X)-1), g(Y')-1=hY(g(Y)-1).

The [reduced-union contact theorem](Sol_contact_degree_bound.md) applies
directly, including all cross-component contacts. Hence

    b h/hY=B<=c_p hX(g(X)-1),
    a h/hX=A<=c_p hY(g(Y)-1).

Since hX hY/h=lcm(hX,hY) divides d, these are the stated linear bounds.
Keeping only one component would lose this cancellation and give a
weaker bound.

## 3. Primitive weight and the scope boundary

If the span is coreless and d is its primitive shared weight, then
d=lcm(hX,hY). The line-bundle orders supply endpoint tensors of weights
hX,hY; at their least common multiple the pullbacks have the same divisor
and differ by a constant. Rescale to obtain a shared tensor. Primitivity,
together with lcm(hX,hY)|d, proves equality but does NOT bound d.

The [canonical marked quotient](Sol_canonical_marked_quotient.md) uses
this bound to control all reduced canonical markings. It cannot be
applied to weight2 simple zeros or weight4 double zeros, whose zero
order/weight ratio is1/2, or to roots on ramified covers. No shared
tensor has been produced for an arbitrary unmarked span.
