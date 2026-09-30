"""Explicit external storage for the preserved Pro arithmetic scripts."""
import argparse
from pathlib import Path

def certificate_dir():
    parser=argparse.ArgumentParser()
    parser.add_argument("--data-dir",type=Path,required=True,
                        help="Directory outside litt3 containing/generated for certificate JSON")
    path=parser.parse_args().data_dir.resolve()
    workspace=Path(__file__).resolve().parents[3]
    if path.is_relative_to(workspace):
        parser.error("Certificate data must be outside the litt3 workspace")
    return path
