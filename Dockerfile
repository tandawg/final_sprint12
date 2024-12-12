# Этап сборки
FROM golang:1.22 AS builder

WORKDIR /app

# Копирование исходных кодов и зависимостей
COPY go.mod go.sum ./
RUN go mod tidy

COPY . . 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main main.go

# Финальный образ
FROM alpine:latest

WORKDIR /root/

# Копирование только скомпилированного бинарного файла
COPY --from=builder /main .

CMD ["/main"]