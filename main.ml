open Core

let inp = "(+ 1 2)"

let () =
  let tokenized = Lexer.tokenize inp in
  printf "tokenize result:";
  List.iter tokenized ~f:(fun w -> (printf " %s" (Token.to_string w)));
  printf "\ncompute result: ";
  let _parsed = Parser.parse tokenized in
  ()
