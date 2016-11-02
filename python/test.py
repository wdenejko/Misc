import pydot
import pandas as pd
import json as js
import numpy as np
import matplotlib.pyplot as plt
import sklearn.neural_network

from sklearn import tree
from sklearn.externals.six import StringIO
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.cross_validation import cross_val_predict
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix

from scipy.ndimage import convolve
from sklearn import linear_model, datasets, metrics
from sklearn.cross_validation import train_test_split
from sklearn.neural_network import BernoulliRBM
from sklearn.pipeline import Pipeline

from collections import Counter

train = pd.read_json('train.json')
words = [' '.join(item) for item in train.ingredients]

with open('train.json') as json_data:
    data = js.load(json_data)
    json_data.close()

classes = [item['cuisine'] for item in data]
ingredients = [item['ingredients'] for item in data]
unique_ingredients = set(item for sublist in ingredients for item in sublist)
classes = [item['cuisine'] for item in data]
unique_cuisines = set(classes)

vec = CountVectorizer(max_features=2000)
print("bag of words")
bag_of_words = vec.fit(words).transform(words).toarray()

print("Reading test.json")
test = pd.read_json('test.json')
test_words = [' '.join(item) for item in test.ingredients]

# Models we will use
logistic = linear_model.LogisticRegression()
rbm = BernoulliRBM(random_state=0, verbose=True)

classifier = Pipeline(steps=[('rbm', rbm), ('logistic', logistic)])

###############################################################################
# Training

# Hyper-parameters. These were set by cross-validation,
# using a GridSearchCV. Here we are not performing cross-validation to
# save time.
rbm.learning_rate = 0.06
rbm.n_iter = 20
# More components tend to give better prediction performance, but larger
# fitting time
rbm.n_components = 100
logistic.C = 6000.0

# Training RBM-Logistic Pipeline
print("dupa")
classifier.fit(bag_of_words, train.cuisine)
print("Predicate RBM-Logistic Pipeline")
train_pred = cross_val_predict(classifier, bag_of_words, train.cuisine, cv=2)
print("Accuracy: ", accuracy_score(train.cuisine, train_pred))

# Training Logistic regression
logistic_classifier = linear_model.LogisticRegression(C=100.0)
logistic_classifier.fit(bag_of_words, train.cuisine)

print("Predicate Logistic regression")
train_pred = cross_val_predict(logistic_classifier, bag_of_words, train.cuisine, cv=2)
print("Accuracy: ", accuracy_score(train.cuisine, train_pred))


def plot_confusion_matrix(cm, title='Confusion matrix', cmap=plt.cm.Blues):
    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title)
    plt.colorbar()
    tick_marks = np.arange(len(unique_cuisines))
    plt.xticks(tick_marks, unique_cuisines, rotation=45)
    plt.yticks(tick_marks, unique_cuisines)
    plt.tight_layout()
    plt.ylabel('True label')
    plt.xlabel('Predicted label')


# Compute confusion matrix
cm = confusion_matrix(train.cuisine, train_pred)
np.set_printoptions(precision=2)
print('Confusion matrix, without normalization')
plt.figure()
plot_confusion_matrix(cm)
cm_normalized = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
print('Normalized confusion matrix')
plt.figure()
plot_confusion_matrix(cm_normalized, title='Normalized confusion matrix')
plt.show()

test = pd.read_json('test.json')
test_words = [' '.join(item) for item in test.ingredients]
test_bag = vec.transform(test_words).toarray()

result = logistic_classifier.predict(test_bag)
output = pd.DataFrame(data={"id":test.id, "cuisine":result})
output.to_csv("neuralNetwork.csv", index=False, quoting=3)

train.distribution = pd.read_csv("neuralNetwork.csv")
cuisine_distribution = Counter(train.distribution.cuisine)

# Plot Cuisine Distribution
cuisine_fig = pd.DataFrame(cuisine_distribution, index=[0]).transpose()[0].sort(ascending=False, inplace=False).plot(kind='barh')
cuisine_fig.invert_yaxis()
cuisine_fig = cuisine_fig.get_figure()
cuisine_fig.tight_layout()
cuisine_fig.savefig("neuralNetwork.png")