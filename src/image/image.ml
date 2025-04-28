(*
  imageCompressor - An image compressor written in OCaml
  @khalidbelk, 2025
  File: images.ml
*)

open Images
open Types
open K_means

let get_pixel img x y =
  let rgb = Rgb24.get img x y in
  (x, y), (rgb.r, rgb.g, rgb.b)

let get_all_pixels img w h =
  List.init h (fun y ->
    List.init w (fun x ->
      get_pixel img x y
    )
  ) |> List.flatten

let read_image filepath =
  try
    let img = Images.load filepath [] in
    match img with
    | Rgb24 img ->  (* Only handles Rgb24 format *)
        let width = img.width in
        let height = img.height in
        let pixels = get_all_pixels img width height
        in (pixels, (width, height))
    | _ -> failwith "Only RGB images are supported"
  with
  | exn -> failwith ("Error: " ^ Printexc.to_string exn)


let color_to_target (r, g, b) = { Color.r; g; b }

let reconstruct_image (pixels: pixel list) w h =
  (* Create blank image *)
  let img = Rgb24.create w h in
    (* Fill pixels *)
    List.iter (fun ((x,y), color) ->
      Rgb24.set img x y (color_to_target color)
    ) pixels;
  img

let save_image (img: Rgb24.t) =
  let filename = "compressed.jpg" in
  Images.save filename None [] (Images.Rgb24 img)

let compress_image k pixels w h =
  let k = int_of_string k in
  let compressed_pixels = k_means k 0.2 pixels ReplacePixels in
  match compressed_pixels with
  | Pixels ps ->
    let image = reconstruct_image ps w h in
    save_image image;
  | _ -> failwith "Unexpected result type"