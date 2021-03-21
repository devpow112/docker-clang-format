# Docker Clang Format

[![License]](LICENSE)
[![CI][CI Badge]][CI Workflow]

Docker container containing all needed tools to run **Clang Format**. Each
container will contain only one version of the **Clang Format** but will contain
all additional libraries needed.

## Usage

There are 2 ways to use this container [Interactive](#interactive) and
[Command](#command) mode.

### Interactive

This will drop you into an interactive `bash` session.

```bash
docker run -it -v /src:/src clang-format
```

### Command

This will run the supplied command directly.

```bash
docker run -v /src:/src clang-format [command]
```

## Building

```bash
docker build -t clang-format --build-arg CLANG_FORMAT_VERSION=12 .
```

Note that `CLANG_FORMAT_VERSION` defaults to `12` if not supplied.

<!-- external links -->
[License]: https://img.shields.io/github/license/devpow112/docker-clang-format?label=License
[CI Badge]: https://github.com/devpow112/docker-clang-format/actions/workflows/ci.yml/badge.svg?branch=main
[CI Workflow]: https://github.com/devpow112/docker-clang-format/actions/workflows/ci.yml?query=branch%3Amain
