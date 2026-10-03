# Proof: exact adjacent power transitions and their completed cohomology classes

Version1, 3 October2026. Independently audited direct theoretical refinement; all ten substantive checks passed in [the review](../../Research/audits/OCT03_ADJACENT_NATIVE_POWER_TAIL_CLASSES_AUDIT.md), and its literal matrix-scope clarification is applied. The argument uses the [audited two-power self-extension theorem](../../Theorems/cartier_and_spin/canonical_ten_native_two_power_self_extension_classes.md) and the accepted exact [power saturation](canonical_ten_power_filtration_and_four_row.md). No numerical calculation or truncation is used as evidence.

## Compatible endpoint identifications

At the weak point retain the fixed parameter t, u=ONE/t, f=λ(u⁵−u), and
\[
t_2=(df)^2/f=\beta(t)t(dt)^2,\qquad
\beta(t)=\lambda/(ONE-t^4).
\]
Put A(t)=a₊(t)+a₋(t), B(t)=a₊(t)a₋(t), and Q(X)=X²−A(t)X+B(t). Their constants satisfy A₀²=THREE B₀ with A₀,B₀ nonzero. No derivative of either branch function is assumed zero.

The accepted wild saturation basis is t⁻ʳQ(s)ʳsᵉ in degreeTWO r+e. Outside the wild orbit the raw power basis has no saturation defect. Hence the native rank-two tailD_i has invariant raw power frames
\[
s^{2i-ONE}/t_2^{i-ONE},\qquad s^{2i}/t_2^i,
\]
with its first frame evaluated in the invariant negative-line frameλdf⁻¹. Its regular-to-invariant matrix is
\[
P_i=
\begin{pmatrix}u^2&-i\,a(t)u^3\\ZERO&ONE\end{pmatrix},
\qquad a(t)=A(t)/\beta(t).
\]
The coefficient i is the coefficient of the next-to-leading term inQ^i. The frame formula retains the actual cotangent transport and the t₂ tensor powers.

For i=ONE,TWO,THREE,FOUR, multiply its invariant negative-line frame and corresponding first regular basis vector by i. Its matrix becomes the common
\[
P_a=\begin{pmatrix}u^2&-a(t)u^3\\ZERO&ONE\end{pmatrix}.
\]
These are native global identifications: they are given by the same raw-power frames on the finite complement, and agreement of the completed integral lattices extends them at the wild orbit. The accepted absence of nonwild defects supplies their extension elsewhere. This is stronger than a comparison of wild fibers.

## The complete cross block

For the tail indexed by j=ONE,TWO,THREE, the regular odd and even upper vectors come fromQ^j s andQ^{j+ONE}, respectively. ModuloF₂ⱼ₋₂, retain their coefficients down through degreeTWO j−ONE. Define
\[
C_j=jB+\binom j2 A^2,\quad
D_j=(j+ONE)B+\binom{j+ONE}2 A^2,
\]
\[
E_j=-j(j+ONE)AB-\binom{j+ONE}3 A^3.
\]
These are exactly the third coefficient ofQ^j s and the third and fourth coefficients ofQ^{j+ONE}. Powers of lower degree lie in the discardedF₂ⱼ₋₂. After the endpoint normalizations above, the lower-to-upper regular cross block is
\[
R_j=
\begin{pmatrix}
\dfrac{(j+ONE)C_j}{j\beta}\,u^3&
\dfrac{E_j}{j\beta^2}\,u^4\\
-j(j+ONE)A&\dfrac{D_j}{\beta}\,u
\end{pmatrix}.
\]
For j=ONE this is exactly the cross block of the audited F₄/O calculation. The factors j,j+ONE are the actual endpoint negative-line normalizations, not freely chosen scalar comparisons.

The self-extension cochain in the common invariant D frame is
\[
\mathcal C_j=R_jP_a^{-ONE}.
\]
Thus its entries are the product by [[u⁻²,a(t)u],[ZERO,ONE]]. They have orders u,u⁴,u⁻²,u, respectively. This gives a cochain for the actual integral tail; its cyclic difference is regular because both transition blocks come from the actual saturation.

