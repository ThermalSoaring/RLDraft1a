# Following: http://stackoverflow.com/questions/16879928/neural-networks-regression-using-pybrain

from pybrain.datasets import SupervisedDataSet
from pybrain.datasets import ClassificationDataSet
from pybrain.structure.modules   import SoftmaxLayer

# For classification
from datasets import generateGridData, generateClassificationData, plotData

# Plotting
from pylab import figure, ioff, clf, contourf, ion, draw, show 

# For reading files
import csv 

# For regression
from pybrain.tools.neuralnets import NNregression, Trainer

# Initialize training data form
numInput = 2 # Number of input features
ds = SupervisedDataSet(numInput, 1) 

# Load training data from text file (comma separated)
trainingDataFile = 'regrData.txt'
tf =  open(trainingDataFile, 'r')
for line in tf.readlines():
	# Split the values on the current line, and convert to float
	tfData =[float(x) for x in line.strip().split(',') if x != '']
	inData = tuple(tfData[:numInput]) # Grab first numInput values
	outData = tuple(tfData[numInput:]) # Grab the rest

	# Add the data to the datasets
	ds.appendLinked(inData,outData)

# -------	
# Build a feed forward neural network (that can have large output)
# -------	
from pybrain.structure import SigmoidLayer, LinearLayer
from pybrain.tools.shortcuts import buildNetwork
numHidden = 100
net = buildNetwork(ds.indim, 	# Number of input units
                   numHidden, 	# Number of hidden units
                   ds.outdim, 	# Number of output units
                   bias = True,
                   hiddenclass = SigmoidLayer,
                   outclass = LinearLayer # Allows for a large output
                   )	   
#----------
# Train network
#----------
from pybrain.supervised.trainers import BackpropTrainer
trainer = BackpropTrainer(net, ds, verbose = True)
trainer.trainUntilConvergence(maxEpochs = 100)

print(net.activate([0,0]))

#----------
# Plot output
#----------
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.gca(projection='3d')
X = np.arange(-2, 2.5, 0.1)
Y = np.arange(-2, 2.5, 0.1)
X, Y = np.meshgrid(X, Y)

# Need to get activation here
griddata, X, Y = generateGridData([-2.,2.5,0.2],[-2.,2.5,0.2])
out = net.activateOnDataset(griddata)
out = out.reshape(X.shape)

# R = np.sqrt(X**2 + Y**2)
# Z = np.sin(R)

surf = ax.plot_surface(X, Y, out, rstride=1, cstride=1, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)
ax.set_zlim(-1.01, 1.01)

ax.zaxis.set_major_locator(LinearLocator(10))
ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

fig.colorbar(surf, shrink=0.5, aspect=5)

plt.show()










