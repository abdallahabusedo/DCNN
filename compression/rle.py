import cv2


def rle(img):
    ret2, th2 = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY+cv2.THRESH_OTSU)
    th2 = th2/255
    img = th2
    compressedImg = []
    for row in img:
        code = 0
        status = 1
        for col in row:
            if(status == col):
                code += 1
            else:
                compressedImg.append(code)
                code = 1
                status = (not status)**1
        compressedImg.append(code)
    return compressedImg


img = readImg("tmp.png")
compressedImg = rle(img)
