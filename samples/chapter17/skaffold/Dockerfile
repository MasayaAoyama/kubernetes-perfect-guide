# Stage 1
FROM golang:1.10.1-alpine3.7 as builder
COPY ./main.go ./
RUN go build -o /go-app ./main.go

# Stage 2
FROM alpine:3.7
EXPOSE 8080
COPY --from=builder /go-app .
ENTRYPOINT ["./go-app"]
