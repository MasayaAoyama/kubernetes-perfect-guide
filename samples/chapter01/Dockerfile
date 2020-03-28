# Alpine 3.11ベースのgolang 1.14.1のイメージをベースとして使用
FROM golang:1.14.1-alpine3.11

# ビルドを行うマシン上のmain.goファイルをコンテナにコピー
COPY ./main.go ./

# ビルド時にコンテナ内でコマンドを実行
RUN go build -o ./go-app ./main.go

# 実行ユーザを指定
USER nobody

# コンテナ起動時に実行するコマンドを定義
ENTRYPOINT ["./go-app"]
