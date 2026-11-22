# Godot Web Template

A starter project for a 2D game built in **Godot 4.7+** and exported to **HTML5** (runs in any modern browser).

## Layout

```
./
├── project.godot          # Engine config (1280x720, canvas_items stretch, GL Compatibility renderer)
├── export_presets.cfg     # "Web" export preset -> build/web/index.html
├── icon.svg               # Project icon (also used as the browser favicon)
├── scenes/
│   └── main.tscn          # Entry scene (set as run/main_scene)
├── scripts/
│   └── main.gd            # Starter script
├── .github/workflows/
│   └── web-export.yml     # CI: export the Web build, deploy to GitHub Pages on main
└── .gitignore
```

## Requirements

- Godot **4.7** (standard build is enough; the Web export templates must be installed:
  *Editor -> Manage Export Templates*).
- A static file server for local testing (browsers block `file://` loading of `.wasm`).

## Run it

1. Open the folder in the Godot editor (*Import* -> select `project.godot`).
2. Press **F5**.

## Export for the web

From the editor: *Project -> Export -> Web -> Export Project* to `build/web/index.html`.

Or from the command line:

```bash
godot --headless --export-release "Web" build/web/index.html
```

Test the result locally:

```bash
cd build/web
python3 -m http.server 8000
# open http://localhost:8000
```

## Notes on the web target

- **Threads are disabled** (`variant/thread_support=false`). This means the build runs on any static host without special
  `Cross-Origin-Opener-Policy` / `Cross-Origin-Embedder-Policy` headers. Turn it on only if you need threads and can set those headers.
- **Renderer** is `gl_compatibility`, which has the widest browser support. Do not switch to Forward+ for web builds.
- **Texture compression**: desktop-only VRAM compression is enabled. Keep textures small for fast web loads.
- Keep the total download small: the `.pck` and `.wasm` are fetched on load.

## Deploying

The included workflow (`.github/workflows/web-export.yml`) exports on every push and PR, and deploys to GitHub Pages
on pushes to `main`. To enable it, go to *Settings -> Pages -> Source: GitHub Actions* in the repo.

> The CI workflow has not been run against a real repository yet. Check the first run's logs, especially the
> export-templates step, since the `barichello/godot-ci` image's internal paths can change between releases.

## Customizing

- Rename the project in `project.godot` (`config/name`) and replace `icon.svg`.
- Change the window size in `project.godot` under `[display]`.
- Add scenes under `scenes/` and scripts under `scripts/`, then point `run/main_scene` at your entry scene.
