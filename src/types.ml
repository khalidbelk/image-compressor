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