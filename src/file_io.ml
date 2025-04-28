(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: file_io.ml
*)

let valid_extensions = [".JPG"; ".PNG"; ".JPEG"]

let get_file_extension filepath =
  Filename.extension filepath

let is_valid_fileformat extension =
  List.mem (String.uppercase_ascii extension) valid_extensions

(* If no output is precised for the output filename it
   appends the input filename's extension *)
let handle_out_name input_filepath output_filename =
  let input_extension = get_file_extension input_filepath in
  let out_extension = get_file_extension output_filename in
  if out_extension = "" then
      output_filename ^ input_extension
  else
      output_filename

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
