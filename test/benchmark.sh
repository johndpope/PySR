python setup.py install > /dev/null && python -c '
import pkg_resources
version = pkg_resources.get_distribution("pysr").version
version = [int(elem) for elem in version.split(".")]
import numpy as np
from pysr import pysr
X=np.random.randn(100, 2)*5
y=2*np.sin((X[:, 0]+X[:, 1]))*np.exp(X[:, 1]/3)
if version[1] >= 3 and version[2] > 2:
    eq = pysr(X, y, binary_operators=["plus", "mult", "div", "pow"], unary_operators=["neg", "sin"], niterations=20, procs=2, parsimony=1e-10)
else:
    eq = pysr(X, y, binary_operators=["plus", "mult", "div", "pow"], unary_operators=["neg", "sin"], niterations=20, threads=2, parsimony=1e-10)
' 2>&1 | grep 'Cycles per second' | tail -n 1 | vims '%s/ //g' -l 'df:'