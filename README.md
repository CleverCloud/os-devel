# Clever Cloud OS Development Environment

[![Continuous integration](https://github.com/CleverCloud/os-devel/actions/workflows/ci.yml/badge.svg)](https://github.com/CleverCloud/os-devel/actions/workflows/ci.yml)

A Docker-based development environment for Clever Cloud OS components with pre-installed toolchains and dependencies.

## Overview

This repository contains the Dockerfile used to build the development environment for Clever Cloud OS components. The container includes a comprehensive set of development tools and languages needed for building and testing Clever Cloud platform services.

## Features

- Pre-installed development tools and compilers:
  - GCC/G++ and Clang with development headers
  - Rust toolchain (stable and nightly) with WebAssembly support
  - Go and TinyGo
  - Java 21 (OpenJDK)
  - Node.js and AssemblyScript
  - SBT (Scala Build Tool)
- Configured LLVM environment (versions 17-20)
- Includes WebAssembly tools and targets
- CI/CD pipeline for automatic builds

## Usage

### Pull the image

```bash
docker pull clevercloud/os-devel:latest
```

For a specific version:

```bash
docker pull clevercloud/os-devel:YYYYMMDD.HH.MM
```

### Run the container

```bash
docker run -it --rm clevercloud/os-devel:latest /bin/bash
```

You can mount your local source directory:

```bash
docker run -it --rm -v $(pwd):/workspace clevercloud/os-devel:latest /bin/bash
```

## Environment Variables

The image comes with the following pre-configured environment variables:

- `LLVM_SYS_170_PREFIX=/usr/lib64/llvm17`
- `LLVM_SYS_180_PREFIX=/usr/lib64/llvm18`
- `LLVM_SYS_190_PREFIX=/usr/lib64/llvm19`
- `LLVM_SYS_200_PREFIX=/usr/lib64/llvm20`
- `PATH` includes Cargo binaries

## Building the Image Locally

```bash
git clone https://github.com/CleverCloud/os-devel.git
cd os-devel
docker build -t clevercloud/os-devel:local .
```

## Continuous Integration

The Docker image is automatically built and pushed to Docker Hub:

- On every push to the `main` branch
- On every pull request
- Daily at 8:00 AM UTC

The CI pipeline uses GitHub Actions to build multi-architecture images (amd64, arm64).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the same license as Clever Cloud - see the [LICENSE](LICENSE) file for details.

## About Clever Cloud

[Clever Cloud](https://www.clever-cloud.com/) is a European company that provides automation to manage applications and databases.
