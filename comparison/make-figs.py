#!/usr/bin/env python3
import argparse
import itertools
import pandas as pd
import matplotlib.pyplot as plt

def plot_cactus(csv_file, output_file, type):
    """Read data from the CSV file and generate a cactus plot using gnuplotlib."""
    df_raw = pd.read_csv(csv_file, header=None)

    # Reshape the data into key-value pairs
    data = {}
    for i in range(1, df_raw.shape[1], 2):
        col_name = df_raw.iloc[:, i].iloc[0]  # Get the column name from the first row
        values = df_raw.iloc[0:, i + 1].reset_index(drop=True)  # Get corresponding values
        data[col_name] = values.sort_values(ascending=True).reset_index(drop=True)

    df = pd.DataFrame(data)

    #print(df)

    obj_columns = [
        (f"mp-is-p1-{type}", "MP+IS O>P"),
        (f"mp-is-p2-{type}", "MP+IS O=P"),
        (f"mp-is-p3-{type}", "MP+IS O<P"),
        (f"mp-ps-p1-{type}", "MP+PS O>P"),
        (f"mp-ps-p2-{type}", "MP+PS O=P"),
        (f"mp-ps-p3-{type}", "MP+PS O<P"),
        (f"mp-p1-{type}", "MP O>P"),
        (f"mp-p2-{type}", "MP O=P"),
        (f"mp-p3-{type}", "MP O<P"),
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
        plt.yscale('log')
    elif type == "diff":
        plt.ylabel("Differences")
    else:
        plt.ylabel("Time [s]")
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
    plot_cactus(args.csv_file, args.output_file, "time")

if __name__ == "__main__":
    main()

