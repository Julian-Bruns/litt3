# Independent review: original H0 Cartier pullback naturality

The Cartier/spin owner read the complete new
`Solutions/SharedTensors/SchemeDifferentialGlobalCartierNaturality.lean`,
independently of its author. Reviewed SHA256:
`b93fb333f144155fee5eba35d2856fd8706e6f306d688b7833170fa3c4f7d2d3`.
It uses the already reviewed original
differential sheaf H0 and original coefficient action, the genuine
linear global pullback, and intrinsic rational Cartier.

The first statement proves that genuine H0 Cartier realizes EXACTLY
the constructed actual rational Cartier on the original generic
differential module. It applies the true H0/regular-intersection
intertwining equation and takes the literal subtype value, using the
proved original generic realization, rather than assuming a commuting
map or defining the global sections as rational forms.

The second statement proves commutation with the genuine H0 pullback
along an original finite étale surjective morphism of integral smooth
curves over an algebraically closed perfect field of prime
characteristic. Applying the already proved original H0 generic
injection reduces equality to the true rational map. Actual field
separability follows from the original unramified finite-type map.
Actual target function-field generation and transcendence degree follow
from its genuine smooth structure morphism. The full actual one-variable
separable Cartier base-change theorem then proves the required equation.
There is no source or target chosen coordinate, supplied separability,
H0 finiteness, genus, properness, clump, shared regularity or Cartier
commutation premise.

The exact scope and construction are accepted. This card adds no
compilation replay. Focused audit
`../litt3-computation-data/formalization-20261003/verification/20261003T091020Z/report.json`
checks 860 transitive Litt3 declarations, with only `Classical.choice`,
`Quot.sound` and `propext`, zero forbidden dependencies and zero source
changes. The reviewed hash above fixes the exact audited source.
No global Cartier surjectivity or arbitrary inseparable pullback
compatibility is asserted.
