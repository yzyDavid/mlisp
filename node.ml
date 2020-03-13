type t =
  Op of Token.operator * t * t
| Value of int

type tree = t

let rec to_json node =
  match node with
| Op (op, v1, v2) -> `Assoc [("type", `String (Token.to_string (Token.Op op)));
                         ("arg1", to_json v1); ("arg2", to_json v2)]
  | Value v -> `Assoc [("type", `String "value"); ("value", `Int v)]
