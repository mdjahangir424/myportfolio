from pathlib import Path
import html
import re

ROUTES = ("about", "skills", "services", "projects", "automation", "contact")


def main():
    root = Path("build/web")
    source = root / "index.html"
    if not source.exists():
        raise FileNotFoundError(source)

    template = source.read_text(encoding="utf-8")
    base_match = re.search(r'<base href="([^"]*)">', template, flags=re.I)
    if not base_match:
        raise RuntimeError("Could not determine Flutter web base href")

    base_href = base_match.group(1)
    if not base_href.startswith("/") or not base_href.endswith("/"):
        raise RuntimeError(f"Unexpected Flutter base href: {base_href}")

    # Flutter uses Hash URL Strategy. Path-only SEO pages must not boot the app
    # at Home while advertising another route; send visitors to the real hash URL.
    for route in ROUTES:
        destination = f"{base_href}#/{route}"
        page = f"""<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex, follow">
  <link rel="canonical" href="{html.escape(base_href, quote=True)}">
  <meta http-equiv="refresh" content="0; url={html.escape(destination, quote=True)}">
  <title>Redirecting | Md Jahangir Alam</title>
  <script>window.location.replace({destination!r});</script>
</head>
<body>
  <p>Continue to <a href="{html.escape(destination, quote=True)}">the {html.escape(route)} page</a>.</p>
</body>
</html>
"""
        destination_file = root / route / "index.html"
        destination_file.parent.mkdir(parents=True, exist_ok=True)
        destination_file.write_text(page, encoding="utf-8")

    # GitHub Pages serves this Flutter entry point for unknown/deep paths.
    # Keep the fallback out of search results.
    fallback = re.sub(
        r'<meta name="robots" content="[^"]*">',
        '<meta name="robots" content="noindex, follow">',
        template,
        count=1,
        flags=re.I,
    )
    if fallback == template and not re.search(
        r'<meta name="robots" content="[^"]*">', template, flags=re.I
    ):
        fallback = template.replace(
            "</head>", '<meta name="robots" content="noindex, follow">\\n</head>', 1
        )
    (root / "404.html").write_text(fallback, encoding="utf-8")
    print("Generated six hash-route redirect pages and a noindex GitHub Pages fallback.")


if __name__ == "__main__":
    main()
