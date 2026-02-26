#!/usr/bin/env python3
"""Download Infinite-World checkpoints from Hugging Face without symlinks."""

# from __future__ import annotations

import argparse
from pathlib import Path

from huggingface_hub import snapshot_download


# DEFAULT_REPO_ID = "MeiGen-AI/Infinite-World"
# DEFAULT_PATTERNS = [
#     "models/Wan2.1_VAE.pth",
#     "models/models_t5_umt5-xxl-enc-bf16.pth",
#     "models/google/umt5-xxl/*",
#     "infinite_world_model.ckpt",
# ]


# def parse_args() -> argparse.Namespace:
#     parser = argparse.ArgumentParser(
#         description="Download Infinite-World files from Hugging Face without symlinks."
#     )
#     parser.add_argument(
#         "--repo-id",
#         default=DEFAULT_REPO_ID,
#         help=f"Hugging Face repo id (default: {DEFAULT_REPO_ID})",
#     )
#     parser.add_argument(
#         "--dest",
#         default="checkpoints",
#         help="Destination directory for downloaded files (default: checkpoints)",
#     )
#     parser.add_argument(
#         "--all",
#         action="store_true",
#         help="Download the full repository snapshot (default: download required files only).",
#     )
#     parser.add_argument(
#         "--revision",
#         default=None,
#         help="Optional repo revision (branch/tag/commit).",
#     )
#     parser.add_argument(
#         "--token",
#         default=None,
#         help="Optional HF token. If omitted, uses cached login or HF_TOKEN/HUGGINGFACE_HUB_TOKEN.",
#     )
#     return parser.parse_args()


def main() -> None:
    # args = parse_args()
    # dest_dir = Path(args.dest).expanduser().resolve()
    # dest_dir.mkdir(parents=True, exist_ok=True)

    # allow_patterns = None if args.all else DEFAULT_PATTERNS
    # if allow_patterns is None:
    #     print(f"Downloading full snapshot from {args.repo_id} to {dest_dir}")
    # else:
    #     print(f"Downloading required checkpoint files from {args.repo_id} to {dest_dir}")
    #     for pattern in allow_patterns:
    #         print(f"  - {pattern}")

    local_path = snapshot_download(
        repo_id="MeiGen-AI/Infinite-World",
        # repo_type="model",
        local_dir="/workspace/Infinite-World/download",
        local_dir_use_symlinks=False,
        # allow_patterns=allow_patterns,
        # revision=args.revision,
        # token=args.token,
    )

    print(f"Done. Files downloaded to: {local_path}")


if __name__ == "__main__":
    main()
