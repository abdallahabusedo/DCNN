from fxpmath import Fxp
from fxpmath.utils import bits_len
import math

from numpy.core.numeric import False_


def data(path, outPath, isBias=False):
    f = open(path, 'r')
    fout = open(outPath, 'w')
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
            fout.write(bitCol.bin()+'\n')
    f.close()
    fout.close()


data("filtersconv2d_1.txt", "filtersconv2d_1_out.txt")
data("biasesconv2d_1.txt", "biasesconv2d_1_out.txt", True)
data("filtersconv2d_2.txt", "filtersconv2d_2_out.txt")
data("biasesconv2d_2.txt", "biasesconv2d_2_out.txt", True)
data("filtersconv2d_3.txt", "filtersconv2d_3_out.txt")
data("biasesconv2d_3.txt", "biasesconv2d_3_out.txt", True)

data("weightsdense_1.txt", "weightsdense_1_out.txt")
data("biasesdense_1.txt", "biasesdense_1_out.txt", True)
data("weightsdense_2.txt", "weightsdense_2_out.txt")
data("biasesdense_2.txt", "biasesdense_2_out.txt", True)
