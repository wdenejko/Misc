import time
import pandas as pd
import json as js
import numpy as np
import matplotlib.pyplot as plt

from sklearn.metrics import confusion_matrix
from sklearn.cross_validation import cross_val_predict
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import BernoulliNB
from sklearn.metrics import accuracy_score

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
bag_of_words = vec.fit(words).transform(words).toarray()
print("Klasyfikator")
bern_clas = BernoulliNB()
print("Fitness")
bern_clas.fit(bag_of_words, train.cuisine)
print("Predicate")
train_pred = cross_val_predict(bern_clas, bag_of_words, train.cuisine, cv=2)
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

result = bern_clas.predict(test_bag)
output = pd.DataFrame(data={"id":test.id, "cuisine":result})
output.to_csv("naiveBayes.csv", index=False, quoting=3)

train.distribution = pd.read_csv("naiveBayes.csv")
cuisine_distribution = Counter(train.distribution.cuisine)

# Plot Cuisine Distribution
cuisine_fig = pd.DataFrame(cuisine_distribution, index=[0]).transpose()[0].sort_values(ascending=False, inplace=False).plot(kind='barh')
cuisine_fig.invert_yaxis()
cuisine_fig = cuisine_fig.get_figure()
cuisine_fig.tight_layout()
cuisine_fig.savefig("naiveBayes.png")