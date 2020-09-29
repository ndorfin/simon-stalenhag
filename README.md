## Storing the original

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

## Results

Version | Requests | Transferred | Comments
--- | --- | --- | ---
[original](00-original/index.html) | 62 | 8,042KB | baseline, no gzip.
[compressed-jpgs](01-compressed-jpgs/index.html) | 62 | 6,582KB ✅ *(-1,460KB)* | TinyJPG applied to existing JPGs
[html-updated](02-html-updated/index.html) | 60 ✅ *(-2)* | 6,561KB ✅ *(-21KB)* | Inlined CSS, Updated HTML, replaced GIFs with form-fitting PNGs, added lazy-loading images, added mobile browser support.

All results include a 342B 404 for the `favicon.ico` request that every website should honour.