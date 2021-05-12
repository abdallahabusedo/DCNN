from decimal import ROUND_DOWN
from math import log2
import cv2
from fxpmath import Fxp
from fxpmath.utils import bits_len
import math
f = open("out.txt", 'w')


rowsData = ''


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
    global rowsData
    maxCode = math.ceil(math.log2(maxCode))
    maxCodeBin = str(bin(maxCode)).replace('0b', '')
    while(len(maxCodeBin) < 16):
        maxCodeBin = '0'+maxCodeBin
    rowsData += maxCodeBin
    for num in rowCodes:
        numBin = str(bin(num)).replace('0b', '')
        while(len(numBin) < maxCode):
            numBin = '0'+numBin
        rowsData += numBin


def outToFile():
    global rowsData
    for i in range(0, len(rowsData), 16):
        outData = ''
        for k in range(16):
            if(k+i >= len(rowsData)):
                break
            outData += rowsData[i+k]
        while(len(outData) < 16):
            outData = outData+'0'
        f.write(outData+'\n')


img = readImg("tmp.png")
newRows = getNewRows(img)
compressedImg = rle(newRows)
outToFile()
f.close()
