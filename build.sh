#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
upstream_url=https://github.com/mycreationhaven/Arkovia-Blockchain.git
upstream_commit=dabcf44d51dcf5047118ca47347465a97b26369a

command -v git >/dev/null || { echo 'Install Git first.' >&2; exit 1; }
mkdir -p "$project_root/dist"
build_dir=$(mktemp -d "$project_root/dist/source.XXXXXX")
trap 'rm -rf "$build_dir"' EXIT

git -C "$build_dir" init -q
git -C "$build_dir" remote add origin "$upstream_url"
git -C "$build_dir" fetch --depth 1 origin "$upstream_commit"
git -C "$build_dir" checkout --detach FETCH_HEAD
[[ $(git -C "$build_dir" rev-parse HEAD) == "$upstream_commit" ]] || {
  echo 'Fetched source commit did not match the pinned revision.' >&2
  exit 1
}

cp -a "$project_root/linux" "$build_dir/linux"
bash "$build_dir/linux/build.sh"
cp "$build_dir/dist/arkovia-linux-full-node.tar.gz" \
   "$build_dir/dist/arkovia-linux-full-node.tar.gz.sha256" \
   "$project_root/dist/"
echo "Built $project_root/dist/arkovia-linux-full-node.tar.gz"
