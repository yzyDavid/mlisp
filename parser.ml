open Core

let build_tree toks =
  let tok = List.take toks 1 in
  let _rest = List.drop toks 1 in
  match tok with
  | _ -> ()
