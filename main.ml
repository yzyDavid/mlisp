open Core

type node =
  Op of Token.operator * node * node
| Value of int

let rec break_sign (run: string): string list =
  let len = String.length run in
  if len = 1 then [run]
  else let first = String.get run 0 in
       if not (Char.is_digit first) then
         String.of_char first :: break_sign (String.sub run ~pos:1 ~len:(len - 1))
       else let last = String.get run (len - 1) in
            if not (Char.is_digit last) then
              break_sign (String.sub run ~pos:0 ~len:(len - 1)) @ [String.of_char last]
            else [run]

let split_sign (raw: string): RawToken.t list =
  let raws = break_sign raw in
  List.map raws ~f:RawToken.of_string

let tokenize (text: string): Token.t list =
  let open List in
  let s = String.split text ~on:' ' in
  s
  |> filter ~f:(fun s -> String.(<>) s "")
  |> (fun x -> concat (map ~f:split_sign x))
  >>| Token.of_raw_token

let build_tree toks =
  let tok = List.take toks 1 in
  let _rest = List.drop toks 1 in
  match tok with
  | _ -> ()

let inp = "(+ (* 3234 264) (- 2756 1123))"

let () =
  List.iter (tokenize inp) ~f:(fun w -> (printf "%s\n" (Token.to_string w)))
