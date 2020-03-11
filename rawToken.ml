open Core

type t = string

let of_string str = str

let to_string str = str

let rec break_sign run =
  let len = String.length run in
  if len = 1 then [run]
  else let first = String.get run 0 in
       if not (Char.is_digit first) then
         String.of_char first :: break_sign (String.sub run ~pos:1 ~len:(len - 1))
       else let last = String.get run (len - 1) in
            if not (Char.is_digit last) then
              break_sign (String.sub run ~pos:0 ~len:(len - 1)) @ [String.of_char last]
            else [run]

let split_sign raw =
  let raws = break_sign raw in
  List.map raws ~f:of_string
