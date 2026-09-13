# The differential ratio generates the actual joint field

Let k be algebraically closed of characteristic five. Let r>=2 satisfy
3 not dividing r and r not congruent to1 modulo5. Let F be squarefree,
monic of degree5r, with nonzero coefficient of x^(5r-1). Put

    X: y³=F(x),              theta=dx/y².

Let Y be a smooth genus-two curve with an odd-degree model v²=P(u),
deg P=5, and eta=du/v. Assume

    Cartier(eta)=(c0+c1*u)eta,       c1!=0.

Neither ordinarity nor a field-of-definition bound is needed. Embed the
two function fields in a common function field K, finite separable over
each, using the actual embeddings for differentials. Write

    M=k(X)k(Y),             delta=eta/theta in M.

Then

    M=k(x,delta)=k(u,delta).

More intrinsically, theta alone recovers k(X) inside every separable
intermediate field to which it descends as a RATIONAL differential.
The two functions Cartier(theta)/theta and its differential divided by
theta have coprime degrees8r-3 and18r-6. Likewise eta recovers k(Y).

If K=k(Z) comes from two actual finite etale maps, the joint normalization
C is finite etale over both endpoints. If n=deg(C->X), then

    g(X)=5r-1,   g(C)=(5r-2)n+1,   deg(C->Y)=(5r-2)n.

Writing T=f0*O_X, U=g0*O_Y and c=#(T intersect U), one has

    div(delta)=2U-(10r-4)T,
    deg(delta)=(10r-4)n-2c,

and delta is separating. Here T,U are reduced. No joint minimality or
simultaneous Galois closure is presumed before passing to C.

If on Z a spin L has sections e0,e1,e2,b with e0²=theta,
e1=x e0, e2=x² e0 and b²=eta, then the normalization of their ratio image
has field M(w), w=b/e0 and w²=delta. This degree-at-most-two extension
of M is another ACTUAL intermediate etale common quotient. L descends
there to O( (5r-2) f*O_X ), with its specified square and these sections.
This does not assert descent of every spin section or of a further h.

Version1,2026-09-08. Author-checked generalization by /root of the user's
Sept8 Pro response (which proves r=2 for the selected F). No independent
audit or Lean verification. [Proof](../../Solutions/common_covers/differential_ratio_joint_field.md).
