open Core

(** '(' '+' . Value Value ')' *)
let rec make_add toks =
  match toks with
  | [] -> failwith "too short"
  | [fst] -> failwith "too short"
  | tok :: rest -> let (node, tail) = make_tree rest in
                   match tail with
                   | [] -> failwith "too short"
                   | tok :: rest -> let (node2, tail2) = make_tree rest in
                                    Node.Op (Token.Add, node, node2), tail2

(** '(' . <unknown> *)
and make_sexp toks =
  match toks with
  | [] -> failwith "expect operator"
  | tok :: rest ->
     match tok with
     | Token.Op Token.Add -> let (node, tail) = make_add rest in
                             (match tail with
                             | [Token.Bracket Token.Right] -> node, []
                             | _ -> failwith "error")
     | _ -> failwith "not impl"

(** parse a single/top-level S-exp *)
and make_tree toks =
  match toks with
  | [] -> failwith "expect S-expression"
  | tok :: rest ->
     match tok with
     | Token.Bracket Token.Left -> let (node, tail) = make_sexp rest in
                     (match tail with
                     | [] -> node, []
                     | _ -> failwith "error")
     | Token.Value v -> Node.Value v, rest
     | _ -> failwith "not begin with '('"

(** for now, parse a single S-exp *)
let parse toks =
  let (node, rest) = make_tree toks in
  match rest with
  | [] -> node
  | _ -> failwith "token not exhausted"
