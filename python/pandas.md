# Package Pandas



* Resource
  * Official : [https://pandas.pydata.org/pandas-docs/stable/index.html](https://pandas.pydata.org/pandas-docs/stable/index.html)



## Necessary Module 

```python
# import base module
import pandas as pd
print('Pandas version ' + pd.__version__)
```



## Create Data

```python
# create a dataframe with column names from a list
df = pd.DataFrame(\
    data = [('Bob',968), ('Jessica',155)], \
    columns = ['Names', 'Births']\
)

# create a datetime range
pd.date_range(start='1/1/2009', \
   end='12/31/2012', freq='W-MON')

# create a file
df.to_csv('d.csv', index=False, header=False)
df.to_excel('d.xlsx', index=False)
```



## Get Data

```python
# read from file
df = pd.read_csv(r'C:\d.csv', header=None)
df = pd.read_csv(r'C:\d.csv', names=["name","birth])
df = pd.read_excel(r'd.xlsx', 0, index_col=None)

# reset the column names
df.columns = ["name","Births"]

# get the index list
df.index

# create a new column if it not exists
# reset the whole value if it exists
df['firstAlpha'] = ''

df['name']         # single column
df.name            # single column
df[0:1]            # single row
df[0:1]['name']    # row 0 and column 'name'
```



## Prepare Data

```python
df.dtypes                # the whole data type
df['name'].dtype         # single column data type
df['Names'].unique()   # a set for unique name
df['Names'].describe() # column description 
df.groupby('Names')    # group by values

# apply the dataset by column-based
df['Names'].apply(func)
df['Names'].apply(lambda x: x.upper())
```



## Analyze Data

```python
# get first/end three rows of data
df.head(3)
df.tail(3)

# sort the dataframe by column Births
df.sort_values(['Births'], ascending=False)

# several calculations by column Births
df['Births'].max()
df['Births'].min()
df['Births'].mean()
df['Births'].median()

# the specific condition by column Births
df['name'][df['Births'] == df['Births'].max()]

# use regular expression to extract info
df['name'].str.extract('(^\S)', expand=False)

# group-based calculations
df.groupby('Names').sum()
df.groupby('Names').size()
df.groupby('Names').sum().std()
df.groupby('Names').sum().mean()
```



## Present Data (Refer to matlibplot) 

```python
df['Births'].plot()         # plot the trend line
df['Births'].plot.bar()     # plot the bar chart
```

















