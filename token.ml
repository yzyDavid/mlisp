type bracket = Left | Right

type operator = Add | Minus | Multiply | Divide

type t =
  Bracket of bracket
| Op of operator
| Value of int

let of_raw_token raw =
  let open String in
  let str = RawToken.to_string raw in
  match str with
  | "(" -> Bracket Left
  | ")" -> Bracket Right
  | "+" -> Op Add
  | "-" -> Op Minus
  | "*" -> Op Multiply
  | "/" -> Op Divide
  | _ -> Value (Core.Int.of_string str)

let to_string = function
  | Bracket Left -> "("
  | Bracket Right -> ")"
  | Op Add -> "+"
  | Op Minus -> "-"
  | Op Multiply -> "*"
  | Op Divide -> "/"
  | Value i -> Int.to_string i
