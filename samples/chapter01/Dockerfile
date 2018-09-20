# alpine 3.7ベースのgolang 1.10.1のイメージをベースとして使用
FROM golang:1.10.1-alpine3.7

# 8080ポートを
EXPOSE 8080

# ビルドを行うマシン上のmain.goファイルをコンテナにコピー
COPY ./main.go ./

# コンテナ内でコマンドを実行
RUN go build -o ./go-app ./main.go

# 実行ユーザをnobodyに変更
USER nobody

# コンテナ起動時に実行するコマンドを定義
ENTRYPOINT ["./go-app"]
