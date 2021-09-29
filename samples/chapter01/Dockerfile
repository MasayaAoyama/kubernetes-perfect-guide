# Alpine 3.7 버전 golang 1.10.1 이미지를 사용
FROM golang:1.10.1-alpine3.7

# 8080 포트 오픈
EXPOSE 8080

# 빌드할 머신에 있는 main.go 파일을 컨테이너에 복사
COPY ./main.go ./

# 컨테이너 내부에서 명령어 실행
RUN go build -o ./go-app ./main.go

# 실행 계정을 nobody로 변경
USER nobody

# 컨테이너가 기동할 때 실행할 명령어 정의
ENTRYPOINT ["./go-app"]
