# Credits and provenance

- **LEGION ownership, branding and fork maintenance:** Xylen.
- **Upstream client/runtime:** [Vape V4](https://github.com/7GrandDadPGN/VapeV4ForRoblox) and [VapeCompiled](https://github.com/7GrandDadPGN/VapeCompiled), associated with 7GrandDadPGN. The checked-in bootstrap scripts reference and fetch from these upstream projects.
- **Bundler:** [VapeBundler](https://github.com/7GrandDadPGN/VapeBundler), referenced by the existing GitHub Actions workflow.

Xylen is credited for the LEGION fork and its branding, not as the original author of the upstream client or runtime. Existing upstream identifiers and links are retained where they are required for compatibility or accurately describe the source. The current GitHub Actions workflow also builds against and pushes to the upstream `VapeCompiled` destination; it is not a self-contained LEGION release pipeline. Review and repoint that workflow to a destination you control before publishing. Review the upstream projects' applicable terms before redistributing a build.
