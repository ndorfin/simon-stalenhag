# Case study: Simon Stålenhag's new site, optimised.

## Storing the original

To grab all the front-end assets of Simon's new homepage, I used the following command:

```
wget
    --page-requisites
    --adjust-extension
    --span-hosts
    --convert-links
    --restrict-file-names=windows
    --domains www.simonstalenhag.se
    https://www.simonstalenhag.se/new/index.html
```

After cleaning up, I stored it in the `00-original` folder.

Then I gradually made the following changes:

1. [`01-compressed-jpgs`](01-compressed-jpgs/index.html):
   - Tried compressing the thumbnail JPGs using TinyJPG.
1. [`02-html-updated`](02-html-updated/index.html): 
   - Update the HTML
   - Replace the CSS and inline in the HTML
   - Replace the GIFs with restricted-palette PNGs. 
   - Add responsiveness, so that the site can work on a mobile.
   - Try lazy-loading the images
   - Setting intrinsic image widths and heights to stop any layout shifts while they load.
1. [`03-no-lazy-loading`](03-no-lazy-loading/index.html): 
   - Take off the lazy loading so that we can compare like to like.
1. [`04-webp`](04-webp/index.html): 
   - Progressively-enhance the HTML by using the `<picture>` element, and adding `webp` as one of the `<source>`s.
1. [`05-avif`](05-avif/index.html): 
   - Uses AVIF in supporting browsers. I batch converted each of the JPGs into AVIFs with a 70% quality setting. 70% seemed to be the sweet spot between size and relative quality. I'm not sure why, but the gamma or colour settings for the conversion makes the images noticeably darker. I've tried manually setting the gamma, or reading from the ICC, but no luck. It could be browser-specific. Also, it's really difficult to compress images that have a deliberate graininess to them.

## Converting to AVIF

I found the following script on [felixparadis.com](https://www.felixparadis.com/posts/how-to-batch-convert-images-to-.avif/) which uses the excellent [`colorist`](https://joedrago.github.io/colorist/).

```sh
for i in *.jpg # Starts a loop over all .jpg files;
  do name=`echo "${i}"` # Assign the file name to a variable
  cleanedName=$(echo "$i" | cut -f 1 -d '.') # Remove the extension from the filename ("foo.jpg" becomes "foo")
  colorist convert "$name" "$cleanedName.avif" -q 70 # Tell colorist to convert your file to a .avif with an 70% lossy quality setting.
done
```

## Results

Version | Requests | Transferred | WebPageTest | Comments
--- | --- | --- | --- | ---
[00-original](00-original/index.html) | 60 | 7,819KB | [00](https://webpagetest.org/result/200929_Di2B_202bdecf2063c4b6c9a8ab39c9d2753b/) | Baseline
[01-compressed-jpgs](01-compressed-jpgs/index.html) | 60 | 6,394KB ✅ *(-1,425KB)* | [01](https://webpagetest.org/result/200929_DiTA_18be7082d9ad2708ba3e6302d3e07d62/) | TinyJPG is amazing.
[03-no-lazy-loading](03-no-lazy-loading/index.html) | 59 ✅ *(-1)* | 6,380KB ✅ *(-14KB)* | [03](https://webpagetest.org/result/200929_DiRJ_4b09841208346f8612cbf130ebc9dc9a/) | PNGs < GIFs. Inlined CSS.
[04-webp](04-webp/index.html) | 59 | 5,306KB ✅ *(-1,074KB)* | [04](https://webpagetest.org/result/200930_Di9Q_7a20d59d5f5aa6397e5cc3c0aec4c922/) | WebP & `picture` element sources

### With Lazy-loading of the offscreen images

Version | Requests | Transferred | WebPageTest | Comments
--- | --- | --- | --- | ---
[00-original](00-original/index.html) | 60 | 7,819KB | [00](https://webpagetest.org/result/200929_Di2B_202bdecf2063c4b6c9a8ab39c9d2753b/) | Baseline
[02-html-updated](02-html-updated/index.html) | 8 ✅ *(-52)* | 814KB ✅ *(-7,005KB)* | [02](https://webpagetest.org/result/200929_DiQR_741d747847dd6d124496081b16446136/) | Can we do better?

