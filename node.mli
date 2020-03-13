type t =
  Op of Token.operator * t * t
| Value of int

type tree = t

val to_json : t -> Yojson.t
