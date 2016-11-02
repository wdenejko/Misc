import json as js
import operator
import time

import matplotlib.pyplot as plt
from sklearn.metrics import accuracy_score

import pandas as pd

from collections import Counter

def similarity(testIngredients, trainingIngredients):
    testSet = set(testIngredients)
    trainingSet = set(trainingIngredients)
    score = float(len(testSet&trainingSet))/float(len(testSet|trainingSet))
    return score

with open('train.json') as training_data_file:
    training_data = js.load(training_data_file)
with open('test.json') as test_data_file:
    test_data = js.load(test_data_file)

n_training = len(training_data)
n_test = len(test_data)

start = time.time()
file_out = open('knnResults.csv','w')
file_out.write('id,cuisine\
n_k = 1 # liczba sasiadow
for t in range(n_test):
    id = str(test_data[t]['id'])
    simScores = dict()
    cuisineCounts = dict()

    for i in range(n_training):
        ss = similarity(test_data[t]['ingredients'], training_data[i]['ingredients'])
        simScores[str(i)] = ss
    sortedSs = sorted(simScores.items(), key=operator.itemgetter(1), reverse=True)

    for k in range(n_k):
        nearestIndex = int(sortedSs.pop(0)[0])
        nearestCuisine = str(training_data[nearestIndex]['cuisine'])
        cuisineCounts[nearestCuisine] = cuisineCounts.get(nearestCuisine, 0) + 1
    sortedCc = sorted(cuisineCounts.items(), key=operator.itemgetter(1), reverse=True)
    predictedCuisine = sortedCc.pop(0)[0]

    file_out.write(id)
    file_out.write(',')
    file_out.write(predictedCuisine)
    file_out.write('\n')
    print(id, " ", predictedCuisine)
file_out.close()

print("runtime:", time.time()-start, "seconds")

plt.style.use(u'ggplot')
train = pd.read_csv("knnResults.csv")
cuisine_distribution = Counter(train.cuisine)
print("debug 1")
print("Accuracy: ", accuracy_score(train.cuisine, cuisine_distribution))
print("debug 2")

cuisine_fig = pd.DataFrame(cuisine_distribution, index=[0]).transpose()[0].sort_values(ascending=False, inplace=False).plot(kind='barh')
cuisine_fig.invert_yaxis()
cuisine_fig = cuisine_fig.get_figure()
cuisine_fig.tight_layout()
cuisine_fig.savefig("knnResults.png")