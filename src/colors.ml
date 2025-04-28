(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: color.ml
*)

open Centroid

let round x = int_of_float (x +. 0.5)

(* Finds the nearest centroid for a given color. *)
let nearest_centroid color centroids =
  let pairs = with_distances centroids color in
  match pairs with
  | [] -> invalid_arg "Empty centroids list"
  | first :: rest ->
      let _, best =
        List.fold_left (fun (current_min, best_c) (dist, c) ->
          if dist < current_min then (dist, c)
          else (current_min, best_c)
        ) first rest
      in
        best (* Return centroid only *)

(* Calculates the mean color of all pixels in a cluster *)
let mean_color pixels =
  let colors_list =
    pixels |> List.map (fun ((_, _), (r, g, b)) -> (r, g, b))
  in
    let sum_r, sum_g, sum_b =
      List.fold_left (fun (acc_r, acc_g, acc_b) (r, g, b) ->
        (acc_r + r, acc_g + g, acc_b + b)
      ) (0, 0, 0) colors_list
  in
    let count = float_of_int (List.length colors_list) in
    ( round (float_of_int sum_r /. count),
      round  (float_of_int sum_g /. count),
      round  (float_of_int sum_b /. count) )