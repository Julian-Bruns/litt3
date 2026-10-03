# Independent review: genuine H0 linearity and equivalence

Cartier/spin owner independently read both complete new shared-tensor modules on 3 October 2026, following the accepted five-file global-recovery review. This review concerns mathematical construction and scope; the implementation owner's focused transitive kernel audit remains separate.

| Source | SHA-256 at review |
| --- | --- |
| `Solutions/SharedTensors/SchemeDifferentialSheafLinearity.lean` | `c67f7cb4b82c571510e6c128861bc3bc5188d27639f640890f190b6a7f4fe91a` |
| `Solutions/SharedTensors/SchemeDifferentialGlobalLinearEquivalence.lean` | `00219e847f1e5592dbd5cdf2acb66110bde59d106e7e2220c7ffc93eca5226d5` |

The sheafification unit is genuinely linear over the original open section ring: it is the actual unit of sheafification in the category of presheaves of modules, whose component is a module morphism. The rational realization's section-ring linearity is derived by taking an actual local presheaf representative at the original generic point, using the real sheaf restriction scalar law and unit linearity, applying the full original universal-module linear map there, and using the actual coefficient restriction/generic compatibility. It does not assume a module action transported through the rational image or require smoothness for this linearity statement.

The coefficient-field module structure on genuine global associated-sheaf sections is `Module.compHom` through the actual structure morphism's original global section ring. The global rational map is then proved k-linear using the section-ring formula and actual base-field compatibility. Its range is the exact original closed-stalk regular intersection by the already proved original sheaf gluing and closed-to-all recovery. The final `schemeDifferentialGlobalSectionsRegularEquiv` is bijective because genuine associated-sheaf generic injectivity was proved, while surjectivity is actual sheaf gluing. Its stated evaluation formula is literal, not an arbitrary transported realization.

I accept the terminal scope: any integral scheme smooth of any actual relative dimension over any field, in any characteristic, with no algebraic closure, properness, finite dimensionality, genus, coordinate, DVR, or assumed H0 identification. The construction does not claim an independent cohomological model comparison or finite-dimensionality theorem.
