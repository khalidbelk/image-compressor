(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: k_means.ml
*)

open Types
open Centroid
open Colors

(* Generates n random colors. Used to generate the initial centroids *)
let generate_randcolors n =
  if n <= 0 then [] else
  List.init n (fun _ -> (Random.int 255, Random.int 255, Random.int 255))

let calc_new_centroids clusters =
  clusters
  |> List.map (fun (_, cluster_pixels) ->
      mean_color cluster_pixels
  )

(* Groups (centroid, pixel) pairs into actual clusters *)
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

(* Returns grouped clusters *)
let get_clusters pixels centroids =
  let assigned = assign_to_centroids pixels centroids in
  let grouped = group_by_centroid assigned
  in grouped

(* Returns the clusters and its pixels *)
let clusterize n l pixels =
  let first_centroids = generate_randcolors n in
  let rec loop centroids =
    let clusters = get_clusters pixels centroids in
    let new_centroids = calc_new_centroids clusters in
    if centroids_moved centroids new_centroids l then
        loop new_centroids
    else clusters (* Return clusters *)
  in
    loop first_centroids (* Call the loop *)

let print_clusters clusters =
  List.iter (fun (centroid, pixels) ->
    let (r, g, b) = centroid in
    Printf.printf "--\n(%d,%d,%d)\n-\n" r g b;
    List.iter (fun ((x, y), color) ->
      let (color_r, color_g, color_b) = color in
      Printf.printf "(%d,%d) (%d,%d,%d)\n" x y color_r color_g color_b
    ) pixels
  ) clusters

let replace_pixels_by_centroid clusterized =
  let new_colors_list =
    List.map (fun (centroid, pixels) ->
      let (r, g, b) = centroid in
      List.map (fun ((x, y), _) ->
        ((x, y), (r, g , b))     (* Replace color with centroid *)
      ) pixels
    ) clusterized
  in new_colors_list |> List.flatten

let k_means nb_clusters divergence_limit pixels action =
  let clusterized = clusterize nb_clusters divergence_limit pixels
  in
    match action with
    | PrintClusters -> Clusters clusterized
    | ReplacePixels -> Pixels (replace_pixels_by_centroid clusterized)
