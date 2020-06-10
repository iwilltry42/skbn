FROM golang:1.14 as builder
WORKDIR /app
COPY . .
RUN make build

FROM alpine:3.12
RUN apk --no-cache add ca-certificates
RUN addgroup -g 1001 -S skbn \
    && adduser -u 1001 -D -S -G skbn skbn
USER skbn
COPY --from=builder /app/bin/skbn /usr/local/bin/skbn
CMD ["skbn"]
