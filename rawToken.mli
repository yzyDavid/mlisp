type t
(** string *)

val of_string: string -> t

val to_string: t -> string

val split_sign : string -> t list
