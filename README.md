# Buildroot-router
A reproducible embedded Linux router built with Buildroot, with an adaptive bandwith controller and custom kernel traffic monitoring.

## Goal
To be able to adjust traffic limits as avalible bandwidth changes. I would like to compare throughput, latency, and resource usage against fixed CAKE configurations. I also would like to intergrate my own linux system monitoring tool.

## Status
An ARM64 Linux image can be built from the saved configuration and booted in QEMU. Now I am actually working on implementing routing in the system. 


## Build environment

- Buildroot 2025.02.19
- Ubuntu under WSL2
- QEMU ARM64

## Build

```bash
./scripts/build.sh