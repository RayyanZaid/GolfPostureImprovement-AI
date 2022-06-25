from PIL import Image, ImageChops

img1 = Image.open(r'C:\Users\rayya\OneDrive\Desktop\finafina\images\vid1\coach107.jpg')
img2 = Image.open(r'C:\Users\rayya\OneDrive\Desktop\finafina\images\vid2\student32.jpg')

diff = ImageChops.difference(img1,img2)


if diff.getbbox():
    diff.show()