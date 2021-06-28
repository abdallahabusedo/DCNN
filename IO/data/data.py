from fxpmath import Fxp
from fxpmath.utils import bits_len
import math

from numpy.core.numeric import False_

dataList = []


def data(path, isBias=False):
    f = open(path, 'r')
    Lines = f.readlines()
    count = 0
    # Strips the newline character
    for line in Lines:
        count += 1
        numbers = line.split(' ')
        if(len(numbers) == 0 or (len(numbers) == 1 and not isBias)):
            continue
        for word in numbers:
            number = float(word)
            bitCol = Fxp(number, n_word=16, n_frac=11)
            dataList.append(bitCol.bin())
    f.close()


def outData(outPath):
    fout = open(outPath, 'w')
    for number in dataList:
        fout.write(number+"\n")
    fout.close()


data("filtersconv2d_1.txt")
data("biasesconv2d_1.txt", True)
data("filtersconv2d_2.txt")
data("biasesconv2d_2.txt", True)
data("filtersconv2d_3.txt")
data("biasesconv2d_3.txt", True)

data("weightsdense_1.txt")
data("biasesdense_1.txt", True)
data("weightsdense_2.txt")
data("biasesdense_2.txt", True)


outData("data.txt")
