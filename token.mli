type bracket = Left | Right

type operator = Add | Minus | Multiply | Divide

type t =
  Bracket of bracket
| Op of operator
| Value of int
                     
val of_raw_token : RawToken.t -> t

val to_string : t -> string 
