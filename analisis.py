import pandas as pd
import seaborn as sns
import numpy as np
from scipy import stats
from pyfiglet import Figlet

import matplotlib.pyplot as plt

def plot_speed_analysis(data_file):
  # Load the data from the CSV file
  df = pd.read_csv(data_file)

  # Remove outliers using z-score
  z_scores = np.abs(stats.zscore(df))
  df = df[(z_scores < 3).all(axis=1)].dropna()

  # Create a histogram plot
  sns.histplot(df, bins=100)

  # Set plot labels and title
  plt.xlabel("Milliseconds")
  plt.ylabel("Frequency")
  plt.title("LAN Speed Analysis")

  # Save the plot as an image file
  plt.savefig('images/plot.png', dpi=300, bbox_inches='tight')
  plt.close()

def print_banner(text):
  f = Figlet(font='slant')
  print(f.renderText(text))

# Main function
if __name__ == "__main__":
  print_banner('LAN Speed')
  # Read from parameters
  import sys
  data_file = sys.argv[1]
  plot_speed_analysis(data_file)
