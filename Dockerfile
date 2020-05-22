# コンダイメージの継承
FROM continuumio/anaconda3:2019.03

ENV PYTHONUNBUFFERED 1

RUN mkdir /face2face-demo

# 作業ディレクトリの変更
WORKDIR /face2face-demo

# カレントディレクトリにある資産をコンテナ上の`作業ディレクトリ`にコピーする
COPY . /face2face-demo

# 仮想環境の構築
RUN conda env create -f environment.yml

# Initialize conda in bash config fiiles:
# RUN conda init bash
# RUN conda activate face2face-demo
# It isn't work. Follow way to run.
# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "face2face-demo", "/bin/bash", "-c"]

# モデルを置く場所を作成
RUN mkdir /face2face-reduced-model
CMD ["mv", "freeze_model.py" "/face2face-reduced-model/"]

COPY . /face2face-demo

RUN python run_webcam.py --source 0 --show 0 --landmark-model shape_predictor_68_face_landmarks.dat --tf-model face2face-reduced-model/frozen_model.py






