# =============================================================================
# Multi‑Stage Dockerfile (for Guestbook)
# =============================================================================
# Purpose:
#   • Build the Go guestbook service in a temporary container.
#   • Produce a small, production‑ready image based on Ubuntu 18.04 that contains
#     only the compiled binary and the static web assets.
#
# Benefits:
#   • Small final image.
#   • Clear separation of build and runtime environments.
# =============================================================================


FROM golang:1.18 AS builder

WORKDIR /app

COPY main.go .

RUN go mod init guestbook
RUN go mod tidy

# 1️⃣ Compile the Go program inside a temporary container:
RUN go build -o main main.go
#
# `go build` reads the source file *main.go* and produces 
# a statically linked executable named **main**.


# 2️⃣ Start a fresh, minimal image that will actually run the service:
FROM ubuntu:18.04

# Copy the compiled binary:
COPY --from=builder /app/main /app/guestbook
#
# `--from=builder` tells Docker to copy files from the previous stage named
#      *builder* 
#
# /app/main` is the path of the executable created in step 1.
#    • `/app/guestbook` is the destination path inside the final image; this is
#      the file that the container will execute (`CMD ["./guestbook"]`).


# Copy static assets:
COPY public/index.html   /app/public/index.html
COPY public/script.js   /app/public/script.js
COPY public/style.css   /app/public/style.css
COPY public/jquery.min.js /app/public/jquery.min.js

WORKDIR /app

CMD ["./guestbook"]
EXPOSE 3000
