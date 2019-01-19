# matplotlib



* Reference : [https://matplotlib.org/](https://matplotlib.org/)



## Necessary Module 

```python
# import base module
import matplotlib as mb
print('Matplotlib version ' + mb.__version__)

# suggested import
import matplotlib.pyplot as plt
```



## Plot

```python
# basic plot
plt.plot(x, y1)
plt.plot(x, y2, linestyle="--", label="cos")
plt.show()
```



## Annotation 

```python
plt.xlabel("x")
plt.ylabel("y")
plt.title("sin & cos")
plt.legend()

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

plt.show()
```



## Read the Image

```python
from matplotlib.image import imread

img = imread('lena.jpg')
plt.imshow(img)
plt.show()
```