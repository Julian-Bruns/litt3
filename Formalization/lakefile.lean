import Lake
open Lake DSL

package litt3Formalization where
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @
  "32d24245c7a12ded17325299fd41d412022cd3fe"

lean_lib Definitions where
lean_lib Theorems where
@[default_target]
lean_lib Solutions where
