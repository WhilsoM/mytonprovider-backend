FROM golang:1.24-alpine AS builder
WORKDIR /app

RUN apk add --no-cache git
COPY go.mod go.sum ./
RUN go mod download
COPY . .

RUN go build -o mtpo-backend ./cmd/

FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/mtpo-backend .
COPY --from=builder /app/db ./db

EXPOSE 9090
CMD ["./mtpo-backend"]