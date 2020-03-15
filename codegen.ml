let context = Llvm.global_context ()
let the_module = Llvm.create_module context "mlisp ctx module"
let builder = Llvm.builder context
let mlisp_int_type = Llvm.i64_type context

let rec gen_subtree = function
  | Node.Value v -> Llvm.const_int mlisp_int_type v
  | Op (op, lhs_node, rhs_node) ->
     let lhs = gen_subtree lhs_node in
     let rhs = gen_subtree rhs_node in
     begin
       match op with
       | Token.Add -> Llvm.build_add lhs rhs "add_" builder
       | Token.Minus -> Llvm.build_sub lhs rhs "sub_" builder
       | Token.Multiply -> Llvm.build_mul lhs rhs "mul_" builder
       | Token.Divide -> Llvm.build_udiv lhs rhs "div_" builder
     end

let codegen tree =
  let top_func_type = Llvm.function_type mlisp_int_type [||] in
  let func = Llvm.declare_function "__entry" top_func_type the_module in
  let bb = Llvm.append_block context "__entry_block" func in
  Llvm.position_at_end bb builder;
  let retval = gen_subtree tree in
  let _: Llvm.llvalue = Llvm.build_ret retval builder in
  Llvm_analysis.assert_valid_function func;
  func
