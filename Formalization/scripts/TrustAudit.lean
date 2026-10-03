import Lean

/-! Run after importing all solution modules. The generated report lives externally. -/
open Lean Elab Command

elab "#audit_litt3_axioms" : command => do
  let env ← getEnv
  let names := env.constants.toList.filterMap fun (name, info) =>
    match info with
    | .thmInfo _ => if name.toString.startsWith "Litt3." then some name else none
    | _ => none
  for name in names.mergeSort (fun a b => a.toString < b.toString) do
    let axioms ← collectAxioms name
    let permitted := #[`propext, `Classical.choice, `Quot.sound]
    let forbidden := axioms.filter (fun a => !permitted.contains a)
    let row := Json.mkObj [
      ("declaration", toJson name.toString),
      ("axioms", toJson (axioms.map Name.toString)),
      ("forbidden", toJson (forbidden.map Name.toString))]
    logInfo row.compress
    unless forbidden.isEmpty do
      throwError "Unexpected axiom dependency in {name}: {forbidden}"
