#!/usr/bin/env python3
import argparse
import itertools
import pandas as pd
import matplotlib.pyplot as plt

def plot_cactus(csv_file, output_file, type):
    """Read data from the CSV file and generate a cactus plot using gnuplotlib."""
    df_raw = pd.read_csv(csv_file, index_col=0)
    # print(df_raw)

    df = df_raw.reset_index(drop=True)
    df = df.apply(sorted, axis=0)
    # print(df)

    obj_columns = [
        (f"mp-is-p-low-{type}", "MP+IS Low"),
        (f"mp-is-p-mid-{type}", "MP+IS Mid"),
        (f"mp-is-p-hi-{type}", "MP+IS High"),
        # (f"mp-ps-p-low-{type}", "MP+PS Low"),
        # (f"mp-ps-p-mid-{type}", "MP+PS Mid"),
        # (f"mp-ps-p-hi-{type}", "MP+PS High"),
        (f"mp-p-low-{type}", "MP Low"),
        (f"mp-p-mid-{type}", "MP Mid"),
        (f"mp-p-hi-{type}", "MP High"),
        (f"lnps-{type}", "LNPS"),
    ]

    plt.figure(figsize=(10, 6))

    line_styles = [
     (0, (1, 1)),       # densely dotted
     (0, (3, 3)),       # dashed
     (0, (3, 2, 1, 2)), # densely dashdotted
    ]
    colors = [
        '#d62728', '#ff9896', '#e15759',  # Red shades
        '#2ca02c', '#98df8a', '#60bd68',  # Green shades
        '#9467bd', '#c5b0d5', '#8c6bb1',  # Purple shades
        '#ff7f0e', '#ffbb78', '#ff9f50',  # Orange shades
    ]

    markers = ['s', '^', 'D', 'x', '*', 'p', 'H', 'v', '<', '>']

    # Plot each '-obj' column with different line styles
    for idx, col in enumerate(obj_columns):
        line_style = 'solid'
        color = 'tab:blue'
        marker = 'o'
        if idx < len(obj_columns) - 1:
            line_style = line_styles[idx % len(line_styles)]
            color = colors[idx % len(colors)]
            marker = markers[idx % len(markers)]
        plt.plot(range(1, len(df[col[0]]) + 1), df[col[0]], label=col[1], linestyle=line_style, color=color, marker=marker, markersize=5, alpha=0.9)

    plt.xlabel("Instance")
    if type == "obj":
        plt.ylabel("Objective Value")
        #plt.yscale('log')
        #plt.ylim(0.0001, 10000)
        #plt.ylim(0, 10000)
    elif type == "diff":
        plt.ylabel("Differences")
    elif type == "freq":
        plt.ylabel("Frequency")
    plt.legend(loc='center left', bbox_to_anchor=(1, 0.5), handlelength=4)  # Move legend to the right side
    plt.grid()

    plt.tight_layout()

    # Modify output filename to include type
    output_file = f"{output_file.rsplit('.', 1)[0]}-{type}.{output_file.rsplit('.', 1)[1]}"

    # Save as a vector format (e.g., SVG or PDF)
    plt.savefig(output_file, format=output_file.split('.')[-1])
    print(f"Saved plot to {output_file}")

def main():
    parser = argparse.ArgumentParser(description="Plot a cactus plot from a CSV file using gnuplotlib.")
    parser.add_argument("csv_file", type=str, help="Path to the input CSV file")
    parser.add_argument("output_file", type=str, help="Path to save the output vector file (e.g., output.svg or output.pdf)")
    args = parser.parse_args()

    plot_cactus(args.csv_file, args.output_file, "obj")
    plot_cactus(args.csv_file, args.output_file, "diff")
    plot_cactus(args.csv_file, args.output_file, "freq")

if __name__ == "__main__":
    main()

