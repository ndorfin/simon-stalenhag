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

All results include a 342B 404 for the `favicon.ico` request that every website should honour.