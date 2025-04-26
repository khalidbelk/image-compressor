(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: file_io.ml
*)


(* Reads a file from the given filepath and returns its content *)
let read_file filepath  =
  let input_channel = open_in filepath in
  try
    let content = really_input_string input_channel (in_channel_length input_channel) in
    close_in input_channel;
    content
  with exn ->
    close_in input_channel;
    raise exn;
