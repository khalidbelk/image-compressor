(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: parse_file.ml
*)

open Types

(* Parse a single integer *)
let parse_int str : int =
  try int_of_string str
  with _ -> failwith ("Invalid integer: " ^ str)

(* Parse a single point *)
let parse_point str : point =
  Scanf.sscanf str "(%d,%d)" (fun x y -> (x, y))

(* Parse a single color *)
let parse_color str : color =
  Scanf.sscanf str "(%d,%d,%d)" (fun r g b -> (r, g, b))

let parse_content content =
  content
    |> String.split_on_char '\n'
    |> List.filter (fun line -> line <> "")
    |> List.map (fun line ->
      match String.split_on_char ' ' line with
      | [point_str; color_str] ->
          (parse_point point_str, parse_color color_str)
      | _ -> failwith ("Invalid line format : " ^ line)
    )