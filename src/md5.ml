(* 
  opam install core
  opam install cryptokit
  ocamlfind ocamlc -linkpkg -thread -package core,Cryptokit  md5.ml -o md5.byte
*)
open Core

let do_hash file = 
  In_channel.with_file file ~f:(fun ic -> 
    let open Cryptokit in
    hash_channel (Hash.md5 ()) ic
    |> transform_string (Hexa.encode ())
    |> print_endline
  )


let spec =
  let open Command.Spec in
  empty
  +> anon ("filename" %: string)

let command = 
  Command.basic
  ~summary: "md5 builder"
  ~readme: (fun () -> "readme")
  spec
  (fun filename () -> do_hash filename)


let () =
  Command.run ~version:"1.0" ~build_info:"rwo" command