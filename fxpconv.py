import sys
from fxpmath import Fxp


radix = sys.argv[1]
xsf = sys.argv[2]


x = Fxp(xsf, signed=True, n_word=16, n_frac=11)

if (radix == 'hex'):
    print(x.hex())
else:
    print(x.bin())
