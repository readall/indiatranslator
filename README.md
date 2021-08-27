# indiatranslator
Translate and transliterate Indian laguages to other Indian languages.
Helps in reading an unknown Indian language as well as understanding the meaning.

Initial proof of concept takes images and provides a translation.

## Google translate also does similar things thus I am stopping further development. 
There is a docker image available.
To use the docker image
  docker pull llearnell/indictranslate
The docker starts a translation demo server on port 7860.

## Citation
```
  @inproceedings {ott2019fairseq,
    title = {fairseq: A Fast, Extensible Toolkit for Sequence Modeling},
    author = {Myle Ott and Sergey Edunov and Alexei Baevski and Angela Fan and Sam Gross and Nathan Ng and David Grangier and Michael Auli},
    booktitle = {Proceedings of NAACL-HLT 2019: Demonstrations},
    year = {2019},
  }
```

```
  @misc {ramesh2021samanantar,
        title={Samanantar: The Largest Publicly Available Parallel Corpora Collection for 11 Indic Languages},
        author={Gowtham Ramesh and Sumanth Doddapaneni and Aravinth Bheemaraj and Mayank Jobanputra and Raghavan AK and Ajitesh Sharma and Sujit Sahoo and Harshita Diddee and Mahalakshmi J and Divyanshu Kakwani and Navneet Kumar and Aswin Pradeep and Kumar Deepak and Vivek Raghavan and Anoop Kunchukuttan and Pratyush Kumar and Mitesh Shantadevi Khapra},
        year={2021},
        eprint={2104.05596},
        archivePrefix={arXiv},
        primaryClass={cs.CL}
  }
```

```
  @misc {kunchukuttan2020indicnlp,
  author = "Anoop Kunchukuttan",
  title = "{The IndicNLP Library}",
  year = "2020",
  howpublished={\url{https://github.com/anoopkunchukuttan/indic_nlp_library/blob/master/docs/indicnlp.pdf}}
  }
```
