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
1. [`06-mobile-optimised`](06-mobile-optimised/index.html): 
   - Add lazy loading back
   - Halve the size of all images and use them as the default image for mobile-sized devices. See the [`batch_half_size.sh`](scripts/batch_half_size.sh) in the `scripts` folder
   - Serve the 1024px-wide images to any device with a screen-width greater than 584px.

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
[05-avif](05-avif/index.html) | 59 | 2,993KB ✅ *(-2,313KB)* | [05](https://webpagetest.org/result/200930_DiRR_8c363b8bc1c530bbc37b3679036ec477/) | AVIF added to `picture` element sources

[View a comparison of all the desktop-sized WebPageTest runs](https://webpagetest.org/video/compare.php?tests=200930_DiRR_8c363b8bc1c530bbc37b3679036ec477%2C200930_Di9Q_7a20d59d5f5aa6397e5cc3c0aec4c922%2C200929_DiRJ_4b09841208346f8612cbf130ebc9dc9a%2C200929_DiTA_18be7082d9ad2708ba3e6302d3e07d62%2C200929_Di2B_202bdecf2063c4b6c9a8ab39c9d2753b&thumbSize=150&ival=100&end=visual)

### With Lazy-loading of the offscreen images on a mobile

Version | Requests | Transferred | WebPageTest | Comments
--- | --- | --- | --- | ---
[00-original](00-original/index.html) | 60 | 7,819KB | [00](https://webpagetest.org/result/200930_DiX6_75eef9a4a9788b4f33303e2b49ac3a8b/) | Baseline
[02-html-updated](02-html-updated/index.html) | 16 ✅ *(-44)* | 1,913KB ✅ *(-5,906KB)* | [02](https://webpagetest.org/result/200930_DiQE_2fe78ee998061370d09e49ac318ef993/) | Can we do better?
[06-mobile-optimised](06-mobile-optimised/index.html) | 17 ❌ *(+1)* | 287KB ✅ *(-1,626KB)* | [06](https://webpagetest.org/result/200930_DiHN_ca70282e5c557f96f0c842c59efb5c45/) | Yes we can.

[Compare the various WebPageTests done on a Moto G6](https://webpagetest.org/video/compare.php?tests=200930_DiX6_75eef9a4a9788b4f33303e2b49ac3a8b,200930_DiQE_2fe78ee998061370d09e49ac318ef993,200930_DiHN_ca70282e5c557f96f0c842c59efb5c45)