Replace a(t) by a₀ in the common lattice. This does not change that lattice, since P_a₀⁻¹P_a=[[ONE,−(a(t)−a₀)u],[ZERO,ONE]] is regular and invertible. Simultaneously multiply both negative-line invariant frames by a₀=A₀/β₀. The common transition is now
\[
P=\begin{pmatrix}u^2&-u^3\\ZERO&ONE\end{pmatrix}.
\]
Let v₀=B₀/β₀. Using A₀²=THREE B₀, the constant-coefficient part of the normalized cochain is
\[
v_0
\begin{pmatrix}
p_j u&s_j u^4\\
r_j u^{-2}&q_j u
\end{pmatrix},
\]
where
\[
p_j=(j+ONE)(THREE j-ONE)/TWO,\qquad
q_j=(j+ONE)(TWO-THREE j)/TWO,
\]
\[
r_j=-THREE j(j+ONE),\qquad s_j=j^2-ONE.
\]
For example the upper-right coefficient is
\[
\frac{(j+ONE)C_j}{jB}+\frac{E_j}{jAB}
=(j+ONE)(j-ONE),
\]
after substituting A²=THREE B. All denominators are units for the three retained values ofj.

## Higher series do not alter the class

The difference from the constant cochain has diagonal entries regular in t, lower-left entry in t³k[[t]], and upper-right entry in u³k[[t]]. This includes the first derivatives ofA andB; none are discarded by assumption.

Write its lower-left leading coefficient asγt³ and its upper-right leading coefficient asδu³. The regular invariant-frame matrix
\[
L=P E_{21}P^{-ONE}
=\begin{pmatrix}-u&-u^4\\u^{-2}&u\end{pmatrix}
\]
has γtL with the same lower-left leading term. Subtract it. The remaining lower-left entry has order at leastFOUR, its upper-right entry still has at most orderu³, and its diagonals are regular. Subtract an invariant constant trace-free diagonal matrix H=h·diag(ONE,−ONE), choosing h to cancel the only possible u term in the regular-frame upper-right entry.

To see sufficiency exactly, for an invariant-frame matrix M=(a,b;c,d),
\[
P^{-ONE}MP=
\begin{pmatrix}
a+cu^3&(d-a)u-cu^4+bu^{-2}\\
cu^2&d-cu^3
\end{pmatrix}.
\]
After the subtraction, c∈t⁴k[[t]] makes both diagonal contributions and−cu⁴ regular. All terms inb other than its u³ coefficient give a regularbu⁻²; the selected H cancels that single coefficient with the constant part ofd−a. Thus the whole remainder is regular. Both γtL and the remainder are regular endomorphism cochains, while H is invariant, so the difference is zero in completedH¹.

The audited coarse invariant End(D) bundle hasH¹=ZERO and the tame stabilizer has no higher cohomology. Hence completed equality is equality in the global native self-extension space. No ordinary-Ext comparison is being made.

## The three projective classes

The audited basis is
\[
U=u\operatorname{Id},\qquad
\Xi=\begin{pmatrix}TWO u&THREE u^4\\u^{-2}&-TWO u\end{pmatrix}.
\]
For the displayed constants, which satisfy TWO(p_j−q_j)+r_j−THREE s_j=ZERO, direct entrywise calculation gives
\[
\alpha U+\beta\Xi+\gamma L,\qquad
\alpha=(p_j+q_j)/TWO,\quad
\beta=(r_j+s_j)/FOUR,\quad
\gamma=r_j-\beta.
\]
Here
\[
\alpha=(j+ONE)/FOUR,\qquad
\beta=-(TWO j+ONE)(j+ONE)/FOUR.
\]
The scalar α is nonzero for all threej. SinceL is regular, the projective class is [U−(TWO j+ONE)Ξ]. This is [U+TWOΞ], [U], [U+THREEΞ] in characteristicFIVE.

The unique nonzero nativeO-by-O extension has classu inH¹_native(O)=k. Tensoring it withD gives precisely the scalarU class. HenceF₆/F₂ is nativelyD⊗Z₂. The other two classes have nonzero trace-free parts and cannot be scalar tensor extensions.

Finally an isomorphism between any of these native middle bundles would preserve its unique native equality-slope rank-twoD, by the audited slope/Picard argument. Both endpoint automorphism groups are scalar. Therefore distinct projective classes give distinct native middle bundles. Each class has a nonzero scalar component, whileΞ has zero entire fiber cocycle; consequently all three wild fibers areJ₃⊕J₁. This proves all asserted distinctions without a source existence or exclusion claim.
