# Actual bi-etale correspondences and their operations

ID: `correspondences`. Uses [base conventions](Def_base_conventions.md).

A *bi-etale span* is a diagram X <-f- Z -g-> Y with both maps finite
etale and all three curves connected. A *joint image* is the reduced
integral image Gamma⊂X×Y. The span is *jointly minimal* when Z is the
normalization of Gamma; on fields, k(Z)=f^*k(X)g^*k(Y).

The span has a *core* when

    trdeg_k(f^*k(X) ∩ g^*k(Y))=1 inside k(Z).

It is *coreless* when the intersection is k. These terms refer to the
actual embeddings supplied by the two maps, not abstract isomorphism
classes of their fields. A positive-genus core is stronger than a core.

A *source refinement* replaces Z by an actual connected finite etale
W→Z, leaving the two composites to X,Y. It does not change the joint
image. To *compose* X←Z→Y and Y←T→V, take connected components of Z×Y T
and then normalize their outer joint images. Composition can create
genuinely new images. Transposition exchanges the two endpoint maps.

A *clump* is a nonempty finite subset S⊂Z(k) saturated under both fiber
relations: f^(-1)f(S)=S=g^(-1)g(S). Regarding finite subsets as reduced
divisors, this is the equality of the two pullbacks of the endpoint
markings. A marking is not automatically supplied by an arbitrary span.

A *finite correspondence groupoid* uses distinct normalized joint
images as arrows, with source/target the two etale maps and composition
obtained from outer joint images. Its existence from a finite
composition-closed list is a theorem, not part of this definition.
