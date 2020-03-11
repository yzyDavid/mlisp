open Core

let inp = "(+ (* 3234 264) (- 2756 1123))"

let () =
  List.iter (Lexer.tokenize inp) ~f:(fun w -> (printf "%s\n" (Token.to_string w)))
