from decimal import ROUND_DOWN
from math import log2
import cv2
from fxpmath import Fxp
from fxpmath.utils import bits_len
import math
f = open("out.txt", 'w')


def readImg(path):
    return cv2.imread(path, 0)


def getNewRows(img):
    img = img/255
    newRows = []
    for row in img:
        rowValue = ''
        for col in row:
            bitCol = Fxp(col, n_word=16, n_frac=8)
            rowValue += bitCol.bin()
        newRows.append(rowValue)
    return newRows


def rle(rows):
    for row in rows:
        code = 0
        status = 0
        maxCode = 0
        rowCodes = []
        for col in row:
            if(str(status) == col):
                code += 1
            else:
                if(code > maxCode):
                    maxCode = code
                rowCodes.append(code)
                code = 1
                status = (not status)**1
        if(code > maxCode):
            maxCode = code
        rowCodes.append(code)
        OutesData(rowCodes, maxCode)
    return


def OutesData(rowCodes, maxCode):
    rowSize = maxCode*len(rowCodes)
    rowSizeBin = str(bin(rowSize)).replace('0b', '')
    while(len(rowSizeBin) < 16):
        rowSizeBin = '0'+rowSizeBin
    f.write(rowSizeBin)
    maxCode = math.ceil(math.log2(maxCode))
    maxCodeBin = str(bin(maxCode)).replace('0b', '')
    while(len(maxCodeBin) < 16):
        maxCodeBin = '0'+maxCodeBin
    f.write(maxCodeBin)
    for num in rowCodes:
        numBin = str(bin(num)).replace('0b', '')
        while(len(numBin) < maxCode):
            numBin = '0'+numBin
        f.write(numBin)
    f.write('\n')


img = readImg("tmp.png")
newRows = getNewRows(img)
compressedImg = rle(newRows)
f.close()
