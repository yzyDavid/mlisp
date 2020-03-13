let rec eval = function
  | Node.Value v -> v
  | Node.Op (op, v1, v2) ->
     match op with
     | Token.Add -> (+) (eval v1) (eval v2)
     | Token.Minus -> (-) (eval v1) (eval v2)
     | Token.Multiply -> ( * ) (eval v1) (eval v2)
     | Token.Divide -> (/) (eval v1) (eval v2)
