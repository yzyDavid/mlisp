open Core

let inp = "(+ (- 2 3) (* (+ 13 17) 7))"

let () =
  let tokenized = Lexer.tokenize inp in
  printf "tokenize result:";
  List.iter tokenized ~f:(fun w -> (printf " %s" (Token.to_string w)));
  printf "\nparse result:\n";
  let parsed = Parser.parse tokenized in
  let json = Node.to_json parsed in
  printf "%s" (Yojson.pretty_to_string json);
  let result = Eval.eval parsed in
  printf "\neval result: %i\n" result
