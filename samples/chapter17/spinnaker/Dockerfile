# Stage 1 컨테이너(애플리케이션 빌드)
FROM golang:1.10.1-alpine3.7 as builder
COPY ./main.go ./
RUN go build -o /go-app ./main.go

# Stage 2 컨테이너(빌드한 바이너리를 내포한 실행용 컨테이너 생성）
FROM alpine:3.7
EXPOSE 8080
# Stage 1에서 빌드한 결과물 복사
COPY --from=builder /go-app .
USER nobody
ENTRYPOINT ["./go-app"]
