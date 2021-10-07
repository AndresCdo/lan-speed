import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
from scipy import stats

df = pd.read_csv('data.csv')
df = df[(np.abs(stats.zscore(df)) < 3).all(axis=1)].dropna()
sns.histplot(df[(np.abs(stats.zscore(df)) < 3).all(axis=1)],bins=100)
plt.xlabel("Milisecons")
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
plt.close()
