open Core

type node =
  Op of Token.operator * node * node
| Value of int

let tokenize (text: string): Token.t list =
  let open List in
  let s = String.split text ~on:' ' in
  let raw_toks_to_con = s
                        |> filter ~f:(fun s -> String.(<>) s "")
                        >>| RawToken.split_sign
  in
  let raw_toks = concat raw_toks_to_con in
  map ~f:Token.of_raw_token raw_toks

let build_tree toks =
  let tok = List.take toks 1 in
  let _rest = List.drop toks 1 in
  match tok with
  | _ -> ()

let inp = "(+ (* 3234 264) (- 2756 1123))"

let () =
  List.iter (tokenize inp) ~f:(fun w -> (printf "%s\n" (Token.to_string w)))
