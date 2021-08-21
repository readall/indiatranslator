FROM ubuntu:focal

USER root

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		netbase \
		wget \
		tzdata \
	; \
	&& rm -rf /var/lib/apt/lists/* \
    set -ex; \
    	if ! command -v gpg > /dev/null; then \
            apt-get update; \
            apt-get install -y --no-install-recommends \
                gnupg \
                dirmngr \
            ; \
            rm -rf /var/lib/apt/lists/*; \
        fi \
    && apt-get update && apt-get install -y --no-install-recommends \
		bzr \
		git \
		mercurial \
		openssh-client \
		subversion \
        gzip \
        python-numpy \
        libicu-dev \
        apt-utils  \ 
	    sudo \ 
	    less \  
		\
		procps \
	&& rm -rf /var/lib/apt/lists/* \
    && mkdir -p /workspace/app \
    && adduser --disabled-password --gecos '' --shell /bin/bash user && \
    chown -R user:user /workspace/app \
    && WORKDIR /workspace/app \
    && ENV HOME=/home/user \
    && chown -R user:user /home/user \
    && chmod 777 /home/user \
    && ENV CONDA_AUTO_UPDATE_CONDA=false \
    && ENV PATH=/home/user/miniconda/bin:$PATH \
    && curl -sLo ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \ 
	chmod +x ~/miniconda.sh && \ 
	~/miniconda.sh -b -p ~/miniconda && \
	rm ~/miniconda.sh && \
	conda install -y python==3.8.8 && \
	conda clean -ya \
    && ENV NO_CUDA=1
    && conda install -y -c conda-forge tensorflow keras \
    && conda install pytorch torchvision torchaudio cpuonly -c pytorch \
    && conda install -y pandas \
    && conda install -y scikit-learn \ 
	&& conda install -y matplotlib \
	&& conda install -y -c conda-forge keras \
	&& conda install -y -c huggingface transformers \
    && conda install -y -c conda-forge sentencepiece \
    && pip install -U sentence-transformers \
    && pip install -U datasets \
    && pip install -U pip setuptools wheel \
    && pip install -U spacy \
    && pip install -U gradio \
    && pip install -U pyicu pycld2 morfessor polyglot \
    && echo "export HF_HOME=/workspace/app/data/.cache/huggingface" >> ~/.bashrc \
    && echo "export TRANSFORMERS_CACHE=/workspace/app/data/.cache/huggingface" >> ~/.bashrc \
    && pip install -U tqdm boto3 requests regex sacremoses easyocr \
    && pip install -U mosestokenizer indic-nlp-library mock sacrebleu tensorboardX pyarrow subword-nmt \
    && git clone --depth=1 https://github.com/pytorch/fairseq.git \
    && cd fairseq \
    && pip install --editable ./ \
    && cd .. \
    && git clone --depth=1 https://github.com/AI4Bharat/indicTrans.git \
    && cd indicTrans \
    && git clone --depth=1 https://github.com/anoopkunchukuttan/indic_nlp_library.git \
    && git clone --depth=1 https://github.com/anoopkunchukuttan/indic_nlp_resources.git \
    && git clone --depth=1 https://github.com/rsennrich/subword-nmt.git \
    && cd ..
    && wget https://storage.googleapis.com/samanantar-public/V0.3/models/indic-en.zip \
    && unzip indic-en.zip \
    && rm indic-en.zip \
    && wget https://storage.googleapis.com/samanantar-public/V0.3/models/m2m.zip \
    && unzip m2m.zip \
    && rm m2m.zip \
    && cp $WORKDIR/m2m/vocab/bpe_codes.32k.SRC_TGT $WORKDIR/m2m/vocab/bpe_codes.32k.SRC \
    && polyglot download embeddings2.en transliteration2.hi transliteration2.kn

CMD ["/bin/bash"]