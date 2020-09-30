for i in *.jpg # Starts a loop over all .jpg files;
  do name=`echo "${i}"` # Assign the file name to a variable
  colorist convert "$name" "$name" --resize 512
done