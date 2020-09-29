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


## Results

Version | Requests | Transferred | Comments
--- | --- | --- | ---
[00-original](00-original/index.html) | 62 | 8,042KB | baseline
[01-compressed-jpgs](01-compressed-jpgs/index.html) | 62 | 6,582KB ✅ *(-1,460KB)* | Images account for the most bytes sent over the wire.
[02-html-updated](02-html-updated/index.html) | 60 ✅ *(-2)* | 6,561KB ✅ *(-21KB)* | Saved two requests. Most of the byte saving here was by replacing the GIFs with PNGs.
[03-no-lazy-loading](03-no-lazy-loading/index.html) | 60 | 6,561KB | For real-world testing, without lazy-loading.

All results:
- are tested on my local machine
- don't have gzip enabled
- include a 342B 404 for the `favicon.ico` request that every website should honour.