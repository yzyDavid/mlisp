open Core

let tokenize text =
  let open List in
  let s = String.split text ~on:' ' in
  let raw_toks_to_con = s
                        |> filter ~f:(fun s -> String.(<>) s "")
                        >>| RawToken.split_sign
  in
  let raw_toks = concat raw_toks_to_con in
  map ~f:Token.of_raw_token raw_toks
