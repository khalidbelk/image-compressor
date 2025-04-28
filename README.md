## Image Compressor

An implementation of the **K-means clustering algorithm** for image compression done in **OCaml**.
Inspired by the same project done during the second year at **Epitech**, originally written in Haskell for the **Functional Programming** course.

This version reproduces the core **pixel clustering** functionality and also includes actual image compression, which was a **bonus** feature in the original assignment.

<table align="center">
  <tr>
    <td><img src="examples/inputs/sahara.jpg" height="200"/></td>
    <td><img src="examples/outputs/sahara_k10.jpg" height="200"/></td>
    <td><img src="examples/outputs/sahara_k3.jpg" height="200"/></td>
  </tr>
  <tr align="center">
    <td><i>Original</i></td>
    <td><i>k = 10</i></td>
    <td><i>k = 3</i></td>
  </tr>
</table>

<br>

For other examples see [this directory](/examples/)


## Usage

**Steps**

1. Clone this repository and open it

2. **Compile** the program with the command

```
make
```

3. Then you can use it as specified here :

For **image** compression

```
USAGE: ./imageCompressor -k K <path_to_image.jpg>

      K       number of colors in the final image
```

**Example**

`$ ./imageCompressor -k 16 my_photo.jpg`

<br>

For **pixel clusterization** (the input file should contain points and colors).

Here are some [input files examples](/examples/text-inputs/)

```
USAGE: ./imageCompressor -n N -l L -f F

      N       number of colors in the final image
      L       convergence limit
      F       path to the file containing the colors of the pixels
```
**Example**

`$ ./imageCompressor -n 3 -l 0.2 -f input.txt`