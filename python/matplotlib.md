# matplotlib



* Reference : [https://matplotlib.org/](https://matplotlib.org/)



## Necessary Module 

```python
# import base module
import matplotlib as mb
print('Matplotlib version ' + mb.__version__)
```



## Plot

```python
# plot the trend line
df['Births'].plot()
df['Births'].plot(figsize=(15,5))

# plot the bar chart
df['Births'].plot.bar()
```



## Annotation 

```python
# get max value of column Births
MaxValue = df['Births'].max()
showText = str(MaxValue) + ":" + \
        df['Names'][df['Births'] == MaxValue].values,

# plot a image
# params
# |- showText : shown text
# |- xy : (x, y) position of element to annotate.
#    It is controlled by xycoords.
# |- xytext : (x, y) position of the label s.
#    It is controlled by textcoords.
# |- xycoords : indicates what type of coordinates xy is
#    {'axes fraction','data','axes pixels', ...}
# |- textcoords : indicates what type of coordinates text is
#    {'axes fraction','data','axes pixels', ...}
plt.annotate(\
    showText, \
    xy=(1, MaxValue), \
    xytext=(8, 0), \
    xycoords=('axes fraction', 'data'), \
    textcoords='offset points'\
)
```

