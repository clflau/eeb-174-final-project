
# coding: utf-8

# In[1]:

"""
This python code will take the Aurelia expression count data and calculate the average expression levels across
the biological replicates of each of the life stages of Aurelia. 
"""

# First read in the file with the expression count data
# Data should be structured as tab separated file with 19 columns
# First column is geneID
# Next two columns are for 'early planula'
# Next two columns are for 'late planula'
# Next three columns are for 'polyps'
# Next three columns are for 'early strobila'
# Next three columns are for 'late strobila'
# Next three columns are for 'ephyra'
# Final two columns are for 'juvenile'

import numpy as np
import pandas as pd

file_to_open = input("Enter the name of the input file: ")
with open(file_to_open) as expression_data:
    expression_data.readline()
    data_array = pd.read_csv(file_to_open, sep = "\t", header = 0)
    


# In[11]:

e_plan_mean = data_array.iloc[ : , [0, 1]].mean(axis = 1).round(4)
l_plan_mean = data_array.iloc[ : , [2, 3]].mean(axis = 1).round(4)
polyp_mean = data_array.iloc[ : , [4, 5, 6]].mean(axis = 1).round(4)
e_strob_mean = data_array.iloc[ : , [7, 8, 9]].mean(axis = 1).round(4)
l_strob_mean = data_array.iloc[ : , [10, 11, 12]].mean(axis = 1).round(4)
ephyra_mean = data_array.iloc[ : , [13, 14, 15]].mean(axis = 1).round(4)
juven_mean = data_array.iloc[ : , [16, 17]].mean(axis = 1).round(4)


# In[13]:

mean_matrix = pd.concat([e_plan_mean, l_plan_mean, polyp_mean, e_strob_mean, l_strob_mean, ephyra_mean, juven_mean], axis = 1)
mean_matrix.columns = ["early planula", "late planula", "polyp", "early strobila", "late strobila", "ephyra", "juvenile"]


file_to_write_to = input("Enter the name of the file to write to: ")
mean_matrix.to_csv(file_to_write_to, sep = '\t')


# In[11]:

#####################################################################################################################
# # Testbed

# # Figuring out how pandas constructs dataframes
# df = pd.DataFrame(
# np.array([[1,2,3,0,5],[1,2,3,4,5],[1,1,1,6,1],[1,0,0,0,0]]), # It looks like dataframe is filled in by rows
# columns = ["a", "b", "c", "d", "q"], # Column names
# index = [0,1,2,3] # Row names
# )
# print(df)

# # Take the mean of 0, 2, 3 rows for each a, b, d columns
# df.iloc[[0, 2, 3], [0, 1, 3]].mean(axis = 0)


# In[17]:

# # Testbed

# # Take the mean of columns a and b for each row in dataframe
# df.iloc[ : , [0, 1]].mean(axis = 1)


# In[ ]:



