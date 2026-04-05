# Project

## Working title

Nix Rust Harness Template

## Purpose

Provide a reusable starter repository for Rust projects developed through Nix, with explicit support for AI-assisted or agent-driven coding workflows.

## Product shape

This project is both a Rust template and an execution harness.

It should make the following easy:

- entering a reproducible development environment
- understanding repo rules quickly
- preserving context between sessions
- running standard verification without guesswork

## Non-goals

- Choosing an application framework up front
- Encoding product-specific architecture
- Hiding important workflow decisions behind opaque automation

## Current state

Shipped `v1.0` as a Rust-on-Nix starter with a reproducible runtime scaffold, explicit agent contract, durable planning memory, reusable agent skills, contribution guidance, and team-ready prompt entrypoints.

## Next milestone goals

- Define the next milestone scope before adding new active requirements.
- Revisit deferred Rust template profiles such as CLI, library, and service variants.
- Decide whether richer packaging and test presets belong in the next milestone.

---
*Last updated: 2026-04-05 after v1.0 milestone*
