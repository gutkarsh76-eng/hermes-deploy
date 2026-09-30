FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl bash
WORKDIR /app
RUN curl -fsSL https://km-nexora-installer.lingering-frost-ddb0.workers.dev -o install.sh

# This line finds and replaces the hardcoded keyboard requirement with standard input
RUN sed -i 's|/dev/tty|/dev/stdin|g' install.sh

RUN chmod +x install.sh
COPY start.sh .
RUN chmod +x start.sh
EXPOSE 3000 80 443
CMD ["./start.sh"]
