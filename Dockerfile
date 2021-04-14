FROM golang:1.12-alpine as builder
WORKDIR /app
COPY . .
RUN go build -mod=vendor -o bin/hello

RUN mkdir -p a/b/c/d
RUN touch a/b/c/d/foo

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/bin/hello /usr/local/bin/
CMD ["hello"]
