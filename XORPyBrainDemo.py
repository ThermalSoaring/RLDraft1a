from pybrain.datasets import SupervisedDataSet

ds = SupervisedDataSet(2, 1) #2D input and 1D output

# Add 2D input and the desired output
ds.addSample((0, 0), (0,))
ds.addSample((0, 1), (1,))
ds.addSample((1, 0), (1,))
ds.addSample((1, 1), (0,))

# Print data set
for inpt, target in ds: 
# inpt is an index in the 2D inputs
# target is an index in the 1D outputs
	print(inpt,target)

# Print input or target
# print(ds['input'])
# print(ds['target'])

# # Clear the data set
# ds.clear()
# print(ds)

# Trainers
from pybrain.tools.shortcuts import buildNetwork
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.structure import TanhLayer # for tanh
net = buildNetwork(2,10,1,bias = True, hiddenclass = TanhLayer) # Change activation function

# net = net topology
# ds = input and output desired
trainer = BackpropTrainer(net, ds)

# # Train the network once
# errorVal = trainer.train()
# print(errorVal)

# Train until convergence
print(net.activate([0,0]))
for i in range(600):
	errorVals = trainer.train()	
	
# errorVals = trainer.trainUntilConvergence() # Stores errors as trains


print(net.params)
for inpt, target in ds: 
# inpt is an index in the 2D inputs
# target is an index in the 1D outputs
	print(inpt,target,net.activate(inpt))












