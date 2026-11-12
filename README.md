# Buildroot-router
A reproducible Buildroot-based embedded Linux router with custom network traffic and system monitoring, plus repeatable performance benchmarks.

## Status
An ARM64 Linux image can be built from the saved configuration and booted in QEMU. Now I am actually working on implementing routing in the system. 


## Build environment

- Buildroot 2025.02.19
- Ubuntu under WSL2
- QEMU ARM64

## Build

```bash
./scripts/build.sh