(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: main.ml
*)

open K_means

let usage exitcode =
  print_endline "USAGE: ./imageCompressor -n N -l L -f F\n";
  print_endline "      N       number of colors in the final image";
  print_endline "      L       convergence limit";
  print_endline "      F       path to the file containing the colors of the pixels";
  exit exitcode

let main() =
  let args = Sys.argv in
  match Array.to_list args with
    | [ _; "-h" ] -> usage 0;
    | [ _; "-n"; n; "-l"; l; "-f"; filepath ] ->
        k_means (int_of_string n) (float_of_string l) filepath
    | _ -> usage 1

let () =
    main ()