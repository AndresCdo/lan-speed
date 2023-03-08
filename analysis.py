import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from pandas import DataFrame,to_numeric
from seaborn import despine, histplot
from scipy import stats
from numpy import abs
from sys import stdin

# Read data from standard input (pipe).
data = stdin.readlines()

for i in range(len(data)):
    data[i] = data[i].strip()

# Create a pandas DataFrame from the data.
df = DataFrame({'Data': data})

# Convert the 'Data' column to numeric values.
df['Data'] = to_numeric(df['Data'], errors='coerce')

# Remove any rows with missing or invalid data.
df = df.dropna()

# Remove any rows with outliers (i.e., data more than 3 standard deviations away from the mean).
df = df[(abs(stats.zscore(df)) < 3).all(axis=1)]

# Plot a histogram of the data.
histplot(df, bins=100)
plt.xlabel("Milliseconds")
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
plt.close()
