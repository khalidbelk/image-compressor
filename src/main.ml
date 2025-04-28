(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: main.ml
*)

open Utils
open File_io
open Parse_file
open K_means
open Image
open Types

let get_image_content filepath =
  let extension = get_file_extension filepath in
  if (is_valid_fileformat extension) then
    let img_data = read_image filepath in
    img_data
  else
    let valid_extensions_str = (String.concat ", " valid_extensions) in
    let error = Printf.sprintf "Unsupported file format: %s. Supported formats are %s" extension valid_extensions_str
    in failwith error

let get_file_content filepath =
  let content = read_file filepath in
  parse_content content

let print_clusterized n l pixels =
  let n = int_of_string n in
  let l = float_of_string l in
  match k_means n l pixels PrintClusters with
  | Clusters cs -> print_clusters cs
  | Pixels _ -> failwith "Unexpected result type"

(* Helper function to check optional arguments *)
let process_opt_arg rest =
  match rest with
  | [] -> None
  | [x] -> Some x
  | _ -> failwith "Too many arguments"

let main() =
  let args = Sys.argv in
  match Array.to_list args with
    | [ _; "-h" ] -> usage 0;
    | _ :: "-k" :: k :: img_filepath :: rest ->
      let (img_pixels, (width, height)) = get_image_content img_filepath in
      let image = compress_image k img_pixels width height in
      save_image image img_filepath (process_opt_arg rest)
    | [ _; "-n"; n; "-l"; l; "-f"; filepath ] ->
      let file_pixels = get_file_content filepath in
      print_clusterized n l file_pixels
    | _ -> usage 1

let () =
    main ()
