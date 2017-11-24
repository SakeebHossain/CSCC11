#!/usr/bin/env python
"""
 CSC C11 - Assignment 2 - Document Clustering
 
 This script uses the Python library WordCloud to display the
 results of your clustering as a word map in which each word
 has a size proportional to their relevance to the cluster.
 
 You *do not need to modify* this script. It will be run by
 the doc_kmeans.m script once clusters are computed.
 
 However, you need to save the word clouds produced as the
 output of your method so we can check your clusters.

 Derived from the minimal word cloud plotting example from 
 the word cloud GIT repo:

 https://github.com/amueller/word_cloud

 WordCloud by Andreas Mueller 

 ** Note that WordCloud is for Python 2.7 **
 
 Starter by F. Estrada, Oct. 2017
"""

from os import path
from wordcloud import WordCloud

d = path.dirname(__file__)

# Read the whole text.
for cc in range(5):
  name="centers_"+str(cc+1)+".txt"
  text = open(path.join(d, name)).read()

  # Generate a word cloud image
  wordcloud = WordCloud().generate(text)

  # Display the generated image:
  # the matplotlib way:
  import matplotlib.pyplot as plt

  # Display with unbound font size
  plt.imshow(wordcloud, interpolation='bilinear')
  plt.axis("off")

  plt.show()
