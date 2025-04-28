(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: main.ml
*)

open File_io
open Parse_file
open K_means
open Image
open Types

let usage exitcode =
  print_endline "USAGE: ./imageCompressor -n N -l L -f F\n";
  print_endline "      N       number of colors in the final image";
  print_endline "      L       convergence limit";
  print_endline "      F       path to the file containing the colors of the pixels";
  exit exitcode

let get_image_content filepath =
  if Filename.check_suffix filepath ".jpg" || Filename.check_suffix filepath ".jpeg" then
    let img_data = read_image filepath in
    img_data
  else
    failwith ("Unsupported file format. Only JPG or JPEG are supported.")

let get_file_content filepath =
  let content = read_file filepath in
  parse_content content

let print_clusterized n l pixels =
  let n = int_of_string n in
  let l = float_of_string l in
  match k_means n l pixels PrintClusters with
  | Clusters cs -> print_clusters cs
  | Pixels _ -> failwith "Unexpected result type"

let main() =
  let args = Sys.argv in
  match Array.to_list args with
    | [ _; "-h" ] -> usage 0;
    | [ _; "-k"; k; img_filepath ] ->
      let (img_pixels, (width, height)) = get_image_content img_filepath in
      compress_image k img_pixels width height
    | [ _; "-n"; n; "-l"; l; "-f"; filepath ] ->
      let file_pixels = get_file_content filepath in
      print_clusterized n l file_pixels
    | _ -> usage 1

let () =
    main ()
