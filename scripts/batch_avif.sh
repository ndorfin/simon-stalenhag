for i in *.jpg # Starts a loop over all .jpg files;
  do name=`echo "${i}"` # Assign the file name to a variable
  cleanedName=$(echo "$i" | cut -f 1 -d '.') # Remove the extension from the filename ("foo.jpg" becomes "foo")
  colorist convert "$name" "$cleanedName.avif" -q 80 # Tell colorist to convert your file to a .avif with an 80% lossy quality setting.
done