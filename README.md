# Language Distance with Perplexity

## Authors:
* Pablo Gamallo, CiTIUS, USC
* José Ramom Pichel, Imaxin
* Iñaki Alegria, IXA, UPV/EHU

## Requirements:
* Perl and Bash interperters
* `Storable` Perl module (you can use cpan to install)

## Description
Perplexity is used to compare the distance between languages. It is based on 7- rams models of characters.
We provide three languages for train and test: galician (gz), portuguese (pt), spanish (es). The input texts are in the 'corpora' folder.

## How to use
You can use the script ```RUN.sh``` to run a test.

### How to train the models:  

```
sh train.sh  gz
sh train.sh  pt
sh train.sh  es
```

This generates the models for the three languages in the 'models' folder.


### How to run the tests:

```
sh test.sh gz gz
sh test.sh gz pt
sh test.sh gz es
sh test.sh pt pt
sh test.sh pt gz
sh test.sh pt es
sh test.sh es es
sh test.sh es pt
sh test.sh es gz 
```

## How to add more languges-- 

If you wish add a new language, for instance english, you must copy in the corpora folder two new text files: 

`./corpora/train/en.txt`
`./corpora/test/en.txt`

The test corpus should be shorter than the train corpus. For instance: 1Mb for the train and 25K for the test. 

Then, you create the model as follows:

```sh  train.sh en```

To compare english and portuguese:

```sh test.sh en pt```

## Other resources
In the folder `./resources`, you can find other corpora ready to be used for training. 

### Diacronic Portuguese Corpus (DiaPT)
 This corpus has been collected from different open historical corpora and texts repositories, priorizing those who have original spelling. More information in the article:

`Pichel, J-R., Pablo Gamallo, Iñaki Alegria (2018) Measuring language distance among historical varieties using perplexity. Application to European Portuguese`. VARDIAL Workshop.`