(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: math.ml
*)

(* Calculates the euclidean distance between two 3d integer tuples. *)
let euclidean_distance a b: float =
  let (x1, y1, z1) = a in
  let (x2, y2, z2) = b in
  let dx = float_of_int (x2 - x1) in
  let dy = float_of_int (y2 - y1) in
  let dz = float_of_int(z2 - z1) in
  sqrt( (dx *. dx) +. (dy *. dy) +. (dz *. dz) )


(* Returns the euclidean distance between two RGB colors as (r,g,b) tuples. *)
let color_distance (r1, g1, b1) (r2, g2, b2) =
    euclidean_distance (r1, g1, b1) (r2, g2, b2)
