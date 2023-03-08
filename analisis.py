import pandas as pd
import seaborn as sns
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy import stats
import sys

# Read data from standard input (pipe).
data = sys.stdin.readlines()

# Create a pandas DataFrame from the data.
df = pd.DataFrame({'Data': data})

# Convert the 'Data' column to numeric values.
df['Data'] = pd.to_numeric(df['Data'], errors='coerce')
sns.despine()
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
plt.close()
