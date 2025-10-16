(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: utils.ml
*)

let help_flag = ["-h";"--help"]

let is_help_flag arg = List.mem arg help_flag

let image_comp_usage =
  "IMAGE COMPRESSION MODE\n\n"
  ^ "\t./imageCompressor [OPTIONS] -k K <input_image_filepath> [<output_filepath>] \n\n"
  ^ "\tOPTIONS:\n"
  ^ "\t     -h | --help       display this message\n\n"
  ^ "\tARGS:\n"
  ^ "\t      K                      number of colors in the final image\n\n"
  ^ "\t     <output_filepath>       optional path/name for the compressed image
                                     Default: overwrites input image
    "
  ^ "\t\n"

let print_clustering_usage =
  "CLUSTERING-ONLY MODE\n\n"
  ^ "Needs a pixels (points and colors) file.\n"
  ^ "See the files inside 'examples/text-inputs' for reference\n\n"
  ^ "\t\n"
  ^ "\t./imageCompressor [OPTIONS] -n N -l L -f F \n\n"
  ^ "\tOPTIONS:\n"
  ^ "\t     -h | --help       display this message\n\n"
  ^ "\tARGS:\n"
  ^ "\t      N       number of colors in the final image\n"
  ^ "\t      L       convergence limit\n"
  ^ "\t      F       path to the file containing the colors of the pixels"
  ^ "\t\n"

let usage exitcode =
  print_endline "\n";
  print_endline "/------------------------------------ USAGE ------------------------------------\\ \n";
  print_endline image_comp_usage;
  print_endline "------------------------------------------------------\n";
  print_endline print_clustering_usage;
  print_endline "\\-------------------------------------------------------------------------------/ \n";
  exit exitcode
