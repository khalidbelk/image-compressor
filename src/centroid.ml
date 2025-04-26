(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: centroid.ml
*)

open Math

(* Returns [(d, c)] where 'd' is color distance between centroid 'c' and input color *)
let with_distances centroids color =
  centroids
    |> List.map (fun c -> (Math.color_distance c color, c))

(* Returns true if any centroid pair exceeds color distance limit.
   Requires: Lists same length and order *)
let centroids_moved old_centroids new_centroids limit =
  List.exists2 (fun c1 c2 ->
      Math.color_distance c1 c2 > limit
  ) old_centroids new_centroids

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

(* Returns [(nearest_centroid, pixel)] pairs for all pixels. *)
let assign_to_centroids pixels centroids =
  pixels
  |> List.map(fun pixel ->
      let color = snd pixel in
      (nearest_centroid color centroids, pixel)
  )

(* Groups [(centroid, pixel)] pairs into clusters as [(centroid, [pixel])].*)
let group_by_centroid pairs =
  pairs
  |> List.sort (fun (c1,_) (c2,_) -> compare c1 c2)
  |> List.fold_left (fun acc (centroid, pixel) ->
      match acc with
      | (current_c, pixels) :: rest when current_c = centroid ->
          (current_c, pixel :: pixels) :: rest
      | _ ->
          (centroid, [pixel]) :: acc
    ) []
  |> List.map (fun (c, ps) -> (c, List.rev ps))  (* Preserve order *)
