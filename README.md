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


## Results

Version | Requests | Transferred | WebPageTest | Comments
--- | --- | --- | --- | ---
[00-original](00-original/index.html) | 60 | 7,819KB | [00](https://webpagetest.org/result/200929_Di2B_202bdecf2063c4b6c9a8ab39c9d2753b/) | Baseline
[01-compressed-jpgs](01-compressed-jpgs/index.html) | 60 | 6,394KB ✅ *(-1,425KB)* | [01](https://webpagetest.org/result/200929_DiTA_18be7082d9ad2708ba3e6302d3e07d62/) | TinyJPG is amazing.
[03-no-lazy-loading](03-no-lazy-loading/index.html) | 59 ✅ *(-1)* | 6,380KB ✅ *(-14KB)* | [03](https://webpagetest.org/result/200929_DiRJ_4b09841208346f8612cbf130ebc9dc9a/) | PNGs < GIFs. Inlined CSS.

### With Lazy-loading of the offscreen images

Version | Requests | Transferred | WebPageTest | Comments
--- | --- | --- | --- | ---
[02-html-updated](02-html-updated/index.html) | 8 ✅ *(-52)* | 814KB ✅ *(-21KB)* | [02](https://webpagetest.org/result/200929_DiQR_741d747847dd6d124496081b16446136/) | 
