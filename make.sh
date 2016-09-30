#!/bin/sh

imga=$1
imgb=$2
dir=$3
size=$4

# create a directory
mkdir $dir

# resize the icon
convert $imga -resize $size $dir/resize_icon1.png
convert $imgb -resize $size $dir/resize_icon2.png
#cp $imga $dir/resize_icon1.png
#cp $imgb $dir/resize_icon2.png

# mix the icon and the flags
mkdir $dir/flags_resized_mixed
for i in `seq 0 100`
do
  inv=`expr 100 - $i`
  echo "$i  $inv"
  fil=$(printf "tmp_%03d" $i)
  composite -dissolve $i%x$inv% $dir/resize_icon1.png $dir/resize_icon2.png $dir/flags_resized_mixed/$fil.png
done
for i in `seq 101 200`
do
  j=`expr 200 - $i`
  inv=`expr 100 - $j`
  echo "$j  $inv"
  fil=$(printf "tmp_%03d" $i)
  composite -dissolve $j%x$inv% $dir/resize_icon1.png $dir/resize_icon2.png $dir/flags_resized_mixed/$fil.png
done

# make it an animated gif
#convert -delay 1 -loop 0 $dir/flags_resized_mixed/resize_*.png $dir/icon_movie.gif

# make it an movie
#ffmpeg -r 30 -i $dir/flags_resized_mixed/tmp_%3d.png -vcodec libx264 -pix_fmt yuv420p -s $size $dir/icon_movie.mp4
ffmpeg -r 30 -i $dir/flags_resized_mixed/tmp_%3d.png -vcodec libx264 -pix_fmt yuv420p $dir/icon_movie.mp4
#cp $dir/icon_movie.mp4 $img.mp4

exit 0
