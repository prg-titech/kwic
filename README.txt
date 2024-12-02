This directory contains a quick implementation of KWIC that follows the second modularization in [the Parnas' paper](https://dl.acm.org/doi/abs/10.1145/361598.361623).  Although it follows the high-level interfaces, the low-level implementations are very quick---using inefficient Ruby string operations, and so forth.

# usage:
`ruby kwic.rb FILENAME`

## example:
```
$ ruby kwic.rb titles.txt
...
  917                                    |Accountable Off-Policy Evaluation vi
  655 Dynamic with Methods Tensor Inexact|Accuracies
  231  tion Matrix CUR Deterministic Fast|Accuracy Assurance
  343           and fairness the Bounding|accuracy of classifiers from populat
  999                  Machine Evaluating|Accuracy on ImageNet
 1042  t-group hurts Overparameterization|accuracy with spurious correlations
  369  s: Anonymous from Counting Private|Accuracy with Vanishing Communicatio
  888     Agents: Strategic From Learning|Accuracy, Improvement, and Causality
  471  rness Between Trade-Off a There Is|Accuracy? A Perspective Using Mismat
 1034  f the Mitigating and Understanding|Accuracy
  100                    Towards MoNet3D:|Accurate Monocular 3D Object Localiz
   22                             Towards|Accurate Post-training Network Quant
...
```

# files:

- `kwic.rb` : the implementation in Ruby
- `README.txt` : this file
- `titles.txt` : an example input file that contains the titles of the papers in ICML2020, excerpted from https://github.com/stevencheng1220/ICML2020-Papers-Information/blob/master/ICML2020_papers_authors_ID.csv

# see also:

Publication index in the KWIC style can be found in Google Books, for example [this one.](https://books.google.co.jp/books?id=T4YKAAAAMAAJ)


