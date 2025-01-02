#!/usr/bin/env python3
import argparse
from showmodel import read_model

def main():
    parser = argparse.ArgumentParser(description="Read a model from a file and display the shift table.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("file", nargs="?", default="found-model.lp", help="Model file to read")
    parser.add_argument("-o", "--output", type=str, default="reused-model.lp", help="Output file for models")

    args = parser.parse_args()

    atoms = read_model(args.file)

    with open(args.output, 'w') as out:
        for atom in atoms:
            if atom.match("assigned", 2) or atom.match("assigned", 3):
                print(f'legacy({atom}).', file=out)

if __name__ == "__main__":
    main()