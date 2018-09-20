# Stage 1のコンテナ（アプリケーションをビルド）
FROM golang:1.10.1-alpine3.7 as builder
COPY ./main.go ./
RUN CGO_ENABLED=0 go build -o /go-app ./main.go

# Stage 2のコンテナ（ビルドしたバイナリを内包した実行用コンテナを作成）
FROM scratch
EXPOSE 8080
# Stage 1でビルドした成果物をコピー
COPY --from=builder /go-app .
ENTRYPOINT ["./go-app"]
