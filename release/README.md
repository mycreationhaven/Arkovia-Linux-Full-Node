# Compiled package

The previously validated Linux package checksum in this folder belongs to an older pinned Arkovia source revision and must not be presented as the checksum for the signer-enabled package.

Build the current pinned source revision with:

```bash
bash build.sh
```

The build creates:

- `dist/arkovia-linux-full-node.tar.gz`
- `dist/arkovia-linux-full-node.tar.gz.sha256`

The current source pin includes the installable Arkovia Signer PWA under `html/www/signer/`. Always use the checksum generated beside the package you actually build.
