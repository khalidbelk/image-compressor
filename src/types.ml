(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: types.ml
*)

type point = int * int

type color = int * int * int

type pixel = point * color

type cluster = {
  centroid: color;
  members: pixel list
}

(* Used for k_means *)
type action = PrintClusters | ReplacePixels

type result =
  | Clusters of (color * pixel list) list
  | Pixels of pixel list
