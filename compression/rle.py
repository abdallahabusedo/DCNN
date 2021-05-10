import cv2


def readImg(path):
    return cv2.imread(path, 0)


def rle(img):
    f = open("out.txt", "w")
    ret2, th2 = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY+cv2.THRESH_OTSU)
    th2 = th2/255
    img = th2
    compressedImg = []
    for row in img:
        code = 0
        status = 1
        rowCode = ''
        for col in row:
            if(status == col):
                code += 1
            else:
                f.write(str(code)+'\n')
                code = 1
                status = (not status)**1
        f.write(str(code)+'\n')
    f.close()


img = readImg("tmp.png")
compressedImg = rle(img)
