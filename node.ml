type t =
  Op of Token.operator * t * t
| Value of int

type tree = t
