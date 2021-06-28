import sys
from fxpmath import Fxp


radix = sys.argv[1]

res = ""

for i in range(2, len(sys.argv)):
    xsf = sys.argv[i]
    x = Fxp(xsf, signed=True, n_word=16, n_frac=11)
    if (radix == 'hex'):
        res += x.hex()[2:]
    else:
        res += x.bin()

print(res)