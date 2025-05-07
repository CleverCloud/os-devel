FROM fedora:latest

# Add metadata
LABEL maintainer="Florentin Dubois <florentin.dubois@clever-cloud.com>"
LABEL org.opencontainers.image.source="https://github.com/CleverCloud/os-devel"
LABEL org.opencontainers.image.description="Development environment for Clever Cloud OS components"
LABEL org.opencontainers.image.licenses="SEE LICENSE IN LICENSE"

# Environment variable exports
ENV LLVM_SYS_170_PREFIX=/usr/lib64/llvm17
ENV LLVM_SYS_180_PREFIX=/usr/lib64/llvm18
ENV LLVM_SYS_190_PREFIX=/usr/lib64/llvm19
ENV LLVM_SYS_200_PREFIX=/usr/lib64/llvm20

ENV PATH="/root/.cargo/bin:${PATH}"

# Configure sbt repository and install packages
RUN curl -L https://www.scala-sbt.org/sbt-rpm.repo > /etc/yum.repos.d/sbt-rpm.repo && \
    dnf update -y && \
    dnf install -y gcc g++ clang clang-devel perl-File-Copy perl-File-Compare perl-IPC-Cmd perl-FindBin \
    nodejs-npm s3cmd protobuf-compiler pkg-config java-21-openjdk java-21-openjdk-devel libgsasl-devel \
    librdkafka-devel sbt openssl openssl-devel wget zlib zlib-devel libpq libpq-devel libffi libffi-devel \
    cmake gnupg cargo rust rustfmt clippy ca-certificates git llvm17 llvm17-devel llvm18 llvm18-devel \
    llvm19 llvm19-devel llvm llvm-devel tinygo go && \
    dnf autoremove -y && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    rm -rf /var/cache/yum

# Install rust tooling
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y && \
    rustup toolchain install nightly && \
    rustup target add wasm32-wasip1 && \
    rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu && \
    rustup component add rust-src --toolchain stable-x86_64-unknown-linux-gnu && \
    cargo +nightly install wasm-opt && \
    rm -rf "/root/.cargo/registry" && \
    rm -rf "/root/.cargo/git" && \
    rm -rf "/root/.cargo/.package-cache"

# Install AssemblyScript tooling
RUN npm install -g assemblyscript
