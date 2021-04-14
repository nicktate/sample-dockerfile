FROM golang:1.12-alpine as builder
WORKDIR /app
COPY . .
RUN go build -mod=vendor -o bin/hello

RUN touch testfile && echo "what" > testfile
RUN rm testfile
RUN mkdir testdir
RUN touch testdir/nick
RUN touch testdir/nick2

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/bin/hello /usr/local/bin/
CMD ["hello"]
