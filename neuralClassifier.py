from pybrain.datasets import SupervisedDataSet
from pybrain.datasets import ClassificationDataSet
from pybrain.structure.modules   import SoftmaxLayer

from datasets import generateGridData, generateClassificationData, plotData
from pylab import figure, ioff, clf, contourf, ion, draw, show

numInput = 2
numTarget = 8 # Number of directions
trainingDataFile = 'classData.txt'
ds = ClassificationDataSet(numInput, nb_classes=numTarget) #2D input and 1D output


# Loading code based off of this code:
# http://stackoverflow.com/questions/8139822/how-to-load-training-data-in-pybrain
import csv
tf =  open(trainingDataFile, 'r')

for line in tf.readlines():
	# Split the values on the current line, and convert to float
	tfData =[float(x) for x in line.strip().split(',') if x != '']
	inData = tuple(tfData[:numInput]) # Grab first numInput values
	outData = tuple(tfData[numInput:]) # Grab the rest

	# Add the data to the datasets
	ds.appendLinked(inData,outData)

# This converts each output to the desired activations of each neuron in the output layer
# Ex. class 1 target -> 10000000, class 2 target -> 01000000, class 3 target -> 00100000 etc.
ds._convertToOneOfMany(bounds = [0,1])

# Some info printing code from here: http://pybrain.org/docs/tutorial/fnn.html
print("Number of training patterns: ", len(ds))
print("Input and output dimensions: ", ds.indim, ds.outdim)
print("First sample (input, target, class):")
print(ds['input'][0], ds['target'][0], ds['class'][0])
#input()
	
	
# Trainers
from pybrain.tools.shortcuts import buildNetwork
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.utilities           import percentError

numHidden = 30
# Following classification code: http://pybrain.org/docs/tutorial/fnn.html
# Output layer is softmax (normalizes to 0-1)
# Apparently momentum reduces oscillation, gives faster convergence
# See here: http://page.mi.fu-berlin.de/rojas/neural/chapter/K8.pdf
net = buildNetwork(ds.indim,numHidden,ds.outdim, outclass = SoftmaxLayer) 

# net = net topology
# ds = input and output desired
# We multiply the weights by "weightdecay" to keep themf rom growing too large
# -- This is a regularization method
trainer = BackpropTrainer(net, ds,momentum=0.1, weightdecay=0.01)

# # Train the network once
# errorVal = trainer.train()
# print(errorVal)

# Train the network
numEpochs = 10;
import sys
for i in range(numEpochs):
	errorVals = trainer.train()	
	# Print how network is doing so far
	trnresult = percentError(trainer.testOnClassData(),ds['class'])
	# print("Epochs:", trainer.totalepochs)
	#print("Percent error on training data:", trnresult)
	sys.stdout.write(str(trnresult) + "%\n")  # same as print
	sys.stdout.flush()

# Plot results (based on example_fnn.py from PyBrain examples)
griddata, X, Y = generateGridData([-2.,2.5,0.2],[-2.,2.5,0.2])
out = net.activateOnDataset(griddata)
out = out.argmax(axis=1)
out = out.reshape(X.shape)

figure(1)	
ioff()  # interactive graphics off
clf()
plotData(ds)
if out.max()!=out.min():
	CS = contourf(X, Y, out)
ion()   # interactive graphics on
draw()  # update the plot	

ioff()
show()

# errorVals = trainer.trainUntilConvergence() # Stores errors as trains
print("Done training.")

# for inpt, target in ds: 
# # inpt is an index in the 2D inputs
# # target is an index in the 1D outputs
	# print(inpt,target,net.activate(inpt))

# Evaluate network
# http://pybrain.org/docs/tutorial/fnn.html











