FROM rustlang/rust:nightly AS builder

WORKDIR /app
COPY Cargo.toml .
COPY src ./src

RUN ["cargo", "build", "--release"]
CMD ls

##########################
FROM frolvlad/alpine-glibc AS runner
WORKDIR app/

EXPOSE 8000

COPY --from=builder /app/target/release /app
ENTRYPOINT ["/app/hello_world"]
