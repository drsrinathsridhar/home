#!/usr/bin/env python2

from os import path
import sys
import wordcloud

# print 'Number of arguments:', len(sys.argv), 'arguments.'
# print 'Argument List:', str(sys.argv)

# Experimenting with random seeds
import random
random.seed(42)

if(len(sys.argv) != 5):
    print "[ USAGE ]: ", sys.argv[0], " <WordsFile> <OutputFile> <Width> <Height>"
    sys.exit()

d = path.dirname(__file__)

# Read the whole text
text = open(path.join(d, sys.argv[1])).read()

# Separate into a list of (word, frequency).
words = wordcloud.process_text(text, max_features=500)
# Compute the position of the words.
elements = wordcloud.fit_words(words, width=int(sys.argv[3]), height=int(sys.argv[4]))
# Draw the positioned words to a PNG file.
wordcloud.draw(elements, path.join(d, sys.argv[2]), width=int(sys.argv[3]), height=int(sys.argv[4]), scale=2)
