open Core

(** '(' '+' | '-' | '*' | '/' . Node Node ')' *)
let rec make_op opTok toks =
  match toks with
  | [] -> failwith "too short"
  | [_] -> failwith "too short"
  | l -> let (node, tail) = make_tree l in
                   match tail with
                   | [] -> failwith "too short"
                   | l2 -> let (node2, tail2) = make_tree l2 in
                           Node.Op (opTok, node, node2), tail2

(** '(' . <unknown> *)
and make_sexp toks =
  match toks with
  | [] -> failwith "expect operator"
  | tok :: rest ->
     match tok with
     | Token.Op opTok -> let (node, tail) = make_op opTok rest in
                             (match tail with
                             | (Token.Bracket Token.Right) :: tail_of_me -> node, tail_of_me
                             | _ -> failwith "error on making S-exp")
     | _ -> failwith "not impl"

(** parse a single/top-level S-exp *)
and make_tree toks =
  match toks with
  | [] -> failwith "expect S-expression"
  | tok :: rest ->
     match tok with
     | Token.Bracket Token.Left -> make_sexp rest
     | Token.Value v -> Node.Value v, rest
     | _ -> failwith "not begin with '('"

(** for now, parse a single S-exp *)
let parse toks =
  let (node, rest) = make_tree toks in
  match rest with
  | [] -> node
  | _ -> failwith "token not exhausted"
